//
//  ViewController.swift
//  FortgroupTest
//
//  Created by Dmitry Rybochkin on 25.03.17.
//  Copyright © 2017 Dmitry Rybochkin. All rights reserved.
//

import UIKit
import RealmSwift
import AlamofireImage

class TableViewController: UITableViewController {
    var indicator: UIActivityIndicatorView?

    let dataManager = DataManager.sharedManager
    var items: [NewsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40.0

        if navigationController != nil {
            let navController: UINavigationController = navigationController!

            let views = navController.navigationBar.subviews.filter { element in element is UIActivityIndicatorView}

            if views.count > 0 {
                indicator = views[0] as? UIActivityIndicatorView
            } else {
                let navBarSize: CGSize = navController.navigationBar.bounds.size
                let origin: CGPoint = CGPoint(x: navBarSize.width/2, y: navBarSize.height/2 )
                indicator = UIActivityIndicatorView(frame: CGRect(x: origin.x, y: origin.y, width: 0, height: 0))
                indicator?.activityIndicatorViewStyle = .whiteLarge
                indicator?.color = UIColor.red
                navController.navigationBar.addSubview(indicator!)
            }
        }

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataDidLoad(_:)),
                                               name: NSNotification.Name.FortgroupTestDataDidLoad,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(dataWillLoad(_:)),
                                               name: NSNotification.Name.FortgroupTestDataWillLoad,
                                               object: nil)

        loadDataAndUpdateUI()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func dataWillLoad(_ notification: Notification) {
        showIndicator()
    }

    func dataDidLoad(_ notification: Notification) {
        if let needUpdate = notification.object as? Bool {
            if needUpdate {
                loadDataAndUpdateUI()
            }
        }
        hideIndicator()
    }

    func loadDataAndUpdateUI() {
        items = dataManager.getItems(NewsModel.self)
        self.tableView.reloadData()
    }

    func showIndicator() {
        print("showIndicator")
        indicator?.isHidden = false
        indicator?.startAnimating()
    }

    func hideIndicator() {
        print("hideIndicator")
        indicator?.isHidden = true
        indicator?.stopAnimating()
    }

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.currentContext
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return items.count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Section"
        }
        return ""
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 28
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ImageItemTableViewCell",
                                                        for: indexPath) as? ImageItemTableViewCell {
                if items.count > 0 {
                    let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                        size: cell.userImageView.frame.size,
                        radius: 5.0
                    )
                    cell.userImageView.af_setImage(
                        withURL: URL(string: items[0].imageUrl)!,
                        filter: filter,
                        imageTransition: .crossDissolve(0.2)
                    )

                    cell.titleLabel.text = items[0].title
                    cell.subTitleLabel.text = items[0].lead
                }
                return cell
            } else {
                assert(false, "Unknown cell type.")
            }
        } else if (indexPath.section == 1) && (indexPath.row == 0) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "OneButtonTableViewCell",
                                                        for: indexPath) as? OneButtonTableViewCell {
                if items.count > 0 {
                    cell.button.setTitle(items[0].type)
                }
                return cell
            } else {
                assert(false, "Unknown cell type.")
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ThreeButtonsTableViewCell",
                                                        for: indexPath) as? ThreeButtonsTableViewCell {
                cell.button1.setTitle(items[indexPath.row - 1].textId)
                cell.button2.setTitle(items[indexPath.row - 1].type)
                cell.button3.setTitle(items[indexPath.row - 1].rubric)
                return cell
            } else {
                assert(false, "Unknown cell type.")
            }
        }

        return UITableViewCell()
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height) {
            print("scrollViewDidEndDragging load data")
            NotificationCenter.default.post(name: Notification.Name.FortgroupTestDataLoad, object: nil)
        }
    }
}
