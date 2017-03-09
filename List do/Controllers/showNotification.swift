//
//  showNotification.swift
//  List do
//
//  Created by Doãn Tuấn on 3/9/17.
//  Copyright © 2017 doantuan. All rights reserved.
//

import UIKit

class showNotification: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
        self.alpha = 1
        self.layer.cornerRadius = self.frame.height/5
    }
    
    func customView(titleLabel:String,mess:String){
        
        // title remind
        let title = UILabel()
        title.frame = CGRect(x: 10, y: 20, width: 300, height: 25)
        title.textColor = UIColor.white
        title.textAlignment = .left
        title.text = titleLabel
        self.addSubview(title)
        // messRemind
        let messLabel = UILabel()
        messLabel.frame = CGRect(x:10, y:60, width: 300, height: 25)
        messLabel.textColor = UIColor.white
        messLabel.textAlignment = .left
        messLabel.text = mess
        self.addSubview(messLabel)
    }
    
    // delay after
    func hiddenView(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.isHidden  = true
        }
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
