//
//  APIRequest.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

/**
 * You'd use this to build up a URLRequest
 * Currently only using it for path, as that is all that is required.
 * But using a builder pattern, we could use it for HTTP methods, auth, params, body etc.
 */
protocol APIEndpoint
{
	associatedtype ResponseType: Decodable
	
	var path: String { get }
}

final class APIRequest<Response: Decodable>: APIEndpoint
{
	typealias ResponseType = Response
	
	private(set) var path: String
	
	init (path: String)
	{
		self.path = path
	}
}
