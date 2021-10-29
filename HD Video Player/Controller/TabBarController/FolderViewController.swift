//
//  FolderViewController.swift
//  HD Video Player
//
//  Created by macOS on 29/10/21.
//

import UIKit

class FolderViewController: UITableViewController {

    @IBOutlet var collcectionView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
