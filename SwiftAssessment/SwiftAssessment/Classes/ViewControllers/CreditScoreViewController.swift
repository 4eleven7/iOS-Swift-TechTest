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
				self?.activityIndicator.stopAnimating()
			
				guard let value = result.value else
				{
					self?.displayError(error: result.error)
					return
				}
			
				self?.donutView.currentScore = value.score
				self?.donutView.maxScore = value.maxScore
		}
	}
	
	// TODO: Ideally we'd check the error and give guidance on what the user should do next
	// Also I'd rather have a dismiss button, with a retry button somewhere in the interface to trigger a retry without the endless alerts
	private func displayError(error: Error?)
	{
		let alertController = UIAlertController(title: "dashboard.error.title".localized, message: "dashboard.error.description".localized, preferredStyle: .alert)
		let retry = UIAlertAction(title: "dashboard.error.actions.retry".localized, style: .default)
		{
			[weak self]
			action in
				self?.updateCreditScore();
		}
		
		alertController.addAction(retry)
		
		present(alertController, animated: true, completion: nil)
	}
}
