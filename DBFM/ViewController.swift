//
//  ViewController.swift
//  DBFM
//
//  Created by 钟信 on 15/8/2.
//  Copyright (c) 2015年 钟信. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,HttpProtocol {

    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var iv: UIButton!
    @IBOutlet weak var tv: UITableView!
    @IBOutlet weak var playTime: UILabel!
    var eHttp:HttpController = HttpController()
    var tableData:NSArray = NSArray()
    var chanelData:NSArray = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        eHttp.delegate=self
        eHttp.onSearch("http://www.douban.com/j/app/radio/channels")
        eHttp.onSearch("http://douban.fm/j/mine/playlist?channel=0")
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return tableData.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "douban")
        let rowData:NSDictionary = self.tableData[indexPath.row] as! NSDictionary
        cell.text = rowData["title"] as! String
        return cell
    }
    func didRecieveResults(results:NSDictionary) {
        if let op=results["songs"]{
            self.tableData = op["songs"] as NSArray
            self.tv.reloadData()
        } else if let op=results["channels"]{
            self.tableData = op["channels"] as NSArray
        
        }
    }
}

