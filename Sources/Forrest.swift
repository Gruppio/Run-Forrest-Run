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
        
    let splitArguments = { (command: String) -> [[String]] in
        return command.componentsSeparatedByString("|")
            .map() { $0.componentsSeparatedByString(" ").filter() { !$0.isEmpty } }
            .filter() { !$0.isEmpty }
    }
    
    // Move in to a factory
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
    public func run(command: String) -> ExecutionResult {
        return executeArguments(splitArguments(command))
    }
    
    /// aaaa
    public func run(arguments arguments: String...) -> ExecutionResult {
        return executeArguments([arguments])
    }
    
    public func run(arguments arguments: [String]...) -> ExecutionResult {
        return executeArguments(arguments)
    }
    
    public func run(command command: Command) -> ExecutionResult {
        return executeExecutables([command])
    }
    /*
    public func run(commands commands: Command...) -> ExecutionResult {
        return executeExecutables(commands)
    }*/
    
    // TODO replace with a factory
    private func executeArguments(argumentsList: [[String]]) -> ExecutionResult {
        return executeExecutables(argumentsList.map() { (arguments) -> Command in
            return Command(arguments: arguments, executor: executor, stdin: nil)
        })
    }
    
    private func executeExecutables(executables: [Executable]) -> ExecutionResult {
        do {
            return try executables.reduce(ExecutionResult(stdout: executables.first?.stdin)) { (prevExecutionResult, var executable) -> ExecutionResult in
                executable.stdin = prevExecutionResult.stdout
                return try executable.execute()
            }
        }
        catch TaskExecutorError.InvalidArguments(arguments: let arguments) {
            return ExecutionResult(stderr: "Forrest: TaskExecutor: Invalid Arguments: \(arguments)")
        }
        catch TaskExecutorError.InvalidLaunchPath(launchPath: let launchPath) {
            return ExecutionResult(stderr: "Forrest: TaskExecutor: Invalid launchPath: \(launchPath)")
        }
        catch {
            return ExecutionResult(stderr: "Forrest: Unknown Exception")
        }
    }
    
}


