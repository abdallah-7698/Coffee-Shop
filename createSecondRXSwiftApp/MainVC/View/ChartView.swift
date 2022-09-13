//
//  ChartView.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 02/07/2022.
//

import UIKit
import RxCocoa
import RxSwift

class ChartView: UIViewController {

    //MARK: - IBOutlet
    
    let tableView : UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ChartTVCell.self, forCellReuseIdentifier: ChartView.chartTVCell)
        return table
    }()
    
    let containerView = UIView()
    let totalLable = CFTotalLable(title: .total)
    let totalPriceLable = CFCoffeeNameSublableLable(title: "£ 0", fontSize: 20)
    
    //MARK: - Constant

    static private let chartTVCell = "ChartTVCell"
    
    private let bag = DisposeBag()
    
   // var chartItems : [ChartItem] = []
     
//    var viewModel = MenuViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindTableView()
        setCellHeight()
        
    }

    private func configureUI(){
        view.backgroundColor = .systemBackground
        
        self.navigationController?.navigationBar.isHidden = false
        title = "Chart"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 25)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.tintColor = Colors.coffee
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -125),
        ])
        
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        containerView.addSubview(totalLable)
        NSLayoutConstraint.activate([
            totalLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor , constant: 22),
            totalLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        containerView.addSubview(totalPriceLable)
        totalPriceLable.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        NSLayoutConstraint.activate([
            totalPriceLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -22),
            totalPriceLable.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func bindTableView(){
        MenuViewModel.shared.chartItemObservable.bind(to: tableView.rx.items(cellIdentifier: ChartView.chartTVCell, cellType: ChartTVCell.self)){ row,model,cell in
            cell.configureCells(coffee: model)
        }.disposed(by: bag)
    }
    
    //MARK: - HelperFunctions
    private func setCellHeight(){
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func getTotalPrice(){
        MenuViewModel.shared.getTotalCount().subscribe { [weak self] price in
            guard let self = self else {return}
            self.totalPriceLable.text = "£ \(price)"
        }.disposed(by: bag)
    }
    
    
}

extension ChartView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
