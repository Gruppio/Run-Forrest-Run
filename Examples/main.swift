//
//  main.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

let forrest = Forrest()

let out = forrest.run("ls", "-la")

if let out = out {
    print(out)
}



let out2 = forrest.run(["ls", "-la"], ["wc", "-w"])

if let out2 = out2 {
    print(out2)
}