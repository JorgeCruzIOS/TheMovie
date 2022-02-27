//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public extension UIDevice {
    /// Returns `true` if the device has a notch
    public var hasTopNotch: Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
}
open class GNavigationBar: UIView {

    var navigationbar: UINavigationController?
    var arrowIcon: String = "arrow_left_ic"
    public lazy var containerBezel: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowRadius = 7
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 1
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1221039245)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "arrow_left_ic", in: Bundle.local_common_utils, compatibleWith: nil), for: .normal)
        button.setImage(UIImage(named: "arrow_left_ic", in: Bundle.local_common_utils, compatibleWith: nil), for: .highlighted)
        button.imageEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        return button
    }()
    
    lazy var titleSection: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    lazy var rightButton: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var withAnimation :Bool?
    private var titleCenterYAnchor: NSLayoutConstraint?
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        buildUI()
        buildConstraint()
    }
    
    public func setComponents(
        title: String,
        navigationController: UINavigationController?,
        withAnimation: Bool = true,
        hiddenBackButton: Bool = false,
        backgroundColor: UIColor = GColorSingleton.WhiteColor,
        withShadows: Bool = false,
        withRightButton: UIButton = UIButton(),
        fontStyle: UIFont  = .systemFont(ofSize: 18, weight: .medium),
        titleCenterY: Int = 0,
        titleSectionColor: UIColor = GColorSingleton.WhiteColor,
        backTintColor: UIColor = GColorSingleton.WhiteColor,
        arrowIcon: String = "arrow_left_ic"){
        self.titleSection.text = title
        self.titleSection.font = fontStyle
        self.titleSection.textColor = titleSectionColor
        self.backButton.tintColor = backTintColor
        self.backButton.isHidden = hiddenBackButton
        self.containerBezel.backgroundColor = backgroundColor
        self.containerBezel.clipsToBounds = !withShadows
        rightButton.addSubview(withRightButton)
        NSLayoutConstraint.activate([
            withRightButton.topAnchor.constraint(equalTo: rightButton.topAnchor),
            withRightButton.leadingAnchor.constraint(equalTo: rightButton.leadingAnchor),
            withRightButton.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor),
            withRightButton.bottomAnchor.constraint(equalTo: rightButton.bottomAnchor),
            
        ])
        self.navigationbar = navigationController
        self.withAnimation = withAnimation
        self.titleCenterYAnchor?.constant = CGFloat(titleCenterY)
        self.arrowIcon = arrowIcon
        self.backButton.setImage(
            UIImage(named: self.arrowIcon, in: Bundle.local_common_utils, compatibleWith: nil)
            ??
            UIImage(named: "arrow_left_ic", in: Bundle.local_common_utils, compatibleWith: nil),
            for: .normal)
        self.backButton.setImage(
            UIImage(named: self.arrowIcon, in: Bundle.local_common_utils, compatibleWith: nil)            ??
            UIImage(named: "arrow_left_ic", in: Bundle.local_common_utils, compatibleWith: nil),
            for: .highlighted)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func buildUI(){
        self.backButton.addTarget(self, action: #selector(self.popNavigationController), for: .touchUpInside)
        self.backgroundColor = .clear
        self.addSubview(containerBezel)
        containerBezel.addSubview(backButton)
        containerBezel.addSubview(titleSection)
        containerBezel.addSubview(rightButton)
    }
    
    
    fileprivate func buildConstraint(){
       //hasNotch if UIDevice.hasNotch
        if UIDevice.current.hasTopNotch == true{
            NSLayoutConstraint.activate([
                self.containerBezel.topAnchor.constraint(equalTo: self.topAnchor, constant: -20),
                self.containerBezel.heightAnchor.constraint(equalToConstant: 120),
                self.backButton.centerYAnchor.constraint(equalTo: self.containerBezel.centerYAnchor, constant: 30),
            ])
        }else{
            NSLayoutConstraint.activate([
                self.containerBezel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                self.containerBezel.heightAnchor.constraint(equalToConstant: 80),
                self.backButton.centerYAnchor.constraint(equalTo: self.containerBezel.centerYAnchor, constant: 10),
            ])
        }
        NSLayoutConstraint.activate([
            self.containerBezel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.containerBezel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: 30),
            self.containerBezel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.backButton.heightAnchor.constraint(equalToConstant: 48),
            self.backButton.widthAnchor.constraint(equalToConstant: 48),
            self.backButton.leadingAnchor.constraint(equalTo: self.containerBezel.leadingAnchor, constant: 15),
            
            self.rightButton.heightAnchor.constraint(equalToConstant: 35),
            self.rightButton.widthAnchor.constraint(equalToConstant: 35),
            self.rightButton.trailingAnchor.constraint(equalTo: self.containerBezel.trailingAnchor, constant: -50),
            self.rightButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0),
            
            self.titleSection.leadingAnchor.constraint(equalTo: self.backButton.trailingAnchor, constant: 15),
            self.titleSection.trailingAnchor.constraint(equalTo: self.rightButton.leadingAnchor, constant: -10),
        ])
        
        titleCenterYAnchor = NSLayoutConstraint(item: titleSection, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backButton, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        titleCenterYAnchor?.isActive = true
    }

    @objc func popNavigationController(){
        if let navController = self.navigationbar {
            navController.popViewController(animated: withAnimation ?? true)
        }else {
            print("Navigation controller not assigned")
        }
    }
    
    public func assignCustomBackEvent(target: Any, event: Selector, eventTrigger: UIControl.Event){
        self.backButton.removeTarget(nil, action: nil, for: .allEvents)
        self.backButton.addTarget(target, action: event, for: eventTrigger)
    }
}
