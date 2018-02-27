//
//  String+Localization.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

extension String
{
	var localized: String {
		return NSLocalizedString(self, comment: self)
	}
}
