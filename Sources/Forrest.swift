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
    
    init(executor: Executor) {
        self.executor = executor
    }
    
    convenience init() {
        self.init(executor: TaskExecutor())
    }
    
    public func run(command: String) -> String? {
        return executeArguments(splitToArgumentsList(command))
    }
    
    public func run(arguments arguments: String...) -> String? {
        return executeArguments([arguments])
    }
    
    public func run(arguments arguments: [String]...) -> String? {
        return executeArguments(arguments)
    }
    
    private func executeArguments(argumentsList: [[String]]) -> String? {
        do {
            return try argumentsList.reduce(nil) { (input, arguments) -> String? in
                return try Command(arguments: arguments, executor: executor, input: input).execute().stdout
                }
        }
        catch {
            return nil
        }
    }
    
    
    func splitToArgumentsList(command: String) -> [[String]] {
        return command.componentsSeparatedByString("|")
                .map() { $0.componentsSeparatedByString(" ").filter() { !$0.isEmpty } }
                .filter() { !$0.isEmpty }
    }
    /*
    
    let argumentsParsed = arguments.reduce([]) { (result, args) -> [String] in
    return result + forrest.splitCommandToArguments(args) }
    .filter(){ !$0.isEmpty }

    
    func splitCommandToArguments(command: String) -> [String] {
        return command.componentsSeparatedByString(" ").filter() { !$0.isEmpty }
    }*/
    
    /*
    func splitCommandsToArgumentsList(commands: [String]) -> [[String]] {
        commands.reduce([[]]) { (argList, command) -> [[String]] in
            return command.componentsSeparatedByString("|").reduce(<#T##initial: T##T#>, combine: <#T##(T, String) throws -> T#>)
        }
    }*/

}


