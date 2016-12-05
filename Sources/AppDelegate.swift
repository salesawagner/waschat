//
//  AppDelegate.swift
//  waschat
//
//  Created by Wagner Sales on 02/12/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Attributes
		let titleAtributes = [
			NSForegroundColorAttributeName: UIColor.black,
			NSFontAttributeName: UIFont.WASnavigationBarFont()
		]
		// Navigation bar appearance
		let navAppearance = UINavigationBar.appearance()
		navAppearance.setBackgroundImage(UIImage(), for: .default)
		navAppearance.shadowImage = UIImage()
		navAppearance.barTintColor = UIColor.WASBlueColor()
		navAppearance.isTranslucent = false
		navAppearance.titleTextAttributes = titleAtributes
		// Navigation bar button appearance
		let barButtonAppearance = UIBarButtonItem.appearance()
		barButtonAppearance.setTitleTextAttributes(titleAtributes, for: UIControlState())
		return true
	}
}
