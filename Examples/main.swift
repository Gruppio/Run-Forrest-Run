//
//  main.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

let forrest = Forrest()

let pwd = forrest.run("pwd")
let out = forrest.run("ls -la | grep swift")

if let out = out.stdout, pwd = pwd.stdout {
    print(out)
}

print("Done")