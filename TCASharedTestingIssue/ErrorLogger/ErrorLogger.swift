//
//  ErrorLogger.swift
//  TCASharedTestingIssue
//
//  Created by Domagoj Stankovic on 12.08.2024..
//

import Foundation

public protocol ErrorLogger: Sendable {
    func log(_ error: Error)
}
