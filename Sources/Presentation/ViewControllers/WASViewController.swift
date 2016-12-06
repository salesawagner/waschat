//
//  WASViewController.swift
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

class WASViewController: UIViewController {
	
	//**************************************************
	// MARK: - Properties
	//**************************************************
	
	var string: String? {
		didSet {
			self.updateUI()
		}
	}
	@IBOutlet weak var inputLabel: UILabel!
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var activityIndicator: UIActivityIndicatorView!
	
	//**************************************************
	// MARK: - Constructors
	//**************************************************
	
	//**************************************************
	// MARK: - Private Methods
	//**************************************************
	
	private func updateUI() {
		if let str = self.string, let inputLabel = self.inputLabel {
			inputLabel.text = self.string
			self.activityIndicator.startAnimating()
			str.asyncOutput(completion: { (output) in
				self.textView.text = output
				self.activityIndicator.stopAnimating()
			})
		}
	}
	
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
		self.updateUI()
	}
}
