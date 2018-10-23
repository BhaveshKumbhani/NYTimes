# NYTimes
NYTimes Most Popular Articles - IOS App

#Tools
XCODE 10.1
macOS OSX 10.13.6

#Language - Swift 4.2
#Dependances: 

	•	ReachabilitySwift
	•	NVActivityIndicatorView
	•	EVReflection
	•	SDWebImage
	•	UIAlertController
	•	NVActivityIndicatorView
	•	Lightbox


## Documentation

Access the full [API documentation](https://drive.google.com/file/d/1XVP2ID-JD2vpNvrFosgBB_Jgmp-V-UCZ/view?usp=sharing) here.


## Project Structure 

  - Localizable - Confired multi language support 
  - Controler - All class files in this folder. Bind Models with GUI 
  - Models - All Models define in that.
  - Others - Will add other further 3rd party source/class if required
  - APIManager - It is singleton class, All api calls are manage from this class.
  - Global - In this folder hold all global requiled enum and configurable variable are defined      
 

## What we need to do

  - Create IOS Native Swift Project
  - Create List screen - Using UITableViewControler (ViewController.swift) with bind custom UITableViewCell (FeedCell.swift)
  - Create custom popover - which is using for display filter data from top-right, (It is fully customizable, we can custimise own way - colour, font, height, width)
  - Preparied swift data model, witch is extend EVObject (Feed, Media, MetaData)
  - Run your app and enjoy!


## Preparing your project

-  $ pod init
-  Add bellow depeduncies 
    ```
    
    target 'NYTimes' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!

   # Pods for NYTimes
     pod 'ReachabilitySwift'
     pod 'NVActivityIndicatorView'
     pod 'EVReflection'
     pod 'SDWebImage', '~> 4.0'
     pod 'UIAlertController+Blocks'
     pod 'Lightbox'

      target 'NYTimesTests' do
        inherit! :search_paths
        # Pods for testing
      end

    end
   
    ```
    to your Podfile
    
 - $ pod install
 
## ***Press "Run" in XCode.***
