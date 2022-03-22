//
//  UIViewEx.swift
//  SwiftExtension
//
//  Created by xuzexin on 2022/3/21.
//

import UIKit

extension UIView{
    
    // 淡入
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1
        }, completion: completion)
    }

    // 淡出
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if isHidden {
            isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }, completion: completion)
    }
    
    class func animateTransitionWithType(type : CATransitionType, view : UIView){

        /*  type:

         kCATransitionFade,          //淡入淡出
         kCATransitionPush,          //推挤
         kCATransitionReveal,        //揭开
         kCATransitionMoveIn,        //覆盖
         cube,                       //立方体
         suckEffect,                 //吮吸
         oglFlip,                    //翻转
         rippleEffect,               //波纹
         pageCurl,                   //翻页
         pageUnCurl,                 //反翻页
         cameraIrisHollowOpen,       //开镜头
         cameraIrisHollowClose,      //关镜头
         
         */
        

        //创建CATransition对象
        let animation = CATransition()
        
        //设置运动type
        animation.type = type;
        
        //设置运动时间
        animation.duration = 1.5
        
        view.layer.add(animation, forKey: "animation")
    }
    
    //截当前View为图片
    func screenShot() -> UIImage? {
        
        guard frame.size.height > 0 && frame.size.width > 0 else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }

    //文字渐变色
    func gradientLayer(superView : UIView, tag : String?, colors : Array<Any>){
  
        for (_,item) in superView.layer.sublayers!.enumerated() {
            
            if item.accessibilityValue == tag {
                item.removeFromSuperlayer()
            }
        }

        //渐变颜色
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        
        //设置渐变的主颜色（可多个颜色添加）
        gradientLayer.colors = colors
        
        //将gradientLayer作为子layer添加到主layer上
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        superView.layer.addSublayer(gradientLayer)
        
        
        self.backgroundColor = UIColor.clear
        gradientLayer.mask = self.layer
        self.frame = gradientLayer.bounds

        gradientLayer.accessibilityValue = tag
        
    }
    
    //背景渐变色
    func gradientLayerBackground(colors : Array<Any>) {

        //渐变颜色
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        //设置渐变的主颜色（可多个颜色添加）
        gradientLayer.colors = colors
        
        //将gradientLayer作为子layer添加到主layer上
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        gradientLayer.cornerRadius = 2
        gradientLayer.masksToBounds = true

    }
    
}


extension UIView {
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        } set {
            self.frame = CGRect(x: newValue, y: self.y, width: self.width, height: self.height)
        }
    }
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        } set {
            self.frame = CGRect(x: self.x, y: newValue, width: self.width, height: self.height)
        }
    }
    public var width: CGFloat {
        get {
            return self.frame.size.width
        } set {
            self.frame = CGRect(x: self.x, y: self.y, width: newValue, height: self.height)
        }
    }
    public var height: CGFloat {
        get {
            return self.frame.size.height
        } set {
            self.frame = CGRect(x: self.x, y: self.y, width: self.width, height: newValue)
        }
    }
    public var left: CGFloat {
        get {
            return self.x
        } set {
            self.x = newValue
        }
    }
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set {
            self.x = newValue - self.width
        }
    }
    public var top: CGFloat {
        get {
            return self.y
        } set {
            self.y = newValue
        }
    }
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set {
            self.y = newValue - self.height
        }
    }
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame = CGRect(origin: newValue, size: self.frame.size)
        }
    }
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set {
            self.center.x = newValue
        }
    }
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set {
            self.center.y = newValue
        }
    }
    public var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame = CGRect(origin: self.frame.origin, size: newValue)
        }
    }
}

extension UIView {
    
    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach(addSubview(_:))
    }
    func removeAllSubviews() {
        subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
    }
    
    func setRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
