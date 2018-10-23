//
//  ViewController.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 22/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit
import SDWebImage
import Lightbox
import NVActivityIndicatorView

let filterDataList = ["1", "7", "30"]

class ViewController: UITableViewController {

    var dataList = [Feed]()
    var currentFilterIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYTimes"
        self.getData()
    }

    func getData() -> Void {
    
        DispatchQueue.main.async {
            self.startAnimating()
            let size = CGSize(width: CGFloat(50).isIpad(), height: CGFloat(50).isIpad())
            self.startAnimating(size, message: "", type: NVActivityIndicatorType.ballClipRotatePulse)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
            self.didStartUpdating()
        }
    }
    func didStartUpdating() -> Void {
        guard  let indexValue = Int(filterDataList[currentFilterIndex]) else {
            return
        }
        
        APIManeger.shared.getList(param: [key_days:indexValue]) { (response) in
            DispatchQueue.main.async {
                self.stopAnimating()
            }
            switch response {
            case .success(let objModels):
                if let list = objModels as? [Feed]{
                    self.dataList.removeAll()
                    self.dataList = list
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                Swift.print("objModels:", objModels)
                break
            case .failure(let error):
                Swift.print("error:", error)
                break
            }
        }
    }
    
}

extension ViewController{
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedCell else {
            return FeedCell()
        }
        let objModel = dataList[indexPath.row]

        cell.lblTitle.text = objModel.title
        cell.lblOwner.text = objModel.byline
        cell.lblDateTime.text = objModel.published_date

        guard  let meta = objModel.media.first?.media_metadata.first(where: {$0.format == "Large Thumbnail"}) else {
            return cell
        }
        if let url =  URL.init(string: meta.url){
            cell.imgThumb.sd_setImage(with: url, placeholderImage: UIImage.init(named: "image-thumb"), options: SDWebImageOptions.highPriority) { (image, error, type, url) in
            }
        }
    
        return cell
    }

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let objModel = dataList[indexPath.row]
    
    guard  let meta = objModel.media.first?.media_metadata.first(where: {$0.format == "superJumbo"}) else {
        return
    }
    if let url =  URL.init(string: meta.url){
        let objImg = LightboxImage.init(imageURL: url)
        objImg.text = objModel.media.first?.caption ?? ""
        let controller = LightboxController(images:[objImg])
        controller.dynamicBackground = true
        present(controller, animated: true, completion: nil)
        
    }
    }
}
extension ViewController : PopOverDelegate{
    func selectedItem(index: Int, item: String) {
        popOverVC.dismiss(animated: true, completion: nil)
        currentFilterIndex = index
        self.getData()
    }
    @IBAction func btnFilterClick(_ sender: UIBarButtonItem) {
        self.openPopOver(dataList:  filterDataList, selectedItem: filterDataList[currentFilterIndex], sender: sender, size: .init(width: 100, height: 120), direction:.any)
    }
}
