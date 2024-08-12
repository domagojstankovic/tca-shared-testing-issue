//
//  RegisterVerifyEmailFeature.swift
//  Presentation
//
//  Created by Domagoj Stankovic on 15.07.2024..
//

import ComposableArchitecture

@Reducer
struct RegisterVerifyEmailFeature: Sendable {
    init() {
    }

    @ObservableState
    struct State: Equatable, Sendable {
        let email: String
        @Shared var isError: Bool
        var testFlag: Bool
        var verifyCode: VerifyCodeFeature.State

        init(email: String) {
            self.email = email
            let isError = Shared(false)
            self._isError = isError
            self.testFlag = false
            self.verifyCode = VerifyCodeFeature.State(count: 6, isError: isError)
        }
    }

    enum Action: Sendable {
        case delegate(Delegate)
        case error(any Error)
        case verifyCode(VerifyCodeFeature.Action)
    }

    @Dependency(\.authUseCase) private var authUseCase
    @Dependency(\.errorLogger) private var errorLogger

    var body: some ReducerOf<Self> {
        Scope(state: \.verifyCode, action: \.verifyCode) {
            VerifyCodeFeature()
        }

        Reduce { state, action in
            switch action {
            case .delegate:
                return .none

            case .error:
                state.isError = true
                state.testFlag = true
                return .none

            case let .verifyCode(.delegate(.codeEntered(code))):
                return .run { [email = state.email] send in
                    try await authUseCase.verifyEmail(
                        email: email,
                        confirmationCode: code
                    )
                    await send(.delegate(.verified))
                } catch: { error, send in
                    errorLogger.log(error)
                    await send(.error(error))
                }

            case .verifyCode:
                return .none
            }
        }
    }
}

extension RegisterVerifyEmailFeature {
    enum Delegate: Sendable {
        case verified
    }
}
