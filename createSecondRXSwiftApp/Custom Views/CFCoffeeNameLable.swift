//
//  CFCoffeeNameLable.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit

class CFCoffeeNameLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        textColor                                   = Colors.darkCoffee
        font                                        = UIFont.systemFont(ofSize: 20, weight: .semibold)
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .left
    }

}
