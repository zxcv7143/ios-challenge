//
//  ViewController.swift
//  AdList
//
//  Created by Anton Zuev on 13/3/25.
//

import UIKit

protocol AdListViewControllerProtocol: AnyObject {
    var presenter: AdListPresenterProtocol? { get set }
    func loadUI()
    func fetchedAds(list: [Ad])
    func setFavoriteAd(with index: Int, of ads: [Ad])
    func showAlertError()
}

protocol AdTableViewCellProtocol: AnyObject {
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat)
    func favoriteAdAction(_ ad: Ad)
}

class AdListViewController: UITableViewController {
    
    var presenter: AdListPresenterProtocol?
    
    private var ads: [Ad] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter else { return }
        presenter.viewDidLoad()
    }
    
    // Private functions
    private func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.refreshControl = UIRefreshControl()
    }
    
    private func setStyles() {
        self.view.backgroundColor = .white
        self.tableView.backgroundColor = .white
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    private func addPullToRefresh() {
        self.refreshControl?.addTarget(self, action: #selector(self.refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        guard let presenter = self.presenter else { return }
        presenter.getAllAds()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ads.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: AdListTableViewCell.cellId, for: indexPath)
        guard let adCell = cell as? AdListTableViewCell else { return UITableViewCell() }
        adCell.delegate = self
        adCell.load(homeAd: self.ads[indexPath.row])
        return adCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //guard let presenter else { return }
        //presenter.goToDetailAd()
    }
}

extension AdListViewController: AdListViewControllerProtocol {
    
    func loadUI() {
        self.configureTableView()
        self.setStyles()
        self.addPullToRefresh()
    }
    
    func fetchedAds(list: [Ad]) {
        self.ads = list
        DispatchQueue.main.async {
            if self.refreshControl?.isRefreshing ?? false {
                self.refreshControl?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
    func setFavoriteAd(with index: Int, of ads: [Ad]) {
        self.ads = ads
        guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? AdListTableViewCell else {
            return
        }
        cell.updateFavoriteView(ad: self.ads[index])
    }
    
    func hideBackButtonNavBar() {
        self.navigationItem.leftBarButtonItem = nil
    }
    
    func showAlertError() {
        //self.showErrorAlert(title: "Error")
    }
}


// Protocol: AdTableViewCell -> View
extension AdListViewController: AdTableViewCellProtocol {
    
    func showAdLocationOnMap(latitude: CGFloat, longitude: CGFloat) {
        //guard let presenter else { return }
        //presenter.showAdLocationOnMap(latitude: latitude, longitude: longitude)
    }
    
    func favoriteAdAction(_ ad: Ad) {
        guard let presenter else { return }
        presenter.favoriteAdAction(ad)
    }
}

