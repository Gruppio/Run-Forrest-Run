//
//  Forrest.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/// My Momma always said: Forrest Run Shell Commands in Swift
open class Forrest {
    open var executableFactory: ExecutableFactory
    
    init(executableFactory: ExecutableFactory) {
        self.executableFactory = executableFactory
    }
    
    /**
     Run the specified shell command ( ex: run("ls -la | grep swift") )
     The command will be splitted in an arguments list using the whitespace character, if you have to
     specify names that contain whitespaces please use run(arguments: )
     *Note* Use always absolute path or path relative to current folder because cd will no have effect
    - parameter command: A Shell Command or multiple Piped Shell Commands ( ex: "ls -la | grep swift" )
    - returns: The Command Result
    */
    open func run(_ command: String) -> ExecutionResult {
        return executeArguments(splitArguments(command))
    }
    
    /**
     Run the shell command expressed in his arguments ( ex: run("ls", "-l") )
     *Note* Use always absolute path or path relative to current folder because cd will no have effect
     - parameter arguments: All the Shell Command Arguments including the command name ( ex: ["ls", "-la"] )
     - returns: The Command Result
     */
    open func run(arguments: String...) -> ExecutionResult {
        return executeArguments([arguments])
    }
    
    /**
     Run multiple Piped shell command expressed in their arguments ( ex: run([["ls", "-l"], ["grep", "swift]]) )
     *Note* Use always absolute path or path relative to current folder because cd will no have effect
     - parameter arguments: Multiple Shell Command Arguments including the commands name ( ex: [["ls", "-la"], ["grep", "swift"]] )
     - returns: The Command Result
     */
    open func run(arguments: [String]...) -> ExecutionResult {
        return executeArguments(arguments)
    }
    
    /**
     Run the Executable ( ex: run(Command(arguments: ["ls", "-l"], executor: TaskExecutor(), stdin: nil) )
     *Note* Use always absolute path or path relative to current folder because cd will no have effect
     - parameter executables: An Executable object
     - returns: The Command Result
    */
    open func run(executables executable: Executable) -> ExecutionResult {
        return executeExecutables([executable])
    }
    
    /**
     Run multiple Piped Executables ( ex: run([Command(arguments: ["ls", "-l"], executor: TaskExecutor(), stdin: nil), ... ] )
     *Note* Use always absolute path or path relative to current folder because cd will no have effect
     - parameter executables: An Executables objects list
     - returns: The Command Result
     */
    open func run(executables executable: Executable...) -> ExecutionResult {
        return executeExecutables(executable)
    }
    
    fileprivate func executeArguments(_ argumentsList: [[String]]) -> ExecutionResult {
        return executeExecutables(argumentsList.map(executableFactory.create))
    }
    
    fileprivate func executeExecutables(_ executables: [Executable]) -> ExecutionResult {
        do {
            return try executables.reduce(ExecutionResult(stdout: executables.first?.stdin)) { (prevExecutionResult, executable) -> ExecutionResult in
                var executable = executable
                executable.stdin = prevExecutionResult.stdout // Pipe
                return try executable.execute()
            }
        }
        catch TaskExecutorError.invalidArguments(arguments: let arguments) {
            return ExecutionResult(stderr: "Forrest: TaskExecutor: Invalid Arguments: \(arguments)")
        }
        catch TaskExecutorError.invalidLaunchPath(launchPath: let launchPath) {
            return ExecutionResult(stderr: "Forrest: TaskExecutor: Invalid launchPath: \(launchPath)")
        }
        catch {
            return ExecutionResult(stderr: "Forrest: Unknown Exception")
        }
    }
    
    // TODO: Move this in to a class
    let splitArguments = { (command: String) -> [[String]] in
        return command.components(separatedBy: "|")
            .map() { $0.components(separatedBy: " ").filter() { !$0.isEmpty } }
            .filter() { !$0.isEmpty }
    }
    
}

extension Forrest {
    public convenience init() {
        self.init(executableFactory: CommandFactory())
    }
}


