//
//  CreditScore.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import Foundation

struct CreditScore : Decodable
{
	let score: Int
	let maxScore: Int
	
	enum CodingKeys: String, CodingKey
	{
		case creditReportInfo
	}
	
	enum CreditReportInfoCodingKeys: String, CodingKey
	{
		case score
		case maxScore = "maxScoreValue"
	}
	
	init(from decoder: Decoder) throws
	{
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let creditReportInfo = try container.nestedContainer(keyedBy: CreditReportInfoCodingKeys.self, forKey: .creditReportInfo)
		
		score = try creditReportInfo.decode(Int.self, forKey: .score)
		maxScore = try creditReportInfo.decode(Int.self, forKey: .maxScore)
	}
}
