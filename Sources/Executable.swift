//
//  Executable.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation


public protocol Executable {
    var stdin: String? { get set }
    func execute() throws -> ExecutionResult
}


public protocol ExecutableFactory {
    func create(_ arguments: [String], stdin: String?) -> Executable
    func create(_ arguments: [String]) -> Executable
}
