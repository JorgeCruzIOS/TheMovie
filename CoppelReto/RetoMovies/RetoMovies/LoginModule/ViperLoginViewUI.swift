//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

// MARK: ViperLoginViewUI Delegate -
/// ViperLoginViewUI Delegate
protocol ViperLoginViewUIDelegate {
    func notifyLoginWithCredential(email: String, credential: String)
}

class ViperLoginViewUI: UIView {
    
    var delegate: ViperLoginViewUIDelegate?
    
    lazy var backgroundImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "background_ic", in: .local_common_utils, compatibleWith: nil))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    //logo_ic
    lazy var logomage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo_ic", in: .local_common_utils, compatibleWith: nil))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var contentScrolling: UIScrollView = {
        let scroll = UIScrollView(frame: .zero)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    lazy private var cardView : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .clear
        return view
    }()
    lazy var emailLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = GColorSingleton.LabelColor
        label.text = "Correo electrónico"
        return label
    }()
    lazy var emailInputView: UITextField = {
        let input = UITextField(frame: .zero)
        input.layer.borderColor = UIColor.white.cgColor
        input.tintColor = GColorSingleton.LabelColor
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 5
        input.backgroundColor = .clear
        input.textColor = GColorSingleton.LabelColor
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: input.frame.height))
        input.leftViewMode = .always
        input.returnKeyType = .done
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    lazy var credentialLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = GColorSingleton.LabelColor
        label.text = "Contraseña"
        return label
    }()
    lazy var credentialInputView: UITextField = {
        let input = UITextField(frame: .zero)
        input.isSecureTextEntry = true
        input.tintColor = GColorSingleton.LabelColor
        input.layer.borderColor = UIColor.white.cgColor
        input.layer.borderWidth = 1
        input.layer.cornerRadius = 5
        input.backgroundColor = .clear
        input.textColor = GColorSingleton.LabelColor
        input.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: input.frame.height))
        input.leftViewMode = .always
        input.returnKeyType = .done
        input.translatesAutoresizingMaskIntoConstraints = false
        return input
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.backgroundColor = .clear
        button.setTitleColor(GColorSingleton.LabelColor, for: .normal)
        button.setTitle("Iniciar sesión", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(self.loginAction(_:)), for: .touchUpInside)
        return button
    }()
    
    convenience init(delegate: ViperLoginViewUIDelegate) {
        self.init()
        self.delegate = delegate
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
        addSubview(backgroundImage)
        addSubview(contentScrolling)
        contentScrolling.addSubview(cardView)
        contentScrolling.addSubview(logomage)
        cardView.addSubview(emailLabel)
        cardView.addSubview(emailInputView)
        cardView.addSubview(credentialLabel)
        cardView.addSubview(credentialInputView)
        cardView.addSubview(continueButton)
    }
    
    fileprivate func setupConstraints() {
        // add constraints to subviews
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentScrolling.topAnchor.constraint(equalTo: topAnchor),
            contentScrolling.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentScrolling.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentScrolling.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            logomage.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            logomage.widthAnchor.constraint(equalToConstant: 150),
            logomage.centerXAnchor.constraint(equalTo: contentScrolling.centerXAnchor),
            logomage.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: -30),
            
            cardView.centerXAnchor.constraint(equalTo: contentScrolling.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: contentScrolling.centerYAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentScrolling.leadingAnchor, constant: 30),
            cardView.trailingAnchor.constraint(equalTo:  contentScrolling.trailingAnchor, constant: -30),
            cardView.bottomAnchor.constraint(equalTo: contentScrolling.bottomAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10),
            emailLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -15),
            
            emailInputView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 5),
            emailInputView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 15),
            emailInputView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -15),
            emailInputView.heightAnchor.constraint(equalToConstant: 50),
            
            credentialLabel.topAnchor.constraint(equalTo: emailInputView.bottomAnchor, constant: 15),
            credentialLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 15),
            credentialLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -15),
            
            credentialInputView.topAnchor.constraint(equalTo: credentialLabel.bottomAnchor, constant: 5),
            credentialInputView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 15),
            credentialInputView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -15),
            credentialInputView.heightAnchor.constraint(equalToConstant: 50),
            
            continueButton.topAnchor.constraint(equalTo: credentialInputView.bottomAnchor, constant: 80),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10),
            continueButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -30),
            continueButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10)
            
        ])
    }
    
    @objc func loginAction(_ sender: UIButton){
        delegate?.notifyLoginWithCredential(email: emailInputView.text ?? "", credential: credentialInputView.text ?? "")
    }
}
