NSAttributedString-HTMLStyle
============================

This repo consits of a few categories for dealing with `HTML` and `NSAttributedString`s. 

**HEY! Apple provided me with methods for these tasks.**
Yes, *unless* you want to specify different attributes for, let's say, headers and paragraphs.

###How does it work
When iOS creates an attributed string from `HTML` `NSHTMLParser` also parses `CSS` attributes. Therefore if you add following `CSS` to your `HTML`<br> 
```css
p {
font-name:"Helvetica";
font-size:14px;
}
h1 {
font-name:"Georgia";
font-size:16px;
}
```

Your headers in `NSAttributedString` will have these attributes: <br>`@{NSFontAttributeName : [UIFont fontWithName:@"Georgia" size:16.f]}` <br>
whereas paragraphs will be attributed with: <br>
`@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica" size:14.f]}`

###Sample usage

```objc
	#import "NSAttributedString+HTMLStyle.h"
	...
	UITextView *textView;  
	NSData *htmlData;
	textView.attributedText = [NSAttributedString attributedStringFromHTMLData:htmlData];
	...Or with custom attributes...
	NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
	[attributes addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:17.f]} forHTMLAttribute:QRHTMLAttributeParagraph flatten:YES];
	textView.attributedText = [NSAttributedString attributedStringFromHTMLData:htmlData attributes:attributes];
```

###Installation

Install via Cocoapods:
`pod 'NSAttributedString-HTMLStyle'`
or copy `NSAttributedString+HTMLStyle.*`

##Author
This repository was originally developed by [Wojtek Czekalski](http://twitter.com/wczekalski) during the developmment of [Quickread](http://quickreadapp.com).
