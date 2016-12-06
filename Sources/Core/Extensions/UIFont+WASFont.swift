//
//  UIFont+WASFont.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension UIFont {
	class func WASFontWithSize(name: String = "Avenir-Book", _ fontSize: CGFloat = 14) -> UIFont {
		return UIFont(name: name, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
	}
	class func WASnavigationBarFont() -> UIFont {
		let fontSize: CGFloat = 17
		return UIFont.WASFontWithSize(name: "Avenir-Medium", fontSize)
	}
}
