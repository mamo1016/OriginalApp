//
//  MapViewController.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/04/23.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit


var preX: Double = 0
var preY: Double = 0

var newX: Double = 0
var newY: Double = 0
var moveX: Double = 0
var moveY: Double = 0
var i: Int = 0

class MapViewController: UIViewController {

    var playerView: UIView!
 
    override func viewDidLoad() {

        super.viewDidLoad()
        
        playerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        i += 1
       
        //背景色の設定
        self.view.backgroundColor = UIColor.cyan

        
        
        
        
        
    
      
        
        
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        let testDraw = TestDraw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))

        //self.view.addSubview(testDraw)
    }

    
    
    // 画面にタッチで呼ばれるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")

        // タッチイベントを取得
        let touchEvent = touches.first!

        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        //タッチした座標を取得
        preX = Double(preDx)
        preY = Double(preDy)
        


    }
    
    
    //　ドラッグ時に呼ばれるメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("drag")
        
        // タッチイベントを取得
        let touchEvent = touches.first!

//        var newDx = Double(touchEvent.location(in: self.view).x)
//        var newDy = Double(touchEvent.location(in: self.view).y)
        
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        
        //プレイヤーのドラッグするフレーム生成
        playerView.backgroundColor = UIColor.gray
        self.view.addSubview(playerView)
        self.playerView.center = CGPoint(x: preDx, y: preDy)
        
//        // ドラッグしたx座標の移動距離
//        var dx = newDx - preX
//        
//        // ドラッグしたy座標の移動距離
//        let dy = newDy - preY
        
        //print("\(newDx) - \(preDy) = \(dx)")
    }
    
    
    // ドラッグ終了時に呼ばれるメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

        // タッチイベントを取得
        let touchEvent = touches.first!

        var newDx = Double(touchEvent.location(in: self.view).x)
        var newDy = Double(touchEvent.location(in: self.view).y)

        // ドラッグしたx座標の移動距離
        var dx = newDx - preX
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preY
        
        moveX = newDx - preX
        moveY = newDy - preY
        
        print(moveX)
        print(moveY)
        print("\(newDx) - \(preX) = \(newDx - preX)")
 
        print("endDrag")
 
 
        
    
//        print(newDx)
//        print(dx)
//        print(dx)

    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
            // Screen Size の取得
   
    
    
    
    

   
}
