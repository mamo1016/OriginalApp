//
//  StartViewController.swift
//  BrainStorming
//
//  Created by 上田　護 on 2017/04/23.
//  Copyright © 2017年 上田　護. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Screen Size の取得
//        let screenWidth = self.view.bounds.width
//        let screenHeight = self.view.bounds.height
//        
//        let testDraw = TestDraw(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//        self.view.addSubview(testDraw)
        self.view.backgroundColor = UIColor.red

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func startBrainMap() {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "map") as! MapViewController
        self.present(nextView, animated: true, completion: nil)
    }

}
