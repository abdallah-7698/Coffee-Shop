//
//  CFLable.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 30/06/2022.
//

import UIKit

class CFRegisterLable: UILabel {

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
        textColor                                   = UIColor(named: "RegisterLableColor")
        font                                        = UIFont.systemFont(ofSize: 17)
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .left
    }

}
