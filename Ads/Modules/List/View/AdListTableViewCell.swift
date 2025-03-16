//
//  AdListTableViewCell.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import UIKit

final class AdListTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var savedInfoLabel: UILabel!
    @IBOutlet weak var favouriteAdButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    // MARK: Vars
    static let cellId: String = "AdListTableViewCellId"
    weak var delegate: AdTableViewCellProtocol?
    private var currentAd: Ad? = nil
    private var photosUrl: [String] = []
    
    // MARK: Public functions
    func load(homeAd: Ad) {
        self.currentAd = homeAd
        self.setupLabelsContent()
        self.setPhotos()
        self.configureFavoriteAdButton(ad: homeAd)
    }
    
    func updateFavoriteView(ad: Ad, date: Date?) {
        self.currentAd = ad
        self.configureFavoriteAdButton(ad: ad)
    }
    
    // MARK: IBActions private functions
    @IBAction private func seeOnMapAction(_ sender: Any) {
        guard let delegate = self.delegate, let homeAd = self.currentAd else { return }
        delegate.showAdLocationOnMap(latitude: homeAd.latitude, longitude: homeAd.longitude)
    }
    
    @IBAction private func favoriteAdAction(_ sender: Any) {
        guard let delegate, let currentAd else { return }
        delegate.favoriteAdAction(currentAd)
    }
    
    // MARK: Private functions

    private func setStyles() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.collectionView.backgroundColor = .white
        self.collectionView.layer.cornerRadius = 10.0
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.collectionView.layer.masksToBounds = true
    }
    
    private func setPhotos() {
        guard let photos = currentAd?.multimedia else { return }
        self.photosUrl = photos.images.map { $0.url }
        self.collectionView.reloadData()
    }
    
    private func setupLabelsContent() {
        guard let currentAd else { return }
        self.propertyTypeLabel.setStyle(font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, text: currentAd.propertyType.rawValue)
        self.locationLabel.setStyle(font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, text: currentAd.address)
        self.priceLabel.setStyle(font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, text: "\(currentAd.priceInfo.amount)\(currentAd.priceInfo.currencySuffix)")
    }
    
    private func configureFavoriteAdButton(ad: Ad) {
        if ad.isFavorite {
            self.favouriteAdButton.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy HH:mm"
            self.savedInfoLabel.setStyle(font: UIFont.systemFont(ofSize: 15), textColor: UIColor.black, text: "Saved on \(formatter.string(from: ad.dateSavedAsFavorite ?? Date()))")
            self.savedInfoLabel.isHidden = false
        } else {
            self.favouriteAdButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.savedInfoLabel.isHidden = true
        }
    }
}

extension AdListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosUrl.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellId, for: indexPath)
        guard let photoCell = cell as? PhotoCell else { return UICollectionViewCell() }
        photoCell.load(url: self.photosUrl[indexPath.row])
        return photoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width - 10, height: self.collectionViewHeightConstraint.constant)
    }
    
}

