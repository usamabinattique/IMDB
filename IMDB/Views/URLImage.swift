//
//  URLImage.swift
//  IMDB
//
//  Created by Usama on 29/06/2022.
//

import SwiftUI

struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        // because data is state property so the view will redraw itself
        if let data = data, let uiimage = UIImage(data: data)  {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 100)
//                .background(Color.gray)
        } else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 100)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}
