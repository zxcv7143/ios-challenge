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
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var favoriteAdSavedView: UIView!
    @IBOutlet private weak var favoriteAdSavedLabel: UILabel!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    @IBOutlet private weak var extraInfoLabel: UILabel!
    @IBOutlet private weak var mapLocationImageView: UIImageView!
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var topConstraint: NSLayoutConstraint!
    @IBOutlet private weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet private weak var favoriteAdImageView: UIImageView!
    
    // MARK: Vars
    static let name: String = "AdListTableViewCellId"
    weak var delegate: AdTableViewCellProtocol?
    private var homeAd: Ad? = nil
    private var photosUrl: [String] = []
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setDelegatesCollectionView()
        self.registerCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.propertyTypeLabel.text = nil
        self.locationLabel.text = nil
        self.priceLabel.text = nil
        self.extraInfoLabel.text = nil
    }
    
    // MARK: Public functions
    func load(homeAd: Ad) {
        self.homeAd = homeAd
        self.setStyles()
        self.setPhotos()
        self.setupLabelsContent()
        self.configureMapLocationButton()
        self.configureFavoriteAdViews(homeAd: homeAd)
        self.configureFavoriteAdSavedView()
    }
    
    func updateFavoriteView(homeAd: Ad, date: Date?) {
        self.homeAd = homeAd
        self.configureFavoriteAdViews(homeAd: homeAd)
    }
    
    // MARK: IBActions private functions
    @IBAction private func seeOnMapAction(_ sender: Any) {
        guard let delegate = self.delegate, let homeAd = self.homeAd else { return }
        delegate.showAdLocationOnMap(latitude: homeAd.latitude, longitude: homeAd.longitude)
    }
    
    @IBAction private func favoriteAdAction(_ sender: Any) {
        guard let delegate, let homeAd else { return }
        delegate.favoriteAdAction(homeAd)
    }
    
    // MARK: Private functions
    private func setDelegatesCollectionView() {
        //self.collectionView.delegate = self
        //self.collectionView.dataSource = self
    }
    
    private func registerCell() {
        //self.collectionView.register(UINib(nibName: PhotoListCollectionViewCell.name, bundle: nil), forCellWithReuseIdentifier: PhotoListCollectionViewCell.name)
    }
    
    private func setStyles() {
        self.backgroundColor = .white
        //self.selectionStyle = .none
        self.collectionView.backgroundColor = .white
        self.collectionView.layer.cornerRadius = 10.0
        self.collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.collectionView.layer.masksToBounds = true
        self.infoView.backgroundColor = .white
        self.infoView.layer.cornerRadius = 10.0
        self.infoView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.infoView.layer.masksToBounds = true
        self.separatorView.backgroundColor = .black
    }
    
    private func setPhotos() {
        guard let photos = homeAd?.multimedia else { return }
        self.photosUrl = photos.images.map { $0.url }
        self.collectionView.reloadData()
    }
    
    private func setupLabelsContent() {
        //guard let homeAd else { return }
        //self.propertyTypeLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 16.0), textColor: .adText, text: homeAd.propertyType)
        //self.locationLabel.setStyle(font: .kohinoorBanglaRegular(withSize: 15.0), textColor: .adText, text: homeAd.direction)
        //self.priceLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 24.0), textColor: .adText, text: homeAd.price)
        //self.extraInfoLabel.setStyle(font: .kohinoorBanglaLight(withSize: 15.0), textColor: .adText, text: homeAd.additionalInfo)
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
            //let formattedDate = formatter.string(from: homeAd.dateSavedAsFavorite ?? Date())
            //self.favoriteAdSavedLabel.setStyle(font: .bold, textColor: .adText, text: "\(NSLocalizedString("saved", comment: "")) \(formattedDate)")
        } else {
            self.favoriteAdImageView.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
            self.favoriteAdImageView.tintColor = .black
            self.favoriteAdSavedView.isHidden = true
            //self.favoriteAdSavedLabel.setStyle(font: .kohinoorBanglaSemibold(withSize: 15.0), textColor: .adText, text: "")
        }
    }
}

//extension AdListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.photosUrl.count
//    }
//    
////    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
////        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoListCollectionViewCell.name, for: indexPath)
////        //guard let photoCell = cell as? PhotoListCollectionViewCell else { return UICollectionViewCell() }
////        //photoCell.load(url: self.photosUrl[indexPath.row])
////        //return photoCell
////    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: self.collectionViewHeightConstraint.constant)
//    }
//    
//}
//

