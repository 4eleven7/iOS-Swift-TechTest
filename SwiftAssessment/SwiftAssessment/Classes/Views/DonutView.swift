//
//  DonutView.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import UIKit

class DonutView: UIView
{
	@IBOutlet private weak var titleLabel: UILabel!
	
	@IBOutlet private weak var currentScoreLabel: UILabel!
	
	@IBOutlet private weak var maxScoreLabel: UILabel!
	
	var currentScore: Int = 0
	{
		didSet {
			currentScoreLabel.text = "dashboard.donut.score.current".localized
		}
	}
	
	var maxScore: Int = 0
	{
		didSet {
			maxScoreLabel.text = "dashboard.donut.score.max".localized
		}
	}
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		assert(titleLabel != nil, "\(self) requires titleLabel outlet to be set")
		titleLabel.text = "dashboard.donut.title".localized
		
		assert(currentScoreLabel != nil, "\(self) requires currentScoreLabel outlet to be set")
		currentScoreLabel.text = ""
		
		assert(maxScoreLabel != nil, "\(self) requires maxScoreLabel outlet to be set")
		maxScoreLabel.text = ""
	}
}
