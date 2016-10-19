//
//  TaskExecutor.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation


enum TaskExecutorError : Error {
    case invalidLaunchPath(launchPath: String)
    case invalidArguments(arguments: [String]?)
}


/// This class has the responsability to execute a Command
open class TaskExecutor {
    var launchPath: String
    
    init(launchPath: String) {
        self.launchPath = launchPath
    }
    
    convenience init() {
        self.init(launchPath: "/usr/bin/env")
    }
}


// MARK: - TaskExecutor + Executor

extension TaskExecutor : Executor {
    
    public func execute(_ executable: Executable) throws -> ExecutionResult {
        
        guard let arguments = (executable as? Argumented)?.arguments else {
            throw TaskExecutorError.invalidArguments(arguments: nil)
        }
        
        guard !launchPath.isEmpty else {
            throw TaskExecutorError.invalidLaunchPath(launchPath: launchPath)
        }
        
        guard !arguments.isEmpty else {
            throw TaskExecutorError.invalidArguments(arguments: arguments)
        }
        
        let task            = Process()
        let stdinPipe       = Pipe()
        let stdoutPipe      = Pipe()
        let stderrPipe      = Pipe()
        
        task.launchPath     = launchPath
        task.arguments      = arguments
        task.standardInput  = stdinPipe
        task.standardOutput = stdoutPipe
        task.standardError  = stderrPipe
        
        if let input = executable.stdin {
            stdinPipe.write(input)
        }
        
        task.launch()
        task.waitUntilExit()
        
        let exitStatus      = Int(task.terminationStatus)
        let stdout          = stdoutPipe.read()
        let stderr          = stderrPipe.read()
        
        return ExecutionResult(exitStatus: exitStatus, stdout: stdout, stderr: stderr)
    }
    
}

// MARK: - NSPipe Extension

extension Pipe {
    func read() -> String? {
        return String(data: self.fileHandleForReading.availableData, encoding: String.Encoding.utf8)
    }
    
    func write(_ str: String) {
        guard let data = str.data(using: String.Encoding.utf8) else {
            return
        }
        self.fileHandleForWriting.write(data)
        self.fileHandleForWriting.closeFile()
    }
}
