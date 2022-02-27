//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public extension String {
    
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
    
    func toDate()->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func floatValue() -> Float? {
        return Float(self)
    }
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }

    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }

    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    func decorative(color: UIColor, font: UIFont, spacing: Double = 0)->NSMutableAttributedString{
        let attibute = NSMutableParagraphStyle()
        attibute.alignment = .left
        attibute.lineBreakMode = .byWordWrapping
        let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font : font,
                NSAttributedString.Key.paragraphStyle : attibute
        ]
        let stringAttribute = NSMutableAttributedString(string: self, attributes: attributes)
        stringAttribute.addAttributes([.kern : spacing], range: NSRange(location: 0, length: stringAttribute.length - 1))
        return stringAttribute
    }
}
