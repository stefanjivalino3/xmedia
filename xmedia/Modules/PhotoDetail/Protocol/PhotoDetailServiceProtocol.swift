//  
//  PhotoDetailServiceProtocol.swift
//  xmedia
//
//  Created by Personal on 30/01/22.
//

import Foundation

protocol PhotoDetailServiceProtocol {

    /// SAMPLE FUNCTION -* Please rename this function to your real function
    ///
    /// - Parameters:
    ///   - success: -- success closure response, add your Model on this closure.
    ///                 example: success(_ data: YourModelName) -> ()
    ///   - failure: -- failure closure response, add your Model on this closure.  
    ///                 example: success(_ data: APIError) -> ()
    func removeThisFuncName(success: @escaping(_ data: PhotoDetailModel) -> (), failure: @escaping() -> ())

}
