//
//  MenuVC.swift
//  LocationNotes
//
//  Created by Роман Мельник on 12.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let menu = [R.string.localizable.menuLocationNotes(), R.string.localizable.menuCurrencyConverter(), R.string.localizable.menuInDeveloping()]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        prepareUI()

    }
    
    // MARK: - UI
    func prepareUI() {
        headerLabel.textColor = .white
        headerLabel.text = R.string.localizable.menuSelectMenuItem()
    }
}

// MARK: - TableView

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    func prepareTableView() {
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 100
        tableView.register(MenuCell.self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as? MenuCell {
            cell.setItemLabel(item: menu[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            guard let vc = Router.shared.tabNavBar() else { return }
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            guard let vc = Router.shared.bannerVC() else { return }
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        } else {
            showAlertView(R.string.localizable.menuAlertTitle(), R.string.localizable.menuAlertDescription())
        }
    }
    
}
