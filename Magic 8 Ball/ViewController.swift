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
    
    @IBAction func shake(_ sender: Any) {
        self.magicBallView.animateShake()
        self.magicBallLabel.text = fortunesArray.randomElement()?.uppercased()
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            shake(motion)
        }
    }
}

extension UIView {
    func animateShake() {
        // Down
        self.transform = CGAffineTransform(translationX: 0, y: 25)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        
        
        // Delay by 0.5 sec then
        
                
        // Down + fade text to 0.5
        
        // Up + fade text to 0.0
        
        // Down + bubble up
        
        // Up + bubble up
        
        // Down + bubble up
        
        // Up + bubble up + fade new text to 0.5
        
        // Down + bubble up + new text to 1
        
        // Rest + bubble up
        
    }
}
