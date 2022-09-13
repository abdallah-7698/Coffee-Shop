//
//  ChartTVCell.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 02/07/2022.
//

import UIKit

class ChartTVCell: UITableViewCell {

    let coffeeImage = UIImageView()
    let coffeeNameLable = CFCoffeeNameLable()
    let countOfCoups = CFCoffeeNameSublableLable(title: "0 cup of coffee", fontSize: 17)
    let totalPriceLable = CFCoffeeNameSublableLable(title: "£ 0", fontSize: 17)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        configureUI()
    }
    
    private func configureUI(){
        self.selectionStyle = .none
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
 
        contentView.addSubview(countOfCoups)
        NSLayoutConstraint.activate([
            countOfCoups.topAnchor.constraint(equalTo: coffeeNameLable.bottomAnchor, constant: 5),
            countOfCoups.leadingAnchor.constraint(equalTo: coffeeNameLable.leadingAnchor)
        ])
        
        contentView.addSubview(totalPriceLable)
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
            totalPriceLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22),
            totalPriceLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }

    func configureCells(coffee : ChartItem){
        coffeeImage.image = UIImage(named: coffee.coffee.icon!)
        coffeeNameLable.text = coffee.coffee.name
        countOfCoups.text = "\(coffee.count) cup of coffee"
        totalPriceLable.text = "£ \(coffee.coffee.price * Float(coffee.count))"
    }
    
}
