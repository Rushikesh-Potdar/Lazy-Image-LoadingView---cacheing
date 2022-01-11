//
//  ViewController.swift
//  LazzyLoadingAndImageCaching
//
//  Created by Mac on 11/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var productList: UITableView!
    
    var productArray = [Product]()
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.getData { [ weak self] products in
            self?.productArray.append(contentsOf: products)
            DispatchQueue.main.async {
                self?.productList.reloadData()
            }
        }
        productList.delegate = self
        productList.dataSource = self
    }


}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productList.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductCell
        
        let product = productArray[indexPath.row]
        cell.productName.text = product.title
        //cell.productImage.image = networkManager.productImage(using: product.image)
        cell.productImage.loadImage(fromURL: product.image, placeholderImage: "Downloading")
        return cell
    }
    
    
}

extension ViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        300
    }
}
