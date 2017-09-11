//
//  ViewController.swift
//  IOStest0
//
//  Created by 王宇鑫 on 2017/9/11.
//  Copyright © 2017年 王宇鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var HelloWorld: UILabel!
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var textArea0: UITextField!
    
    @IBAction func textInput(_ sender: Any) {
        if let str = textArea0.text
        {
            HelloWorld.text = "Hello \(str)"
        }
    }

    @IBAction func didEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
        HelloWorld.text = "Hello Dude"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HelloWorld.text = "Hello dude"
        HelloWorld.font = HelloWorld.font.withSize(30)
        background.image = UIImage.init(imageLiteralResourceName: "Background")
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
