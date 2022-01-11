//
//  NetworkManager.swift
//  LazzyLoadingAndImageCaching
//
//  Created by Mac on 11/01/22.
//

import Foundation
import UIKit

class NetworkManager{
    
    func getData(complitionHandler : @escaping ([Product]) -> Void) {
        let url =  URL(string: "https://fakestoreapi.com/products/")!
        
        let session = URLSession(configuration: .default)
            
            session.dataTask(with: url) { serverData, serverResponse, error in
                
            if error == nil , let data = serverData {
                do{
                    let result = try JSONDecoder().decode(Products.self, from: data)
                    complitionHandler(result)
                }catch{
                    print("error while parsing API \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func productImage(using url: String) ->UIImage {
        if let imageURL = URL(string: url){
            do{
                let imageData = try Data(contentsOf: imageURL)
                return UIImage(data: imageData)!
            } catch{
                print("unable to parse data")
            }
        }
        return UIImage(systemName: "checkerboard.rectangle")!
    }
}
