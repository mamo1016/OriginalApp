//
//  ViewController.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/04/23.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit
import AVFoundation

var preX: Double = 0
var preY: Double = 0
var oldX: Double = 0
var oldY: Double = 0

var newX: Double = 0
var newY: Double = 0
var moveX: Double = 0
var moveY: Double = 0
var i: Float = 0.0
var j: Float = 0.0
var frame: UIView!
let layer = CAShapeLayer()
var newFrameLimit: Double = 0


let pi = CGFloat(M_PI)
let start:CGFloat = 0.0 // 開始の角度
let end :CGFloat = pi * 2 // 終了の角度
var path: UIBezierPath = UIBezierPath();

var screenCenter: Int!
var frameAmount: Int = 0

class MapViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate{
    
    var myLabel: UILabel!
    //テキストボックスフィールドの変数
    private var myTextField: UITextField!
    //選択したレイヤーをいれておく
    private var selectLayer:CALayer!
    //最後にタッチされた座標をいれておく
    private var touchLastPoint:CGPoint!
    
    weak var timer: Timer!
    var startTime = Date()
    
    
    
    
    @IBOutlet weak var label: UILabel!
    
    func tap(/*sender: AnyObject*/) {
        
        let alert = UIAlertController(title: "文字を入力", message: "最初の文字を入力してください", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "完了", style: .default) { (action:UIAlertAction!) -> Void in
            
            // 入力したテキストをコンソールに表示
            let textField = alert.textFields![0] as UITextField
            self.myLabel.text = textField.text
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action:UIAlertAction!) -> Void in
        }
        
