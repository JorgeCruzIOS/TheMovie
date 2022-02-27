//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import youtube_ios_player_helper
import SDKGCommonUtils
import SDKGServicesManager

// MARK: ViperMovieDetailViewUI Delegate -
/// ViperMovieDetailViewUI Delegate
protocol ViperMovieDetailViewUIDelegate {
    func fetchNavigationController()->UINavigationController?
    func fetchModule()->ModuleFacadeHome
    func fetchCurrentFavoriteState(model: MovieEntity)
}

internal class ViperMovieDetailViewUI: UIView {
    
    var delegate: ViperMovieDetailViewUIDelegate?
    var movieDetailResponse: DetailMovieServiceProtocol.Response = nil
    var mooviVideoDetail: ListVideoMovieServiceProtocol.Response = nil

    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = GColorSingleton.PrimaryColor
        button.addTarget(self, action: #selector(self.didTapFavoriteAction(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentViewScroll: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    lazy var navigationBar: GNavigationBar = {
        let navigation = GNavigationBar()
        navigation.translatesAutoresizingMaskIntoConstraints = false
        return navigation
    }()
    private lazy var overviewLabelHelper: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Vista general"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var playerView: YTPlayerView = {
        let view = YTPlayerView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var titleMovie: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var percentAverageLabelHelper: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Puntuación de usuario"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var publicationDateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var genresMovie: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var percentAverageLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var percentAverageView : GCircleProgress = {
        let view = GCircleProgress(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let playerVars = ["controls" : 0,
                          "playsinline" : 0,
                          "autohide" : 0,
                          "showinfo" : 0,
                          "modestbranding" : 0]
    
    convenience init(delegate: ViperMovieDetailViewUIDelegate) {
        self.init()
        self.delegate = delegate
        navigationBar.setComponents(title: "Detalle", navigationController: delegate.fetchNavigationController(), titleSectionColor: GColorSingleton.LabelColor, backTintColor: GColorSingleton.LabelColor)
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
        addSubview(contentViewScroll)
        addSubview(navigationBar)
        contentViewScroll.addSubview(playerView)
        contentViewScroll.addSubview(titleMovie)
        contentViewScroll.addSubview(percentAverageLabel)
        contentViewScroll.addSubview(percentAverageView)
        contentViewScroll.addSubview(percentAverageLabelHelper)
        contentViewScroll.addSubview(favoriteButton)
        contentViewScroll.addSubview(publicationDateLabel)
        contentViewScroll.addSubview(genresMovie)
        contentViewScroll.addSubview(overviewLabelHelper)
        contentViewScroll.addSubview(overviewLabel)
    }
    
    fileprivate func setupConstraints() {
        // add constraints to subviews
        NSLayoutConstraint.activate([
            
            navigationBar.topAnchor.constraint(equalTo: topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            contentViewScroll.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            contentViewScroll.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentViewScroll.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewScroll.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            playerView.topAnchor.constraint(equalTo: contentViewScroll.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor),
            playerView.heightAnchor.constraint(equalToConstant: 300),
            playerView.centerXAnchor.constraint(equalTo: contentViewScroll.centerXAnchor),
                
            titleMovie.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 20),
            titleMovie.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            titleMovie.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -15),
            
            percentAverageView.topAnchor.constraint(equalTo: titleMovie.bottomAnchor, constant: 10),
            percentAverageView.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            percentAverageView.widthAnchor.constraint(equalToConstant: 50),
            percentAverageView.heightAnchor.constraint(equalToConstant: 50),

            percentAverageLabel.centerXAnchor.constraint(equalTo: percentAverageView.centerXAnchor),
            percentAverageLabel.centerYAnchor.constraint(equalTo: percentAverageView.centerYAnchor),
            
            percentAverageLabelHelper.centerYAnchor.constraint(equalTo: percentAverageView.centerYAnchor),
            percentAverageLabelHelper.leadingAnchor.constraint(equalTo: percentAverageView.trailingAnchor, constant: 10),
            percentAverageLabelHelper.widthAnchor.constraint(equalToConstant: 100),
            
            favoriteButton.heightAnchor.constraint(equalToConstant: 35),
            favoriteButton.widthAnchor.constraint(equalToConstant: 35),
            favoriteButton.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -30),
            favoriteButton.centerYAnchor.constraint(equalTo: percentAverageView.centerYAnchor),
            
            publicationDateLabel.topAnchor.constraint(equalTo: percentAverageView.bottomAnchor,constant: 30),
            publicationDateLabel.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            publicationDateLabel.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -15),
            
            genresMovie.topAnchor.constraint(equalTo: publicationDateLabel.bottomAnchor,constant: 10),
            genresMovie.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            genresMovie.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -15),
            
            overviewLabelHelper.topAnchor.constraint(equalTo: genresMovie.bottomAnchor,constant: 30),
            overviewLabelHelper.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            overviewLabelHelper.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -15),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewLabelHelper.bottomAnchor,constant: 20),
            overviewLabel.leadingAnchor.constraint(equalTo: contentViewScroll.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: contentViewScroll.trailingAnchor, constant: -15),
            
            overviewLabel.bottomAnchor.constraint(equalTo: contentViewScroll.bottomAnchor, constant: -50)
        ])
    }
    
    public func onLoadInformation(information:DetailMovieServiceProtocol.Response){
        movieDetailResponse = information
        titleMovie.text = movieDetailResponse?.title
        percentAverageView.createCircularPath(endPointPercent: (CGFloat((movieDetailResponse?.vote_average ?? 0)) * 10), withSize: 25)
        percentAverageView.progressAnimation(duration: TimeInterval(1))
        percentAverageLabel.text = "\(String(format: "%.0f",Double((movieDetailResponse?.vote_average ?? 0) * 10))) %"
        publicationDateLabel.text = "\(movieDetailResponse?.release_date ?? "") • \(printSecondsToHoursMinutes(movieDetailResponse?.runtime ?? 0))"
        let genres = movieDetailResponse?.genres?.compactMap({ gen in
            return gen.name
        })
        genresMovie.text = "\(genres?.joined(separator: ", ") ?? "")"
        overviewLabel.text = movieDetailResponse?.overview
    }
    
    public func onLoadVideo(key: String){
        playerView.load(withVideoId: key, playerVars: playerVars)
    }
    
    private func secondsToHoursMinutes(_ seconds: Int) -> (Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60)
    }
    
    private func printSecondsToHoursMinutes(_ minutes: Int)->String {
      let (h, m) = secondsToHoursMinutes(minutes * 60)
      return ("\(h)h \(m)m")
    }
    
    @objc private func didTapFavoriteAction(_ sender: UIButton){
       
        delegate?.fetchCurrentFavoriteState(model: MovieEntity(id: movieDetailResponse?.id, type: delegate?.fetchModule() == .Movie ? 1 : 2, title: delegate?.fetchModule() == .Movie ? movieDetailResponse?.title : movieDetailResponse?.name, overview: movieDetailResponse?.overview, date: delegate?.fetchModule() == .Movie ? movieDetailResponse?.release_date : movieDetailResponse?.first_air_date, poster_path: movieDetailResponse?.poster_path))
    }
}
