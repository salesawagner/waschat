//
//  String+WASString.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension String {
	func trim() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	func remove(_ string: String) -> String {
		return self.replacingOccurrences(of: string, with: "")
	}
	func WASMatchesForRegex(regex: String) -> [String] {
		var strings = [""]
		do {
			let regex	= try NSRegularExpression(pattern: regex, options: [])
			let range	= NSMakeRange(0, self.characters.count)
			let ranges	= regex.matches(in: self, options: .reportCompletion, range: range)
			strings = ranges.map {
				let nSString = self as NSString
				return nSString.substring(with: $0.range)
			}
		} catch let e {
			print("WASMatchesForRegex error: \(e)")
		}
		return strings
	}
}
