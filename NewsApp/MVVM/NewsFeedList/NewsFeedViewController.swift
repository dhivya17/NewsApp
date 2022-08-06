//
//  ViewController.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 04/08/22.
//

import UIKit

class NewsFeedViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var feeds: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchNewsApi()
    }
    
    func setupUI() {
        self.title = "NewsApp"
        configureView()
        constrainView()
    }
    
    func configureView() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.cellId)
    }
    
    func constrainView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func fetchData(completion: @escaping (Result<NewsFeed, NetworkError>) -> Void) {
        Task(priority: .background) {
            let result = await NewsDataService().getNewsFeed(page: 1)
            completion(result)
        }
    }
    
    func fetchNewsApi()  {
        fetchData { result in
            switch result {
            case .failure(let err):
                print(err)
            case .success(let feeds):
                self.feeds = feeds.articles
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(feeds)
            }
        }
    }
}


extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellId, for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.updateCell(data: feeds[indexPath.row])
        return cell
    }
}
