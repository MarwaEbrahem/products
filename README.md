# products
It is an application that display products list in a UICollectionView that can be scrolled infinitely to load more products, when a product is selected, a new product details view will display with custom transition.
Products returned by the API cached locally in coreData. When there's no internet connection, the app displays the cached data. As soon as an internet connection is available again, the app makes a request to the API to request new data and update the local cache.

Used swift language and apply dependency inversion principle that refers to a specific form of decoupling software modules.
Architecture pattern used: 
•	MVVM, which allows you to use data from a single model class and represent it in different ways to populate a view.
•	it consist of model , view and view model to connect between them 
	Models
These hold the app data. These are the structs and classes that you have created to hold the data you receive from a REST API or from some other data source.
	Views
These display UI elements on the screen. These are usually classes that subclass UIView and use UIKit.
	View Models
These classes are where you take the information from the model classes and transform them into values that can be displayed in a particular view.

Design pattern used: 
•	singleton pattern 
To guarantees that only one instance of a class is instantiated.
•	facade pattern
That can be recognized in a class that has a simple interface, but delegates most of the work to other classes. Usually, facades manage the full life cycle of objects they use.
