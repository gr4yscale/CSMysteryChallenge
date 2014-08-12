CSMysteryChallenge
==================

I wanted persistence both in the form of caching images to disk, and objects fetched from the server.

I also wanted to try my hand at getting an object graph out of JSON fetched with network requests without resorting to RestKit.

RestKit solves a lot of difficult problems, but it is so very opininated in how you use it and there are so many components to it that it can be difficult to make sense of fully. I feel that I should understand in detail how the code that my code depends on runs.

So, I'm using Groot to deserialize JSON and give back NSManagedObjects, and call into the TMAPIClient for network requests. I tried to genericize as much as possible the components that make up CSDataAccess. The idea for that class was that the consumer (usually view controllers) should have to do nothing more than to just say "fetch these resources" and not have to worry about anything else. It should also provide a managedObjectContext for specific for UI updates.

Additional thoughts on the data/networking side: 

Many people are familiar with Mantle for mapping JSON to objects. I was going to try that route, inspired by this slide deck: http://www.slideshare.net/GuillermoGonzalez51/better-web-clients-with-mantle-and-afnetworking but I discovered Mantle doesn't handle Core Data well. In particular, if you fetch down partial JSON for an object that's already been deserialized previously, all of the attributes where there were nil JSON keys get nil'd. This is because the MTLManagedObjectAdapter makes a copy of Mantle objects and applies the values of each property onto a new NSManagedObject everytime. I then discovered they removed Core Data support entirely as of very recent: https://github.com/Mantle/Mantle/pull/374 So, I ended up with Groot. The author of Overcoat who was advocating use of Mantle + Overcoat wrote it, and I'm liking it quite well.

Objection is used to inject dependencies. I think that using dependency injection makes a) you think about the interfaces between your objects more closely and b) makes it easy to swap out dependencies for stubs or specially-instantiated objects for testing purposes.

There are a couple of places where I have properties or methods exposed publicly that I would like to make private. This is a drawback of me not having an adequate testing environment setup still. Sometimes if it's very important to test it, we get around it by using a pragma to suppress warnings about unrecognized selectors and call the implementations private selectors anyways. More likely than not you shouldn't be testing a private method, but looking at private properties is sometimes helpful. Anyway, I end up making the public declaration of these properties that I'd rather have hidden a readonly property but then redeclare it read-write in the private declaration.

I didn't get time to write as many tests as I would haved liked to, but there are a couple. CSPostSpec is more of a functional test than a unit test. It confirms that everything is hooked up and configured properly with Groot and Core Data. If I were to continue making tests that used core data stuff, I would probably have a different Objection module for unit-testing versions of that stack. Perhaps an in-memory persistent store since I'll want to reset state between tests.

 I'm not actually mocking any objects out so there isn't any demonstration of any actual unit testing I just realized. The other test didn't get very far
 I am a fan of Kiwi for Unit Testing, but lately have found myself using XCTestCase a lot more for the other types if testing I do on my current project. We have Kiwi Functional Tests, Kiwi Unit Tests, KIF acceptance, and FBSnapshotTestCase...quite a plethora of tools to ensure everything is running smoothly!

I used SDWebImage for caching and displaying the images. One very nice thing about SDWebImage is that it does background image decompression. This greatly improves scrolling performance, especially on older devices. Previously you would have to use some boilerplate category to do it, like they show here: http://ioscodesnippet.com/2011/10/02/force-decompressing-uiimage-in-background-to-achieve/

The caption text that comes down on the Post models included styling HTML. Rather than sanitize it I ended up trying to render it as a NSAttributedString then override the font name and size. I wish there had been a sanitized version of that string coming from the API.

I tried to let Auto Layout compute the size of the entire CSPostTableViewCell but it kept returning a zero size. In the past I've used systemLayoutSizeFittingSize: on the contentView of the cell and it has worked no problem. Perhaps I have an issue with my constraints, but I worked a hack in to keep moving that just adds up the heights of the 3 dynamic heights (caption, tags list, and imageView) and added a magic number for all of the padding.




Things I didn't get time to build but would have liked to:

-A state machine-backed container view showing different subviews depending on the state: (no internet, empty data, loading data for the first time, data available)

-Better paginated API handling: Determine the correct offset to accurately fetch new posts. Look at the original post_count and adjust the offset accordingly if the response has a higher post_count

-Loading placeholder for images; more robust image fetching

-Nice interactive animations and transitions, inspired by Facebook's "Paper". I didn't have any other controllers or many views to work with. I might have used the "Pop" framework.

-Photo detail view (I was going to just hook it up to URBMediaViewController)

-Dynamic Type Sizing

-Sharing, Open in Safari Actions

-Splash screen or Launch Image


