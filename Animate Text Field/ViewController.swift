//
//  ViewController.swift
//  Animate Text Field
//
//  Created by JayAng on 8/21/15.
//  Copyright (c) 2015 JayAng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var animatedTextField: UITextField! {
        didSet {
            self.animatedTextField.delegate = self
            self.animatedTextField.tag = 1
            self.animatedTextField.font = UIFont(name: "HelveticaNeue", size: 20)
            self.animatedTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            self.animatedTextField.borderStyle = UITextBorderStyle.None
            self.animatedTextField.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
            
        }
    }
    
    @IBOutlet var animatedLabel: UILabel! {
        didSet {
            animatedLabel.text = "Fade Away!"
            animatedLabel.font = UIFont(name: "HelveticaNeue", size: 30)
            animatedLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var changeLabelTextField: UITextField! {
        didSet {
            self.changeLabelTextField.delegate = self
            self.changeLabelTextField.tag = 2
            self.changeLabelTextField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            self.changeLabelTextField.borderStyle = UITextBorderStyle.None
            self.changeLabelTextField.backgroundColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1)
            self.changeLabelTextField.font = UIFont(name: "HelveticaNeue", size: 20)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAndAnimateShapeLayer()

    }
    
    func createAndAnimateShapeLayer() {
        
        let animatedShapeLayer = CAShapeLayer()
        animatedShapeLayer.bounds = self.view.bounds
        animatedShapeLayer.position = self.view.center
        animatedShapeLayer.cornerRadius = self.view.bounds.width / 2
        self.view.layer.addSublayer(animatedShapeLayer)
        
        animatedShapeLayer.fillColor = UIColor.yellowColor().CGColor
        
        let midX = CGRectGetMidX(self.view.frame)
        let midY = CGRectGetMidY(self.view.frame)
        
        let startingPoint = UIBezierPath(roundedRect: CGRect(x: midX, y: midY, width: 0, height: 0), cornerRadius: 100).CGPath
        let endPoint = UIBezierPath(roundedRect: CGRect(x: -600, y: -100, width: 1500, height: 1500), cornerRadius: 5000).CGPath
        
        animatedShapeLayer.path = startingPoint
        
        let animationOfShape = CABasicAnimation(keyPath: "path")
        animationOfShape.toValue = endPoint
        animationOfShape.duration = 1
        animationOfShape.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animationOfShape.fillMode = kCAFillModeBoth //keep to value after completion
        animationOfShape.removedOnCompletion = false
        
        animatedShapeLayer.addAnimation(animationOfShape, forKey: animationOfShape.keyPath)
        
    }
    
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidChange(textField: UITextField) {
        
        if textField.tag == 1 {
            
            UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                let transition = CATransition.new()
                transition.duration = 1.0;
                transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                transition.type = kCATransitionFade
                
                textField.layer.addAnimation(transition, forKey: nil)
                
                }) { (finished: Bool) -> Void in
                    
                    var textFieldString = textField.text
                    
                    textField.text = textFieldString
            }
        } else if textField.tag == 2 {
            
            var animateLabelText = CATransition.new()
            animateLabelText.duration = 0.5
            animateLabelText.type = kCATransitionFromBottom
            
            animatedLabel.layer.addAnimation(animateLabelText, forKey: kCATransitionFromBottom)
            
            animatedLabel.text = textField.text
            
            if animatedLabel.text == "" {
                animatedLabel.text = "Fade Away!"
            }
            
            
        }
    }
}



