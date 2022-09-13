//
//  OrderCoffeeView.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class OrderCoffeeView: UIViewController {
    
    //MARK: - IBOutlet
    let containerView1 = UIView()
    let contaienrBackgroundImage = UIImageView()
    let coupImage = UIImageView()
    
    let containerView2 = UIView()
    let coffeeNameLable = CFCoffeeNameLable()
    let priceLable = CFCoffeeNameSublableLable()
    let countNumber = CFCoffeeNameSublableLable(title: "0", fontSize: 25)
    lazy var addOrder : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var removeOrder : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "remove_button"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var buttonsStackView : UIStackView = {
        let stack = UIStackView(arrangedSubviews: [removeOrder , addOrder])
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    let underLineView1   = UIView()
    
    let containerView3 = UIView()
    let totalLable = CFTotalLable(title: .total)
    let totalPriceLable = CFCoffeeNameSublableLable()
    
    let underLineView2 = UIView()
    
    let addToChartButton = CFMainButton(title: .addToChart)
        
    //MARK: - Constant
    // will change
    var coffee : Coffee?
    
    private let bag = DisposeBag()
    
    //private var viewModel = MenuViewModel()
    
    
    //MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addOrderCoffee()
        removeOrderCoffee()
        addToChart()
    }
    
    //MARK: - UI Configuration
    
    private func configureUI(){
        view.backgroundColor = .systemBackground
        
        self.navigationController?.navigationBar.isHidden = false
        guard let coffee = coffee else {return}
        title = coffee.name
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 25)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.tintColor = Colors.coffee
        
        view.addSubview(containerView1)
        containerView1.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView1.heightAnchor.constraint(equalToConstant: 245)
        ])
        containerView1.addSubview(contaienrBackgroundImage)
        contaienrBackgroundImage.translatesAutoresizingMaskIntoConstraints = false
        contaienrBackgroundImage.image = UIImage(named: "header")
        NSLayoutConstraint.activate([
            contaienrBackgroundImage.topAnchor.constraint(equalTo: containerView1.topAnchor),
            contaienrBackgroundImage.leadingAnchor.constraint(equalTo: containerView1.leadingAnchor),
            contaienrBackgroundImage.trailingAnchor.constraint(equalTo: containerView1.trailingAnchor),
            contaienrBackgroundImage.bottomAnchor.constraint(equalTo: containerView1.bottomAnchor)
        ])
        containerView1.addSubview(coupImage)
        coupImage.translatesAutoresizingMaskIntoConstraints = false
        coupImage.image = UIImage(named: coffee.icon!)
        NSLayoutConstraint.activate([
            coupImage.centerXAnchor.constraint(equalTo: containerView1.centerXAnchor),
            coupImage.centerYAnchor.constraint(equalTo: containerView1.centerYAnchor),
        ])
        
        view.addSubview(containerView2)
        containerView2.translatesAutoresizingMaskIntoConstraints =  false
        NSLayoutConstraint.activate([
            containerView2.topAnchor.constraint(equalTo: containerView1.bottomAnchor),
            containerView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView2.heightAnchor.constraint(equalToConstant: 125)
        ])
        containerView2.addSubview(coffeeNameLable)
        coffeeNameLable.text = coffee.icon
        NSLayoutConstraint.activate([
            coffeeNameLable.leadingAnchor.constraint(equalTo: containerView2.leadingAnchor , constant: 22),
            coffeeNameLable.centerYAnchor.constraint(equalTo: containerView2.centerYAnchor)
        ])
        containerView2.addSubview(priceLable)
        priceLable.text = "£ \(coffee.price)"
        priceLable.font = UIFont.systemFont(ofSize: 16)
        NSLayoutConstraint.activate([
            priceLable.topAnchor.constraint(equalTo: coffeeNameLable.bottomAnchor, constant: 5),
            priceLable.leadingAnchor.constraint(equalTo: coffeeNameLable.leadingAnchor)
        ])
        containerView2.addSubview(buttonsStackView)
        NSLayoutConstraint.activate([
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView2.trailingAnchor, constant: -22),
            buttonsStackView.widthAnchor.constraint(equalToConstant: 130),
            buttonsStackView.centerYAnchor.constraint(equalTo: containerView2.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            addOrder.widthAnchor.constraint(equalToConstant: 60),
            removeOrder.widthAnchor.constraint(equalToConstant: 60)
        ])
        containerView2.addSubview(countNumber)
        NSLayoutConstraint.activate([
            countNumber.trailingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor, constant: -15),
            countNumber.centerYAnchor.constraint(equalTo: containerView2.centerYAnchor)
        ])
        
        view.addSubview(underLineView1)
        underLineView1.translatesAutoresizingMaskIntoConstraints = false
        underLineView1.backgroundColor = Colors.coffee
        NSLayoutConstraint.activate([
            underLineView1.topAnchor.constraint(equalTo: containerView2.bottomAnchor),
            underLineView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underLineView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underLineView1.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        view.addSubview(containerView3)
        containerView3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView3.topAnchor.constraint(equalTo: underLineView1.bottomAnchor),
            containerView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView3.heightAnchor.constraint(equalToConstant: 125)
        ])
        containerView3.addSubview(totalLable)
        NSLayoutConstraint.activate([
            totalLable.leadingAnchor.constraint(equalTo: containerView3.leadingAnchor , constant: 22),
            totalLable.centerYAnchor.constraint(equalTo: containerView3.centerYAnchor)
        ])
        containerView3.addSubview(totalPriceLable)
        totalPriceLable.text = "£ 0"
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
            totalPriceLable.trailingAnchor.constraint(equalTo: containerView3.trailingAnchor, constant: -22),
            totalPriceLable.centerYAnchor.constraint(equalTo: containerView3.centerYAnchor)
        ])
        
        view.addSubview(underLineView2)
        underLineView2.translatesAutoresizingMaskIntoConstraints = false
        underLineView2.backgroundColor = Colors.coffee
        NSLayoutConstraint.activate([
            underLineView2.topAnchor.constraint(equalTo: containerView3.bottomAnchor),
            underLineView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underLineView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underLineView2.heightAnchor.constraint(equalToConstant: 2)
        ])
        
        view.addSubview(addToChartButton)
        NSLayoutConstraint.activate([
            addToChartButton.topAnchor.constraint(equalTo: underLineView2.bottomAnchor, constant: 30),
            addToChartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 22),
            addToChartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -20),
            addToChartButton.heightAnchor.constraint(equalToConstant: 66)
        ])
        
    }
    
    //MARK: - HelperFunctions

    private func addOrderCoffee(){
        addOrder.rx.tap.throttle(RxTimeInterval.microseconds(300), scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            guard let self = self else {return}
            var countN = Int(self.countNumber.text!)!
            countN = countN + 1
            self.countNumber.text = "\(countN)"
            self.totalPriceLable.text = "£ \(Float(countN) * self.coffee!.price)"
        }.disposed(by: bag)
    }

    private func removeOrderCoffee(){
        removeOrder.rx.tap.throttle(RxTimeInterval.microseconds(300), scheduler: MainScheduler.instance).subscribe {[weak self] _ in
            guard let self = self else {return}
            var countN = Int(self.countNumber.text!)!
            if countN > 0 {
                countN = countN - 1
                self.countNumber.text = "\(countN)"
                self.totalPriceLable.text = "£ \(Float(countN) * self.coffee!.price)"
            }
        }.disposed(by: bag)
    }

    private func addToChart(){
        addToChartButton.rx.tap.throttle(RxTimeInterval.microseconds(300), scheduler: MainScheduler.instance).subscribe { [weak self] (_) in
            
            guard let self = self else {return}
            let data = ChartItem(coffee: self.coffee!, count: Int(self.countNumber.text!)!)
            MenuViewModel.shared.acceptData(data: data)
            self.countNumber.text = "\(0)"
            self.totalPriceLable.text = "£ \(0.0)"
            
        }.disposed(by: bag)
    }

    
    
}





