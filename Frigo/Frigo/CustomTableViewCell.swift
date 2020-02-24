//
//  CustomTableViewCell.swift
//  Frigo
//
//  Created by Lily Cheng on 2/16/20.
//  Copyright © 2020 Lily Cheng. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodAmount: UILabel!
    @IBOutlet weak var foodDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

 

}
