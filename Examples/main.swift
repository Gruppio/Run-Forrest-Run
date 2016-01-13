//
//  main.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import Foundation

let forrest = Forrest()

/*
let out = forrest.run("ls", "-la")

if let out = out {
    print(out)
}


*/
/*
let out2 = forrest.run(["ls", "-la"], ["grep", "Run"])

if let out2 = out2 {
    print(out2)
}*/

let o = ["ciao come", "stai"].reduce([[]]) { (result, args) -> [[String]] in
    return result + forrest.splitToArgumentsList(args)
    }.filter(){!$0.isEmpty}

print(o)

let out3 = forrest.run("echo", "ciao", "come stai | grep ciao")

if let out3 = out3 {
    print(out3)
}

print("Done")