//
//  MenuTVCell.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit

class MenuTVCell: UITableViewCell {

    //MARK: - IBOutlet

    let coffeeImage = UIImageView()
    let coffeeNameLable = CFCoffeeNameLable()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
        // Configure the view for the selected state
    }

    //MARK: - UI Configuration
    private func configureUI(){
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(coffeeImage)
        coffeeImage.contentMode = .center
        coffeeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        coffeeImage.topAnchor.constraint(equalTo: contentView.topAnchor , constant: 15),
        coffeeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
        coffeeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -15),
        coffeeImage.widthAnchor.constraint(equalToConstant: 60)
        ])
        contentView.addSubview(coffeeNameLable)
        NSLayoutConstraint.activate([
        coffeeNameLable.leadingAnchor.constraint(equalTo: coffeeImage.trailingAnchor, constant: 30),
        coffeeNameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        coffeeNameLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    //MARK: - HelperFunctions
    
    func configure(coffee : Coffee){
        coffeeImage.image = UIImage(named: coffee.icon!)
        coffeeNameLable.text = coffee.name
    }
    
}
