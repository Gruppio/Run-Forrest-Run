//
//  Command.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation


struct Command {
    var executor:   Executor
    var arguments:  [String]
    
    init(arguments: [String], executor: Executor) {
        self.arguments  = arguments
        self.executor   = executor
    }
    
    init(_ arguments: String..., executor: Executor) {
        self.init(arguments: arguments, executor: executor)
    }
}


extension Command : Executable {
    func execute() throws -> CommandResult {
        return try executor.execute(self)
    }
}


