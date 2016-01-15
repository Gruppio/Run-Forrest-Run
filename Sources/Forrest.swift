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
    public func run(command: String) -> CommandResult {
        return executeArguments(splitArguments(command))
    }
    
    /// aaaa
    public func run(arguments arguments: String...) -> CommandResult {
        return executeArguments([arguments])
    }
    
    public func run(arguments arguments: [String]...) -> CommandResult {
        return executeArguments(arguments)
    }
    
    public func run(command command: Command) -> CommandResult {
        return executeCommands([command])
    }
    
    public func run(commands commands: Command...) -> CommandResult {
        return executeCommands(commands)
    }
    
    private func executeArguments(argumentsList: [[String]]) -> CommandResult {
        /*do {
            return try argumentsList.reduce(CommandResult(stdout: nil)) { (prevCommandResult, arguments) -> CommandResult in
                return try Command(arguments: arguments, executor: executor, stdin: prevCommandResult.stdout).execute()
                }
        }
        catch TaskExecutorError.InvalidCommandArguments(command: let command) {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Invalid Arguments in Command: \(command)")
        }
        catch TaskExecutorError.InvalidLaunchPath(launchPath: let launchPath) {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Invalid launchPath: \(launchPath)")
        }
        catch {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Unknown Exception")
        }*/
        return executeCommands(argumentsList.map() { (arguments) -> Command in
            return Command(arguments: arguments, executor: executor, stdin: nil)
        })
    }
    
    private func executeCommands(commands: [Command]) -> CommandResult {
        do {
            return try commands.reduce(CommandResult(stdout: commands.first?.stdin)) { (prevCommandResult, command) -> CommandResult in
                return try Command(arguments: command.arguments, executor: command.executor, stdin: prevCommandResult.stdout).execute()
            }
        }
        catch TaskExecutorError.InvalidCommandArguments(command: let command) {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Invalid Arguments in Command: \(command)")
        }
        catch TaskExecutorError.InvalidLaunchPath(launchPath: let launchPath) {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Invalid launchPath: \(launchPath)")
        }
        catch {
            return CommandResult(exitStatus: nil, stdout: nil, stderr: "Unknown Exception")
        }
    }
    
}


