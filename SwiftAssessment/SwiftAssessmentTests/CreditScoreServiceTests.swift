//
//  CreditScoreServiceTests.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import XCTest
@testable import SwiftAssessment

class CreditScoreServiceTests: XCTestCase
{
	var service: CreditScoreService!
	var network: Network!
	
	override func setUp()
	{
		super.setUp()
		
		network = MockNetwork()
		service = UserCreditScoreService(network: network)
	}
	
	func testServiceSuccess()
	{
		let expectation = XCTestExpectation(description: "Service should successfully load credit score")
		
		service.loadScore
		{
			result in
				XCTAssertNotNil(result.value, "Result should contain a value")
				XCTAssertNil(result.error, "Result should not contain an error")
			
				expectation.fulfill()
		}
	}
	
	func testServiceFailure()
	{
		(network as! MockNetwork).failure = true
		
		let expectation = XCTestExpectation(description: "Service should attempt to load score, but fail")
		
		service.loadScore
		{
			result in
				XCTAssertNil(result.value, "Result should not contain a value")
				XCTAssertNotNil(result.error, "Result should contain an error")
			
				expectation.fulfill()
		}
	}
}

class MockNetwork: Network
{
	var failure: Bool = false
	
	func call<Endpoint: APIEndpoint>(_ api: Endpoint, completion: @escaping (_ response: Result<Endpoint.ResponseType>) -> Void)
	{
		guard failure == false else {
			return completion(.failure(ServiceErrors.generalError(err: nil)))
		}
		
		let bundle = Bundle(for: type(of: self))
		let url = bundle.url(forResource: "creditscorevalues", withExtension: "json")
		let jsonData = try! Data(contentsOf: url!)
		
		let value = try! JSONDecoder().decode(Endpoint.ResponseType.self, from: jsonData)
		
		completion(Result.success(value))
	}
}
