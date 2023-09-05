//
//  UIImageView+Download.swift
//  RCMarvel
//
//  Created by user on 30/08/23.
//

import UIKit

extension UIImageView {
    func download(url: String) {
        let urlCompleta = url + ".jpg"
        let imageURL = URL(string: urlCompleta)!
        
        URLSession.shared.dataTask(with: .init(url: imageURL)) { data, response, error in
            if error != nil { return }
            
            guard let data else { return }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
