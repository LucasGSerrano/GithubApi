//
//  MainViewController.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 12/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

// MARK: - View Controller
class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var reposDataSource: ReposDataSource?
    fileprivate var pullRequestsDataSource: PullRequestsDataSource?
    fileprivate var selectedIndexPath: IndexPath? = nil

    var urlToLoad: String?

    var paging = 1

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        reposDataSource = setUpReposDataSource()
    }

}

// MARK: - Data Source
class ReposDataSource: CollectionArrayDataSource<Repos, ReposCell> {}
class PullRequestsDataSource: CollectionArrayDataSource<PullRequests, PullRequestCell> {}

// MARK: - Private Methods
fileprivate extension MainViewController {
    func setUpReposDataSource() -> ReposDataSource? {
        let networkService = NetworkService(withBaseURL: Constants.baseUrl)
        networkService.fetch(fromRoute: Routes.repos, paging) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let model):
                let dataSource = ReposDataSource(collectionView: strongSelf.collectionView, array: model.items ?? [])
                dataSource.collectionItemSelectionHandler = { [weak self] indexPath in
                    guard let strongSelf = self, let repo = strongSelf.reposDataSource?.item(at: indexPath) else { return }
                    strongSelf.selectedIndexPath = indexPath
                    strongSelf.urlToLoad = "repos/\(repo.owner?.name ?? "")/\(repo.name ?? "")/pulls"
                    strongSelf.pullRequestsDataSource = strongSelf.setUpPullRequestDataSource()
                }
                strongSelf.reposDataSource = dataSource
                strongSelf.collectionView.reloadData()
                strongSelf.paging += 1
            case .failure(let error):
                print (error)
            }
        }
        return nil
    }

    func setUpPullRequestDataSource() -> PullRequestsDataSource? {
        guard let url = urlToLoad else {
            defer { reposDataSource = setUpReposDataSource() }
            return nil
        }
        let networkService = NetworkService(withBaseURL: Constants.baseUrl)
        let route = Route<[PullRequests]>(endpoint: url)
        networkService.fetch(fromRoute: route, nil) { [weak self] (result) in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let model):
                let dataSource = PullRequestsDataSource(collectionView: strongSelf.collectionView, array: model)
                strongSelf.pullRequestsDataSource = dataSource
                dataSource.collectionItemSelectionHandler = { [weak self] indexPath in
                    guard let strongSelf = self, let pullRequest = strongSelf.pullRequestsDataSource?.item(at: indexPath) else { return }
                    if let externalUrl = URL(string: pullRequest.url ?? ""), externalUrl.absoluteString != "" {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(externalUrl, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(externalUrl)
                        }
                    }
                }
                let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(self?.backBtn))
                strongSelf.navigationItem.setLeftBarButton(backButton, animated: true)
                strongSelf.collectionView.reloadData()
            case .failure(let error):
                print (error)
            }
        }
        return nil
    }

    @objc func backBtn() {
        navigationItem.setLeftBarButton(nil, animated: true)
        paging = 1
        reposDataSource = setUpReposDataSource()
    }

}
