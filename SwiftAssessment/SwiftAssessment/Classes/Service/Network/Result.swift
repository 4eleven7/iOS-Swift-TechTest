//
//  Result.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

enum Result<T>
{
	case success(T)
	case failure(Error)
}

extension Result
{
	var value: T?
	{
		guard case .success(let value) = self else {
			return nil
		}
		
		return value
	}
	
	var error: Error?
	{
		guard case .failure(let error) = self else {
			return nil
		}
		
		return error
	}
}

typealias ResultCompletion<T> = (Result<T>) -> Void
