//
//  PQPastelView.swift
//  Swift彩虹渐变登录页面
//
//  Created by pgq on 2017/11/1.
//  Copyright © 2017年 pgq. All rights reserved.
//

import UIKit

@objc public enum PQPastelDefaultColor: Int {
    case warmFlame
    case nightFade
    case springWarmth
    case juicyPeach
    case youngPassion
    case ladyLips
    case sunnyMorning
    case rainyAshville
    case frozenDreams
    case winterNeva
    
    func colors() -> [UIColor] {
        switch self {
        case .warmFlame:
            return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1)]
        case .nightFade:
            return [#colorLiteral(red: 0.631372549, green: 0.5490196078, blue: 0.8196078431, alpha: 1), #colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1)]
        case .springWarmth:
            return [#colorLiteral(red: 0.9803921569, green: 0.8156862745, blue: 0.768627451, alpha: 1), #colorLiteral(red: 1, green: 0.8196078431, blue: 1, alpha: 1)]
        case .juicyPeach:
            return [#colorLiteral(red: 1, green: 0.9254901961, blue: 0.8235294118, alpha: 1), #colorLiteral(red: 0.9882352941, green: 0.7137254902, blue: 0.6235294118, alpha: 1)]
        case .youngPassion:
            return [#colorLiteral(red: 1, green: 0.5058823529, blue: 0.4666666667, alpha: 1), #colorLiteral(red: 1, green: 0.5254901961, blue: 0.4784313725, alpha: 1), #colorLiteral(red: 1, green: 0.5490196078, blue: 0.4980392157, alpha: 1), #colorLiteral(red: 0.9764705882, green: 0.568627451, blue: 0.5215686275, alpha: 1), #colorLiteral(red: 0.8117647059, green: 0.3333333333, blue: 0.4235294118, alpha: 1), #colorLiteral(red: 0.6941176471, green: 0.1647058824, blue: 0.3568627451, alpha: 1)]
        case .ladyLips:
            return [#colorLiteral(red: 1, green: 0.6039215686, blue: 0.6196078431, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1), #colorLiteral(red: 0.9960784314, green: 0.8117647059, blue: 0.937254902, alpha: 1)]
        case .sunnyMorning:
            return [#colorLiteral(red: 0.9647058824, green: 0.8274509804, blue: 0.3960784314, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.6274509804, blue: 0.5215686275, alpha: 1)]
        case .rainyAshville:
            return [#colorLiteral(red: 0.9843137255, green: 0.7607843137, blue: 0.9215686275, alpha: 1), #colorLiteral(red: 0.6509803922, green: 0.7568627451, blue: 0.9333333333, alpha: 1)]
        case .frozenDreams:
            return [#colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.9450980392, alpha: 1), #colorLiteral(red: 0.9019607843, green: 0.8705882353, blue: 0.9137254902, alpha: 1)]
        case .winterNeva:
            return [#colorLiteral(red: 0.631372549, green: 0.768627451, blue: 0.9921568627, alpha: 1), #colorLiteral(red: 0.7607843137, green: 0.9137254902, blue: 0.9843137255, alpha: 1)]
        }
    }
}

extension CGPoint : ExpressibleByStringLiteral{
    
    public init(stringLiteral value: String) {
        let point = CGPointFromString(value)
        self.init(x:point.x ,y:point.y)
    }
    public init(extendedGraphemeClusterLiteral value: String) {
        let point = CGPointFromString(value)
        self.init(x:point.x ,y:point.y)
    }
    public init(unicodeScalarLiteral value: String) {
        let point = CGPointFromString(value)
        self.init(x:point.x ,y:point.y)
    }
}

enum PQPastelPosition : CGPoint {
    
    case bottomLeft = "{1,0}"
    case bottomCenter = "{1,0.5}"
    case bottomRight = "{1,1}"
    case centerLeft = "{0.5,0}"
    case centerCenter = "{0.5,0.5}"
    case centerRight = "{0.5,1}"
    case topLeft = "{0,0}"
    case topCenter = "{0,0.5}"
    case topRight = "{0,1}"
    
}


class PQPastelView: UIView {
    
    /// 动画
    private struct Animation {
        static let keyPath = "colors"
        static let key = "ColorChange"
    }


    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame =  bounds
        
    }
    
    /// 移除动画
    override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }
    
    
    /// 开始动画
    func startAnimation(){
        gradient.removeAllAnimations()
        setup()
        animateGradient()
    }
    
    /// 初始化
    private func setup(){
        gradient.frame = bounds
        gradient.colors = currentGreadientColor()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.drawsAsynchronously = true
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    
    
    /// 获取当前动画颜色
    ///
    /// - Returns: 颜色数组
    private func currentGreadientColor() -> [CGColor] {
        guard colors.count > 0 else {
            return []
        }
        return[colors[currentGradient % colors.count].cgColor,colors[(currentGradient + 1) % colors.count].cgColor]
    }
    
    public func setColors(_ colors : [UIColor]) {
        guard colors.count > 0 else {
            return
        }
        self.colors = colors
    }
    
    public func appendColor(_ color : UIColor){
        self.colors.append(color)
    }
    
    private func animateGradient(){
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: Animation.keyPath)
        animation.duration = animatiomDuration
        animation.toValue = currentGreadientColor()
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradient.add(animation, forKey: Animation.key)
    }
    
    
    var gradient = CAGradientLayer()
    var animatiomDuration = 2.0
    var startPoint : CGPoint = PQPastelPosition.topLeft.rawValue
    var endPoint : CGPoint = PQPastelPosition.bottomRight.rawValue
    private var currentGradient : Int = 0
    private var colors : [UIColor] = [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]


}

extension PQPastelView : CAAnimationDelegate{
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if flag {
            gradient.colors = currentGreadientColor()
            animateGradient()
        }
    }
}
