//
//  BookmarksViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tblBookmarks: UITableView!
    var bookmarks = [BookmarkModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        UISettings()
    }
    func UISettings(){
        self.view.dropShadow(offset: -5)
        tblBookmarks.tableFooterView = UIView(frame: CGRect.zero)
        tblBookmarks.emptyMessage(Strings.NoBookmark)
    }
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension BookmarksViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

