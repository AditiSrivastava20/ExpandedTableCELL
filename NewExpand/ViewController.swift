//
//  ViewController.swift
//  NewExpand
//
//  Created by Sierra 4 on 07/04/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedIndexPath:IndexPath?
    var array = arrayData.viewArray
    var status = false
    
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tblView.delegate = self
        tblView.dataSource = self
        tblView.rowHeight = UITableViewAutomaticDimension
    }

}

extension ViewController:UITableViewDelegate , UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Control.myCell.rawValue, for: indexPath) as! FirstTableViewCell
        cell.delegate = self
        cell.object = array[indexPath.section]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath{
            selectedIndexPath = nil
        }
        else{
            selectedIndexPath = indexPath
        }
        var indexPaths: [IndexPath] = []
        if let previous = previousIndexPath{
            indexPaths += [previous]
        }
        if let current = selectedIndexPath{
            indexPaths += [current]
        }
        if indexPaths.count > 0{
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! FirstTableViewCell).watchFrameChanges()
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! FirstTableViewCell).ignoreFrameChanges()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath{
            if status == false{
                return FirstTableViewCell.expandedheight
            }
            else{
                return 250
            }
                   }
        else{
            return FirstTableViewCell.defaultHeight
        }
    }
}

extension ViewController: PickerDelegate{
    func getStatus(status: Bool, table: UITableView) {
        print(Control.nill.rawValue , status)
        self.status = status
        table.reloadData()
        tblView.reloadData()
    }
}