        // UIAlertControllerにtextFieldを追加
        alert.addTextField { (textField:UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    var playerView: UIView!
    var firstView: UIView!
    
    
    //設定メソッド
    override func viewDidLoad() {
        //背景色の設定
        self.view.backgroundColor = UIColor.cyan
        
        
//        let shapeLayer = CAShapeLayer()
//        
//        let uiPath = UIBezierPath()
//        uiPath.move(to: CGPoint(x:5,y:5))       // ここから
//        uiPath.addLine(to: CGPoint(x:150,y:15))  // ここまで線を引く
//        
//        shapeLayer.strokeColor = UIColor.blue.cgColor  // 微妙に分かりにくい。色は要指定。
//        shapeLayer.path = uiPath.cgPath  // なんだこれは
//        
//        // 作成したCALayerを画面に追加
//        view.layer.addSublayer(shapeLayer)
        
        
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        
        
        
        //丸を描く
        let oval = MyShapeLayer()
        oval.frame = CGRect(x:screenWidth/2 - 40,y:screenHeight/2 - 40,width:80,height:80)
        oval.drawOval(lineWidth:1)
        self.view.layer.addSublayer(oval)
        
//        //四角を描く
//        let rect = MyShapeLayer()
//        rect.frame = CGRect(x:screenWidth/2, y:screenHeight/2,width:70,height:60)
//        rect.drawRect(lineWidth:1)
//        self.view.layer.addSublayer(rect)

        
        // Labelを生成
        myLabel = UILabel(frame: CGRect(x: screenWidth/2,y: screenHeight/2,width: 100,height: 50))
        myLabel.text = "new word"
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.textColor = UIColor.white
//        self.view.addSubview(myLabel)

        super.viewDidLoad()
        

        
    }

    
    //画面がタッチされた時
    func hitLayer(touch:UITouch) -> CALayer{
        var touchPoint:CGPoint = touch.location(in:self.view)       //タッチされた座標取得
        touchPoint = self.view.layer.convert(touchPoint, to: self.view.layer.superlayer)
        return self.view.layer.hitTest(touchPoint)!
    }
    
    func selectLayerFunc(layer:CALayer?) {
        if((layer == self.view.layer) || (layer == nil)){
            selectLayer = nil
            return
        }
        selectLayer = layer
    }
    
    // 画面にタッチで呼ばれるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // タッチイベントを取得
        let touchEvent = touches.first!
        selectLayer = nil
        let touch:UITouch = touches.first!        //タッチを取得
        let layer:CALayer = hitLayer(touch: touch)        //タッチした場所にあるレイヤーを取得
        let touchPoint:CGPoint = touch.location(in: self.view)        //タッチされた座標を取得
        touchLastPoint = touchPoint        //最後にタッチされた場所に座標を入れて置く
        self.selectLayerFunc(layer:layer)        //選択されたレイヤーをselectLayerにいれる
        oldX = Double(touchPoint.x)
        oldY = Double(touchPoint.y)
        
        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        //タッチした座標を取得
        preX = Double(preDx)
        preY = Double(preDy)
        
        let oval = MyShapeLayer()
        oval.frame = CGRect(x:preX - 40,y:preY - 40,width:80,height:80)//新しい円フレームの設定
        oval.drawOval(lineWidth:1)
        
        
        // Labelを生成
        myLabel = UILabel(frame: CGRect(x: 0,y: 0,width: 100,height: 50))
        myLabel.text = "new word"
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.textColor = UIColor.white
        
        //レイヤーの内側がタッチされた時
        if (selectLayer != nil){
            //タイマー開始
            timer = Timer.scheduledTimer(timeInterval: 0.01,target: self,selector: #selector(self.timerCounter),userInfo: nil,repeats: true)
            //グローバル変数に格納
            startTime = Date()
            
        }
        
    }
    
    //　ドラッグ時に呼ばれるメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchEvent = touches.first!        // タッチイベントを取得
        
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        //タッチした座標を取得
        preX = Double(preDx)
        preY = Double(preDy)
        moveX = oldX - preX
        moveY = oldY - preY
        //print(moveX)
        
        let touchPoint:CGPoint = touchEvent.location(in:self.view)
        let touchOffsetPoint:CGPoint = CGPoint(x:touchPoint.x - touchLastPoint.x,
                                               y:touchPoint.y - touchLastPoint.y)
        touchLastPoint = touchPoint
        
        if (selectLayer != nil){//hitしたレイヤーがあった場合
            let px:CGFloat = selectLayer.position.x
            let py:CGFloat = selectLayer.position.y
            //レイヤーを移動させる
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            selectLayer.position = CGPoint(x:px + touchOffsetPoint.x,y:py + touchOffsetPoint.y) //選択されたレイヤーの位置
            selectLayer.borderWidth = 0.0
            selectLayer.borderColor = UIColor.green.cgColor
            CATransaction.commit()
            self.myLabel.center = CGPoint(x:px + touchOffsetPoint.x,y:py + touchOffsetPoint.y)
        }
        
        print(oldX,oldY)
        
    }
    
    // タッチ終了時に呼ばれるメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // タッチイベントを取得
        let touchEvent = touches.first!
        //ドラッグ終了時の座標
        var newDx = Double(touchEvent.location(in: self.view).x)
        var newDy = Double(touchEvent.location(in: self.view).y)
        
        // ドラッグしたx座標の移動距離
        var dx = newDx - preX
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preY
        
        
        if timer != nil{
            timer.invalidate()
        }
        frameAmount = 0
        if newFrameLimit < 0.3 {
            tap()
        }
        //線を描く
        let line = MyShapeLayer()
        line.frame = CGRect(x:0, y:0,width:0,height:0)
        line.drawRect(lineWidth:1, startPointX: CGFloat(preX), startPointY: CGFloat(preY),endPointX: CGFloat(oldX),
                      endPointY: CGFloat(oldY))
        self.view.layer.addSublayer(line)

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func timerCounter() {
        // タイマー開始からのインターバル時間
        let currentTime = Date().timeIntervalSince(startTime)
        // fmod() 余りを計算
        let minute = (Int)(fmod((currentTime/60), 60))
        // currentTime/60 の余り
        let second = (Int)(fmod(currentTime, 60))
        // floor 切り捨て、小数点以下を取り出して *100
        let msec = (Int)((currentTime - floor(currentTime))*100)
        
        // %02d： ２桁表示、0で埋める
        let sMinute = String(format:"%02d", minute)
        let sSecond = String(format:"%02d", second)
        let sMsec = String(format:"%02d", msec)
        
        newFrameLimit = currentTime
        
        //1秒以上タッチされた時 &　ドラッグが大きいとき
        if ( newFrameLimit >= 1.0 && newFrameLimit <= 100 && frameAmount < 1 && fabs(moveX) < 20 && fabs(moveY) < 20){
            let oval = MyShapeLayer()
            oval.frame = CGRect(x:preX - 40,y:preY - 40,width:80,height:80)//新しい円フレームの設定
            oval.drawOval(lineWidth:1)
            // Labelを追加
            self.view.addSubview(myLabel)
            frameAmount += 1
            self.view.layer.addSublayer(oval)//円フレームの追加
            selectLayer = oval

            
        }
        
    }

}
