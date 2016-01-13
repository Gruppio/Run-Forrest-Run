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
    
    public func parseAndRun(command: String) -> String? {
        return executeArguments(splitToArgumentsList(command))
    }
    
    public func run(arguments: String...) -> String? {
        let args = arguments.reduce([]) { (result, args) -> [[String]] in
            return result + forrest.splitToArgumentsList(args) }
            .filter(){ !$0.isEmpty }
            .flatMap() { $0 }
        print(args)
        return executeArguments([arguments])
        //return executeArguments([arguments])
    }
    
    public func run(argumentsList: [String]...) -> String? {
        return executeArguments(argumentsList)
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
}


