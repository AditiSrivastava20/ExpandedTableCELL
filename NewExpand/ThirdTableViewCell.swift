//
//  ThirdTableViewCell.swift
//  NewExpand
//
//  Created by Sierra 4 on 10/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class ThirdTableViewCell: UITableViewCell {

    @IBOutlet weak var btnCheckBox: UIButton!
    @IBOutlet weak var lblStyle: UILabel!
    
    var object : Model?{
        didSet{
            UIUpdate()
        }
    }
    
    fileprivate func UIUpdate(){
        lblStyle.text = object?.label
    }
    
}
