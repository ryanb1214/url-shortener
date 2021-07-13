//
//  SecondViewController.swift
//  URL Shortener
//
//  Created by Ryan on 2020-04-21.
//  Copyright © 2020 Ryan Ball. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    let cellTableIdentifier = "CellTableIdentifier"
    
    
    @IBOutlet weak var tableView: UITableView!
    let urls = [
        ["LongURL" : "test.com", "ShortURL" : "shrtco.de"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(LongAndShortURLCell.self,
                                forCellReuseIdentifier: cellTableIdentifier)
        let xib = UINib(nibName: "LongAndShortURLCell", bundle: nil)
        tableView.register(xib,
                              forCellReuseIdentifier: cellTableIdentifier)
        tableView.rowHeight = 65
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: -
    // MARK: Table View Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellTableIdentifier, for: indexPath)
            as! LongAndShortURLCell
        
        let rowData = urls[indexPath.row]
        cell.longURL = rowData["LongURL"]!
        cell.shortURL = rowData["ShortURL"]!
        
        return cell
    }
    
}

