//
//  NewsFeedViewModel.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 06/08/22.
//

import Foundation

protocol NewsFeedViewModelProtocol {
    var networkManager: NewsDataServiceProtocol { get }
}

final class NewsFeedViewModel: NewsFeedViewModelProtocol {
    var networkManager: NewsDataServiceProtocol
    
    var newsFeed: ((NewsFeed) -> Void)?
    var showActivityIndicator: ((Bool) -> Void)?
    var refreshControlCallback: ((Bool) -> Void)?
    private var refreshing = false
    
    init() {
        networkManager = NewsDataService()
    }
    
    func fetchNewsApi()  {
        fetchData { [weak self] result in
            switch result {
            case .success(let feeds):
                guard let self = self else { return }
                self.stopRefreshingData()
                self.newsFeed?(feeds)
            case .failure(let error):
                self?.showActivityIndicator?(false)
                print(error)
            }
        }
    }
    
    func refreshData() {
        if !refreshing {
            refreshing = true
            refreshControlCallback?(refreshing)
            fetchNewsApi()
        }
    }
    
    func stopRefreshingData() {
        refreshing = false
        showActivityIndicator?(false)
        refreshControlCallback?(refreshing)
    }
    
    private func fetchData(completion: @escaping (Result<NewsFeed, NetworkError>) -> Void) {
        Task(priority: .userInitiated) {
            let result = await networkManager.getNewsFeed(page: 1)
            completion(result)
        }
    }
}
