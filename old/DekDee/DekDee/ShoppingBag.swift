//
//  ShoppingBag.swift
//  Dek Dee
//
//  Created by Jakkrits on 10/12/2558 BE.
//  Copyright © 2558 AppIllus. All rights reserved.
//

import UIKit

@IBDesignable
class ShoppingBag: UIView {
    
    var layers : Dictionary<String, AnyObject> = [:]
    var completionBlocks : Dictionary<CAAnimation, (Bool) -> Void> = [:]
    var updateLayerValueForCompletedAnimation : Bool = false
    
    var bagColor : UIColor!
    var circleBackgroundColor : UIColor!
    var starColor : UIColor!
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProperties()
        setupLayers()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setupProperties()
        setupLayers()
    }
    
    override var frame: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    override var bounds: CGRect{
        didSet{
            setupLayerFrames()
        }
    }
    
    func setupProperties(){
        self.bagColor = UIColor(red:0.212, green: 0.443, blue:0.996, alpha:1)
        self.circleBackgroundColor = UIColor.whiteColor()
        self.starColor = UIColor(red:0.971, green: 0.972, blue:1, alpha:1)
    }
    
    func setupLayers(){
        let oval = CAShapeLayer()
        self.layer.addSublayer(oval)
        layers["oval"] = oval
        let pathBody = CAShapeLayer()
        oval.addSublayer(pathBody)
        layers["pathBody"] = pathBody
        let pathHandle = CAShapeLayer()
        oval.addSublayer(pathHandle)
        layers["pathHandle"] = pathHandle
        let star = CAShapeLayer()
        oval.addSublayer(star)
        layers["star"] = star
        
        resetLayerPropertiesForLayerIdentifiers(nil)
        setupLayerFrames()
    }
    
    func resetLayerPropertiesForLayerIdentifiers(layerIds: [String]!){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if layerIds == nil || layerIds.contains("oval"){
            let oval = layers["oval"] as! CAShapeLayer
            oval.fillColor     = self.circleBackgroundColor.CGColor
            oval.strokeColor   = UIColor.whiteColor().CGColor
            oval.shadowColor   = UIColor(red:0, green: 0, blue:0, alpha:0.463).CGColor
            oval.shadowOpacity = 0.46
            oval.shadowOffset  = CGSizeMake(4, 4)
            oval.shadowRadius  = 10
        }
        if layerIds == nil || layerIds.contains("pathBody"){
            let pathBody = layers["pathBody"] as! CAShapeLayer
            pathBody.fillColor = self.bagColor.CGColor
            pathBody.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("pathHandle"){
            let pathHandle = layers["pathHandle"] as! CAShapeLayer
            pathHandle.fillColor = self.bagColor.CGColor
            pathHandle.lineWidth = 0
        }
        if layerIds == nil || layerIds.contains("star"){
            let star = layers["star"] as! CAShapeLayer
            star.fillColor = self.starColor.CGColor
            star.lineWidth = 0
        }
        
        CATransaction.commit()
    }
    
    func setupLayerFrames(){
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        if let oval : CAShapeLayer = layers["oval"] as? CAShapeLayer{
            oval.frame = CGRectMake(0.10422 * oval.superlayer!.bounds.width, 0.10306 * oval.superlayer!.bounds.height, 0.79156 * oval.superlayer!.bounds.width, 0.79388 * oval.superlayer!.bounds.height)
            oval.path  = ovalPathWithBounds((layers["oval"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let pathBody : CAShapeLayer = layers["pathBody"] as? CAShapeLayer{
            pathBody.frame = CGRectMake(0.12329 * pathBody.superlayer!.bounds.width, 0.349 * pathBody.superlayer!.bounds.height, 0.75342 * pathBody.superlayer!.bounds.width, 0.51105 * pathBody.superlayer!.bounds.height)
            pathBody.path  = pathBodyPathWithBounds((layers["pathBody"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let pathHandle : CAShapeLayer = layers["pathHandle"] as? CAShapeLayer{
            pathHandle.frame = CGRectMake(0.33744 * pathHandle.superlayer!.bounds.width, 0.10221 * pathHandle.superlayer!.bounds.height, 0.32697 * pathHandle.superlayer!.bounds.width, 0.31774 * pathHandle.superlayer!.bounds.height)
            pathHandle.path  = pathHandlePathWithBounds((layers["pathHandle"] as! CAShapeLayer).bounds).CGPath;
        }
        
        if let star : CAShapeLayer = layers["star"] as? CAShapeLayer{
            star.frame = CGRectMake(0.40392 * star.superlayer!.bounds.width, 0.48963 * star.superlayer!.bounds.height, 0.19216 * star.superlayer!.bounds.width, 0.1916 * star.superlayer!.bounds.height)
            star.path  = starPathWithBounds((layers["star"] as! CAShapeLayer).bounds).CGPath;
        }
        
        CATransaction.commit()
    }
    
    //MARK: - Animation Setup
    
    func addStarAnimateAnimation(){
        addStarAnimateAnimationCompletionBlock(nil)
    }
    
    func addStarAnimateAnimationCompletionBlock(completionBlock: ((finished: Bool) -> Void)?){
        if completionBlock != nil{
            let completionAnim = CABasicAnimation(keyPath:"completionAnim")
            completionAnim.duration = 0
            completionAnim.delegate = self
            completionAnim.setValue("starAnimate", forKey:"animId")
            completionAnim.setValue(false, forKey:"needEndAnim")
            layer.addAnimation(completionAnim, forKey:"starAnimate")
            if let anim = layer.animationForKey("starAnimate"){
                completionBlocks[anim] = completionBlock
            }
        }
        
        self.layer.speed = 1
        
        //let fillMode : String = kCAFillModeForwards
        let _ : String = kCAFillModeForwards

    }
    
    //MARK: - Animation Cleanup
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool){
        if let completionBlock = completionBlocks[anim]{
            completionBlocks.removeValueForKey(anim)
            if (flag && updateLayerValueForCompletedAnimation) || anim.valueForKey("needEndAnim") as! Bool{
                updateLayerValuesForAnimationId(anim.valueForKey("animId") as! String)
                removeAnimationsForAnimationId(anim.valueForKey("animId") as! String)
            }
            completionBlock(flag)
        }
    }
    
    func updateLayerValuesForAnimationId(identifier: String){
        if identifier == "starAnimate"{
            
        }
    }
    
    func removeAnimationsForAnimationId(identifier: String){
        if identifier == "starAnimate"{
            
        }
    }
    
    func removeAllAnimations(){
        for layer in layers.values{
            (layer as! CALayer).removeAllAnimations()
        }
    }
    
    //MARK: - Bezier Path
    
    func ovalPathWithBounds(bound: CGRect) -> UIBezierPath{
        let ovalPath = UIBezierPath(ovalInRect:bound)
        return ovalPath;
    }
    
    func pathBodyPathWithBounds(bound: CGRect) -> UIBezierPath{
        let pathBodyPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        pathBodyPath.moveToPoint(CGPointMake(minX + 0.98338 * w, minY))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.76025 * w, minY))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.76025 * w, minY + 0.07705 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.67618 * w, minY + 0.20062 * h), controlPoint1:CGPointMake(minX + 0.76025 * w, minY + 0.1452 * h), controlPoint2:CGPointMake(minX + 0.72254 * w, minY + 0.20062 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.59211 * w, minY + 0.07705 * h), controlPoint1:CGPointMake(minX + 0.62984 * w, minY + 0.20062 * h), controlPoint2:CGPointMake(minX + 0.59211 * w, minY + 0.1452 * h))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.59211 * w, minY))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.41033 * w, minY))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.41033 * w, minY + 0.07705 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.32627 * w, minY + 0.20062 * h), controlPoint1:CGPointMake(minX + 0.41033 * w, minY + 0.1452 * h), controlPoint2:CGPointMake(minX + 0.37263 * w, minY + 0.20062 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.2422 * w, minY + 0.07705 * h), controlPoint1:CGPointMake(minX + 0.2799 * w, minY + 0.20062 * h), controlPoint2:CGPointMake(minX + 0.2422 * w, minY + 0.1452 * h))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.2422 * w, minY))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.0166 * w, minY))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.00059 * w, minY + 0.03 * h), controlPoint1:CGPointMake(minX + 0.005 * w, minY), controlPoint2:CGPointMake(minX + -0.00216 * w, minY + 0.01344 * h))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.14764 * w, minY + 0.91041 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.22677 * w, minY + h), controlPoint1:CGPointMake(minX + 0.15653 * w, minY + 0.9599 * h), controlPoint2:CGPointMake(minX + 0.19195 * w, minY + h))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.77321 * w, minY + h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.85238 * w, minY + 0.91041 * h), controlPoint1:CGPointMake(minX + 0.80806 * w, minY + h), controlPoint2:CGPointMake(minX + 0.84345 * w, minY + 0.95987 * h))
        pathBodyPath.addLineToPoint(CGPointMake(minX + 0.99942 * w, minY + 0.03 * h))
        pathBodyPath.addCurveToPoint(CGPointMake(minX + 0.98338 * w, minY), controlPoint1:CGPointMake(minX + 1.00215 * w, minY + 0.01341 * h), controlPoint2:CGPointMake(minX + 0.995 * w, minY))
        pathBodyPath.closePath()
        pathBodyPath.moveToPoint(CGPointMake(minX + 0.98338 * w, minY))
        
        return pathBodyPath;
    }
    
    func pathHandlePathWithBounds(bound: CGRect) -> UIBezierPath{
        let pathHandlePath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        pathHandlePath.moveToPoint(CGPointMake(minX + 0.09681 * w, minY + h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.19367 * w, minY + 0.90062 * h), controlPoint1:CGPointMake(minX + 0.15027 * w, minY + h), controlPoint2:CGPointMake(minX + 0.19367 * w, minY + 0.95548 * h))
        pathHandlePath.addLineToPoint(CGPointMake(minX + 0.19367 * w, minY + 0.51304 * h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.49998 * w, minY + 0.19876 * h), controlPoint1:CGPointMake(minX + 0.19367 * w, minY + 0.33978 * h), controlPoint2:CGPointMake(minX + 0.33106 * w, minY + 0.19876 * h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.80629 * w, minY + 0.51304 * h), controlPoint1:CGPointMake(minX + 0.66885 * w, minY + 0.19876 * h), controlPoint2:CGPointMake(minX + 0.80629 * w, minY + 0.33978 * h))
        pathHandlePath.addLineToPoint(CGPointMake(minX + 0.80629 * w, minY + 0.90062 * h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.90314 * w, minY + h), controlPoint1:CGPointMake(minX + 0.80629 * w, minY + 0.95548 * h), controlPoint2:CGPointMake(minX + 0.84968 * w, minY + h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + w, minY + 0.90062 * h), controlPoint1:CGPointMake(minX + 0.95661 * w, minY + h), controlPoint2:CGPointMake(minX + w, minY + 0.95548 * h))
        pathHandlePath.addLineToPoint(CGPointMake(minX + w, minY + 0.51304 * h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.49998 * w, minY), controlPoint1:CGPointMake(minX + w, minY + 0.23016 * h), controlPoint2:CGPointMake(minX + 0.77568 * w, minY))
        pathHandlePath.addCurveToPoint(CGPointMake(minX, minY + 0.51304 * h), controlPoint1:CGPointMake(minX + 0.22432 * w, minY), controlPoint2:CGPointMake(minX, minY + 0.23016 * h))
        pathHandlePath.addLineToPoint(CGPointMake(minX, minY + 0.90062 * h))
        pathHandlePath.addCurveToPoint(CGPointMake(minX + 0.09681 * w, minY + h), controlPoint1:CGPointMake(minX + -0.00005 * w, minY + 0.95548 * h), controlPoint2:CGPointMake(minX + 0.04334 * w, minY + h))
        pathHandlePath.closePath()
        pathHandlePath.moveToPoint(CGPointMake(minX + 0.09681 * w, minY + h))
        
        return pathHandlePath;
    }
    
    func starPathWithBounds(bound: CGRect) -> UIBezierPath{
        let starPath = UIBezierPath()
        let minX = CGFloat(bound.minX), minY = bound.minY, w = bound.width, h = bound.height;
        
        starPath.moveToPoint(CGPointMake(minX + 0.33444 * w, minY + 0.31106 * h))
        starPath.addCurveToPoint(CGPointMake(minX + 0.23248 * w, minY + 0.6395 * h), controlPoint1:CGPointMake(minX + -0.07713 * w, minY + 0.34071 * h), controlPoint2:CGPointMake(minX + -0.10613 * w, minY + 0.34279 * h))
        starPath.addCurveToPoint(CGPointMake(minX + 0.49942 * w, minY + 0.84249 * h), controlPoint1:CGPointMake(minX + 0.13223 * w, minY + 1.05835 * h), controlPoint2:CGPointMake(minX + 0.12517 * w, minY + 1.08786 * h))
        starPath.addCurveToPoint(CGPointMake(minX + 0.76636 * w, minY + 0.6395 * h), controlPoint1:CGPointMake(minX + 0.84903 * w, minY + 1.07171 * h), controlPoint2:CGPointMake(minX + 0.87367 * w, minY + 1.08786 * h))
        starPath.addCurveToPoint(CGPointMake(minX + 0.6644 * w, minY + 0.31106 * h), controlPoint1:CGPointMake(minX + 1.08268 * w, minY + 0.36232 * h), controlPoint2:CGPointMake(minX + 1.10497 * w, minY + 0.34279 * h))
        starPath.addCurveToPoint(CGPointMake(minX + 0.33444 * w, minY + 0.31106 * h), controlPoint1:CGPointMake(minX + 0.51028 * w, minY + -0.08946 * h), controlPoint2:CGPointMake(minX + 0.49942 * w, minY + -0.11768 * h))
        starPath.closePath()
        starPath.moveToPoint(CGPointMake(minX + 0.33444 * w, minY + 0.31106 * h))
        
        return starPath;
    }
    
    
}

