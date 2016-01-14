//
//  Forrest.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/// My Momma always said: Forrest Run shell commands in Swift
public class Forrest {
        
    var splitArguments = { (command: String) -> [[String]] in
        return command.componentsSeparatedByString("|")
            .map() { $0.componentsSeparatedByString(" ").filter() { !$0.isEmpty } }
            .filter() { !$0.isEmpty }
    }
    
    public var executor: Executor
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    /**
     init a Forrest object with a TaskExecutor executor
     */
    convenience init() {
        self.init(executor: TaskExecutor())
    }
    

    /**
    Run a Shell command using the specified executor
    - parameter command: A Shell Command or even multiple piped shell commands ( ex: "ls -la | grep swift" )
    - returns: The Command Result
    */
    public func run(command: String) -> String? {
        return executeArguments(splitArguments(command))
    }
    
    /// aaaa
    public func run(arguments arguments: String...) -> String? {
        return executeArguments([arguments])
    }
    
    public func run(arguments arguments: [String]...) -> String? {
        return executeArguments(arguments)
    }
    
    private func executeArguments(argumentsList: [[String]]) -> String? {
        do {
            return try argumentsList.reduce(nil) { (prevCommandResult, arguments) -> String? in
                return try Command(arguments: arguments, executor: executor, stdin: prevCommandResult).execute().stdout
                }
        }
        catch {
            return nil
        }
    }
}


