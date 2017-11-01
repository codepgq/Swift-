# Swift-本例子参考[Pastel](https://github.com/cruisediary/Pastel),但是Pastel不支持4.0
<br>

最终效果图：

![最终效果](http://upload-images.jianshu.io/upload_images/1940927-b91569b724eb7eb0.gif?imageMogr2/auto-orient/strip)



<br>
###一、UI就是Storyboard拖拖拖搞定了，其它的设置也很简单
`textfield`输入框，背景设置一点不透明度就好了

![textfiled](http://upload-images.jianshu.io/upload_images/1940927-fe4d701ffaa0a4bc.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


`button`登录按钮
```
    @IBOutlet var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
            loginBtn.layer.borderWidth = 1.0
            loginBtn.layer.cornerRadius = 4
        }
    }
```


<br>
###二、创建一个类，去实现这个效果
- 2.1 创建一个类，集成UIView
<br>
- 2.2 定义一些属性
```
    var gradient = CAGradientLayer()
    var animatiomDuration = 2.0
    var startPoint : CGPoint = PQPastelPosition.topLeft.rawValue
    var endPoint : CGPoint = PQPastelPosition.bottomRight.rawValue
    private var currentGradient : Int = 0
    private var colors : [UIColor] = [#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)]
```

- 2.3 定义一些需要用到的枚举
<br>
  - 位置枚举
```
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
```

  - 颜色枚举 这里是参考的Pastel
```
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
```

- 2.4 向外提供可调用方法
```
    public func setColors(_ colors : [UIColor]) {
        guard colors.count > 0 else {
            return
        }
        self.colors = colors
    }
    
    public func appendColor(_ color : UIColor){
        self.colors.append(color)
    }
```

<br>
- 2.5 最最最重要的方法来了
动画处理
  - 先从数组中取出两个颜色，为gradient赋值，也就是最初的颜色
  - 然后在创建动画`CABasicAnimation`设置`toValue`为当前颜色数组下标+1
比如：颜色数组是[红、绿、蓝、紫] 那么默认颜色就是：红 渐变 绿， 而动画的`toValue`就是：绿 渐变 蓝
  - 然后在动画结束的时候再次开启动画，颜色在往后位移一次，周而复始，就可以完成这个效果了

<br>
初始化gradient
```
    /// 初始化
    private func setup(){
        gradient.frame = bounds
        gradient.colors = currentGreadientColor()
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.drawsAsynchronously = true
        
        layer.insertSublayer(gradient, at: 0)
    }
```

<br>
设置动画
```
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
```
<br>
要想循环播放并且颜色位移，就要监听动画结束的时候再做处理
```
extension PQPastelView : CAAnimationDelegate{
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        if flag {
            gradient.colors = currentGreadientColor()
            animateGradient()
        }
    }
}
```

至此功能就实现了，把 [Demo地址](https://github.com/codepgq/Swift-) 给给为老爷奉上，其余细节部分在Demo中。

本例子参考[Pastel](https://github.com/cruisediary/Pastel)
