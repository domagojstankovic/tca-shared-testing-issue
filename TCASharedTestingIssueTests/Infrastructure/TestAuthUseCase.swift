//
//  TestAuthUseCase.swift
//  TCASharedTestingIssueTests
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation
@testable import TCASharedTestingIssue

struct TestAuthUseCase: AuthUseCase {
    let verificationCodeResult: Result<String, Error>

    func verifyEmail(email: String, confirmationCode: String) async throws {
        if try verificationCodeResult.get() != confirmationCode {
            throw TestError.general
        }
    }
}
