//
//  ViewController.swift
//  waschat
//
//  Created by Wagner Sales on 02/12/16.
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

class ViewController: UIViewController {

	//**************************************************
	// MARK: - Properties
	//**************************************************
	
	@IBOutlet weak var textView: UITextView!
	
	//**************************************************
	// MARK: - Constructors
	//**************************************************
	
	//**************************************************
	// MARK: - Private Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Internal Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Public Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Override Public Methods
	//**************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let str = "@bob @john @wagner_ @google,@hipchat@pru (success) such a cool feature; http://twitter.com/jdorfman/status/430511497475670016 #00ffff00 salesawagner@gmail.com"
//		let str = "Olympics are starting soon;https://www.nbcolympics.com"
		let message = Message(message: str)
		self.textView.text = message.output()
		
		print(message.output())
		
	}

}

