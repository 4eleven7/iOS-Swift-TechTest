//
//  Network.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

/**
 * This abstraction allows you to switch between whatever network library you wanted.
 *
 * Most people use Alamofire, and I would likely do so also, in a production app.
 * I just didn't want to set up cocoapods for a demo...
 * However using Alamofire across the board allows you to use a lot of nice convenience features like URLConvertible etc.
 */
protocol Network
{
	/**
	 * Completion should always return on the main thread
	 */
	func call<Endpoint: APIEndpoint>(_ api: Endpoint, completion: @escaping (_ response: Result<Endpoint.ResponseType>) -> Void)
}

/**
 * Standard iOS Network Session (ie, URLSession.)
 */
final class StandardNetworkSession: Network
{
	private let session = URLSession(configuration: .default)
	
	func call<Endpoint: APIEndpoint>(_ api: Endpoint, completion: @escaping (_ response: Result<Endpoint.ResponseType>) -> Void)
	{
		// Check we have a valid URL, if not return an error
		guard let url = URL(string: api.path) else
		{
			let error = ServiceError.invalidURL(url: api.path)
			return completion(.failure(error))
		}
		
		let task = session.dataTask(with: URLRequest(url: url))
		{
			responseData, responseUrl, responseError in
				DispatchQueue.main.async
				{
					if let error = responseError
					{
						let serviceError = ServiceError.generalError(err: error)
						return completion(.failure(serviceError))
					}
					else if let jsonData = responseData
					{
						do
						{
							// We keep this generic by using the associated type ReponseType and Decodable
							let result = try JSONDecoder().decode(Endpoint.ResponseType.self, from: jsonData)
							return completion(.success(result))
						}
						catch (let error)
						{
							if let jsonString = String(data: jsonData, encoding: String.Encoding.utf8) {
								print(jsonString)
							}
							
							let serviceError = ServiceError.invalidJSON(jsonErr: error)
							return completion(.failure(serviceError))
						}
					}
					else
					{
						let serviceError = ServiceError.generalError(err: nil)
						return completion(.failure(serviceError))
					}
				}
		}
		
		task.resume()
	}
}
