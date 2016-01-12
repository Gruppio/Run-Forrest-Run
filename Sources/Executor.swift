//
//  Executor.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

protocol Executor {
    func execute(command: Command) throws -> CommandResult
}
