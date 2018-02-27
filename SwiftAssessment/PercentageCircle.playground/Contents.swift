//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class DonutView: UIView
{
	private let shapeLayer = CAShapeLayer()
	
	override func draw(_ rect: CGRect)
	{
		super.draw(rect)
		
		let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
		
		let path = UIBezierPath(arcCenter: center, radius: frame.size.width / 2, startAngle: -CGFloat.pi / 2, endAngle: 1.5 * CGFloat.pi, clockwise: true)
		shapeLayer.path = path.cgPath
		shapeLayer.strokeColor = UIColor.white.cgColor
		shapeLayer.lineWidth = 5
		shapeLayer.strokeEnd = 0.7
		shapeLayer.fillColor = UIColor.clear.cgColor
		shapeLayer.lineCap = kCALineCapRound
		layer.addSublayer(shapeLayer)
	}
}

class MyViewController : UIViewController
{
	override func loadView()
	{
		self.view = DonutView()
	}
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
