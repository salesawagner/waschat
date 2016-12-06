//
//  String+WASString.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

//**************************************************************************************************
//
// MARK: - Definitions -
//
//**************************************************************************************************

typealias Completion = (_ output: String) -> Void

//**************************************************************************************************
//
// MARK: - Extension -
//
//**************************************************************************************************

extension String {
	
	//**************************************************
	// MARK: - Properties
	//**************************************************
	
	var mentions: [String] {
		var strings = [String]()
		let regex = String(format: "(?<=\\W|^)@(\\w+)")
		let matches = self.WASMatchesForRegex(regex: regex)
		for mention in matches {
			let string = mention.remove("@")
			strings.append(string)
		}
		return strings
	}
	
	var emoticons: [String] {
		var strings = [String]()
		let regex = "\\(([A-za-z0-9]{1,15})\\)"
		let emoticons = self.WASMatchesForRegex(regex: regex)
		for emoticon in emoticons {
			var string = emoticon
			string = string.remove("(").remove(")")
			strings.append(string)
		}
		return strings
	}
	
	var colors: [String] {
		var strings = [String]()
		let regex = String(format: "#(?:[0-9A-Fa-f]{2}){3}")
		let colorString = self.uppercased()
		let colors = colorString.WASMatchesForRegex(regex: regex)
		for color in colors {
			if (color.toColor() != nil) {
				strings.append(color.remove("#"))
			}
		}
		return strings
	}
	
	var links: [[String : String]] {
		var links = [[String : String]]()
		var regex = "((?:http|https)://)?"
		regex += "(?:www\\.)?"
		regex += "[\\w\\d\\-_]+\\.\\w{2,3}"
		regex += "(\\.\\w{2})?"
		regex += "(/(?<=/)"
		regex += "(?:[\\w\\d\\-./_]+)?)?"
		let URLs = self.WASMatchesForRegex(regex: regex)
		for link in URLs {
			if let url = URL(string: link) {
				var dictionary = [String : String]()
				dictionary["url"] = link
				do {
					/*
					errSSLHostNameMismatch -9843 The host name you connected with does not match any of
					the host names allowed by the certificate. This is commonly caused by an incorrect
					value for the kCFStreamSSLPeerName property within the dictionary associated with
					the stream’s kCFStreamPropertySSLSettings key. Available in OS X v10.4 and later.
					*/
					let page = try String(contentsOf: url, encoding: .utf8)
					let title = page.pageTitle()
					dictionary["title"] = title
				} catch let erro {
					print("contents could not be loaded:")
					print("link: \(link)")
					print("erro: \(erro)")
				}
				links.append(dictionary)
			}
		}
		return links
	}
	
	//**************************************************
	// MARK: - Private Methods
	//**************************************************
	
	private func pageTitle() -> String {
		var string = ""
		let regex = "(?<=\\<title\\>)(\\s*.*\\s*)(?=\\<\\/title\\>)"
		let titles = self.WASMatchesForRegex(regex: regex)
		if let title = titles.first {
			string = title
		}
		
		let encodedData = string.data(using: .utf8)!
		let attributedOptions: [String : Any] = [
			NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
			NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
		]
		if let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil) {
			string = attributedString.string.remove("\"")
		}
		return string.abbreviation(54)
	}
	
	//**************************************************
	// MARK: - Public Methods
	//**************************************************
	
	func output() -> String {
		var output = ""
		let mentions	= self.mentions
		let emoticons	= self.emoticons
		let colors		= self.colors
		let links		= self.links
		
		var dictionary = [String : [Any]]()
		if mentions.count > 0 {
			dictionary["mentions"] = mentions
		}
		if emoticons.count > 0 {
			dictionary["emoticons"] = emoticons
		}
		if colors.count > 0 {
			dictionary["colors"] = colors
		}
		if links.count > 0 {
			dictionary["links"]	= links
		}
		if let data = try? JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted) {
			if let JSONString = String(data: data, encoding: .utf8) {
				output = JSONString.replacingOccurrences(of: "\\", with: "")
			}
		}
		return output
	}
	
	func asyncOutput(completion: @escaping Completion) {
		DispatchQueue.global(qos: .background).async {
			let output = self.output()
			DispatchQueue.main.async {
				completion(output)
			}
		}
	}
}
