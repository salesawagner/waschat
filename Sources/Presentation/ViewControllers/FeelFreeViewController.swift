//
//  FeelFreeViewController.swift
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

class FeelFreeViewController: UIViewController {
	
	//**************************************************
	// MARK: - Properties
	//**************************************************
	
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	var viewController: WASViewController!
	
	//**************************************************
	// MARK: - Constructors
	//**************************************************
	
	//**************************************************
	// MARK: - Private Methods
	//**************************************************
	
	private func setupKeyBoardNotifications() {
		let notificationCenter = NotificationCenter.default
		notificationCenter.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
		notificationCenter.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
	
	fileprivate func setMessage(message: String?) {
		self.textField.text = ""
		self.viewController.string = message
	}
	
	//**************************************************
	// MARK: - Internal Methods
	//**************************************************
	
	func keyboardWillShow(notification: NSNotification) {
		if let info = notification.userInfo {
			let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
			let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? Double
			let curveValue = info[UIKeyboardAnimationCurveUserInfoKey] as? Int
			let curve = UIViewAnimationCurve(rawValue: curveValue!)
			let height: CGFloat = keyboardFrame.size.height
			
			UIView.beginAnimations("keyboardWillShow", context: nil)
			UIView.setAnimationDuration(duration!)
			UIView.setAnimationCurve(curve!)
			
			self.bottomConstraint.constant = height
			self.view.layoutIfNeeded()
			
			UIView.setAnimationDelegate(self)
			UIView.commitAnimations()
		}
	}
	
	internal func keyboardWillHide(notification: NSNotification) {
		if let info = notification.userInfo {
			let duration = info[UIKeyboardAnimationDurationUserInfoKey] as? Double
			let curveValue = info[UIKeyboardAnimationCurveUserInfoKey] as? Int
			let curve = UIViewAnimationCurve(rawValue: curveValue!)
			
			UIView.beginAnimations("keyboardWillHide", context: nil)
			UIView.setAnimationDuration(duration!)
			UIView.setAnimationCurve(curve!)
			
			self.bottomConstraint.constant = 0
			self.view.layoutIfNeeded()
			
			UIView.setAnimationDelegate(self)
			UIView.commitAnimations()
		}
	}
	
	@IBAction internal func sendButtonTapped(_ sender: Any) {
		self.setMessage(message: self.textField.text)
	}
	
	//**************************************************
	// MARK: - Public Methods
	//**************************************************
	
	//**************************************************
	// MARK: - Override Public Methods
	//**************************************************
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupKeyBoardNotifications()
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "FreeParseContainerSegue" {
			if let viewController = segue.destination as? WASViewController {
				self.viewController = viewController
			}
		}
	}
	
	deinit {
		let notificationCenter = NotificationCenter.default
		notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
		notificationCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
	}
}

//**********************************************************************************************************
//
// MARK: - Extension - UITextFieldDelegate
//
//**********************************************************************************************************

extension FeelFreeViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.setMessage(message: self.textField.text)
		return textField.resignFirstResponder()
	}
}
