//
//  CommandResult.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

struct CommandResult {
    let exitStatus: Int?
    let stdout:     String?
    let stderr:     String?
    var successExitStatus: Int = 0
    
    init(exitStatus: Int?, stdout: String?, stderr: String?) {
        self.exitStatus = exitStatus
        self.stdout     = stdout
        self.stderr     = stderr
    }
    
    init(stdout: String?) {
        self.init(exitStatus: nil, stdout: stdout, stderr: nil)
    }
}

