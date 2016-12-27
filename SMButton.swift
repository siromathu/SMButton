//
//  SMButton.swift
//  Sample
//
//  Created by Siroson Mathuranga Sivarajah on 26/12/16.
//  Copyright © 2016 Siroson Mathuranga Sivarajah. All rights reserved.
//

let checkMark = "✓"
let errorMark = "✕"

import UIKit

class SMButton: UIButton, Shakeable {
    
    // MARK: - Types
    enum Status {
        case start, failed, success
    }
    
    var updateStatus = Status.start {
        didSet {
            switch updateStatus {
            case .start:
                startActivity()
                
            case .failed:
                endActivity(title: errorMark, isFailed: true)
                
            case .success:
                endActivity(title: checkMark, isFailed: false)
            }
        }
    }
    
    // MARK:- Properties
    private var buttontitleLabel = UILabel()
    private var activityIndicator: UIActivityIndicatorView!
    
    public var title: String! {
        didSet {
            buttontitleLabel.text = title
        }
    }
    
    // MARK:- Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, title: String) {
        self.init(frame: frame)
        
        layer.cornerRadius = 5.0
        backgroundColor = #colorLiteral(red: 0.3486660123, green: 0.6849880219, blue: 0.3210497797, alpha: 1)
        
        self.title = title
        
        // add controls
        setTitleLabel()
        setActivityIndicator()
    }
    
    override func setTitle(_ title: String?, for state: UIControlState) {
        super.setTitle("", for: .normal)
        
        self.title = title
    }
    
    // MARK: - Conveniance Methods
    private func setTitleLabel() {
        buttontitleLabel = UILabel(frame: self.bounds)
        buttontitleLabel.isUserInteractionEnabled = false
        buttontitleLabel.font = UIFont.systemFont(ofSize: 20.0)
        buttontitleLabel.textColor = .white
        buttontitleLabel.textAlignment = .center
        buttontitleLabel.backgroundColor = .clear
        buttontitleLabel.text = self.title
        addSubview(buttontitleLabel)
    }
    
    private func setActivityIndicator() {
        activityIndicator = UIActivityIndicatorView()
        activityIndicator.isUserInteractionEnabled = false
        let xPos = bounds.size.width/2
        let yPos = bounds.size.height + bounds.size.height/2
        activityIndicator.center = CGPoint(x: xPos, y: yPos)
        addSubview(activityIndicator)
    }
    
    func startActivity() {
        self.backgroundColor = #colorLiteral(red: 0.3486660123, green: 0.6849880219, blue: 0.3210497797, alpha: 1)
        activityIndicator.startAnimating()
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.buttontitleLabel.frame.origin.y = -self.frame.size.height
            
            let xPos = self.bounds.size.width/2;
            let yPos = self.bounds.size.height/2;
            self.activityIndicator.center = CGPoint(x: xPos, y: yPos);
            
        }, completion: nil)
    }
    
    func endActivity(title: String, isFailed: Bool) {
        self.buttontitleLabel.text = title
        self.buttontitleLabel.frame.origin.y = self.frame.size.height
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            if isFailed {
                self.backgroundColor = .red
            }
            
            self.buttontitleLabel.frame.origin.y = 0
            self.activityIndicator.center.y = -(self.bounds.size.height + self.bounds.size.height/2)
            
        }, completion: { finished in
            self.activityIndicator.stopAnimating()
            let xPos = self.bounds.size.width/2
            let yPos = self.bounds.size.height + self.bounds.size.height/2
            self.activityIndicator.center = CGPoint(x: xPos, y: yPos)
            
            if isFailed {
                self.shake()
            }
        })
    }
}

// MARK: - Protocols
protocol Shakeable {
    func shake()
}

extension Shakeable where Self: UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4.0, y: self.center.y))
        layer.add(animation, forKey: "position")
    }
}
