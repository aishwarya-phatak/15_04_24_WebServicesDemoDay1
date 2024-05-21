//
//  CompanyTableViewCell.swift
//  15_04_24_WebServicesDemoDay1
//
//  Created by Vishal Jagtap on 21/05/24.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyZipLabel: UILabel!
    @IBOutlet weak var companyCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
