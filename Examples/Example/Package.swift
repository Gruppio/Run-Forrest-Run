//
//  Package.swift
//  Example
//
//  Created by Michele Gruppioni on 16/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "Example",
    dependencies: [
        //.Package(url: "https://github.com/Gruppio/Run-Forrest_Run.git", majorVersion: 1),
        .Package(url: "../", majorVersion: 1)
    ]
)