
//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth
import SDKGCommonUtils
// MARK: ViperProfileViewUI Delegate -
/// ViperProfileViewUI Delegate
protocol ViperProfileViewUIDelegate {
    func fetchNavigationController()->UINavigationController?
    func notifyReloadOnInitial()
}
class ViperProfileViewUI: UIView {
    
    var delegate: ViperProfileViewUIDelegate?
    private var moviesResult: [MovieEntity]?
    lazy var navigationBar: GNavigationBar = {
        let navigation = GNavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    lazy var profileImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "profile_ic", in: .local_common_utils, compatibleWith: nil))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    lazy var titleSection: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GColorSingleton.PrimaryColor
        label.text = "Mis favoritos"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    lazy var profileName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GColorSingleton.PrimaryColor
        label.text = "Jorge Alfredo"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    lazy var profileEmail: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = GColorSingleton.LabelColor
        label.text = Auth.auth().currentUser?.email
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var moviesCollectionUI: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = false
        collectionView.collectionViewLayout = UICollectionViewFlowLayout.init()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 50, right: 0)
        collectionView.addSubview(refreshControl)
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = GColorSingleton.LabelColor
        refreshControl.addTarget(self, action: #selector(self.onRefreshView(_:)), for: .valueChanged)
        return refreshControl
    }()
    
    public var isLoadingOptions = true
    private let sectionInsets = UIEdgeInsets(
      top: 0.0,
      left: 15.0,
      bottom: 0.0,
      right: 15.0)
    private let itemsPerRow: CGFloat = 2
    
    convenience init(delegate: ViperProfileViewUIDelegate) {
        self.init()
        self.delegate = delegate
        navigationBar.setComponents(title: "Perfil", navigationController: delegate.fetchNavigationController(), titleSectionColor: GColorSingleton.LabelColor, backTintColor: GColorSingleton.LabelColor)
        setupUIElements()
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    fileprivate func setupUIElements() {
        // arrange subviews
        moviesCollectionUI.collectionViewLayout = UICollectionViewFlowLayout.init()
        moviesCollectionUI.delegate = self
        moviesCollectionUI.dataSource = self
        moviesCollectionUI.register(ViperHomeMoviesCC.self, forCellWithReuseIdentifier: "ViperHomeMoviesCC")
        moviesCollectionUI.register(ViperHomeMoviesShimmerCC.self, forCellWithReuseIdentifier: "ViperHomeMoviesShimmerCC")
        
        addSubview(navigationBar)
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(profileEmail)
        addSubview(titleSection)
        addSubview(moviesCollectionUI)
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            profileImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            profileImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor),
            profileImage.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 30),
            
            profileName.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 15),
            profileName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            profileName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            profileEmail.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 15),
            profileEmail.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 15),
            profileEmail.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            titleSection.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            titleSection.leadingAnchor.constraint(equalTo: leadingAnchor,  constant: 30),
            
            moviesCollectionUI.topAnchor.constraint(equalTo: titleSection.bottomAnchor, constant: 10),
            moviesCollectionUI.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionUI.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesCollectionUI.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func onRefreshView(_ sender: UIRefreshControl){
        delegate?.notifyReloadOnInitial()
    }
    
    func reload(result: [MovieEntity]){
        moviesResult = result
        moviesCollectionUI.reloadData()
        refreshControl.endRefreshing()
    }
}

extension ViperProfileViewUI: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoadingOptions ? 4 : moviesResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shimmer =  collectionView.dequeueReusableCell(withReuseIdentifier: "ViperHomeMoviesShimmerCC", for: indexPath) as! ViperHomeMoviesShimmerCC
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ViperHomeMoviesCC", for: indexPath) as! ViperHomeMoviesCC
        if isLoadingOptions == false{
            cell.movieTitle.text = moviesResult?[indexPath.row].title
            cell.dateOfMovieTitle.text = moviesResult?[indexPath.row].date?.toDate().toString(format: "MMM d, yyyy")
            cell.movieDescription.text = moviesResult?[indexPath.row].overview
            if let urlStringPoster = moviesResult?[indexPath.row].poster_path, let urlPoster = URL(string:"https://image.tmdb.org/t/p/w500\(urlStringPoster)"){
                cell.movieImage.setImage(from: urlPoster, placeholder: nil)
            }
        }
        return isLoadingOptions ? shimmer : cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = 15 * (itemsPerRow + 1)
        let availableWidth = self.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return  CGSize(width: widthPerItem,  height: 350)
    }
    
    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
