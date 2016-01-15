//
//  Forrest.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/// My Momma always said: Forrest Run Shell Commands in Swift
public class Forrest {
    public var executableFactory: ExecutableFactory
    
    init(executableFactory: ExecutableFactory) {
        self.executableFactory = executableFactory
    }
    
    /**
    Run a Shell command using the specified executor
    - parameter command: A Shell Command or even multiple piped shell commands ( ex: "ls -la | grep swift" )
    - returns: The Command Result
    */
    public func run(command: String) -> ExecutionResult {
        return executeArguments(splitArguments(command))
    }
    
    public func run(arguments arguments: String...) -> ExecutionResult {
        return executeArguments([arguments])
    }
    
    public func run(arguments arguments: [String]...) -> ExecutionResult {
        return executeArguments(arguments)
    }
    
    public func run(executable executable: Executable) -> ExecutionResult {
        return executeExecutables([executable])
    }
    
    public func run(executable executable: Executable...) -> ExecutionResult {
        return executeExecutables(executable)
    }
    
    
    
    private func executeArguments(argumentsList: [[String]]) -> ExecutionResult {
        return executeExecutables(argumentsList.map(executableFactory.create))
    }
    
    private func executeExecutables(executables: [Executable]) -> ExecutionResult {
        do {
            return try executables.reduce(ExecutionResult(stdout: executables.first?.stdin)) { (prevExecutionResult, var executable) -> ExecutionResult in
                executable.stdin = prevExecutionResult.stdout // Pipe
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
    
    // TODO: Move this in to a class
    let splitArguments = { (command: String) -> [[String]] in
        return command.componentsSeparatedByString("|")
            .map() { $0.componentsSeparatedByString(" ").filter() { !$0.isEmpty } }
            .filter() { !$0.isEmpty }
    }
    
}

extension Forrest {
    public convenience init() {
        self.init(executableFactory: CommandFactory())
    }
}


