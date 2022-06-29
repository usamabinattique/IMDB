//
//  CircleImage.swift
//  IMDB
//
//  Created by Usama on 30/06/2022.
//

import SwiftUI

struct CircleImage: View {
    var urlString: String
    var body: some View {
        URLImage(urlString: urlString)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(urlString: "")
    }
}
