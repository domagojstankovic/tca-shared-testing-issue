//
//  VerifyEmailFeatureTests.swift
//  TCASharedTestingIssueTests
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import XCTest
import ComposableArchitecture
@testable import TCASharedTestingIssue

final class VerifyEmailFeatureTests: XCTestCase {
    @MainActor
    func testError() async {
        let errorLogger = TestErrorLogger()

        let store = TestStore(initialState: VerifyEmailFeature.State(email: "info@underflow.eu")) {
            VerifyEmailFeature()
        } withDependencies: {
            $0.authUseCase = TestAuthUseCase(
                verificationCodeResult: .success("583726")
            )
            $0.errorLogger = errorLogger
        }

        await store.send(.verifyCode(.onFirstAppear)) {
            $0.verifyCode.focusedIndex = 0
        }

        await store.send(\.verifyCode.digits[id: 0].binding.text, "1") {
            $0.verifyCode.digits[id: 0]?.text = "1"
            $0.verifyCode.digits[id: 0]?.previousText = "1"
        }

        await store.receive(\.verifyCode.digits[id: 0].delegate, .didUpdate("1")) {
            $0.verifyCode.focusedIndex = 1
        }

        await store.send(\.verifyCode.digits[id: 1].binding.text, "2") {
            $0.verifyCode.digits[id: 1]?.text = "2"
            $0.verifyCode.digits[id: 1]?.previousText = "2"
        }

        await store.receive(\.verifyCode.digits[id: 1].delegate, .didUpdate("2")) {
            $0.verifyCode.focusedIndex = 2
        }

        await store.send(\.verifyCode.digits[id: 2].binding.text, "3") {
            $0.verifyCode.digits[id: 2]?.text = "3"
            $0.verifyCode.digits[id: 2]?.previousText = "3"
        }

        await store.receive(\.verifyCode.digits[id: 2].delegate, .didUpdate("3")) {
            $0.verifyCode.focusedIndex = 3
        }

        await store.send(\.verifyCode.digits[id: 3].binding.text, "4") {
            $0.verifyCode.digits[id: 3]?.text = "4"
            $0.verifyCode.digits[id: 3]?.previousText = "4"
        }

        await store.receive(\.verifyCode.digits[id: 3].delegate, .didUpdate("4")) {
            $0.verifyCode.focusedIndex = 4
        }

        await store.send(\.verifyCode.digits[id: 4].binding.text, "5") {
            $0.verifyCode.digits[id: 4]?.text = "5"
            $0.verifyCode.digits[id: 4]?.previousText = "5"
        }

        await store.receive(\.verifyCode.digits[id: 4].delegate, .didUpdate("5")) {
            $0.verifyCode.focusedIndex = 5
        }

        await store.send(\.verifyCode.digits[id: 5].binding.text, "6") {
            $0.verifyCode.digits[id: 5]?.text = "6"
            $0.verifyCode.digits[id: 5]?.previousText = "6"
        }

        await store.receive(\.verifyCode.digits[id: 5].delegate, .didUpdate("6")) {
            $0.verifyCode.focusedIndex = nil
        }

        await store.receive(\.verifyCode.delegate, .codeEntered("123456"))

        await store.receive(\.error) {
            $0.isError = true
            $0.testFlag = true
        }
    }
}
