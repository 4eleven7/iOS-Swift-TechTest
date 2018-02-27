//
//  ServiceError.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

enum ServiceError: Error, CustomStringConvertible
{
	case invalidURL(url: String)
	case invalidJSON(jsonErr: Error)
	
	case generalError(err: Error?)
	
	var description: String
	{
		switch self
		{
			case .invalidURL(let url):
				return "error.service.invalid.url".localized + " " + url
			
			case .invalidJSON(let jsonErr):
				return "error.service.invalid.json".localized + " " + jsonErr.localizedDescription
			
			case .generalError(let err):
				return "error.service.unknown".localized + " " + (err?.localizedDescription ?? "")
		}
	}
}
