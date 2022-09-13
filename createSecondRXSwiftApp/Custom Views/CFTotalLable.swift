//
//  CFTotalLable.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit

class CFTotalLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title : Title){
        super.init(frame: .zero)
        configure()
        text = title.rawValue
    }
    
    func configure(){
        textColor                                   = Colors.lightCoffee
        font                                        = UIFont.systemFont(ofSize: 28, weight: .medium)
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .left
    }

}
