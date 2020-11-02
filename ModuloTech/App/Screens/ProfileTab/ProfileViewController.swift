//
//  ProfileViewController.swift
//  ModuloTech
//
//  Created by Ahmed K. on 30/10/2020.
//

import UIKit
import RxCocoa
import RxSwift

class ProfileViewController: MainViewController {

    @IBOutlet private weak var birthDateLabel: UILabel!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    private let viewModel = ProfileViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindView()
    }

    private func bindView() {
        self.viewModel.userFullName.subscribe(onNext: { [unowned self] fullName in

            self.fullNameLabel.text = fullName
            self.addressLabel.text = self.viewModel.userAddress
            self.birthDateLabel.text = self.viewModel.userBirthDate
        }).disposed(by: self.disposeBag)
    }
}
