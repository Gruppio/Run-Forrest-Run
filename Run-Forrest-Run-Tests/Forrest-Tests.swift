//
//  Forrest-Tests.swift
//  Run-Forrest-Run
//
//  Created by Michele Gruppioni on 12/01/16.
//  Copyright © 2016 Michele Gruppioni. All rights reserved.
//

import XCTest


class Forrest_Tests: XCTestCase {
    
    let forrest = Forrest()
    
    func testSplitArgumentsWith1Command() {
        XCTAssertEqual(forrest.splitArguments("a"), [["a"]])
    }

    func testSplitArgumentsWith2Commands() {
        XCTAssertEqual(forrest.splitArguments("a|b"), [["a"], ["b"]])
    }
    
    func testSplitArgumentsWith3Commands() {
        XCTAssertEqual(forrest.splitArguments("a|b|c"), [["a"], ["b"], ["c"]])
    }
    
    func testSplitArgumentsWith1CommandWithFlag() {
        XCTAssertEqual(forrest.splitArguments("a -b"), [["a", "-b"]])
    }
    
    func testSplitArgumentsWith2CommandsWithFlag() {
        XCTAssertEqual(forrest.splitArguments("a -b|c -d"), [["a", "-b"], ["c", "-d"]])
    }
    
    func testSplitArgumentsWith3CommandsWithFlag() {
        XCTAssertEqual(forrest.splitArguments("a -b|c -d|e -f"), [["a", "-b"],["c", "-d"],["e", "-f"]])
    }
    
    func testSplitArgumentsWith1CommandWithFlags() {
        XCTAssertEqual(forrest.splitArguments("a -b --bb"), [["a", "-b", "--bb"]])
    }
    
    func testSplitArgumentsWith2CommandsWithFlags() {
        XCTAssertEqual(forrest.splitArguments("a -b --bb|c -d --dd"), [["a", "-b", "--bb"], ["c", "-d", "--dd"]])
    }
    
    func testSplitArgumentsWith3CommandsWithFlags() {
        XCTAssertEqual(forrest.splitArguments("a -b --bb|c -d --dd|e -f --ff"), [["a", "-b", "--bb"],["c", "-d", "--dd"],["e", "-f", "--ff"]])
    }
    
    func testSplitArgumentsWith1CommandAndSpaces() {
        XCTAssertEqual(forrest.splitArguments("  a "), [["a"]])
    }
    
    func testSplitArgumentsWith2CommandsAndSpaces() {
        XCTAssertEqual(forrest.splitArguments(" a  | b "), [["a"], ["b"]])
    }
    
    func testSplitArgumentsWith3CommandsAndSpaces() {
        XCTAssertEqual(forrest.splitArguments(" a | b  | c  "), [["a"], ["b"], ["c"]])
    }
    
    func testSplitArgumentsWith1CommandWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitArguments(" a  -b "), [["a", "-b"]])
    }
    
    func testSplitArgumentsWith2CommandsWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitArguments(" a -b     | c  -d "), [["a", "-b"], ["c", "-d"]])
    }
    
    func testSplitArgumentsWith3CommandsWithFlagAndSpaces() {
        XCTAssertEqual(forrest.splitArguments(" a -b   | c  -d | e -f "), [["a", "-b"],["c", "-d"],["e", "-f"]])
    }

}
