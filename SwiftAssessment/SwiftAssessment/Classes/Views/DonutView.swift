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
	{
		didSet {
			titleLabel.text = "dashboard.donut.title".localized
			titleLabel.alpha = 0.0
		}
	}
	
	@IBOutlet private weak var currentScoreLabel: UILabel!
	{
		didSet {
			currentScoreLabel.text = ""
			currentScoreLabel.alpha = 0.0
		}
	}
	
	@IBOutlet private weak var maxScoreLabel: UILabel!
	{
		didSet {
			maxScoreLabel.text = ""
			maxScoreLabel.alpha = 0.0
		}
	}
	
	var currentScore: Int = 0
	{
		didSet {
			currentScoreLabel.text = String.localizedStringWithFormat("dashboard.donut.score.current".localized, currentScore)
			updateDonut()
		}
	}
	
	var maxScore: Int = 0
	{
		didSet {
			maxScoreLabel.text = String.localizedStringWithFormat("dashboard.donut.score.max".localized, maxScore)
			updateDonut()
		}
	}
	
	private let backgroundLayer = CAShapeLayer()
	private let progressLayer = CAShapeLayer()
	
	override func awakeFromNib()
	{
		super.awakeFromNib()
		
		backgroundColor = UIColor.white
		
		assert(titleLabel != nil, "\(self) requires titleLabel outlet to be set")
		assert(currentScoreLabel != nil, "\(self) requires currentScoreLabel outlet to be set")
		assert(maxScoreLabel != nil, "\(self) requires maxScoreLabel outlet to be set")
	}
	
	override func draw(_ rect: CGRect)
	{
		super.draw(rect)
		
		createOutsideCircle()
		createProgressCircle()
	}
	
	private func updateDonut()
	{
		// Safe to assume max score should never be 0
		guard maxScore != 0 && currentScore != 0 else {
			return
		}
		
		let pecentage = CGFloat(currentScore) / CGFloat(maxScore)
		
		let animation = CABasicAnimation(keyPath: "strokeEnd")
		animation.fromValue = 0.0
		animation.toValue = pecentage
		animation.duration = 2
		animation.fillMode = kCAFillModeForwards
		animation.isRemovedOnCompletion = false
		animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
		
		progressLayer.add(animation, forKey: "progressLayerAnimation")
		
		UIView.animate(withDuration: 1) {
			self.titleLabel.alpha = 1.0
			self.currentScoreLabel.alpha = 1.0
			self.maxScoreLabel.alpha = 1.0
		}
	}
}

extension DonutView
{
	private func createOutsideCircle()
	{
		backgroundLayer.removeFromSuperlayer()
		
		configure(layer: progressLayer, offset: 5)
		backgroundLayer.strokeColor = UIColor.black.cgColor
		backgroundLayer.lineWidth = 1
		backgroundLayer.strokeEnd = 1
		layer.addSublayer(backgroundLayer)
	}
	
	private func createProgressCircle()
	{
		progressLayer.removeFromSuperlayer()
		
		configure(layer: progressLayer)
		progressLayer.strokeColor = UIColor.orange.cgColor
		progressLayer.lineWidth = 5
		progressLayer.strokeEnd = 0
		layer.addSublayer(progressLayer)
	}
	
	private func configure(layer: CAShapeLayer, offset: CGFloat = 0)
	{
		let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
		let path = UIBezierPath(arcCenter: center, radius: (frame.size.width / 2) + offset, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
		layer.path = path.cgPath
		layer.fillColor = UIColor.clear.cgColor
		layer.lineCap = kCALineCapRound
	}
}
