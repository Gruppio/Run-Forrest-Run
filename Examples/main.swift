//
//  main.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

let forrest     = Forrest()
let pwd         = forrest.run("pwd").stdout
let swiftFiles  = forrest.run("ls | grep swift").stdout

if let pwd = pwd, let swiftFiles = swiftFiles {
    print("Swift Files in \(pwd) \(swiftFiles)")
}
