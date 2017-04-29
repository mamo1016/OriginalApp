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


var screenCenter: Int!

class MapViewController: UIViewController, UITextFieldDelegate {
    
    var myLabel: UILabel!
    //テキストボックスフィールドの変数
    private var myTextField: UITextField!
    
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
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        //背景色の設定
        self.view.backgroundColor = UIColor.cyan


        
        //-------------------------------------------------
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
        
        

        //---------------------------------------------------
       
        
        
        playerView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        // Screen Size の取得
        let screenWidth = self.view.bounds.width
        let screenHeight = self.view.bounds.height
        
        //最初のフレーム生成
        firstView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        firstView.backgroundColor = UIColor.red
        self.firstView.center = CGPoint(x: screenWidth / 2, y: screenHeight / 2)
        
        //ビューを描画
        self.view.addSubview(firstView)

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
        
        
        // Labelを生成
        myLabel = UILabel(frame: CGRect(x: preDx,y: preDy,width: 100,height: 50))
        myLabel.backgroundColor = UIColor(red: 0.261, green: 0.737, blue: 0.561, alpha: 1.0)
        //myLabel.center = self.view.center
        myLabel.text = "new word"
        myLabel.textAlignment = NSTextAlignment.center
        myLabel.textColor = UIColor.white
        

        
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
        self.playerView.center = CGPoint(x: preDx, y: preDy)
        self.myLabel.center = CGPoint(x: preDx, y: preDy)

        //ビューを描画
        self.view.addSubview(playerView)
        // Labelをviewに追加
        self.view.addSubview(myLabel)

        
        
        
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
        
        
        
        // UITextFieldを作成する.
        myTextField = UITextField(frame: CGRect(x: 0,y: 0,width: 200,height: 50))
        
        // 表示する文字を代入する.
        myTextField.text = "Input new word"
        
        // Delegateを設定する.
        myTextField.delegate = self
        
        // 枠を表示する.
        myTextField.borderStyle = UITextBorderStyle.roundedRect
        
        // UITextFieldの表示する位置を設定する.
        myTextField.layer.position = CGPoint(x:self.view.bounds.width/2,y:100);
        
        // Viewに追加する.
        self.view.addSubview(myTextField)
        
        
        /*
         UITextFieldが編集された直後に呼ばれるデリゲートメソッド.
         */
        func textFieldDidBeginEditing(textField: UITextField){
            print("textFieldDidBeginEditing:" + textField.text!)
        }
        
        /*
         UITextFieldが編集終了する直前に呼ばれるデリゲートメソッド.
         */
        func textFieldShouldEndEditing(textField: UITextField) -> Bool {
            print("textFieldShouldEndEditing:" + textField.text!)
            
            return true
        }
        
        /*
         改行ボタンが押された際に呼ばれるデリゲートメソッド.
         */
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            
            return true
        }
        
        
        

        
        
        print(moveX)
        print(moveY)
        //print("\(newDx) - \(preX) = \(newDx - preX)")
        print("endDrag")
    }
    
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    

   
}
