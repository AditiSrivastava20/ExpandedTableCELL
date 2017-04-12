//
//  SecondTableViewCell.swift
//  NewExpand
//
//  Created by Sierra 4 on 10/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit


class SecondTableViewCell: UITableViewCell {

    var frameAdded = false
    var isChecked = false
    var array = arrayData.secondArray
    var array2 = arrayData.secondArray2
    
    class var expHeight: CGFloat{get{return 170}}
    class var defHeight : CGFloat{get{return 44}}
    
    @IBOutlet weak var lblSecond: UILabel!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var tableVIewthird: UITableView!
    @IBOutlet weak var btlSubs: UIButton!
        
    
    override func awakeFromNib() {
        tableVIewthird.delegate = self
        tableVIewthird.dataSource = self
    }
    func checkHeight(){
        viewSecond.isHidden = (frame.size.height < SecondTableViewCell.expHeight)
        
    }
    var object : Model?{
        didSet{
            UIUpdate()
        }
    }
    fileprivate func UIUpdate(){
        lblSecond.text = object?.label
    }
    
    func watchFrameChanges(){
        if !frameAdded{
            addObserver(self, forKeyPath: Second.myFrame.rawValue, options: .new, context: nil)
            frameAdded = true
            checkHeight()
        }
    }
    func ignoreFrameChanges(){
        if frameAdded{
            removeObserver(self, forKeyPath: Second.myFrame.rawValue)
            frameAdded = false
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Second.myFrame.rawValue{
            checkHeight()
    }
}
    
    @IBAction func btnCheck(_ sender: UIButton) {
        if isChecked == false{
            sender.setImage(#imageLiteral(resourceName: "ic_check_box"), for: .normal)
            isChecked = true
            
        }
        else{
            sender.setImage(#imageLiteral(resourceName: "ic_check_box_outline_blank"), for: .normal)
            isChecked = false
        }
    }
}

extension SecondTableViewCell:UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Second.thirdCell.rawValue, for: indexPath) as! ThirdTableViewCell
        cell.object = array[indexPath.row]
         return cell
    }
}
