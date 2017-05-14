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
var k: Int = 0
var m: Int = 0
var frame: UIView!
let layer = CAShapeLayer()
var newFrameLimit: Double = 0
let line = MyShapeLayer()


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

    var words:[String] = []
    var i:Int = 0
    var coordinateX = [Double]()
    var coordinateY = [Double]()

    
    func tap(/*sender: AnyObject*/) {
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        let alert = UIAlertController(title: "文字を入力", message: "最初の文字を入力してください", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "完了", style: .default) { (action:UIAlertAction!) -> Void in
            // 入力したテキストをコンソールに表示
            let textField = alert.textFields![0] as UITextField
            self.words += [""]
            self.words[self.i].append(textField.text!)
            self.myLabel = UILabel(frame: CGRect(x: 0, y: 0,width: 100,height: 50))
            self.myLabel.center = CGPoint(x: screenWidth/2, y: screenHeight/2)
            self.myLabel.textAlignment = NSTextAlignment.center
            self.myLabel.textColor = UIColor.white
            self.myLabel.text = self.words[self.i]//textField.text
            
            // Labelを追加
            self.view.addSubview(self.myLabel)
            self.i += 1
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .default) { (action:UIAlertAction!) -> Void in
        }
        
        // UIAlertControllerにtextFieldを追加
        alert.addTextField { (textField:UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
        
        
     
//        self.view.addSubview(myLabel)
    }
    
    
    
    var playerView: UIView!
    var firstView: UIView!
    
    
    //設定メソッド
    override func viewDidLoad() {
        //背景色の設定
        self.view.backgroundColor = UIColor.cyan
        
        
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        
        
        
        //丸を描く
        let oval = MyShapeLayer()
        oval.frame = CGRect(x:screenWidth/2 - 40,y:screenHeight/2 - 40,width:80,height:80)
        oval.drawOval(lineWidth:1/*, startPointX: 100, startPointY: 100, endPointX: 300, endPointY: 200*/)
        self.view.layer.addSublayer(oval)
        
        // Labelを生成

        myLabel = UILabel(frame: CGRect(x: screenWidth/2 - 50,y: screenHeight/2 - 25,width: 100,height: 50))
        //myLabel.text = "new word"
  //      self.myLabel.text = self.words[0]
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.textColor = UIColor.white
        self.view.addSubview(myLabel)
        super.viewDidLoad()
        tap()
        
        

        
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
      
//        if(selectLayer == CAShapeLayer){
//            
//        }
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
        oval.drawOval(lineWidth:1/*, startPointX: 100, startPointY: 100, endPointX: 300, endPointY: 200*/)
        
        
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
            j=1
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
        
        
    }
    
    // タッチ終了時に呼ばれるメソッド
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // タッチイベントを取得
        let touchEvent = touches.first!
        //ドラッグ終了時の座標
        let newDx = Double(touchEvent.location(in: self.view).x)
        let newDy = Double(touchEvent.location(in: self.view).y)
        
        // ドラッグしたx座標の移動距離
        var dx = newDx - preX
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preY
        
        
        if timer != nil{
            timer.invalidate()
        }
        frameAmount = 0
        if newFrameLimit < 0.3 && j==1 {
            tap()
            j=0
        }
        
        
        newFrameLimit = 0
//        print(newDx)
        
//        coordinate += [oldX]
//        coordinate[0].append(oldX)
//        print(coordinate[0])
        

        if m == 1 {
            coordinateX += [newDx]
            coordinateY += [newDy]
            print( (coordinateX[k]), (coordinateY[k]))
            k += 1
            m = 0
        }
        
        //線を描く
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
        
        //1秒以上タッチされた時 &　ドラッグが大きいとき新しい円フレームを追加
        if ( newFrameLimit >= 1.0 && newFrameLimit <= 100 && frameAmount < 1 && fabs(moveX) < 20 && fabs(moveY) < 20 && j == 1){
            let oval = MyShapeLayer()
            oval.frame = CGRect(x:preX - 40,y:preY - 40,width:80,height:80)//新しい円フレームの設定
            oval.drawOval(lineWidth:1/*, startPointX: CGFloat(preX), startPointY: CGFloat(preY), endPointX: CGFloat(oldX), endPointY: CGFloat(oldY)*/)
            // Labelを追加
            self.view.addSubview(myLabel)
            frameAmount += 1
            self.view.layer.addSublayer(oval)//円フレームの追加
            selectLayer = oval
            j=0
            m=1
            
        }

        
    }
    

}
