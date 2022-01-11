//
//  LazzyImageView.swift
//  LazzyLoadingAndImageCaching
//
//  Created by Mac on 11/01/22.
//

import Foundation
import UIKit

class LazzyImageView: UIImageView {
    
    private var imageCache = NSCache<AnyObject,UIImage>()
    
    func loadImage(fromURL imageURL : String, placeholderImage : String){
        
        self.image = UIImage(named: placeholderImage)
        
        if let cacheImage = self.imageCache.object(forKey: imageURL as AnyObject){
            
            debugPrint("image loaded from image cache")
            self.image = cacheImage
            return
            
        }else{
            DispatchQueue.global().async {
                [weak self] in
                
                if let imageData = try? Data(contentsOf: URL(string: imageURL)!){
                    if let image = UIImage(data: imageData){
                        DispatchQueue.main.async {
                            debugPrint("image downloaded from server")
                            self?.imageCache.setObject(image, forKey: imageURL as AnyObject)
                            self?.image = image
                        }
                    }
                }
            }
        }
        
    }
}
