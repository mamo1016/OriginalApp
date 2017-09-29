//
//  MyShapeLayer.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/05/01.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit

let upperLimit: Float = 1.0
let lowerLimit: Float = 0.0
var redGain: Float = 0.0
var greenGain: Float = 0.0
var blueGain: Float = 0.0
class MyShapeLayer: CALayer {
    
//    //四角を描くメソッド
    func drawRect(lineWidth:CGFloat, startPointX:CGFloat,startPointY:CGFloat,endPointX: CGFloat,endPointY:CGFloat){
//        let rect = CAShapeLayer()
//        rect.strokeColor = UIColor.black.cgColor
//        rect.fillColor = UIColor.clear.cgColor
//        rect.lineWidth = lineWidth
//        rect.path = UIBezierPath(rect:CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)).cgPath
//        self.addSublayer(rect)

        
//        let line = CAShapeLayer()
//        line.strokeColor = UIColor.black.cgColor
//        line.fillColor = UIColor.clear.cgColor
//        line.lineWidth = lineWidth
//        line.path = UIBezierPath(rect:CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)).cgPath
//        self.addSublayer(line)
        

        
        
        
        
        
        
        
        
        let shapeLayer = CAShapeLayer()
        let uiPath = UIBezierPath()
        uiPath.move(to: CGPoint(x:startPointX,y:startPointY))       // ここから
        uiPath.addLine(to: CGPoint(x:endPointX,y:endPointY))  // ここまで線を引く
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeColor = UIColor.blue.cgColor  // 微妙に分かりにくい。色は要指定。
        shapeLayer.path = uiPath.cgPath
        // 作成したCALayerを画面に追加
        self.addSublayer(shapeLayer)
    }
    
    //円を描くメソッド
    func drawOval(lineWidth:CGFloat/*,startPointX:CGFloat,startPointY:CGFloat,endPointX: CGFloat,endPointY:CGFloat*/){
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.white.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = lineWidth
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x:0, y:0, width:self.frame.width, height: self.frame.height)).cgPath
        self.addSublayer(ovalShapeLayer)
//
        //0から9までの値を取得する
        var random: Float = Float(arc4random_uniform(10))
        print(random)
        redGain = min(random/10, upperLimit) // なんかの計算＆上限値込み
        random = Float(arc4random_uniform(10))
        greenGain = min(random/10, upperLimit) // なんかの計算＆上限値込み
        random = Float(arc4random_uniform(10))
        blueGain = min(random/10, upperLimit) // なんかの計算＆上限値込み

        
        let pi = CGFloat(M_PI)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = pi*2 // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        //path.move(to: CGPoint(x:0, y:0))
        path.addArc(withCenter: CGPoint(x:frame.width/2, y:frame.height/2), radius: 20, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
        let layer = CAShapeLayer()

        
        layer.fillColor =  UIColor(colorLiteralRed: redGain, green: greenGain, blue: blueGain, alpha: 1.0).cgColor
        //layer.fillColor = UIColor.red.cgColor
        layer.path = path.cgPath
        
        self.addSublayer(layer)
//        print(redGain)

        
        
//        let shapeLayer = CAShapeLayer()
//        let uiPath = UIBezierPath()
//        uiPath.move(to: CGPoint(x:startPointX,y:startPointY))       // ここから
//        uiPath.addLine(to: CGPoint(x:endPointX,y:endPointY))  // ここまで線を引く
//        shapeLayer.lineWidth = lineWidth
//        shapeLayer.strokeColor = UIColor.blue.cgColor  // 微妙に分かりにくい。色は要指定。
//        shapeLayer.path = uiPath.cgPath
//        // 作成したCALayerを画面に追加
//        self.addSublayer(shapeLayer)


    }
    
}
