//: Playground - noun: a place where people can play

import UIKit

class Link: NSObject {
	
	let url: String
	var title: String = ""
	
	init(url: String) {
		self.url = url
		if let url = URL(string: url) {
			do {
				let contents = try String(contentsOf: url)
				self.title = contents.URLTitle()
			} catch let e {
				print("contents could not be loaded: \(e)")
			}
		}
	}
	
	func toDictionary() -> Dictionary<String, String> {
		var dictionary = [String : String]()
		dictionary["url"]	= self.url
		dictionary["title"] = self.title
		return dictionary
	}
}

class Message: NSObject {
	let mentions: [String]
	let emoticons: [String]
	let colors: [String]
	let links: [Link]
	
	init(message: String) {
		self.mentions	= message.mentions()
		self.emoticons	= message.emoticons()
		self.colors		= message.colors()
		self.links		= message.URLs()
	}
	
	func output() -> String {
		var output = ""
		var dictionary = [String : [Any]]()
		dictionary["mentions"]	= self.mentions
		dictionary["colors"]	= self.mentions
		dictionary["emoticons"] = self.emoticons
		
		var links = [[String : String]]()
		for link in self.links {
			links.append(link.toDictionary())
		}
		dictionary["links"] = links
		
		do {
			let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
			if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
				output = JSONString
			}
		} catch let e {
			print("message could not be serialized: \(e)")
		}
		return output
	}
}


extension String {
	func trim() -> String {
		return self.trimmingCharacters(in: .whitespacesAndNewlines)
	}
	func removeFirst() -> String {
		var string = self
		return String(string.remove(at: string.startIndex))
	}
	func WASMatchesForRegex(regex: String) -> [String] {
		do {
			let regex	= try NSRegularExpression(pattern: regex, options: [])
			let range	= NSMakeRange(0, self.characters.count)
			let ranges	= regex.matches(in: self.trim(), options: .reportCompletion, range: range)
			return ranges.map {
				let nSString = self as NSString
				return nSString.substring(with: $0.range)
			}
		} catch let e {
			print("WASMatchesForRegex error: \(e)")
		}
		return [""]
	}
	func mentions() -> [String] {
		var strings = [String]()
		let regex = String(format: "(?<=\\W|^)@(\\w+)")
		let mentions = self.WASMatchesForRegex(regex: regex)
		for mention in mentions {
			strings.append(mention)
		}
		return strings
	}
	func emoticons() -> [String] {
		var strings = [String]()
		let regex = "\\(([a-z]+)\\)"
		let emoticons = self.WASMatchesForRegex(regex: regex)
		
		for emoticon in emoticons {
			var string = emoticon
			string = string.replacingOccurrences(of: "(", with: "")
			string = string.replacingOccurrences(of: ")", with: "")
			strings.append(string)
		}
		return strings
	}
	func URLs() -> [Link] {
		let regex = "https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
		let URLs = self.WASMatchesForRegex(regex: regex)
		var links = [Link]()
		for url in URLs {
			links.append(Link(url: url))
		}
		return links
	}
	func URLTitle() -> String {
		var string = ""
		let regex = "(?<=\\<title\\>)(\\s*.*\\s*)(?=\\<\\/title\\>)"
		let titles = self.WASMatchesForRegex(regex: regex)
		if let title = titles.first {
			string = title
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
				strings.append(color)
			}
		}
		return strings
	}
	func toColor() -> UIColor? {
		var string = self.trim()
		guard string.hasPrefix("#"), string.characters.count == 7 else {
			return nil
		}
		string = string.uppercased()
		string = string.removeFirst()
		
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

var str = "@bob @john @wagner_ @google,@hipchat@pru (success) such a cool feature; http://twitter.com/jdorfman/status/430511497475670016 #00ffff00 salesawagner@gmail.com"


let message = Message(message: str)
message.output()