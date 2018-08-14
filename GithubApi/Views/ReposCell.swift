//
//  ReposCell.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 13/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

import UIKit

class ReposCell: UICollectionViewCell, ConfigurableCell {
    @IBOutlet weak var ownerImage: CachedImageView!
    @IBOutlet weak var ownerName: UILabel!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!

    // MARK: - ReusableCell
    public static var height: CGFloat = 50.0

    // MARK: - ConfigurableCell
    func configure(_ item: Repos, at indexPath: IndexPath) {
        ownerName.text = item.owner?.name ?? "Sem nome"
        title.text = item.name
        repoDescription.text = item.description

        stars.text = "\(item.stars ?? 0)"
        forks.text = "\(item.forks ?? 0)"

        if let image = item.owner?.imageUrl, image != "" {
            ownerImage.loadImageFromURL(imageUrl: image)
        }

    }
}
