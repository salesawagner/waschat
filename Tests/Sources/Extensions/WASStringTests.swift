//
//  WASStringTests.swift
//  waschat
//
//  Created by Wagner Sales on 05/12/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import XCTest
@testable import waschat

class WASStringTests: XCTestCase {
	
	let emptyOutput = "{\n\n}"
	let validColor = "#FFFFFF"
	let invalidColor = "#HH7113"
	let validMention = "@chris"
	let invalidMention = "chris"
	let validEmoticon = "(megusta)"
	let invalidEmoticon = "(thisemoticonneedbeinvalid)"
	
	func bla() {
		let regex = "invalidRegex"
		let matches = "".WASMatchesForRegex(regex: regex)
		print(matches)
	}
	
	func testColor() {
		let string = validColor
		let color = string.toColor()
		XCTAssertNotNil(color, "The color should be not nil.")
	}
	
	func testColorFail() {
		let string = invalidColor
		let color = string.toColor()
		XCTAssertNil(color, "The color should be nil.")
	}
	
	func testColors() {
		let string = "Nice color " + validColor
		let countExpected = 1
		let stringExpected = validColor.remove("#")
		let outputExpected = "{\n  \"colors\" : [\n    \"\(stringExpected)\"\n  ]\n}"
		XCTAssertEqual(string.colors.count, countExpected, "The colors count should be equal \(countExpected).")
		XCTAssertEqual(string.colors.first!, stringExpected, "The first colors should be equal \(stringExpected)")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testColorsFail() {
		let string = "Nice color " + invalidColor
		let countExpected = 0
		let outputExpected = emptyOutput
		XCTAssertEqual(string.colors.count, countExpected, "The colors count should be equal \(countExpected).")
		XCTAssertNil(string.colors.first, "The first colors should be nil")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testMentions() {
		let string = validMention + " you around?"
		let countExpected = 1
		let stringExpected = validMention.remove("@")
		let outputExpected = "{\n  \"mentions\" : [\n    \"\(stringExpected)\"\n  ]\n}"
		XCTAssertEqual(string.mentions.count, countExpected, "The mentions count should be equal \(countExpected).")
		XCTAssertEqual(string.mentions.first!, stringExpected, "The first mention should be equal \(stringExpected)")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testMentionsInvalid() {
		let string = invalidMention + " you around?"
		let countExpected = 0
		let outputExpected = emptyOutput
		XCTAssertEqual(string.mentions.count, countExpected, "The mentions count should be equal \(countExpected).")
		XCTAssertNil(string.mentions.first, "The first mention should be nil")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testEmoticons() {
		let string = "Good morning! " + validEmoticon
		let countExpected = 1
		let stringExpected = validEmoticon.remove("(").remove(")")
		let outputExpected = "{\n  \"emoticons\" : [\n    \"\(stringExpected)\"\n  ]\n}"
		XCTAssertEqual(string.emoticons.count, countExpected, "The emoticons count should be equal \(countExpected).")
		XCTAssertEqual(string.emoticons.first!, stringExpected, "The first emoticon should be equal \(stringExpected)")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testEmoticonsInvalid() {
		let string = "Good morning! " + invalidEmoticon
		let countExpected = 0
		let outputExpected = emptyOutput
		XCTAssertEqual(string.mentions.count, countExpected, "The emoticons count should be equal \(countExpected).")
		XCTAssertNil(string.mentions.first, "The first mention should be nil")
		XCTAssertEqual(string.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testLinks() {
		let expectation = self.expectation(description: #function)
		let string = "Olympics are starting soon;http://www.nbcolympics.com"
		let countExpected = 1
		let urlExpected = "http://www.nbcolympics.com"
		let titleExpected = "2016 Rio Olympic Games | NBC Olympics"
		let outputExpected = "{\n  \"links\" : [\n    {\n      \"url\" : \"http://www.nbcolympics.com\",\n      \"title\" : \"2016 Rio Olympic Games | NBC Olympics\"\n    }\n  ]\n}"
		XCTAssertEqual(string.links.count, countExpected, "The links count should be equal \(countExpected).")
		if let link = string.links.first {
			let url = link["url"]!
			let title = link["title"]!
			XCTAssertEqual(url, urlExpected, "The first url should be equal \(urlExpected)")
			XCTAssertEqual(title, titleExpected, "The title should be equal \(titleExpected)")
		}
		string.asyncOutput { (output) in
			expectation.fulfill()
			XCTAssertEqual(output, outputExpected, "The outuput should be equal \(outputExpected)")
		}
		self.waitForExpectations(timeout: 10, handler: nil)
	}
	
	func testAll() {
		let expectation = self.expectation(description: #function)
		let string = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
		let mentionsCountExpected = 2
		let emoticonsCountExpected = 1
		let linksCountExpected = 1
		let outputExpected = "{\n  \"emoticons\" : [\n    \"success\"\n  ],\n  \"mentions\" : [\n    \"bob\",\n    \"john\"\n  ],\n  \"links\" : [\n    {\n      \"url\" : \"https://twitter.com/jdorfman/status/430511497475670016\",\n      \"title\" : \"Justin Dorfman on Twitter: nice @littlebigdetail from ...\"\n    }\n  ]\n}"
		XCTAssertEqual(string.mentions.count, mentionsCountExpected, "The mentions count should be equal \(mentionsCountExpected).")
		XCTAssertEqual(string.emoticons.count, emoticonsCountExpected, "The emoticons count should be equal \(emoticonsCountExpected).")
		XCTAssertEqual(string.links.count, linksCountExpected, "The links count should be equal \(linksCountExpected).")
		string.asyncOutput { (output) in
			expectation.fulfill()
			XCTAssertEqual(output, outputExpected, "The links count should be equal \(outputExpected).")
		}
		self.waitForExpectations(timeout: 10, handler: nil)
	}
}
