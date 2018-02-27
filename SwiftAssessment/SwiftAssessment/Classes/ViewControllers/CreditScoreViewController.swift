//
//  CreditScoreViewController.swift
//  SwiftAssessment
//
//  Created by Dan Love on 27/02/2018.
//  Copyright © 2018 Shh Love Ltd. All rights reserved.
//

import UIKit

class CreditScoreViewController: UIViewController
{
	var creditScoreService: CreditScoreService?
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		creditScoreService = UserCreditScoreService()
	}
	
	override func viewDidAppear(_ animated: Bool)
	{
		creditScoreService?.loadScore
		{
			result in
				print("Result: \(result)")
		}
	}
}
