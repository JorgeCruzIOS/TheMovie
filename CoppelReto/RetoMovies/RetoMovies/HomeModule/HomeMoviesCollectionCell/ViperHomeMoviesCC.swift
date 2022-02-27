//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

internal class ViperHomeMoviesCC: UICollectionViewCell {
    
    private lazy var itemContent: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 16
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = GColorSingleton.ShadowLevelOne.cgColor
        view.backgroundColor = GColorSingleton.WhiteColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieRateImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "start_ic", in: .local_common_utils, compatibleWith: nil)
        imageView.tintColor = GColorSingleton.PrimaryColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor =  GColorSingleton.PrimaryColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor =  GColorSingleton.PrimaryColor
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var movieDescription: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor =  GColorSingleton.LabelColor
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateOfMovieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = GColorSingleton.PrimaryColor
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    public var currentIndexPath: IndexPath?
    
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
        itemContent.addSubview(movieDescription)
        itemContent.addSubview(movieRateImage)
        itemContent.addSubview(rateLabel)
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
            movieImage.heightAnchor.constraint(equalTo: itemContent.heightAnchor, multiplier: 0.5, constant: 0),
            
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 20),
            movieTitle.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor, constant: 10),
            movieTitle.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            
            
            dateOfMovieTitle.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            dateOfMovieTitle.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor, constant: 10),
            dateOfMovieTitle.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            
            rateLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            rateLabel.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            
            movieRateImage.heightAnchor.constraint(equalToConstant: 15),
            movieRateImage.widthAnchor.constraint(equalToConstant: 15),
            movieRateImage.trailingAnchor.constraint(equalTo: rateLabel.leadingAnchor, constant: -5),
            movieRateImage.centerYAnchor.constraint(equalTo: rateLabel.centerYAnchor),
            
            movieDescription.topAnchor.constraint(equalTo: dateOfMovieTitle.bottomAnchor, constant: 10),
            movieDescription.leadingAnchor.constraint(equalTo: itemContent.leadingAnchor, constant: 10),
            movieDescription.trailingAnchor.constraint(equalTo: itemContent.trailingAnchor, constant: -10),
            
        ])
    }
}
