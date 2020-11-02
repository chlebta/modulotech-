//
//  ProfileViewModel.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import Foundation
import RxCocoa
import RxSwift

class ProfileViewModel {

    private let apiRequest: UserRequest
    private let disposeBag = DisposeBag()

    let userFullName = BehaviorRelay<String?>(value: nil)

    private(set) var userAddress: String?
    private(set) var userBirthDate: String?

    init(_ apiRequest: UserRequest = HomeRequest()) {
        self.apiRequest = apiRequest
        self.subscribeToUser()
    }

    private func subscribeToUser() {
        self.apiRequest.user.subscribe(onNext: { [weak self] user in
            guard let user = user else {
                return
            }
            self?.updateAttributes(user)
        }).disposed(by: self.disposeBag)
    }

    private func updateAttributes(_ user: User) {

        self.userFullName.accept(String(format: "name".localized, "\(user.firstName) \(user.lastName)"))

        self.userAddress = String(format: "address".localized, self.formatAddress(user.address))
        self.userBirthDate = String(format: "birthDate".localized, self.formatDate(user.birthDate))
    }

    private func formatAddress(_ address: Address) -> String {
        return address.streetCode + " " + address.street + ", \(address.postalCode)" + " " + address.city
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
}
