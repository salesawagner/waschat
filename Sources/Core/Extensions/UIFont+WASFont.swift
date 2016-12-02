//
//  UIFont+WASFont.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension UIFont {
	class func WASFontWithSize(_ fontSize: CGFloat = 14) -> UIFont {
		return UIFont(name: "Avenir-Book", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
	}
	class func WASnavigationBarFont() -> UIFont {
		let fontSize: CGFloat = 17
		return UIFont(name: "Avenir-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
	}
}
