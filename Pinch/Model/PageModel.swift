//
//  PageModel.swift
//  Pinch
//
//  Created by Kyungyun Lee on 11/02/2022.
//

import Foundation

class PageModel : ObservableObject {
    
    let pagesData : [Pages] = [
        Pages(id: 1, imageName: "magazine-front-cover"),
        Pages(id: 2, imageName: "magazine-back-cover")
    ]
    
    
}
