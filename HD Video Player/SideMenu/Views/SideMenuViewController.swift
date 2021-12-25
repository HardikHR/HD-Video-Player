//
//  SideMenuViewController.swift
//  CustomSideMenuiOSExample
//
//  Created by John Codeos on 2/7/21.
//

import UIKit

protocol SideMenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}
struct SideMenuModel {
    var icon: UIImage
    var title: String
}

class SideMenuViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var sideMenuTableView: UITableView!

    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    var menu: [SideMenuModel] = [
        SideMenuModel(icon: UIImage(systemName: "video")!, title: "Video"),
        SideMenuModel(icon: UIImage(systemName: "folder")!, title: "Folder"),
        SideMenuModel(icon: UIImage(systemName: "clock.arrow.circlepath")!, title: "Recent"),
        SideMenuModel(icon: UIImage(systemName: "video.slash")!, title: "Hide Video"),
        SideMenuModel(icon: UIImage(systemName: "star")!, title: "Rate Us"),
        SideMenuModel(icon: UIImage(systemName: "arrowshape.turn.up.right.circle.fill")!, title: "Share"),
        SideMenuModel(icon: UIImage(systemName: "person.fill.questionmark")!, title: "About us")
     ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.sideMenuTableView.separatorStyle = .none
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }
        self.sideMenuTableView.register(SideMenuCell.nib, forCellReuseIdentifier: SideMenuCell.identifier)
        self.sideMenuTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate -

extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource -

extension SideMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCell.identifier, for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        cell.iconImageView.image = self.menu[indexPath.row].icon
        cell.titleLabel.text = self.menu[indexPath.row].title
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(indexPath.row)
    }
}
