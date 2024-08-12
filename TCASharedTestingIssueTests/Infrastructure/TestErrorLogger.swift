//
//  TestErrorLogger.swift
//  TCASharedTestingIssueTests
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation
import ConcurrencyExtras
@testable import TCASharedTestingIssue

final class TestErrorLogger: ErrorLogger {
    private let isolatedErrors = LockIsolated([Error]())

    var errors: [Error] {
        isolatedErrors.value
    }

    func log(_ error: Error) {
        isolatedErrors.withValue {
            $0.append(error)
        }
    }
}
