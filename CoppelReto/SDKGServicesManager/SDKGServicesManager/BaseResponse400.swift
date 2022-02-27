//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public struct BaseResponse400: Decodable {
    
    public let status_code: Int?
    public let status_message: String?
    public let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        
        case status_code = "status_code"
        case status_message = "status_message"
        case success = "success"
    }
}
