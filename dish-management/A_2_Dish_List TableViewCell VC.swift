//
//  A_2_Dish_List TableViewCell VC.swift
//  dish-management
//
//  Created by 山田航輝 on 2022/02/01.
//

import UIKit

class A_2_Dish_List_TableViewCell_VC: UITableViewCell {

    
    @IBOutlet var dish_imageView: UIImageView!
    @IBOutlet var dish_nameLabel: UILabel!
    @IBOutlet var daysLeftLabel: UILabel!
    @IBOutlet var createdDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
