//
//  UIViewController+WASViewController.swift
//
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit
import SCLAlertView

extension UIViewController {
	func showError() {
		let style: SCLAlertViewStyle = .error
		let colorStyle = UIColor.WASRedColor().WASColorToUInt()
		let title		= L.sorry
		let subtitle	= L.somethingWentWrong
		SCLAlertView().showTitle(title,
		                         subTitle: subtitle,
		                         style: style,
		                         duration: 0,
		                         colorStyle: colorStyle)
	}
	func preloadView() {
		let _ = view
	}
}
