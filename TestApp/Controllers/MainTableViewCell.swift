//
//  MainTableViewCell.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postName: UILabel!
    @IBOutlet weak var postDescription: UILabel!
    
    let baseURL = "https://scripts.qexsystems.ru/test_ios/public"
    
    func configur(with post: Post) {
        postName.text = post.name
        postDescription.text = post.description
        postImage.image = nil

        DispatchQueue.global().async {
            guard let photoUrl = post.photo else { return }
            guard let urlImage = URL(string: self.baseURL + photoUrl) else {return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
            self.postImage.image = UIImage(data: imageData)
            }
        }
    }
}
