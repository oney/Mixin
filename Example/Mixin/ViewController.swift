//
//  ViewController.swift
//  Mixin
//
//  Created by Howard Yang on 12/03/2017.
//  Copyright (c) 2017 Howard Yang. All rights reserved.
//

import UIKit
import Mixin

class ViewController: UIViewController {
    var findTableView: UITableView? { return tableView }
    
    @IBOutlet weak var tableView: UITableView!
    
    var keyboardHeight: CGFloat? {
        didSet {
            tableView.contentInset.bottom = keyboardHeight ?? 0
        }
    }
    
    var fetchingMore = false
    var dataCount: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController viewWillAppear")
    }
}

extension ViewController: KeyboardMixin {}
extension ViewController: StandardTableMixin {
    func showPagingSpinner() -> Bool {
        return fetchingMore
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if #available(iOS 10.0, *) {
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    func loadMore() {
        if fetchingMore { return }
        fetchingMore = true
        tableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dataCount += 50
            self.fetchingMore = false
            self.tableView.reloadData()
        }
        print("loadMore")
    }
}
extension ViewController: TextFieldReturnMixin {
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("ViewController textFieldShouldReturn")
        return true
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        title = "Begin Dragging"
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("ViewController scrollViewDidScroll")
        
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        print("ViewController didSelectRowAt")
    }
}

extension ViewController: ScrollFinishMixin {
    func scrollFinish(_ scrollView: UIScrollView) {
        title = "Finish Scrolling"
        print("scrollFinish")
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
}
