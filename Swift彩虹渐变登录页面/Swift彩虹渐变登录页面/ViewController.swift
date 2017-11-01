//
//  ViewController.swift
//  Swift彩虹渐变登录页面
//
//  Created by pgq on 2017/11/1.
//  Copyright © 2017年 pgq. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.borderColor = UIColor.white.withAlphaComponent(0.12).cgColor
            loginBtn.layer.borderWidth = 1.0
            loginBtn.layer.cornerRadius = 4
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let pastel = PQPastelView(frame: view.bounds)
        
//        pastel.setColors(PQPastelDefaultColor.frozenDreams.colors())
        
        pastel.startAnimation()
        
        view.insertSubview(pastel, at: 0)
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


}

