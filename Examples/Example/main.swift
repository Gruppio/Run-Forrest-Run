//
//  main.swift
//  Example
//
//  Created by Michele Gruppioni on 16/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation
import Run-Forrest-Run

let forrest     = Forrest()
let pwd         = forrest.run("pwd").stdout
let swiftFiles  = forrest.run("ls | grep swift").stdout

if let pwd = pwd, swiftFiles = swiftFiles {
    print("Swift Files in \(pwd) \(swiftFiles)")
}

print("Done")

