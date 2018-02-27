//
//  CreditScoreService.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

protocol CreditScoreService
{
	func loadScore(completion: @escaping ResultCompletion<CreditScore>)
}

final class UserCreditScoreService: CreditScoreService
{
	private let network: Network
	
	init (network: Network = StandardNetworkSession())
	{
		self.network = network
	}
	
	func loadScore(completion: @escaping ResultCompletion<CreditScore>)
	{
		// TODO: Base URL should really be listed as an 'environment' in a scheme or in a plist etc
		let request = APIRequest<CreditScore>(path: "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values")
		
		network.call(request)
		{
			result in
				completion(result)
		}
	}
}
