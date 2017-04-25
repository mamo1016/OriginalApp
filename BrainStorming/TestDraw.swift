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
    }
    
}
