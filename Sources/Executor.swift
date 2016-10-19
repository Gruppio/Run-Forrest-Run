//
//  Executor.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/**
 *  This protocol define the method that an object must implement for execute a Command
 */
public protocol Executor {
    func execute(_ executable: Executable) throws -> ExecutionResult
}
