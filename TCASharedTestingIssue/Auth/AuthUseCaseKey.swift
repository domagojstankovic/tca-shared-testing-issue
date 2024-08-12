//
//  AuthUseCaseKey.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation
import Dependencies

enum AuthUseCaseKey: DependencyKey {
    static let liveValue: AuthUseCase = LiveAuthUseCase()
}

extension DependencyValues {
    var authUseCase: AuthUseCase {
        get { self[AuthUseCaseKey.self] }
        set { self[AuthUseCaseKey.self] = newValue }
    }
}
