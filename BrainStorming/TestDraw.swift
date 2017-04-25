//
//  TestDraw.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/04/25.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit

class TestDraw: UIView {
    
    
    override func draw(_ rect: CGRect) {
        
        UIColor(red: 0.0, green: 0.502, blue: 1.0, alpha: 1.0)

        // 三角形 -------------------------------------
        // UIBezierPath のインスタンス生成
        let line = UIBezierPath();
        // 起点
        line.move(to: CGPoint(x: 450, y: 60));
        // 帰着点
        line.addLine(to: CGPoint(x: 400, y: 300));
        line.addLine(to: CGPoint(x: 600, y: 280));
        // ラインを結ぶ
        line.close()
        // 色の設定
        UIColor.red.setStroke()
        // ライン幅
        line.lineWidth = 4
        // 描画
        line.stroke();
        
        
        // 楕円 -------------------------------------
        let oval = UIBezierPath(ovalIn: CGRect(x: 140, y: 90, width: 90, height: 140))
        
        // 塗りつぶし色の設定
        UIColor.gray.setFill()
        // 内側の塗りつぶし
        oval.fill()
        
        // stroke 色の設定
        UIColor.green.setStroke()
        // ライン幅
        oval.lineWidth = 2
        // 描画
        oval.stroke()
        
        
        // 矩形 -------------------------------------
        let rectangle = UIBezierPath(rect: CGRect(x: 200,y: 70,width: 120,height: 100))
        // stroke 色の設定
        UIColor.blue.setStroke()
        // ライン幅
        rectangle.lineWidth = 8
        // 描画
        rectangle.stroke()
        
        // 角が丸い矩形 -------------------------------------
        let roundRect = UIBezierPath(roundedRect: CGRect(x: 50, y: 100, width: 110, height: 150), cornerRadius: 10)
        // stroke 色の設定
        UIColor.yellow.setStroke()
        roundRect.lineWidth = 6
        roundRect.stroke()
        
        
        // 円弧 -------------------------------------
        let arc = UIBezierPath(arcCenter: CGPoint(x:380, y:170), radius: 85,  startAngle: 0, endAngle: CGFloat(M_PI)*4/3, clockwise: true)
        // 透明色設定
        let aColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        aColor.setStroke()
        arc.lineWidth = 10
        
        
        // 点線のパターンをセット
        let dashPattern:[CGFloat] = [ 1 , 4 ]
        arc.setLineDash(dashPattern, count: 2, phase: 0)
        arc.stroke()
    }
    
}
