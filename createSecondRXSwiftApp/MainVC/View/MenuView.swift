//
//  MenuView.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import UIKit
import RxSwift
import RxCocoa


class MenuView: UIViewController {
    
    //MARK: - IBOutlet
    var tableView : UITableView = {
        let table = UITableView()
        table.register(MenuTVCell.self, forCellReuseIdentifier: MenuView.menuTVCell)
        return table
    }()
    
    let imageView = UIImageView(image: UIImage(named: "cart_menu_icon copy"))
    lazy var badgeNumber = CFBadgeLable()


    //MARK: - Constant
    
    static private let menuTVCell = "MenuTVCell"
    

    private let bag = DisposeBag()
    
    
    //MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureUI()
        bindTableView()
        setCellHeight()
        onSelectCellAction()
        MenuViewModel.shared.frachItems()
            
    }
    
    //MARK: - UI Configuration
    
    private func configureUI(){
        self.navigationController?.navigationBar.isHidden = false
        title = "Menu"
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Arial Rounded MT Bold", size: 25)! ,
            NSAttributedString.Key.foregroundColor : Colors.coffee]
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = Colors.coffee
        view.addSubview(tableView)
        tableView.frame = view.bounds
       
        prepareBadge()
        addBarButton()
    
    }
    
    private func prepareBadge(){
        imageView.frame = CGRect(x: 0, y: 0, width: 17, height: 17)
        MenuViewModel.shared.getChartItemsCount().subscribe { count in
            self.chackCountItems(itemsCount: count)
        }.disposed(by: bag)
        let badgeView = UIView(frame: CGRect(x: -6, y: -5, width: 20, height: 20))
        badgeView.backgroundColor = .systemRed
        badgeView.layer.cornerRadius = 10
        badgeView.addSubview(badgeNumber)
        imageView.contentMode = .center
        imageView.addSubview(badgeView)
    }
    
    private func addBarButton(){
        let rightBarButton = UIBarButtonItem(customView: imageView)
        let tapGesture = UITapGestureRecognizer()
        imageView.addGestureRecognizer(tapGesture)
        navigationItem.rightBarButtonItem = rightBarButton
        tapGesture.rx.event.subscribe { _ in
            let vc = ChartView()
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
    }
    
    
    
    //MARK: - HelperFunctions
    
    private func bindTableView(){
        MenuViewModel.shared.itemObservable.bind(to: self.tableView.rx.items(cellIdentifier: MenuView.menuTVCell, cellType: MenuTVCell.self)){(row , model , cell) in
            cell.configure(coffee: model)
        }.disposed(by: bag)
    }
    
    private func setCellHeight(){
        tableView.rx.setDelegate(self).disposed(by: bag)
    }
    
    private func onSelectCellAction(){
        tableView.rx.modelSelected(Coffee.self).bind { [weak self] model in
            guard let self = self else{return}
            let vc = OrderCoffeeView()
            vc.coffee = model
            if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: bag)
    }
    
    private func chackCountItems(itemsCount : Int){
        if itemsCount == 0 {
            imageView.isHidden = true
        }else{
            imageView.isHidden = false
            badgeNumber.text = " \(itemsCount)"
        }
    }
    
}

extension MenuView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
