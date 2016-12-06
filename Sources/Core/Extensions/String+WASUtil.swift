//
//  String+WASUtil.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension String {
	
	//**************************************************
	// MARK: - Public Methods
	//**************************************************
	
	func trim() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	
	func remove(_ string: String) -> String {
		return self.replacingOccurrences(of: string, with: "")
	}
	
	func abbreviation(_ characteres: Int) -> String {
		var string = self
		if string.characters.count > characteres {
			let index = string.index(string.startIndex, offsetBy: characteres)
			string = string.substring(to: index) + "..."
		}
		return string
	}
	
	func toColor() -> UIColor? {
		var string = self.trim()
		guard string.hasPrefix("#"), string.characters.count == 7 else {
			return nil
		}
		string = string.uppercased().remove("#")
		
		var rgbValue: UInt32 = 0
		Scanner(string: string).scanHexInt32(&rgbValue)
		let divisor = CGFloat(255)
		let red     = CGFloat((rgbValue & 0xFF000000) >> 24) / divisor
		let green   = CGFloat((rgbValue & 0x00FF0000) >> 16) / divisor
		let blue    = CGFloat((rgbValue & 0x0000FF00) >>  8) / divisor
		let alpha   = CGFloat( rgbValue & 0x000000FF       ) / divisor
		return UIColor(red: red, green: green, blue: blue, alpha: alpha)
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
