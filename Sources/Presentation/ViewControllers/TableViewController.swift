//
//  TableViewController.swift
//  waschat
//
//  Created by Wagner Sales on 05/12/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit

//**************************************************************************************************
//
// MARK: - Constants -
//
//**************************************************************************************************

private let kMentionsSegue	= "MentionsSegue"
private let kEmoticonsSegue = "EmoticonsSegue"
private let kColorsSegue	= "ColorsSegue"
private let kLinksSegue		= "LinksSegue"
private let kAllSegue		= "AllSegue"

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

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let identifier = segue.identifier {
			var string: String?
			switch identifier {
				case kMentionsSegue:
					string = "@chris you around?"
				case kEmoticonsSegue:
					string = "Good morning! (megusta) (coffee)"
				case kColorsSegue:
					string = "Nice color #FFFFFF"
				case kLinksSegue:
					string = "Olympics are starting soon;http://www.nbcolympics.com"
				case kAllSegue:
					string = "@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
			default:
				break
			}
			if let viewController = segue.destination as? WASViewController {
				viewController.string = string
			}
			if let viewController = segue.destination as? ParseViewController {
				viewController.string = string!
			}
		}
    }
}
