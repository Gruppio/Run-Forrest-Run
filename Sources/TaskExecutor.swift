//
//  TaskExecutor.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation


enum TaskExecutorError : ErrorType {
    case InvalidLaunchPath(launchPath: String)
    case InvalidCommandArguments(command: Command)
}


class TaskExecutor {
    var launchPath: String
    
    init(launchPath: String) {
        self.launchPath = launchPath
    }
    
    convenience init() {
        self.init(launchPath: "/usr/bin/env")
    }
}


extension TaskExecutor : Executor {
    func execute(command: Command) throws -> CommandResult {
        
        guard !launchPath.isEmpty else {
            throw TaskExecutorError.InvalidLaunchPath(launchPath: launchPath)
        }
        
        guard !command.arguments.isEmpty else {
            throw TaskExecutorError.InvalidCommandArguments(command: command)
        }
        
        let task            = NSTask()
        let stdoutPipe      = NSPipe()
        let stderrPipe      = NSPipe()
        
        task.launchPath     = launchPath
        task.arguments      = command.arguments
        task.standardOutput = stdoutPipe
        task.standardError  = stderrPipe
        task.launch()
        task.waitUntilExit()
        
        let exitStatus      = Int(task.terminationStatus)
        let stdout          = stdoutPipe.getAvailableData()
        let stderr          = stderrPipe.getAvailableData()
        
        return CommandResult(exitStatus: exitStatus, stdout: stdout, stderr: stderr)
    }
    
}

extension NSPipe {
    func getAvailableData() -> String? {
        return String(data: self.fileHandleForReading.availableData, encoding: NSUTF8StringEncoding)
    }
}
