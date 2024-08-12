//
//  LiveAuthUseCase.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation

struct LiveAuthUseCase: AuthUseCase {
    func verifyEmail(email: String, confirmationCode: String) async throws {
        print("Verify code")
    }
}
