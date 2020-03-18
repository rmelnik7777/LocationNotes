//
//  MenuCell.swift
//  LocationNotes
//
//  Created by Роман Мельник on 12.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var parentsView: UIView!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        preareUI()
    }
    
    // MARK: - UI
    
    func preareUI() {
        parentsView.layer.cornerRadius = 10
        parentsView.backgroundColor = R.color.appOrange()
        itemLabel.font = R.font.superWebcomicBrosBold(size: 22)
        itemLabel.textColor = .white
    }
    
    // MARK: - Setup cell
    
    func setItemLabel(item: String) {
        itemLabel.text = item.uppercased()
    }
    
}
