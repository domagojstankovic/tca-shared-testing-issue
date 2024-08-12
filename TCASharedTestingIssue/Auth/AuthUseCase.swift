//
//  AuthUseCase.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation

protocol AuthUseCase: Sendable {
    func verifyEmail(email: String, confirmationCode: String) async throws
}
