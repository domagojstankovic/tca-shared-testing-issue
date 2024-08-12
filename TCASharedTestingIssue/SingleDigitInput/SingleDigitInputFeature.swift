//
//  SingleDigitInputFeature.swift
//  Presentation
//
//  Created by Domagoj Stankovic on 15.07.2024..
//

import ComposableArchitecture

@Reducer
struct SingleDigitInputFeature<ID: Hashable & Sendable> {
    init() {
    }

    @ObservableState
    struct State: Identifiable, Equatable, Sendable {
        let id: ID
        var text: String
        var previousText: String
        @Shared var isError: Bool

        init(
            id: ID,
            text: String = "",
            isError: Shared<Bool>
        ) {
            self.id = id
            self.text = text
            self.previousText = text
            self._isError = isError
        }
    }

    enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case delegate(Delegate)
    }

    var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding(\.text):
                if state.previousText != state.text {
                    state.previousText = state.text
                    return .send(.delegate(.didUpdate(state.text)))
                } else {
                    return .none
                }

            case .binding:
                return .none

            case .delegate:
                return .none
            }
        }
    }
}

extension SingleDigitInputFeature {
    enum Delegate: Sendable, Equatable {
        case didUpdate(String)
    }
}
