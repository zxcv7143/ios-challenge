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
    @IBOutlet private weak var favoriteAdSavedView: UIView!
    @IBOutlet private weak var favoriteAdSavedLabel: UILabel!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var extraInfoLabel: UILabel!
    @IBOutlet private weak var mapLocationImageView: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var favoriteAdImageView: UIImageView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
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
    }
    
    func updateFavoriteView(homeAd: Ad, date: Date?) {
        self.currentAd = homeAd
        self.configureFavoriteAdViews(homeAd: homeAd)
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
        self.infoView.backgroundColor = .white
        self.infoView.layer.cornerRadius = 10.0
        self.infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.infoView.layer.masksToBounds = true
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
    
    private func configureMapLocationButton() {
        self.mapLocationImageView.image = UIImage(systemName: "location.circle")?.withRenderingMode(.alwaysTemplate)
        self.mapLocationImageView.tintColor = .yellow
    }
    
    private func configureFavoriteAdSavedView() {
        self.favoriteAdSavedView.layer.cornerRadius = 6
        self.favoriteAdSavedView.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    private func configureFavoriteAdViews(homeAd: Ad) {
        if homeAd.isFavorite {
            self.favoriteAdImageView.image = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
            self.favoriteAdImageView.tintColor = .red
            self.favoriteAdSavedView.isHidden = false
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
        } else {
            self.favoriteAdImageView.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            self.favoriteAdImageView.tintColor = .black
            self.favoriteAdSavedView.isHidden = true
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

