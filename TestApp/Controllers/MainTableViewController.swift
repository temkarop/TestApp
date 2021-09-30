//
//  MainTableViewController.swift
//  TestApp
//
//  Created by Артем Ропавка on 23.09.2021.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    let networkFetchData = NetworkFetchData()
    let networkService = NetworkService()
    
    private var searchPosts: SearchPosts!

    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 110
        
        networkFetchData.fetchPosts(endPoint: "/posts") { (searchPosts) in
            guard let searchPosts = searchPosts else { return }
                self.searchPosts = searchPosts
                self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPosts?.posts.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MainTableViewCell
        let post = searchPosts?.posts[indexPath.row]
        
        cell.configur(with: post!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = searchPosts.posts[indexPath.row]
        performSegue(withIdentifier: "DetailVC", sender: post)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC",
            let post = sender as? Post {
                let destinationVC = segue.destination as! DetailViewController
                destinationVC.post = post
        }
    }
}

extension MainTableViewController {
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        
        guard let newPost = segue.source as? NewPostTableViewController else { return }
        
        
        let newNamePost = newPost.newNamePost.text
        let newDescriptionPost = newPost.newDescriptionPost.text
        let newImagePost = newPost.newImagePost.image
        
        let post = ["name": newNamePost,
                    "description": newDescriptionPost,
                    "photo": newImagePost?.toBase64(format: .jpeg(1))]
        
            networkService.postToSave(endPoint: "/post/create", parameters: post as [String : Any]) { [weak self] (result) in
            switch result{
                
            case .success(let post):
                self?.performSegue(withIdentifier: "savePost", sender: post)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

