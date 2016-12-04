//
//  String+WASRegex.swift
//
//
//  Created by Wagner Sales on 9/14/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension String {

	/**
	Matche in string by regex parameter.
	
	- parameter regexString: regex String.
	
	- returns: String array of matches.
	*/
	public func WASMatchesForRegex(regexString: String) -> [String] {
		do {
			let regex		= try NSRegularExpression(pattern: regexString, options: .caseInsensitive)
			let nsString	= self as NSString
			let range		= NSMakeRange(0, nsString.length)
			let results		= regex.matches(in: self, options: .reportCompletion, range: range)
			return results.map({
				nsString.substring(with: $0.range)
			})
		} catch let e {
			print("Error: \(e)")
		}
		return [String]()
	}
	
}
