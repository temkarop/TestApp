//
//  DetailViewController.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    let baseURL = "https://scripts.qexsystems.ru/test_ios/public/"

    var post: Post!
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postNameLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updatedAtLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        postNameLabel.text = post.name
        createdAtLabel.text = post.createdAt
        updatedAtLabel.text = post.updatedAt
        descriptionTextView.text = post.description
        updateImage()
    }
    private func updateImage() {
        
        DispatchQueue.global().async {
            guard let photoUrl = self.post.photo else { return }
            guard let urlImage = URL(string: self.baseURL + photoUrl) else {return }
            guard let imageData = try? Data(contentsOf: urlImage) else { return }

            DispatchQueue.main.async {
                self.postImage.image = UIImage(data: imageData)
            }
        }
    }
}
