//
//  NewsSearchView.swift
//  NewsArticles
//
//  Created by Renu Punjabi on 4/15/21.
//

import Foundation
import UIKit

final class NewsSearchView: UITableView {

    
    var newsList: [NewsSearchDetails] = [] {
        didSet {
            reloadData()
        }
    }
        
    var didSelectNewsItem: (NewsSearchDetails) -> Void = { _ in }
    let searchController = UISearchController(searchResultsController: nil)
    var searching: (String) -> Void = { _ in }
    var refreshList: () -> Void = { }
    var activityView: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)

    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    init() {
        super.init(frame: .zero, style: .plain)
        backgroundColor = .white
        registerCell()
        delegate = self
        dataSource = self
        setUpSearch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func registerCell() {
        register(NewsCell.self)
    }
    
    private func setUpSearch() {
      searchController.searchBar.delegate = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "Search news"
   }
    
    @objc private func filterContentForSearchText(_ searchText: String) {
        searching(searchText)
    }
    
    func refreshItems() {
        refreshList()
    }
    
    //MARK: Activity Indicator methods
      
    func showActivityIndicator() {
     activityView.center = self.center
     addSubview(activityView)
     activityView.startAnimating()
    }

    func hideActivityIndicator(){
       activityView.stopAnimating()
       activityView.hidesWhenStopped = true
    }

}

extension NewsSearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
          tableView.deselectRow(at: indexPath, animated: true)
        }
        let item = newsList[indexPath.row]
        didSelectNewsItem(item)
    }
}

extension NewsSearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(for: indexPath) as NewsCell
        cell.configure(newsList[indexPath.row])
        return cell
    }
    
}

extension NewsSearchView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshItems()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // to limit network activity, reload half a second after last key press.
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(filterContentForSearchText), object: nil)
        perform(#selector(filterContentForSearchText), with: searchText, afterDelay: 1.0)
    }

}

