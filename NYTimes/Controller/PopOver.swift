//
//  PopOver.swift
//  Sports
//
//  Created by Bhavesh Kumbhani | Digicians Technologies on 20/12/17.
//  Copyright © 2017 Bhavesh Kumbhani. All rights reserved.
//

protocol PopOverDelegate {
    func selectedItem(index: Int, item: String)
}

import UIKit

class PopOver: UITableViewController {

    var dataList : [String] = []
    var selectedItem : String = ""
    var delegate : PopOverDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "popOverCell")
        self.tableView.tintColor = UIColor.darkGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "popOverCell", for: indexPath)
        guard dataList.count > 0 else {
            Swift.debugPrint("dataList nil in cellForRowAt-PopOver")
            return cell
        }
        
        let strItem = dataList[indexPath.row]
        cell.textLabel?.text = strItem
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        if selectedItem == strItem {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        for c in tableView.visibleCells{
            c.accessoryType = .none
        }
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        if delegate != nil {
            delegate?.selectedItem(index: indexPath.row, item: dataList[indexPath.row])
        }
    }
}
var popOverVC : PopOver! = nil
extension UIViewController : UIPopoverPresentationControllerDelegate{
    func bgWhiteColor() -> Void {
        self.view.backgroundColor = UIColor.white
    }
    func openPopOver(dataList : [String], selectedItem: String, sender: AnyObject, size: CGSize, direction: UIPopoverArrowDirection)  {
        popOverVC = PopOver()
        popOverVC.dataList =  dataList
        popOverVC.selectedItem = selectedItem
        popOverVC.delegate = self as? PopOverDelegate
        popOverVC.preferredContentSize = size
        popOverVC.modalPresentationStyle = .popover
        popOverVC.popoverPresentationController?.delegate = self
        popOverVC.popoverPresentationController?.permittedArrowDirections = direction
        if sender.isKind(of: UIBarButtonItem.classForCoder()) {
            popOverVC.popoverPresentationController?.barButtonItem = sender as? UIBarButtonItem
        }else{
            
            popOverVC.popoverPresentationController?.sourceView = sender as? UIView
        }
        self.present(popOverVC, animated: true, completion: nil)
    }
    public func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool
    {
        return true
    }
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle
    {
        return UIModalPresentationStyle.none
    }
    
    
}
