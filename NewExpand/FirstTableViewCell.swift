//
//  PickerTableViewCell.swift
//  NewExpand
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

protocol PickerDelegate{
    func getStatus(status:Bool , table:UITableView)
}

class FirstTableViewCell: UITableViewCell {
    static var height = 200
    static var def = 44
    var selectedIndexPath:IndexPath?
    var flag = false
    var delegate:PickerDelegate?
    var myPath = IndexPath(row: 0, section: 1)
    var frameAdded = false
   
    var array = arrayData.pickerArray
    
    class var expandedheight: CGFloat{get{return CGFloat(43*3 ) }}
    class var defaultHeight : CGFloat{get{return CGFloat(FirstTableViewCell.def)}}
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewMyView: UIView!
    @IBOutlet weak var tblViewSecond: UITableView!
    {
        didSet{
            tblViewSecond.delegate = self
            tblViewSecond.dataSource = self
            tblViewSecond.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    
    func checkHeight(){
        viewMyView.isHidden = (frame.size.height < FirstTableViewCell.expandedheight)
        
    }
    var object : Model?{
        didSet{
            UIUpdate()
    }
    }
    fileprivate func UIUpdate(){
        lblTitle.text = object?.label
    }
    func watchFrameChanges(){
        if !frameAdded{
        addObserver(self, forKeyPath: Picker.frame.rawValue, options: .new, context: nil)
            frameAdded = true
        checkHeight()
        }
    }
    func ignoreFrameChanges(){
        if frameAdded{
        removeObserver(self, forKeyPath: Picker.frame.rawValue)
            frameAdded = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == Picker.frame.rawValue{
            checkHeight()
    }
    }
    
    @IBAction func btnSubscribe(_ sender: UIButton) {
        
        
     myPath = IndexPath(row: sender.tag, section: 0)
        sender.setTitle(Picker.added.rawValue , for: .normal)
        let previousIndexPath = selectedIndexPath
        if myPath == selectedIndexPath{
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = myPath
        }
        var indexPaths: [IndexPath] = []
        if let previous = previousIndexPath{
            indexPaths += [previous]
        }
        if let current = selectedIndexPath{
            indexPaths += [current]
        }
        if indexPaths.count > 0{
            tblViewSecond.reloadRows(at: indexPaths, with: .automatic)
        }
        if flag == false{
            self.delegate?.getStatus(status: true , table: tblViewSecond)
        flag = true
        }
        else{
            self.delegate?.getStatus(status: false , table: tblViewSecond)
            flag = false
        }
        tblViewSecond.reloadData()
        
    }
}
extension FirstTableViewCell:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Picker.tableCell.rawValue, for: indexPath) as! SecondTableViewCell
        cell.btlSubs.tag = indexPath.row
        cell.object = array[indexPath.row]
        cell.btlSubs.addTarget(self, action: #selector(btnSubscribe(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! SecondTableViewCell).watchFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! SecondTableViewCell).ignoreFrameChanges()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath == selectedIndexPath ? SecondTableViewCell.expHeight : SecondTableViewCell.defHeight
    }
}
