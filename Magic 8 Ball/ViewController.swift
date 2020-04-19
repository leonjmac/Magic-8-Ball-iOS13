//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Angela Yu on 14/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var magicBallView: UIView!
    @IBOutlet weak var magicBallLabel: UILabel!
    @IBOutlet weak var askButton: UIButton!
    
    let fortunesArray = ["Don\'t count on it", "Seems unlikely", "Perhaps", "Ask me later", "Yes", "Nope", "¯\\_(ツ)_/¯" ]
    var starsView = UIView()
    
    override func viewDidLoad() {
        var starsArray: [CAShapeLayer] = []
        for _ in 0..<10 {
            // Draw  stars
            starsArray.append(drawDiamond(CGSize(width: 37.5, height: 50.0)))
        }
        
        self.starsView = UIView(frame: self.view.frame)
        _ = starsArray.map({ shape in
            let star = UIView()
            star.layer.addSublayer(shape)
            let xOrigin = Int.random(in: (Int(self.magicBallView.frame.origin.x) + 40)...(Int(self.magicBallView.frame.size.width) - 40))
            let yOrigin = Int.random(in: (Int(self.magicBallView.frame.origin.y) + 40)...(Int(self.magicBallView.frame.size.height) - 40))
            star.frame.origin = CGPoint(x: xOrigin, y: yOrigin)
            starsView.addSubview(star)
        })
        // Ensure stars are inserted below other UI elements
        self.view.insertSubview(starsView, at: 0)
    }
    
    @IBAction func shake(_ sender: Any) {
        self.askButton.isEnabled.toggle()
        _ = self.starsView.subviews.map { view in
            self.pulse(shape: view, withDelay: 0.125 * Double(Int.random(in: 0..<5)))
        }
        self.swapMagicLabelText((fortunesArray.randomElement()?.uppercased())!)
        self.magicBallView.animateShake(withCompletion: { finished in
            self.askButton.isEnabled = finished
        })
    }
    
    func pulse(shape:UIView, withDelay delay: Double = 0.0) {
        shape.layer.anchorPoint = CGPoint(x: shape.frame.width / 2.0, y:shape.frame.height / 2.0)
        UIView.animate(withDuration: 0.5, delay: delay, options: [.curveEaseInOut, .autoreverse], animations: {
            shape.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            shape.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { finished in
            shape.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    
    func swapMagicLabelText(_ value: String) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
            self.magicBallLabel.alpha = 0.0
        }, completion: {
            finished in
                self.magicBallLabel.text = value
                UIView.animate(withDuration: 0.5, animations: {
                self.magicBallLabel.alpha = 1.0
            })
        })
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shake(motion)
        }
    }
    
    func drawDiamond(_ size: CGSize) -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x:size.width / 2.0 , y:0.0))
        path.addQuadCurve(to: CGPoint(x: size.width, y: size.height / 2.0), controlPoint: CGPoint(x: 0.625 * size.width , y: 0.375 * size.height))
        path.addQuadCurve(to: CGPoint(x: size.width / 2.0 , y: size.height), controlPoint: CGPoint(x: 0.625 * size.width , y: 0.625 * size.height))
        path.addQuadCurve(to: CGPoint(x: 0.0 , y: size.height / 2.0), controlPoint: CGPoint(x: 0.375 * size.width, y: 0.625 * size.height))
        path.addQuadCurve(to: CGPoint(x: size.width / 2.0 , y: 0.0), controlPoint: CGPoint(x: 0.375 * size.width, y: 0.375 * size.height))

        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.fillColor = UIColor.yellow.cgColor
        return shape
    }
}

extension UIView {
    func animateShake(withCompletion completion:((Bool) -> Void)?) {
        self.transform = CGAffineTransform(translationX: 0, y: 35)
        UIView.animate(withDuration: 1.25, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: completion)
    }
}
