//
//  MaximizableView.swift
//  Example
//
//  Created by LeeChan on 12/6/16.
//  Copyright © 2016 MarkiiimarK. All rights reserved.
//

import UIKit

class MaximizableView: UIView {
    
//    var fillView:UIView!
//    
//    lazy var containerView:UIView = {
//        let v = UIView()
//        v.layer.masksToBounds = true
//        v.layer.borderWidth = 0.2
//        v.layer.borderColor = UIColor.clear.cgColor
//        return v
//    }()
//    
//    var statusBarView:UIView!
//    let statusBarHeight:CGFloat = 19
//    
//    var statusBarIsDark:Bool = false {
//        didSet {
//            statusBarIsDark = UIApplication.shared.statusBarStyle == UIStatusBarStyle.default
//        }
//    }
//    var pointInFill:CGPoint {
//        didSet {
//            pointInFill = calculatePointInView(fillView: fillView)
//        }
//    }
//    @IBInspectable var animationDuration:TimeInterval
//    @IBInspectable var cornerRadius:CGFloat
//    @IBInspectable var shadowOpacity:Float
//    @IBInspectable var shadowRadius:CGFloat
//    @IBInspectable var springCoef:CGFloat
//    @IBInspectable var shadowOffset:CGSize
//    
//    var isMaximized:Bool {
//        didSet {
//            if isMaximized {
//                minimize()
//            } else {
//                maximize()
//            }
//        }
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        layer.shadowPath = UIBezierPath(roundedRect: layer.bounds, cornerRadius: cornerRadius).cgPath
//        containerView.frame = bounds
//        sharedInit()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func sharedInit() {
//        containerView = UIView(frame: bounds)
//        containerView.backgroundColor = backgroundColor
//        addSubview(containerView)
//        backgroundColor = UIColor.clear
//        while subviews.count > 1 {
//            containerView.addSubview(subviews.first!)
//        }
//        
//        animationDuration = 0.4
//        cornerRadius = 8.0
//        shadowOpacity = 0.5
//        shadowRadius = 2.0
//        springCoef = 0.8
//        shadowOffset = __CGSizeEqualToSize(CGSize.zero, shadowOffset) ? CGSize(width: 0, height: 1) : shadowOffset
//        isMaximized = false
//        
//        layer.masksToBounds = false
//        layer.shadowOffset = shadowOffset
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowRadius = shadowRadius
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = UIBezierPath(roundedRect: containerView.layer.bounds, cornerRadius: cornerRadius).cgPath
//    }
//    
//    override func prepareForInterfaceBuilder() {
//        sharedInit()
//    }
//    
//    // MAKR: - Variable Set Functions
//    func setCornerRadius(cornerRadius:CGFloat) {  layer.cornerRadius = cornerRadius  }
//    func setShadowOpacity(shadowOpacity:Float) {  layer.shadowOpacity = shadowOpacity  }
//    func setShadowRadius(shadowRadius:CGFloat) {  layer.shadowRadius = shadowRadius  }
//    func setShadowOffset(shadowOffset:CGSize) {  layer.shadowOffset = shadowOffset  }
//    
//    // MAKR: - Transitions
//    func maximize() {
//        fillView = getSuper()
//        layer.shadowOpacity = 0.0
//        fillView.addSubview(containerView)
//        containerView.frame = CGRect(x: pointInFill.x, y: pointInFill.y,
//                                     width: frame.size.width, height: frame.size.height)
//        if statusBarView != nil {
//            statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: statusBarHeight+1))
//        }
//        statusBarView.backgroundColor = containerView.backgroundColor
//        if let bgColor = statusBarView.backgroundColor {
//            let componentColors:[CGFloat] = bgColor.cgColor.components!
//            let colorBrightness:CGFloat = (componentColors[0]*299 + componentColors[1]*587 + componentColors[2]*114)/1000
//            
//            
//            if colorBrightness < 0.5 {
//                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
//            } else {
//                UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
//            }
//            
//            statusBarView.alpha = 0.0
//            fillView.addSubview(statusBarView)
//            
//            UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//                self.containerView.layer.cornerRadius = 0
//                self.containerView.frame = CGRect(x: 0, y: self.statusBarHeight, width: self.fillView.frame.size.width, height: self.fillView.frame.size.height-self.statusBarHeight)
//                self.statusBarView.alpha = 1
//            }, completion: { (completed) in
//                self.isMaximized = true
//            })
//        }
//    }
//    
//    func minimize() {
//        containerView.layer.cornerRadius = cornerRadius
//        UIApplication.shared.statusBarStyle = statusBarIsDark ? UIStatusBarStyle.default : UIStatusBarStyle.lightContent
//        
//        UIView.animate(withDuration: animationDuration, delay: 0, usingSpringWithDamping: springCoef, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
//            self.containerView.frame = CGRect(x: self.pointInFill.x, y: self.pointInFill.y, width: self.frame.size.width, height: self.frame.size.height)
//            self.statusBarView.alpha = 0
//            
//        }) { (completed) in
//            self.layer.shadowOpacity = self.shadowOpacity
//            self.addSubview(self.containerView)
//            self.containerView.frame = self.bounds
//            self.statusBarView.removeFromSuperview()
//            self.isMaximized = false
//        }
//    }
//    
//    func getSuper() -> UIView {
//        var tempView = self.superview
//        while (tempView?.superview != nil) {
//            tempView = tempView?.superview
//        }
//        return tempView!
//    }
//    
//    
//    func calculatePointInView(fillView:UIView) -> CGPoint {
//        var tempView = self
//        var point = CGPoint(x: 0, y: 0)
//        while (tempView != fillView) {
//            point.x += tempView.frame.origin.x
//            point.y += tempView.frame.origin.y
//            tempView = tempView.superview as! MaximizableView
//        }
//        return point
//    }
//    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        containerView.layer.cornerRadius = cornerRadius
//        layer.shadowRadius = shadowRadius
//        layer.shadowOpacity = shadowOpacity
//        layer.shadowPath = UIBezierPath(roundedRect: containerView.layer.bounds, cornerRadius: cornerRadius).cgPath
//    }
}
