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
	
	var string: String? {
		didSet {
			self.textField.text = ""
			self.updateTextView()
		}
	}
	@IBOutlet weak var textView: UITextView!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var bottomConstraint: NSLayoutConstraint!
	
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
	
	private func updateTextView() {
		if let str = self.string {
			let message = Message(message: str)
			self.textView.text = message.output()
		}
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
		self.string = self.textField.text
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
		self.string = "@bob @john @wagner_ @google,@hipchat@pru (success) such a cool feature; http://twitter.com/jdorfman/status/430511497475670016 #00ffff00 salesawagner@gmail.com"
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
extension ViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.string = self.textField.text
		return textField.resignFirstResponder()
	}
}
