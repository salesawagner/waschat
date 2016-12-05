//
//  String+WASString.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension String {
	func mentions() -> [String] {
		var strings = [String]()
		let regex = String(format: "(?<=\\W|^)@(\\w+)")
		let mentions = self.WASMatchesForRegex(regex: regex)
		for mention in mentions {
			let string = mention.remove("@")
			strings.append(string)
		}
		return strings
	}
	func emoticons() -> [String] {
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
	func URLs() -> [[String : String]] {
		let regex = "((https?)\\:\\/\\/)[a-zA-Z0-9\\-\\.]+\\.[a-zA-Z]{2,3}(\\/\\S*)?\\w+"
		let URLs = self.WASMatchesForRegex(regex: regex)
		var links = [[String : String]]()
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
	func pageTitle() -> String {
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
		do {
			let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
			string = attributedString.string.remove("\"")
		} catch {
			print("Error: \(error)")
		}
		return string.abbreviation(54)
	}
	func abbreviation(_ characteres: Int) -> String {
		var string = self
		if string.characters.count > characteres {
			let index = string.index(string.startIndex, offsetBy: characteres)
			string = string.substring(to: index) + "..."
		}
		return string
	}
	func colors() -> [String] {
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
}
