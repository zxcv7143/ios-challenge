//
//  AdListTableViewCell.swift
//  Ads
//
//  Created by Anton Zuev on 14/3/25.
//
import UIKit

final class AdListTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var propertyTypeLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var charactericLabel: UILabel!
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
        self.configureFavouriteAdButton(ad: homeAd)
    }
    
    func updateFavouriteView(ad: Ad) {
        self.currentAd = ad
        self.configureFavouriteAdButton(ad: ad)
    }
    
    // MARK: IBActions private functions
    @IBAction private func seeOnMapAction(_ sender: Any) {
        delegate?.showAdLocationsOnMap()
    }
    
    @IBAction private func favouriteAdAction(_ sender: Any) {
        guard let currentAd else { return }
        Task {
            await delegate?.favouriteAdAction(currentAd)
        }
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
        self.pageControl.numberOfPages = self.photosUrl.count
        self.collectionView.reloadData()
    }
    
    private func setupLabelsContent() {
        guard let currentAd else { return }
        self.propertyTypeLabel.setLabelStyle(font: UIFont.boldSystemFont(ofSize: 15), textColor: UIColor.main, text: "\(currentAd.propertyType.rawValue.localized) \("in".localized) \(currentAd.address)")
        self.locationLabel.setLabelStyle(font: UIFont.systemFont(ofSize: 15), textColor: UIColor.main, text: "\(currentAd.neighborhood), \(currentAd.district)")
        self.priceLabel.setLabelStyle(font: UIFont.boldSystemFont(ofSize: 20), textColor: UIColor.main, text: currentAd.fullPrice)
        self.charactericLabel.setLabelStyle(font: UIFont.systemFont(ofSize: 10), textColor: UIColor.main, text: "\(currentAd.size) m², \(currentAd.rooms) \("Rooms".localized), \(currentAd.bathrooms) \("Bathrooms".localized)")
    }
    
    private func configureFavouriteAdButton(ad: Ad) {
        if ad.isFavourite {
            self.favouriteAdButton.setImage(UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.savedInfoLabel.setLabelStyle(font: UIFont.systemFont(ofSize: 10), textColor: UIColor.main, text: "\("AdSavedDate".localized) \(ad.dateSavedAsFavourite?.formattedDate() ?? "")")
            self.savedInfoLabel.isHidden = false
        } else {
            self.favouriteAdButton.setImage(UIImage(systemName: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.savedInfoLabel.isHidden = true
        }
    }
    
    @IBAction func pageChanged(_ sender: Any) {
        //let x = CGFloat(self.pageControl.currentPage) * self.collectionView.frame.size.width
        //self.collectionView.setContentOffset(CGPointMake(x, 0), animated: true)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            pageControl.currentPage = Int(pageNumber)

    }
}

