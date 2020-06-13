//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Ankur on 08/06/20.
//  Copyright © 2020 Ankur. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    private let refreshControl = UIRefreshControl()
    var dataModel: DataModel = DataModel()
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        refreshControl.backgroundColor = .lightGray
        refreshControl.tintColor = .red
        let font = UIFont.systemFont(ofSize: 30, weight: .light)
        let attributes = [NSAttributedString.Key.font: font]
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching new values...", attributes: attributes)
        // Do any additional setup after loading the view.
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(regenerateRandomNumber), for: .valueChanged)
    }
    
    @objc private func regenerateRandomNumber(_ sender: Any) {
        dataModel.diceArr.append(Int.random(in: 1...6))
        tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension ViewController: UITableViewDelegate
{
    
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataModel.diceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell: RandomCell = tableView.dequeueReusableCell(withIdentifier: "RandomCell") as! RandomCell
        cell.cellInfo = (indexPath.row + 1 , dataModel.diceArr[indexPath.row])
        return cell
    }    
}

