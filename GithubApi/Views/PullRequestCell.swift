//
//  PullRequestCell.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 14/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class PullRequestCell: UICollectionViewCell, ConfigurableCell {
    @IBOutlet weak var ownerImage: CachedImageView!
    @IBOutlet weak var ownerName: UILabel!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!

    @IBOutlet weak var body: UILabel!

    // MARK: - ReusableCell
    public static var height: CGFloat = 100.0

    // MARK: - ConfigurableCell
    func configure(_ item: PullRequests, at indexPath: IndexPath) {
        ownerName.text = item.user?.name ?? "Sem nome"
        title.text = item.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale.current
        date.text = item.created != nil ? dateFormatter.string(from: item.created!) : "Sem informações"
        body.text = item.body
        if let image = item.user?.imageUrl, image != "" {
            ownerImage.loadImageFromURL(imageUrl: image)
        }

    }
}
