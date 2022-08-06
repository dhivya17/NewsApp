//
//  ViewController.swift
//  NewsApp
//
//  Created by d.c.venkatachalam on 04/08/22.
//

import UIKit

class NewsFeedViewController: UIViewController {
    private var tableView: UITableView!
    private var viewModel: NewsFeedViewModel
    private var activityIndicator: UIActivityIndicatorView!
    private var refreshControl: UIRefreshControl!
    
    var feeds: NewsFeed?
    
    init(
        viewModel: NewsFeedViewModel = NewsFeedViewModel()
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        self.title = "NewsApp"
        configureView()
        constrainView()
        bindViewModel()
        viewModel.fetchNewsApi()
        activityIndicator.startAnimating()
    }
    
    func configureView() {
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlHandler), for: .valueChanged)
        
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.cellId)
        tableView.refreshControl = refreshControl
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func constrainView() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func bindViewModel() {
        viewModel.newsFeed = { [weak self] newsfeed in
            self?.feeds = newsfeed
            self?.refreshTableView()
        }
        
        viewModel.showActivityIndicator = { [weak self] show in
            self?.showAnimator(show)
        }
        
        viewModel.refreshControlCallback = { [weak self] refreshing in
            DispatchQueue.main.async {
                refreshing ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            }
        }
    }
    
    func refreshTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showAnimator(_ show: Bool) {
        DispatchQueue.main.async { [weak self] in
            show ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }
    }
    
    @objc private func refreshControlHandler() {
        self.showAnimator(false)
        self.viewModel.refreshData()
    }
}


extension NewsFeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        feeds?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellId, for: indexPath) as? NewsTableViewCell, let articles = feeds?.articles  else { return UITableViewCell() }
        cell.updateCell(data: articles[indexPath.row])
        return cell
    }
}
