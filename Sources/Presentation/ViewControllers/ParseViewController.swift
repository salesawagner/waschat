//
//  ParseViewController.swift
//  waschat
//
//  Created by Wagner Sales on 06/12/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

class ParseViewController: UIViewController {

	var string: String = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "ParseContainerSegue" {
			if let viewController = segue.destination as? WASViewController {
				viewController.string = self.string
			}
		}
	}
}
