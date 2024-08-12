//
//  ConsoleErrorLogger.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation

struct ConsoleErrorLogger: ErrorLogger {
    func log(_ error: any Error) {
        print("🔴", error)
    }
}
