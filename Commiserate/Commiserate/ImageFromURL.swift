//
//  ImageFromURL.swift
//  Commiserate
//
//  Created by Zeynep Toy on 28.03.2024.
//

import SwiftUI
import Kingfisher

public struct ImageFromUrl: View {
    
    var url: String
    var showPlaceholder: Bool = true
    var placeholder: String
    
    public init(
        url: String,
        showPlaceholder: Bool = true,
        placeholder: String = "placeholder"
    ) {
        self.url = url
        self.showPlaceholder = showPlaceholder
        self.placeholder = placeholder
    }
    
    public var body: some View {
        KFImage.url(URL(string: url))
            .resizable()
            .placeholder({
                if showPlaceholder {
                    Image(placeholder)
                        .resizable()
                } else {
                    Color.clear // Use a clear color as a placeholder when showPlaceholder is false
                }
            })
    }
}

struct ImageFromUrl_Previews: PreviewProvider {
    static var previews: some View {
        ImageFromUrl(url: "https://github.com/onevcat/Kingfisher/blob/master/images/kingfisher-1.jpg?raw=true", showPlaceholder: false)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
