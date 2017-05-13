//
//  MyShapeLayer.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/05/01.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit


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
    func drawOval(lineWidth:CGFloat){
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.blue.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = lineWidth
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x:0, y:0, width:self.frame.width, height: self.frame.height)).cgPath
        self.addSublayer(ovalShapeLayer)
        

    }
    
}
