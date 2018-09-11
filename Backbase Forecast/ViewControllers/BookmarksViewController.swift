//
//  BookmarksViewController.swift
//  Backbase Forecast
//
//  Created by Admin on 10.09.2018.
//  Copyright © 2018 Backbase. All rights reserved.
//

import UIKit
protocol BookmarkDelegate {
    func didSelectBookmark(_ bookmark:BookmarkModel)
}
class BookmarksViewController: UIViewController {
    @IBOutlet weak var tblBookmarks: UITableView!
    var delegate:BookmarkDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        UISettings()
    }
    func UISettings(){
        self.view.dropShadow(offset: -5)
        tblBookmarks.tableFooterView = UIView(frame: CGRect.zero)
        if ForecastUserDefaults.Bookmarks.count == 0{
            tblBookmarks.emptyMessage(Strings.NoBookmark) 
        }
    }
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension BookmarksViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ForecastUserDefaults.Bookmarks.count > 0{
            tblBookmarks.removeEmptyMessage()
        }
        return ForecastUserDefaults.Bookmarks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let bookmark = ForecastUserDefaults.Bookmarks[indexPath.row]
        cell.textLabel?.text = bookmark.name
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bookmark = ForecastUserDefaults.Bookmarks[indexPath.row]
        delegate?.didSelectBookmark(bookmark)
        self.dismiss(animated: true, completion: nil)
    }
}

