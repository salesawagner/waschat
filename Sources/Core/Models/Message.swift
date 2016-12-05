//
//  Message.swift
//  waschat
//
//  Created by Wagner Sales on 04/12/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

//**************************************************************************************************
//
// MARK: - Class - BandListViewModel
//
//**************************************************************************************************

class Message: NSObject {
	
	//**************************************************
	// MARK: - Properties
	//**************************************************
	
	let message: String
	let mentions: [String]
	let emoticons: [String]
	let colors: [String]
	let links: [[String : String]]
	
	//**************************************************
	// MARK: - Constructors
	//**************************************************
	
	init(message: String) {
		self.message	= message
		self.mentions	= message.mentions()
		self.emoticons	= message.emoticons()
		self.colors		= message.colors()
		self.links		= message.URLs()
	}
	
	//**************************************************
	// MARK: - Private Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Internal Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Public Methods
	//**************************************************
	
	func output() -> String {
		var output = ""
		var dictionary = [String : [Any]]()
		if self.mentions.count > 0 {
			dictionary["mentions"] = self.mentions
		}
		if self.emoticons.count > 0 {
			dictionary["emoticons"] = self.emoticons
		}
		if self.colors.count > 0 {
			dictionary["colors"] = self.colors
		}
		if self.links.count > 0 {
			dictionary["links"]	= self.links
		}
		do {
			let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
			if let JSONString = String(data: data, encoding: .utf8) {
				output = JSONString.replacingOccurrences(of: "\\", with: "")
			}
		} catch let e {
			print("message could not be serialized: \(e)")
		}
		return output
	}
	
	//**************************************************
	// MARK: - Override Public Methods
	//**************************************************
	
}
