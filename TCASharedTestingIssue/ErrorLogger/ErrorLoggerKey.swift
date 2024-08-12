//
//  ErrorLoggerKey.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation
import ComposableArchitecture

enum ErrorLoggerKey: DependencyKey {
    static let liveValue: ErrorLogger = ConsoleErrorLogger()    
}

extension DependencyValues {
    var errorLogger: ErrorLogger {
        get { self[ErrorLoggerKey.self] }
        set { self[ErrorLoggerKey.self] = newValue }
    }
}
