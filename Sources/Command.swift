//
//  Command.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/**
 *  This struct contain all the informations needed for execute a command
 */
public struct Command : Executable, Argumented {
    /// The Arguments of the command, including the name of the command
    public var arguments:  [String]
    public var executor:   Executor
    public var stdin:      String?
    
    
    init(arguments: [String], executor: Executor, stdin: String?) {
        self.arguments  = arguments
        self.executor   = executor
        self.stdin      = stdin
    }
    
    init(_ arguments: String..., executor: Executor, stdin: String?) {
        self.init(arguments: arguments, executor: executor, stdin: stdin)
    }
    
    init(_ arguments: String..., executor: Executor) {
        self.init(arguments: arguments, executor: executor, stdin: nil)
    }
    
    public func execute() throws -> ExecutionResult {
        return try executor.execute(self)
    }
}
