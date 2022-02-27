//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

class ViperHomeMoviesShimmerCC:  UICollectionViewCell {
    
    private lazy var itemContent: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = GColorSingleton.ShadowLevelOne.cgColor
        view.backgroundColor = GColorSingleton.WhiteColor.withAlphaComponent(0.53)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieImage: GShimmer = {
        let view = GShimmer(frame: .zero)
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.backgroundColor = UIColor(red: 98/255, green: 114/255, blue: 123/255, alpha: 0.73)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieTitle: GShimmer = {
        let view = GShimmer(frame: .zero)
        view.backgroundColor = UIColor(red: 98/255, green: 114/255, blue:123/255, alpha: 0.73)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var dateOfMovieTitle: GShimmer = {
        let view = GShimmer(frame: .zero)
        view.backgroundColor = UIColor(red: 98/255, green: 114/255, blue: 123/255, alpha: 0.73)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
        setupConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUIElements() {
        addSubview(itemContent)
        itemContent.addSubview(movieImage)
        itemContent.addSubview(movieTitle)
        itemContent.addSubview(dateOfMovieTitle)
        movieImage.startAnimating()
        movieTitle.startAnimating()
        dateOfMovieTitle.startAnimating()
    }
    
    fileprivate func setupConstraints() {
        NSLayoutConstraint.activate([
            itemContent.topAnchor.constraint(equalTo: topAnchor),
            itemContent.leadingAnchor.constraint(equalTo: leadingAnchor),
            itemContent.trailingAnchor.constraint(equalTo: trailingAnchor),
            itemContent.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            movieImage.topAnchor.constraint(equalTo: itemContent.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor),
            movieImage.heightAnchor.constraint(equalTo: itemContent.heightAnchor, multiplier: 0.7, constant: 0),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            movieTitle.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor, constant: 10),
            movieTitle.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            movieTitle.heightAnchor.constraint(equalToConstant: 20),
            
            dateOfMovieTitle.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 5),
            dateOfMovieTitle.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor, constant: 10),
            dateOfMovieTitle.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            dateOfMovieTitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
