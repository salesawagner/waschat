//
//  UIImageView+WASImageView.swift
//  wasband
//
//  Created by Wagner Sales on 30/11/16.
//  Copyright © 2016 Wagner Sales. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
	func WASsetImageWithUrl(_ photoUrl: String?) {
		if let url = Foundation.URL(string: photoUrl ?? "") {
			let placeholderImage = UIImage(named:"img_header")
			self.af_setImage(
				withURL: url,
				placeholderImage: placeholderImage,
				imageTransition: .crossDissolve(0.25)
			)
		}
	}
}
