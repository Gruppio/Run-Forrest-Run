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
        return executeCommands([command])
    }
    
    public func run(commands commands: Command...) -> ExecutionResult {
        return executeCommands(commands)
    }
    
    private func executeArguments(argumentsList: [[String]]) -> ExecutionResult {
        return executeCommands(argumentsList.map() { (arguments) -> Command in
            return Command(arguments: arguments, executor: executor, stdin: nil)
        })
    }
    
    private func executeCommands(commands: [Command]) -> ExecutionResult {
        do {
            return try commands.reduce(ExecutionResult(stdout: commands.first?.stdin)) { (prevExecutionResult, command) -> ExecutionResult in
                return try Command(arguments: command.arguments, executor: command.executor, stdin: prevExecutionResult.stdout).execute()
            }
        }
        catch TaskExecutorError.InvalidArguments(arguments: let arguments) {
            return ExecutionResult(exitStatus: nil, stdout: nil, stderr: "Invalid Arguments: \(arguments)")
        }
        catch TaskExecutorError.InvalidLaunchPath(launchPath: let launchPath) {
            return ExecutionResult(exitStatus: nil, stdout: nil, stderr: "Invalid launchPath: \(launchPath)")
        }
        catch {
            return ExecutionResult(exitStatus: nil, stdout: nil, stderr: "Unknown Exception")
        }
    }
    
}


