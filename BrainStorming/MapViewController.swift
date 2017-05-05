//
//  MapViewController.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/04/23.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit
import AVFoundation

var preX: Double = 0
var preY: Double = 0

var newX: Double = 0
var newY: Double = 0
var moveX: Double = 0
var moveY: Double = 0
var i: Float = 0.0
var j: Float = 0.0
var frame: UIView!
let layer = CAShapeLayer()


let pi = CGFloat(M_PI)
let start:CGFloat = 0.0 // 開始の角度
let end :CGFloat = pi * 2 // 終了の角度
var path: UIBezierPath = UIBezierPath();

var screenCenter: Int!

class MapViewController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate{
    
    var myLabel: UILabel!
    //テキストボックスフィールドの変数
    private var myTextField: UITextField!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    //選択したレイヤーをいれておく
    private var selectLayer:CALayer!
    
    //最後にタッチされた座標をいれておく
    private var touchLastPoint:CGPoint!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    
    
    //--------------------------------------
    
    
    @IBOutlet weak var label: UILabel!
    @IBAction func tap(sender: AnyObject) {
        
        let alert = UIAlertController(title: "文字を入力", message: "最初の文字を入力してください", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "完了", style: .default) { (action:UIAlertAction!) -> Void in
            
            // 入力したテキストをコンソールに表示
            let textField = alert.textFields![0] as UITextField
            self.label.text = textField.text
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

    //---------------------------------------
    
//    var audioPlayer : AVAudioPlayer!
    var playerView: UIView!
    var firstView: UIView!
   
    
    //設定メソッド
    override func viewDidLoad() {

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        let width = self.view.bounds.width
        let height = self.view.bounds.height

        //丸を生成するボタン
        let ovalBtn = UIButton()
        ovalBtn.frame = CGRect(x:0,y:0,width:100,height:50)
        ovalBtn.center = CGPoint(x:width / 3,y:height - 30)
        ovalBtn.addTarget(self, action: #selector(MapViewController.ovalBtnTapped(sender:)), for: .touchUpInside)
        ovalBtn.setTitle("丸",for:.normal)
//        ovalBtn.backgroundColor = UIColor.green
        self.view.addSubview(ovalBtn)
        
        //丸を描く
        let oval = MyShapeLayer()
        oval.frame = CGRect(x:30,y:30,width:80,height:80)
        oval.drawOval(lineWidth:1)
        self.view.layer.addSublayer(oval)
        
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        
        super.viewDidLoad()
        
        //背景色の設定
        self.view.backgroundColor = UIColor.cyan
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        //四角フレーム生成
        firstView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        firstView.backgroundColor = UIColor.red
        self.firstView.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
    }
    
    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    
    /************** Button Tapped ***********/
    func ovalBtnTapped(sender:UIButton){
        //丸を描く
        let oval = MyShapeLayer()
        oval.frame = CGRect(x:30,y:30,width:80,height:80)
        oval.drawOval(lineWidth:1)
        self.view.layer.addSublayer(oval)
    }
    
    /************** Touch Action ****************/
    func hitLayer(touch:UITouch) -> CALayer{
        var touchPoint:CGPoint = touch.location(in:self.view)
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

    
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    

    // 画面にタッチで呼ばれるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touch")
        
        // タッチイベントを取得
        let touchEvent = touches.first!
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        selectLayer = nil
        //タッチを取得
        let touch:UITouch = touches.first!
        //タッチした場所にあるレイヤーを取得
        let layer:CALayer = hitLayer(touch: touch)
        //タッチされた座標を取得
        let touchPoint:CGPoint = touch.location(in: self.view)
        //最後にタッチされた場所に座標を入れて置く
        touchLastPoint = touchPoint
        //選択されたレイヤーをselectLayerにいれる
        self.selectLayerFunc(layer:layer)
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        // ドラッグ前の座標, Swift 1.2 から
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        
        //タッチした座標を取得
        preX = Double(preDx)
        preY = Double(preDy)

        //円フレームの生成
        path.addArc(withCenter: CGPoint(x: preX,y: preY), radius: 50, startAngle: start, endAngle: end, clockwise: true) // 円弧
//        //レイヤー、パスの生成
//        layer.fillColor = UIColor.orange.cgColor
//        layer.path = path.cgPath
//        path.close()
//        playerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        //円フレームを追加
//        self.view.layer.addSublayer(layer)

        
        // Labelを生成
        myLabel = UILabel(frame: CGRect(x: 0,y: 0,width: 100,height: 50))
//        myLabel.backgroundColor = UIColor(red: 0.261, green: 0.737, blue: 0.561, alpha: 1.0)
        myLabel.text = "new word"
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.textColor = UIColor.white
  
//        // Labelを追加
//        self.view.addSubview(myLabel)

    }

    
    
    
    //　ドラッグ時に呼ばれるメソッド
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("drag")
        
        // タッチイベントを取得
        let touchEvent = touches.first!
        
        let preDx = touchEvent.previousLocation(in: self.view).x
        let preDy = touchEvent.previousLocation(in: self.view).y
        //タッチした座標を取得
        preX = Double(preDx)
        preY = Double(preDy)
        
        
        let touchPoint:CGPoint = touchEvent.location(in:self.view)
        let touchOffsetPoint:CGPoint = CGPoint(x:touchPoint.x - touchLastPoint.x,
                                               y:touchPoint.y - touchLastPoint.y)
        touchLastPoint = touchPoint
        
        if (selectLayer != nil){
            //hitしたレイヤーがあった場合
            let px:CGFloat = selectLayer.position.x
            let py:CGFloat = selectLayer.position.y
            //レイヤーを移動させる
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            selectLayer.position = CGPoint(x:px + touchOffsetPoint.x,y:py + touchOffsetPoint.y)
            selectLayer.borderWidth = 0.0
            selectLayer.borderColor = UIColor.green.cgColor
            CATransaction.commit()
        }
        
//        //円フレームの生成
//        path.addArc(withCenter: CGPoint(x: preDx,y: preDy), radius: 50, startAngle: start, endAngle: end, clockwise: true) // 円弧
//        //円フレームを追加
//        self.view.layer.addSublayer(layer)
      
//        //プレイヤーのドラッグするフレーム生成
//        playerView.backgroundColor = UIColor.gray
//        self.playerView.center = CGPoint(x: preDx, y: preDy)
        self.myLabel.center = CGPoint(x: preDx, y: preDy)
        
//        //円フレームの生成
//        path.addArc(withCenter: CGPoint(x: preX,y: preY), radius: 50, startAngle: start, endAngle: end, clockwise: true) // 円弧

//        let path = UIBezierPath(ovalIn: CGRect(x: 0,y: 0,width: width,height: height))



        //四角フレームを描画
//        self.view.addSubview(playerView)
//        //円フレームを追加
//        self.view.layer.addSublayer(layer)

        
        
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
        //ドラッグ終了時の座標
        var newDx = Double(touchEvent.location(in: self.view).x)
        var newDy = Double(touchEvent.location(in: self.view).y)

        // ドラッグしたx座標の移動距離
        var dx = newDx - preX
        
        // ドラッグしたy座標の移動距離
        let dy = newDy - preY
        
        moveX = newDx - preX
        moveY = newDy - preY
        
        
        
//        // UITextFieldを作成する.
//        myTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
//        
//        // 表示する文字を代入する.
//        myTextField.text = "Input new word"
//        
//        // Delegateを設定する.
//        myTextField.delegate = self
//        
//        // 枠を表示する.
//        myTextField.borderStyle = UITextBorderStyle.roundedRect
//        
//        // UITextFieldの表示する位置を設定する.
//        myTextField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
//        
//        // Viewに追加する.
//        self.view.addSubview(myTextField)
//        
//        
//        /*
//         UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
//         */
//        func textFieldDidBeginEditing(textField: UITextField){
//            print("textFieldDidBeginEditing:" + textField.text!)
//        }
//        
//        /*
//         UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
//         */
//        func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//            print("textFieldShouldEndEditing:" + textField.text!)
//            
//            return true
//        }
//        
//        /*
//         改行ボタンが押された際に呼ばれるデリゲートメソッド.
//         */
//        func textFieldShouldReturn(textField: UITextField) -> Bool {
//            textField.resignFirstResponder()
//            
//            return true
//        }
        
        
        

        
        
        print(moveX)
        print(moveY)
        //print("\(newDx) - \(preX) = \(newDx - preX)")
        print("endDrag")
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
//    // AutoLayoutによる位置の設定がviewWillAppear以降で行われるので、その後にアニメーション処理を追記
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        // ①アニメーションするプロパティを指定し、オブジェクト作成
//        let moveToCenter = CABasicAnimation(keyPath: "position.x")
//        
//        // ②アニメーションの初期値を指定する
//        moveToCenter.fromValue = -view.bounds.size.width/2
//        
//        // ③アニメーションの終了時の値を指定する
//        moveToCenter.toValue = view.bounds.size.width/2
//        
//        // ④アニメーションの時間を指定する
//        moveToCenter.duration = 2.0
//        
//        // ⑤アニメーションをlayerに追加する
//        self.view.layer.add(moveToCenter, forKey: nil)
//    }
//
    
    
    
    

   
}
