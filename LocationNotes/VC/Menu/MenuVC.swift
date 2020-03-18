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
    
    let menu = ["fdjfhdjgh", "dafefsefe","dawadaf121"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
          tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.register(MenuCell.self)
        // Do any additional setup after loading the view.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MenuVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
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
//            self.navigationController?.pushViewController(Router.shared.bannerVC(), animated: true)
//            print("Govno")
        }
        print("indexPath - \(indexPath)")
    }
    
    
}
