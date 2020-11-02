//
//  DevicesListViewController.swift
//  ModuloTech
//
//  Created by Ahmed K. on 11/10/2020.
//

import UIKit
import RxCocoa
import RxSwift

final class DevicesListViewController: MainViewController {

    var viewModel = DevicesListViewModel()
    private let disposeBag = DisposeBag()
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.setupCellsSelection()
        self.bindTableView()

    }
}

// MARK: - TableView Setups
extension DevicesListViewController: UITableViewDelegate {

    private func setupTableView() {
        self.tableView = UITableView(frame: self.view.frame, style: .grouped)
        self.tableView.backgroundColor = .white
        self.tableView.rowHeight = 50
        self.tableView.separatorColor = .lightGray
        self.tableView.allowsMultipleSelection = false

        // Add tableView and setup constraints
        self.view.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }

    private func bindTableView() {
        self.viewModel.dataSource
            .bind(to: self.tableView.rx.items) { (tableView, row, model) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(model.deviceName) @ type \(model.productType)"
                return cell
            }
            .disposed(by: self.disposeBag)
    }

    private func setupCellsSelection() {
        self.tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.viewModel.didSelectItem(indexPath)
            }).disposed(by: disposeBag)
    }
}
