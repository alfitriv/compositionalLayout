//
//  ViewController.swift
//  MakeupPicker
//
//  Created by Vania Radmila Alfitri on 19/03/20.
//  Copyright © 2020 Vania Radmila Alfitri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var makeupStore = MakeupStore.shared
    @IBOutlet weak var tableView: UITableView!
    var makeupList: [Makeup] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeupStore.fetchMakeUpList(successHandler: { [weak self] (makeup) in
            print(makeup)
            self?.makeupList = makeup
            self?.tableView.register(UINib(nibName: "MakeupListCell", bundle: nil), forCellReuseIdentifier: "Cell")
            self?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return makeupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MakeupListCell
        let makeup = makeupList[indexPath.row]
        cell.setupView(makeup)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

