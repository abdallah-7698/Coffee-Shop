//
//  MenuViewModel.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MenuViewModel{
    
    
    private init (){}
    
    static let shared = MenuViewModel()
    
    private let bag = DisposeBag()
    
    
    private var items = PublishSubject<[Coffee]>()
    
    var itemObservable : Observable<[Coffee]> {
        return items.asObservable()
    }
    
    private var chartItemBehavior = BehaviorRelay<[ChartItem]>(value: [])
    var chartItemObservable : Observable<[ChartItem]> {
        return chartItemBehavior.asObservable()
    }
    
    func acceptData(data : ChartItem){
        chartItemBehavior.accept(addValue(arrayIn: chartItemBehavior.value, newItem: data))
    }
    
    private func addValue(arrayIn : [ChartItem] , newItem : ChartItem) -> [ChartItem]{
        var array = arrayIn
        if array.count > 0{
            for index in 0...array.count-1 {
                if array[index].coffee == newItem.coffee {
                    array[index].count += newItem.count
                    return array
                }
            }
            array.append(newItem)
            return array
        }
        array.append(newItem)
        return array
    }
    
    
    func getTotalCount() -> Observable<Int> {
        return chartItemBehavior.map { $0.reduce(0) { $0 + $1.count }} // 9
    }
    
    func  getChartItemsCount() ->Observable<Int> {
        return chartItemBehavior.map { $0.count }
    }
    
    
    // done
    func frachItems(){
      let coffeeArray = [
        Coffee(name: "Espresso", icon: "espresso", price: 4.5) ,
        Coffee(name: "Cappuccino", icon: "cappuccino", price: 11) ,
        Coffee(name: "Macciato", icon: "macciato", price: 13) ,
        Coffee(name: "Mocha", icon: "mocha", price: 8.5) ,
        Coffee(name: "Latte", icon: "latte", price: 7.5)
                        ]
        
        items.onNext(coffeeArray)
        items.onCompleted()
    }
    
}
