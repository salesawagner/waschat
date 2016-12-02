//
//  UIView+WASCorner.swift
//
//
//  Created by Wagner Sales on 02/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

extension UIView {
	@IBInspectable var WAScornerRadius: CGFloat {
		get {
			return layer.cornerRadius
		}
		set {
			layer.cornerRadius = newValue
			layer.masksToBounds = newValue > 0
		}
	}	
}
