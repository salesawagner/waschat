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
	
	func textColor() {
		let colorString = "#FFFFFF"
		let color = colorString.toColor()
		XCTAssertNotNil(color, "The color should be not nil.")
	}
	
	func testColorFail() {
		let colorString = "Invalid"
		let color = colorString.toColor()
		XCTAssertNil(color, "The color should be nil.")
	}
	
	func testColors() {
		let string = "Nice color #FF7113"
		let message = Message(message: string)
		let countExpected = 1
		let stringExpected = "FF7113"
		let outputExpected = "{\n  \"colors\" : [\n    \"FF7113\"\n  ]\n}"
		XCTAssertEqual(message.colors.count, countExpected, "The colors count should be equal \(countExpected).")
		XCTAssertEqual(message.colors.first!, stringExpected, "The first colors should be equal \(stringExpected)")
		XCTAssertEqual(message.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testMentions() {
		let string = "@chris you around?"
		let message = Message(message: string)
		let countExpected = 1
		let stringExpected = "chris"
		let outputExpected = "{\n  \"mentions\" : [\n    \"chris\"\n  ]\n}"
		XCTAssertEqual(message.mentions.count, countExpected, "The mentions count should be equal \(countExpected).")
		XCTAssertEqual(message.mentions.first!, stringExpected, "The first mention should be equal \(stringExpected)")
		XCTAssertEqual(message.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testEmoticons() {
		let string = "Good morning! (megusta) (coffee)"
		let message = Message(message: string)
		let countExpected = 2
		let stringExpected = "megusta"
		let outputExpected = "{\n  \"emoticons\" : [\n    \"megusta\",\n    \"coffee\"\n  ]\n}"
		XCTAssertEqual(message.emoticons.count, countExpected, "The emoticons count should be equal \(countExpected).")
		XCTAssertEqual(message.emoticons.first!, stringExpected, "The first emoticon should be equal \(stringExpected)")
		XCTAssertEqual(message.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testLinks() {
		let string = "Olympics are starting soon;http://www.nbcolympics.com"
		let message = Message(message: string)
		let countExpected = 1
		let urlExpected = "http://www.nbcolympics.com"
		let titleExpected = "2016 Rio Olympic Games | NBC Olympics"
		let outputExpected = "{\n  \"links\" : [\n    {\n      \"url\" : \"http://www.nbcolympics.com\",\n      \"title\" : \"2016 Rio Olympic Games | NBC Olympics\"\n    }\n  ]\n}"
		XCTAssertEqual(message.links.count, countExpected, "The links count should be equal \(countExpected).")
		if let link = message.links.first {
			let url = link["url"]!
			let title = link["title"]!
			XCTAssertEqual(url, urlExpected, "The first url should be equal \(urlExpected)")
			XCTAssertEqual(title, titleExpected, "The title should be equal \(titleExpected)")
		}
		XCTAssertEqual(message.output(), outputExpected, "The outuput should be equal \(outputExpected)")
	}
	
	func testMessage() {
		let string = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
		let message = Message(message: string)
		let mentionsCountExpected = 2
		let emoticonsCountExpected = 1
		let linksCountExpected = 1
		let outputExpected = "{\n  \"emoticons\" : [\n    \"success\"\n  ],\n  \"mentions\" : [\n    \"bob\",\n    \"john\"\n  ],\n  \"links\" : [\n    {\n      \"url\" : \"https://twitter.com/jdorfman/status/430511497475670016\",\n      \"title\" : \"Justin Dorfman on Twitter: nice @littlebigdetail from ...\"\n    }\n  ]\n}"
		XCTAssertEqual(message.mentions.count, mentionsCountExpected, "The mentions count should be equal \(mentionsCountExpected).")
		XCTAssertEqual(message.emoticons.count, emoticonsCountExpected, "The emoticons count should be equal \(emoticonsCountExpected).")
		XCTAssertEqual(message.links.count, linksCountExpected, "The links count should be equal \(linksCountExpected).")
		XCTAssertEqual(message.output(), outputExpected, "The links count should be equal \(outputExpected).")
	}
	
    func testPerformanceExample() {
        self.measure {
            let _ = Message(message: "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016")
        }
    }
    
}
