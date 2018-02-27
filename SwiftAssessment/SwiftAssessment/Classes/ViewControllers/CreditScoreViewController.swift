//
//  CreditScoreViewController.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import UIKit

final class CreditScoreViewController: UIViewController
{
	@IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
	{
		didSet {
			activityIndicator.stopAnimating()
		}
	}
	
	@IBOutlet private weak var donutView: DonutView!
	{
		didSet {
			//tableView.delegate = self
		}
	}
	
	var creditScoreService: CreditScoreService!
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		title = "dashboard.title".localized
		
		assert(activityIndicator != nil, "\(self) requires activityIndicator outlet to be set")
		assert(donutView != nil, "\(self) requires donutView outlet to be set")
		
		creditScoreService = UserCreditScoreService()
		assert(creditScoreService != nil, "\(self) requires a CreditScoreService")
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		updateCreditScore()
	}
	
	private func updateCreditScore()
	{
		guard activityIndicator.isAnimating == false else {
			return
		}
		
		activityIndicator.startAnimating()
		
		creditScoreService?.loadScore
		{
			[weak self]
			result in
				print("Result: \(result)")
				guard let value = result.value else
				{
					// TODO: Handle errors
					return
				}
			
				self?.donutView.currentScore = value.score
				self?.donutView.maxScore = value.maxScore
			
				self?.activityIndicator.stopAnimating()
		}
	}
}
