//
//  OneButtonTableViewCell.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 26.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import UIKit

class OneButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
