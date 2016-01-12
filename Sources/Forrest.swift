//
//  Forrest.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

public class Forrest {
    var executor: Executor
    
    init(withExecutor executor: Executor) {
        self.executor = executor
    }
    
    convenience init() {
        self.init(withExecutor: TaskExecutor())
    }
    
    func run(arguments: String...) -> String? {
        do {
            return try Command(arguments: arguments, executor: executor, input: nil).execute().stdout
        }
        catch {
            return nil
        }
    }
    
    func run(argumentsList: [String]...) -> String? {
        var oldOutput: String?
        for arguments in argumentsList {
            do {
                oldOutput = try Command(arguments: arguments, executor: executor, input: oldOutput).execute().stdout
            }
            catch {
                return nil
            }
        }
        return oldOutput
    }
}

/*
infix operator --> { associativity left precedence 160 }
func -->(result: CommandResult, command: Command) throws -> CommandResult {
    if let stdout = result.stdout {
        return try Command(arguments: command.arguments + [stdout], executor: command.executor).execute()
    }
    else {
        return try command.execute()
    }
}*/

