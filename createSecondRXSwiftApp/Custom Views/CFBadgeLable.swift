//
//  CFBadgeLable.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 03/07/2022.
//

import UIKit

class CFBadgeLable: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(count : String?){
        super.init(frame: .zero)
        configure()
        text = count
    }
    
    func configure(){
        textColor                                   = .systemBackground
        font                                        = UIFont.systemFont(ofSize: 17, weight: .regular)
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .center
        layer.masksToBounds                         = true
        
    }

}
