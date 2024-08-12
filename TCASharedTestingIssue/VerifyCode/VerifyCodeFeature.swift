//
//  VerifyCodeFeature.swift
//  Presentation
//
//  Created by Domagoj Stankovic on 15.07.2024..
//

import ComposableArchitecture

@Reducer
struct VerifyCodeFeature {
    init() {
    }

    @ObservableState
    struct State: Equatable, Sendable {
        var digits: IdentifiedArrayOf<DigitFeature.State>
        var focusedIndex: Int?
        @Shared var isError: Bool

        init(
            count: Int,
            isError: Shared<Bool>
        ) {
            let digits = (0..<count).map {
                DigitFeature.State(id: $0, isError: isError)
            }
            self.digits = IdentifiedArray(uniqueElements: digits)
            self._isError = isError
        }
    }

    enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case delegate(Delegate)
        case digits(IdentifiedActionOf<DigitFeature>)
        case onFirstAppear
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .delegate:
                return .none

            case let .digits(.element(id, .delegate(.didUpdate(focusedText)))):
                if !focusedText.isEmpty {
                    // Set only the last digit to enforce having a single number in a box
                    let newText = focusedText.last(where: \.isNumber).map(String.init) ?? ""
                    state.digits[id: id] = DigitFeature.State(
                        id: id,
                        text: newText,
                        isError: state.$isError
                    )

                    // Move focus to the next box
                    state.focusedIndex = id + 1

                    if let focusedIndex = state.focusedIndex, focusedIndex >= state.digits.count {
                        // Last digit has been entered
                        state.focusedIndex = nil
                        let code = state.digits.map(\.text).joined()
                        if code.count == state.digits.count {
                            return .send(.delegate(.codeEntered(code)))
                        } else {
                            return .none
                        }
                    }
                }
                return .none

            case .digits:
                return .none

            case .onFirstAppear:
                state.focusedIndex = 0
                return .none
            }
        }
        .forEach(\.digits, action: \.digits) {
            DigitFeature()
        }
    }
}

extension VerifyCodeFeature {
    typealias DigitFeature = SingleDigitInputFeature<Int>

    enum Delegate: Sendable, Equatable {
        case codeEntered(String)
    }
}
