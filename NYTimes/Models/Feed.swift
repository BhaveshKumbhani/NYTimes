//
//  Feed.swift
//  NYTimes
//
//  Created by Bhavesh Kumbhani on 23/10/18.
//  Copyright © 2018 Bhavesh Kumbhani. All rights reserved.
//

import UIKit
import EVReflection

class Feed: EVObject {

    var abstract = String()
    var adx_keywords = String()
    var asset_id = String()
    var byline = String()
    var column = String()
    var published_date = String()
    var section = String()
    var source = String()
    var title = String()
    var type = String()
    var url = String()
    var views = Int()
    var id = String()
    var des_facet = [String]()
    var geo_facet = [String]()
    var per_facet = [String]()
    var org_facet = [String]()
    var media = [Media]()
}
class Media: EVObject {
    var approved_for_syndication = String()
    var caption = String()
    var copyright = String()
    var media_metadata = [MetaData]()
    var subtype = String()
    var type = String()
}
class MetaData: EVObject {
     var format = String()
     var url = String()
     var height = Int()
     var width = Int()
}
