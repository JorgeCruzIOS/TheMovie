//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils
import SDKGServicesManager

// MARK: ViperHomeMoviesViewUI Delegate -
/// ViperHomeMoviesViewUI Delegate
protocol ViperHomeMoviesViewUIDelegate: AnyObject {
    func fetchNavigationController()->UINavigationController?
    func notifyMenuOptionSelected()
    func notifyReloadOnInitial()
    func notifyFilterChange(filter: FilterFacadeMovie)
    func notifyMovieSelected(idMovie:Int)
}

internal class ViperHomeMoviesViewUI: UIView {
    private var delegate: ViperHomeMoviesViewUIDelegate?
    private var moviesResult: ListMoviesServiceProtocol.Response = nil
    private var arrayOptionMovies: [FilterFacadeMovie] = [FilterFacadeMovie]()
    private var arrayOptionButton: [UIButton] = [UIButton]()
    lazy var navigationBar: GNavigationBar = {
        let navigation = GNavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    private lazy var filterInputText: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = "¿Que pelicula buscas hoy?".decorative(color: GColorSingleton.LabelColor, font: .systemFont(ofSize: 18, weight: .semibold))
        return textField
    }()
    private lazy var filterBox: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = GColorSingleton.WhiteColor
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = GColorSingleton.ShadowLevelOne.cgColor
        
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(filterInputText)
        let viewline = UIView(frame: .zero)
        viewline.backgroundColor = .white.withAlphaComponent(0.2)
        viewline.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewline)
        let boxOptions = UIStackView(frame: .zero)
        boxOptions.translatesAutoresizingMaskIntoConstraints = false
        boxOptions.axis = .horizontal
        boxOptions.alignment = .center
        boxOptions.spacing = 20
        view.addSubview(scrollView)
        scrollView.addSubview(boxOptions)
        for option in arrayOptionMovies{
            let filterOptionButton = UIButton(frame: .zero)
            filterOptionButton.translatesAutoresizingMaskIntoConstraints = false
            filterOptionButton.backgroundColor = GColorSingleton.WhiteColor
            filterOptionButton.layer.cornerRadius = 16
            filterOptionButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            filterOptionButton.layer.shadowOpacity = 1
            filterOptionButton.layer.shadowColor = GColorSingleton.ShadowLevelOne.cgColor
            filterOptionButton.setAttributedTitle(option.normativeName().decorative(color: GColorSingleton.LabelColor, font: .systemFont(ofSize: 14, weight: .medium)), for: .normal)
            filterOptionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            filterOptionButton.tag = option.rawValue
            filterOptionButton.addTarget(self, action: #selector(self.onTabOptionButton(_:)), for: .touchUpInside)
            arrayOptionButton.append(filterOptionButton)
            boxOptions.addArrangedSubview(filterOptionButton)
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            boxOptions.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            boxOptions.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            boxOptions.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            boxOptions.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
        onTapOptionButtonUI(uihash: arrayOptionMovies[0].rawValue)
        return view
    }()
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = GColorSingleton.LabelColor
        refreshControl.addTarget(self, action: #selector(self.onRefreshView(_:)), for: .valueChanged)
        return refreshControl
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
    
    lazy var rightButtonMenu: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(GColorSingleton.LabelColor, for: .normal)
        button.tintColor = GColorSingleton.LabelColor
        button.setImage(UIImage(named: "setting_ic", in: .local_common_utils, compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(self.onTabRightButton(_:)), for: .touchUpInside)
        return button
    }()
    
    public var isLoadingOptions = true
    private let sectionInsets = UIEdgeInsets(
      top: 0.0,
      left: 15.0,
      bottom: 0.0,
      right: 15.0)
    private let itemsPerRow: CGFloat = 2
    var module: ModuleFacadeHome?
    
    convenience init(
        delegate: ViperHomeMoviesViewUIDelegate,
        module: ModuleFacadeHome?) {
        self.init()
            navigationBar.setComponents(title: "The Movie App", navigationController: delegate.fetchNavigationController(), hiddenBackButton: true, withRightButton: rightButtonMenu, titleSectionColor: GColorSingleton.LabelColor)
        self.delegate = delegate
        self.module = module
        arrayOptionMovies = self.module == .Movie ?
            [.Popular, .TopRated, .NowPlaying, .Upcoming] :
            [.Popular, .TopRated, .AiringToday, .OnTheAir,]
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
        addSubview(moviesCollectionUI)
        addSubview(filterBox)
        moviesCollectionUI.reloadData()
    }
    
    fileprivate func setupConstraints() {
        // add constraints to subviews
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            filterBox.topAnchor.constraint(equalTo: navigationBar.bottomAnchor,constant: 20),
            filterBox.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            filterBox.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            filterBox.heightAnchor.constraint(equalToConstant: 60),
            
            
            moviesCollectionUI.topAnchor.constraint(equalTo: filterBox.bottomAnchor),
            moviesCollectionUI.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviesCollectionUI.trailingAnchor.constraint(equalTo: trailingAnchor),
            moviesCollectionUI.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func reload(result: ListMoviesServiceProtocol.Response){
        moviesResult = result
        moviesCollectionUI.reloadData()
        refreshControl.endRefreshing()
    }
    
    @objc private func onTabOptionButton(_ sender: UIButton){
        onDissTapOptionButtonUI()
        onTapOptionButtonUI(uihash: sender.tag)
        delegate?.notifyFilterChange(filter:
                                    FilterFacadeMovie(rawValue: sender.tag)!)
    }
    
    @objc private func onRefreshView(_ sender: UIRefreshControl){
        delegate?.notifyReloadOnInitial()
    }
    
    @objc private func onTabRightButton(_ sender: UIButton){
        delegate?.notifyMenuOptionSelected()
    }
    
    private func onTapOptionButtonUI(uihash:Int){
        let button = arrayOptionButton.filter({
            $0.tag == uihash
        }).first
        let title = button?.titleLabel?.text
        button?.backgroundColor = GColorSingleton.LabelColor
        button?.setAttributedTitle(title?.decorative(color: GColorSingleton.NoneSpaceColor, font: .systemFont(ofSize: 14, weight: .medium)), for: .normal)
    }
    
    private func onDissTapOptionButtonUI(){
        arrayOptionButton.forEach({
            let title = $0.titleLabel?.text
            $0.backgroundColor = GColorSingleton.WhiteColor
            $0.setAttributedTitle(title?.decorative(color: GColorSingleton.LabelColor, font: .systemFont(ofSize: 14, weight: .medium)), for: .normal)
        })
    }
}

extension ViperHomeMoviesViewUI: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoadingOptions ? 4 : moviesResult?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let shimmer =  collectionView.dequeueReusableCell(withReuseIdentifier: "ViperHomeMoviesShimmerCC", for: indexPath) as! ViperHomeMoviesShimmerCC
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "ViperHomeMoviesCC", for: indexPath) as! ViperHomeMoviesCC
        if isLoadingOptions == false{
            cell.movieTitle.text = module == .Movie ?
            moviesResult?.results?[indexPath.row].title :
            moviesResult?.results?[indexPath.row].name
            cell.dateOfMovieTitle.text =  module == .Movie ?
            moviesResult?.results?[indexPath.row].release_date?.toDate().toString(format: "MMM d, yyyy") :
            moviesResult?.results?[indexPath.row].first_air_date?.toDate().toString(format: "MMM d, yyyy")
            
            cell.movieDescription.text = moviesResult?.results?[indexPath.row].overview
            cell.rateLabel.text = "\(moviesResult?.results?[indexPath.row].vote_average ?? 0.0)"
            if let urlStringPoster = moviesResult?.results?[indexPath.row].poster_path, let urlPoster = URL(string:"https://image.tmdb.org/t/p/w500\(urlStringPoster)"){
                cell.movieImage.setImage(from: urlPoster, placeholder: nil)
            }
        }
        return isLoadingOptions ? shimmer : cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let id = moviesResult?.results?[indexPath.row].id else{
            return
        }
        delegate?.notifyMovieSelected(idMovie: id)
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
