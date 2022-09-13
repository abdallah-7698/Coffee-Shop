//
//  AuthorizationViewModel.swift
//  createSecondRXSwiftApp
//
//  Created by MacOS on 01/07/2022.
//

import Foundation
import RxSwift
import RxCocoa

class AuthorizationViewModel{
    
    
var emailBehavior = BehaviorRelay<String>(value: "")
var passwordBehavior = BehaviorRelay<String>(value: "")

    private var isEmailValid : Observable<Bool> {
        emailBehavior.asObservable().map { text in
            let emailPattern = "[A-Z0-9a-z._%+-]+@([A-Za-z0-9.-]{2,64})+\\.[A-Za-z]{2,64}"
            let isValid = !(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) && NSPredicate(format: "SELF MATCHES %@",emailPattern).evaluate(with: text)
            return isValid
        }
    }
    
    private var isPasswordValid : Observable<Bool> {
        passwordBehavior.asObservable().map { text in
            let passwordPattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
            let isValid = !(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) && NSPredicate(format: "SELF MATCHES %@", passwordPattern).evaluate(with: text)
            return isValid
        }
    }
    

    
    var isEveryThingValid : Observable<Bool> {
        Observable.combineLatest(isEmailValid, isPasswordValid){ emailValid , passwordValid in
            let validation = emailValid && passwordValid
            return validation
        }
    }
        
    
    
}
