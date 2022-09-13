//
//  CFButton.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 30/06/2022.
//

import UIKit

class CFMainButton: UIButton {

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
        setTitle(title.rawValue, for: .normal)
    }
    
    func configure(){
        isUserInteractionEnabled = true
        setTitleColor(.white, for: .normal)
        backgroundColor                                 = Colors.coffee
        layer.cornerRadius                              = 66 / 2
        titleLabel!.font                                = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints       = false
    }

}
