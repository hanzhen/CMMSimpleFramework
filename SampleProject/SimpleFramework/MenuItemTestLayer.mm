//  Created by JGroup(kimbobv22@gmail.com)

#import "MenuItemTestLayer.h"
#import "HelloWorldLayer.h"

@implementation MenuItemTestLayer

-(id)initWithColor:(ccColor4B)color width:(GLfloat)w height:(GLfloat)h{
	if(!(self = [super initWithColor:color width:w height:h])) return self;
	
	menuItem1 = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0 batchBarSeq:0];
	menuItem1.delegate = self;
	menuItem1.title = @"button 1";
	menuItem1.userData = @"first Button";
	menuItem1.position = ccp(self.contentSize.width/2-menuItem1.contentSize.width/2-10,self.contentSize.height/2);
	[self addChild:menuItem1];
	
	menuItem2 = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0 batchBarSeq:0];
	[menuItem2 setSelectedImage:[CCSprite spriteWithFile:@"Icon.png"]];
	menuItem2.delegate = self;
	menuItem2.touchCancelDistance = 100.0f; // check this function
	menuItem2.title = @"button 2";
	menuItem2.userData = @"second Button";
	menuItem2.position = ccp(self.contentSize.width/2+menuItem2.contentSize.width/2+10,self.contentSize.height/2);
	[self addChild:menuItem2];
	
	menuItem3 = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0 batchBarSeq:0];
	menuItem3.title = @"disabled button";
	menuItem3.position = ccp(contentSize_.width/2,contentSize_.height/2+menuItem3.contentSize.height+10);
	[menuItem3 setIsEnable:NO];
	[self addChild:menuItem3];
	
	menuItemBack = [CMMMenuItemLabelTTF menuItemWithFrameSeq:0 batchBarSeq:0];
	[menuItemBack setTitle:@"BACK"];
	menuItemBack.position = ccp(menuItemBack.contentSize.width/2+20,menuItemBack.contentSize.height/2+20);
	menuItemBack.delegate = self;
	[self addChild:menuItemBack];
	
	displayLabel = [CMMFontUtil labelWithstring:@" "];
	displayLabel.position = ccp(self.contentSize.width/2,self.contentSize.height/2-60);
	[self addChild:displayLabel];
	
	return self;
}

-(void)menuItem_whenPushdown:(CMMMenuItem *)menuItem_{
	if(menuItem_ == menuItem1 || menuItem_ == menuItem2)
		[displayLabel setString:[NSString stringWithFormat:@"%@ push down",menuItem_.userData]];
}
-(void)menuItem_whenPushup:(CMMMenuItem *)menuItem_{
	if(menuItem_ == menuItem1 || menuItem_ == menuItem2){
		[displayLabel setString:[NSString stringWithFormat:@"%@ push up",menuItem_.userData]];
	}else if(menuItem_ == menuItemBack){
		[[CMMScene sharedScene] pushStaticLayerItemAtKey:_HelloWorldLayer_key_];
	}
}
-(void)menuItem_whenPushcancel:(CMMMenuItem *)menuItem_{
	if(menuItem_ == menuItem1 || menuItem_ == menuItem2){
		[displayLabel setString:[NSString stringWithFormat:@"%@ cancel",menuItem_.userData]];
	}
}

@end