//
//  stackLoadingView.swift
//  animationChallenges
//
//  Created by Andrew Tsukuda on 5/9/18.
//  Copyright © 2018 Andrew Tsukuda. All rights reserved.
//

import UIKit

/**
    The different types of transitions
 
     ````
     case shutter
     case fadeOnly
     ````
*/
public enum TransitionType {
    /// Default animation. Lines fade-in in 'shutter' fashion
    case shutter // default
    
    /// Only animates logo, nothing else
    case fadeOnly
}

/**
    Options for the shutter effect lines
 
     ````
     case vertical
     case horizontal
     ````
*/
public enum LineOrientation {
    /// Creates Vertical lines like |||||
    case vertical
    
    /// Creates horizontal lines from top to bottom like =
    case horizontal
}

/**
    A Subclass of UIView that displays an animated splash screen.
 
    Meant to be used as the first view that appears in your app.
 
 */
public class SplashScreenView: UIView {
    
    private var imageView: UIImageView!

    var lineCount: Int!  // Number of lines
    
    private var shouldAnimateLogo: Bool!
    private var shouldDrawLines: Bool!
    
    private override init(frame: CGRect) {
        super.init(frame: frame)

        shouldDrawLines = false
        shouldAnimateLogo = false
    }
    
    /**
        Initializes and returns a newly allocated splash screen view with the specified parameters. Use this initializer to have the most control over your animation.
     
        - Parameter frame: **CGRect** Rect that dictates the location of the view.
            Defaults to the screen size (whole screen).
        - Parameter imageColor: **UIColor** Color of the image.
        - Parameter imageSize: **CGSize** Size of the image.
        - Parameter imageName: **String** Name of image. Use the filename of asset
        - Parameter transition: **TransitionType** Type of transition.
        - Parameter lineOrientation: **LineOrientation** Line Orientation. More info in enum doc
    */
    public convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), imageColor: UIColor, imageSize: CGSize, imageName: String, transition: TransitionType = .fadeOnly, lineOrientation: LineOrientation = .horizontal, lineColor: UIColor = .white) {
        self.init(frame: frame)
        
        /* Set Default Values for required vars */
        lineCount = 10
        shouldAnimateLogo = true
        

        backgroundColor = imageColor
        
        let x = bounds.midX - (0.5 * imageSize.width)
        let y = bounds.midY - (0.5 * imageSize.height)
        setImageView(fromName: imageName, withSize: imageSize, withOriginPoint: CGPoint(x: x, y: y))
        addSubview(self.imageView)
        
        
        switch transition {
        case .fadeOnly:
            backgroundColor = UIColor.white
            animateLogo()
        case .shutter :
            animateLines(lineOrientation: lineOrientation, lineColor: lineColor)
        }
    }
    
    /**
        Initializes and returns a newly allocated splash screen view with the specified image.
     
        - Parameter frame: **CGRect** Rect that dictates the location of the view.
        Defaults to the screen size (whole screen).
        - Parameter imageName: **String** Name of image. Use the filename of asset
     */
    public convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), imageName: String) {
        self.init(frame: frame, imageColor: UIColor.black, imageSize: CGSize(width: 200, height: 200), imageName: imageName)
    }
    
    /**
     Initializes and returns a newly allocated splash screen view with the specified parameters. Use this initializer to create Splash Screen without logo and only animated lines.
     
     - Parameter frame: **CGRect** Rect that dictates the location of the view.
     Defaults to the screen size (whole screen).
     - Parameter lineOrientation: **LineOrientation**
     - Parameter lineCount: **Int** Number of lines to be produced (default is 10)
     - Parameter lineColor: **UIColor** Color of the incoming lines (default is white)
     - Parameter backgroundColor: **UIColor** Color of the background (default is black)
     */
    public convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), lineOrientation: LineOrientation = .horizontal, lineCount: Int = 10, lineColor: UIColor = .white, backgroundColor: UIColor = .black) {
        self.init(frame: frame)
        self.lineCount = lineCount
        self.backgroundColor = backgroundColor
        animateLines(lineOrientation: lineOrientation, lineColor: lineColor)
    }
    
    // MARK: Animate Lines
    private func animateLines(lineOrientation: LineOrientation, lineColor: UIColor = UIColor.white) {
        
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
            
            let delay: TimeInterval = 1 + (0.05 * Double(i)) + Double(1 / Double(lineCount))
            let lineAnimationDuration = 0.5
            if i == (lineCount - 1){
                UIView.animate(withDuration: lineAnimationDuration, delay: delay, options: [], animations: {
                    lineView.backgroundColor = lineColor
                    
                }, completion: { (bool) in
                    // Fade Out View
                    UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                        self.layer.opacity = 0
                    }, completion: { (bool) in
                        if self.shouldAnimateLogo {
                            self.animateLogo(lines: true)
                        } else {
                            self.removeFromSuperview()
                        }
                    })
                })
            } else {
                UIView.animate(withDuration: lineAnimationDuration, delay: delay, options: [], animations: {
                    lineView.backgroundColor = lineColor
                    
                }, completion: nil)
            }
            
        }
    }
    
    // MARK: Animate Logo
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
            UIView.animate(withDuration: 0.8, delay: 0, options: [], animations: {
                self.imageView.frame = self.imageView.frame.insetBy(dx: -100, dy: -100)
                self.layer.opacity = 0
            }, completion: { (bool) in
                self.removeFromSuperview()
            })
        })
    }
    
    // MARK: Create Image View and set
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
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
