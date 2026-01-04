//
//  PageModel.swift
//  Pinch
//
//  Created by Preeteesh Remalli on 04/01/26.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumnailImageName: String {
        "thumb-" + imageName
    }
}
