//
//  CFCoffeeNameSubtitle.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit

class CFCoffeeNameSublableLable: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title : String , fontSize : CGFloat){
        super.init(frame: .zero)
        configure()
        text = title
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    func configure(){
        textColor                                   = .label
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .left
    }
    
}
