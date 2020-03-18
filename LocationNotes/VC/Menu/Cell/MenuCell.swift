//
//  MenuCell.swift
//  LocationNotes
//
//  Created by Роман Мельник on 12.03.2020.
//  Copyright © 2020 Roman Melnyk. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func setItemLabel(item: String) {
        itemLabel.text = item.uppercased()
    }
    
}
