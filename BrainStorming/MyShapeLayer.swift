//
//  MyShapeLayer.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/05/01.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit

class MyShapeLayer: CALayer {
    func drawRect(lineWidth:CGFloat){
        let rect = CAShapeLayer()
        rect.strokeColor = UIColor.black.cgColor
        rect.fillColor = UIColor.clear.cgColor
        rect.lineWidth = lineWidth
        rect.path = UIBezierPath(rect:CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height)).cgPath
        self.addSublayer(rect)
    }
    
    func drawOval(lineWidth:CGFloat){
        let ovalShapeLayer = CAShapeLayer()
        ovalShapeLayer.strokeColor = UIColor.blue.cgColor
        ovalShapeLayer.fillColor = UIColor.clear.cgColor
        ovalShapeLayer.lineWidth = lineWidth
        ovalShapeLayer.path = UIBezierPath(ovalIn: CGRect(x:0, y:0, width:self.frame.width, height: self.frame.height)).cgPath
        self.addSublayer(ovalShapeLayer)
    }
    
}
