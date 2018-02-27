//
//  CreditScoreTests.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import XCTest
@testable import SwiftAssessment

class CreditScoreTests: XCTestCase
{
	func testDecodingCreditScore()
	{
		let bundle = Bundle(for: type(of: self))
		let url = bundle.url(forResource: "creditscorevalues", withExtension: "json")
		let jsonData = try! Data(contentsOf: url!)
		let creditScore = try! JSONDecoder().decode(CreditScore.self, from: jsonData)
		
		XCTAssertNotNil(creditScore)
		XCTAssertEqual(creditScore.score, 514)
		XCTAssertEqual(creditScore.maxScore, 700)
	}
}
