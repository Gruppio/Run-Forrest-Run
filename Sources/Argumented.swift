//
//  Argumented.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 15/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

/**
 *  This protocol must be implemented by objects with a list of arguments 
 */
public protocol Argumented {
    var arguments: [String] { get set }
}