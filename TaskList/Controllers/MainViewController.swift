//
//  ViewController.swift
//  TaskList
//
//  Created by Victor Smirnov on 06/06/2019.
//  Copyright © 2019 Victor Smirnov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  let headerTitles = ["Active", "Completed"]
  var items = [Item]()
  
  var completedItems: [Item] {
    return items.filter { $0.isCompleted }
  }
  var activeItems: [Item] {
    return items.filter { !$0.isCompleted }
  }

  @IBOutlet weak var tableWiew: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    items.append(contentsOf:  [
      Item(name: "Make perfect cource", comments: "Oh, yeah", dueDate: Date() + Measurement(value: 24, unit: UnitDuration.hours).value),
      Item(name: "Make a wish", comments: "Oh, yeah", dueDate: Date() + Measurement(value: 23, unit: UnitDuration.hours).value),
      Item(name: "Make a wish", comments: "Oh, yeah", dueDate: Date() + Measurement(value: 23, unit: UnitDuration.hours).value)
   ])
    items[2].completionDate = Date()
  }
  
  func getItem(forIndexPath indexPath: IndexPath) -> Item {
    return (indexPath.section == 0) ? activeItems[indexPath.row] : completedItems[indexPath.row]
  }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    switch section {
    case 0:
      return activeItems.count
    case 1:
      return completedItems.count
    default:
      return 0
    }
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return headerTitles[section]
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    let item = getItem(forIndexPath: indexPath)
    
    cell.textLabel?.text = item.name
    cell.detailTextLabel?.text = "\(item.dueDate)"
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
      let item = getItem(forIndexPath: indexPath)
      items.remove(at: items.firstIndex(where: { $0 == item })!)
      tableView.reloadData()
    }
  }
}
