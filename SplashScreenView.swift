//
//  stackLoadingView.swift
//  animationChallenges
//
//  Created by Andrew Tsukuda on 5/9/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import UIKit

enum TransitionType {
    case shutter // default
    case fadeOnly
}

enum LineOrientation {
    case vertical
    case horizontal
}

class SplashScreenView: UIView {
    
    private var imageView: UIImageView!

    var lineCount: Int!  // Number of lines
    var lineAnimationDuration: Double!
    
    var imageName: String!
    var shouldAnimateLogo: Bool!
    var shouldDrawLines: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        shouldAnimateLogo = false
        shouldDrawLines = false
    }
    
    convenience init(frame: CGRect, logoColor: UIColor, logoSize: CGSize, logoName: String, transition: TransitionType = .fadeOnly, lineOrientation: LineOrientation = .horizontal) {
        self.init(frame: frame)
        
        /* Set Default Values for required vars */
        lineCount = 10
        shouldAnimateLogo = true
        
        backgroundColor = logoColor
        
        let x = bounds.midX - (0.5 * logoSize.width)
        let y = bounds.midY - (0.5 * logoSize.height)
        setImageView(fromName: logoName, withSize: logoSize, withOriginPoint: CGPoint(x: x, y: y))
        addSubview(self.imageView)
        
        switch transition {
        case .fadeOnly:
            backgroundColor = UIColor.white
            animateLogo()
        case .shutter :
            animateLines(lineOrientation: lineOrientation)
        }
    }
    
    convenience init(frame: CGRect, imageName: String) {
        self.init(frame: frame, logoColor: UIColor.black, logoSize: CGSize(width: 200, height: 200), logoName: imageName)
        
    }
    
    convenience init(frame: CGRect, lineOrientation: LineOrientation = .horizontal, lineCount: Int = 10) {
        self.init(frame: frame)
        self.lineCount = lineCount
        backgroundColor = UIColor.black
        animateLines(lineOrientation: lineOrientation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animateLines(lineOrientation: LineOrientation) {
        
        var lineHeight: CGFloat = 0
        var lineWidth: CGFloat = 0
        var lineFrame = CGRect.zero
        
        switch lineOrientation {
        case .horizontal:
            lineHeight = bounds.maxY / CGFloat(lineCount)
            lineWidth = bounds.maxX
        
        case .vertical:
            lineHeight = bounds.maxY
            lineWidth = bounds.maxX / CGFloat(lineCount)
        }
        for i in 0...lineCount {
            if lineOrientation == .horizontal {
                lineFrame = CGRect(x: 0, y: (self.bounds.minY + (CGFloat(i) * lineHeight)), width: lineWidth, height: lineHeight)
            } else {
                lineFrame = CGRect(x: (self.bounds.minX + (CGFloat(i) * lineWidth)), y: 0, width: lineWidth, height: lineHeight)
            }
            let lineView = UIView(frame: lineFrame)
            lineView.backgroundColor = UIColor.clear
            addSubview(lineView)
            sendSubview(toBack: lineView)
            let delay: TimeInterval = 1 + (0.05 * Double(i)) + Double(1 / Double(lineCount))
            lineAnimationDuration = 0.5
            UIView.animate(withDuration: lineAnimationDuration, delay: delay, options: [], animations: {
                lineView.backgroundColor = UIColor.white
            }, completion: nil)
            if i == (lineCount - 1) && shouldAnimateLogo {
                animateLogo(lines: true)
            }
        }
        
    }
    
    private func animateLogo(lines: Bool = false) {
        /* Make Logo dissappear */
        var logoDelay = TimeInterval(0.5)
        
        // Make logo delay longer if lines are being drawn
        if lines {
            logoDelay = 1 + (0.05 * Double(lineCount)) + Double(1 / Double(lineCount))
        }
        
        // Shrink
        UIView.animate(withDuration: 0.2, delay: logoDelay, options: [], animations: {
            self.imageView.frame = self.imageView.frame.insetBy(dx: 10, dy: 10)
        }, completion: { (complete) in
            
            // Grow and fade
            UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
                self.imageView.frame = self.imageView.frame.insetBy(dx: -50, dy: -50)
                self.imageView.layer.opacity = 0
            }, completion: nil)
        })
    }
    
    private func setImageView(fromName: String, withSize: CGSize?, withOriginPoint: CGPoint?) {
        let imageView = UIImageView(image: UIImage(named: fromName))
        var size = CGSize(width: 200, height: 200)
        if let withSize = withSize {
            size = withSize
        }
        
        var x = bounds.midX - (0.5 * size.width)
        var y = bounds.midY - (0.5 * size.height)
        
        if let withOriginPoint = withOriginPoint {
            x = withOriginPoint.x
            y = withOriginPoint.y
        }
        
        imageView.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        self.imageView = imageView
    }
}
