//  Created by JGroup(kimbobv22@gmail.com)

#import "CMMLoadingObject.h"

@interface CMMLoadingObject(Private)

-(void)_performLoadingSchedule;
-(void)_loopAngLoading;

@end

@implementation CMMLoadingObject
@synthesize delegate,loadingMethodFormatter;

+(id)loadingObject{
	return [[[self alloc] init] autorelease];
}

-(id)init{
	if(!(self = [super init])) return self;
	
	delegate = nil;
	loadingMethodFormatter = cmmVarCMMLoadingObject_defaultLoadingFormatter;
	_curSequence = 0;
	
	return self;
}

-(void)startLoadingWithTarget:(id)target_{
	if(!target_) return;
	[[[CCDirector sharedDirector] scheduler] unscheduleUpdateForTarget:self];
	
	_loadingTarget = target_;
	_curSequence = 0;
	
	if(cmmFuncCommon_respondsToSelector(delegate,@selector(loadingObject_whenLoadingStart:)))
		[delegate loadingObject_whenLoadingStart:self];
	[self _performLoadingSchedule];
}
-(void)startLoading{
	[self startLoadingWithTarget:delegate];
}
-(void)startLoadingWithMethodFormatter:(NSString *)methodFormatter_ target:(id)target_{
	[self setLoadingMethodFormatter:methodFormatter_];
	[self startLoadingWithTarget:target_];
}
-(void)startLoadingWithMethodFormatter:(NSString *)methodFormatter_{
	[self startLoadingWithMethodFormatter:methodFormatter_ target:delegate];
}

-(void)_performLoadingSchedule{
	[[CCDirector sharedDirector].scheduler scheduleSelector:@selector(_loopAngLoading) forTarget:self interval:0.1f paused:NO];
}
-(void)_loopAngLoading{
	[[CCDirector sharedDirector].scheduler unscheduleSelector:@selector(_loopAngLoading) forTarget:self];
	
	BOOL isEndLoading_ = NO;
	if(!loadingMethodFormatter){
		isEndLoading_ = YES;
	}else{
		SEL targetSelector_ = NSSelectorFromString([NSString stringWithFormat:loadingMethodFormatter,_curSequence]);
		if(cmmFuncCommon_respondsToSelector(_loadingTarget,targetSelector_))
			[_loadingTarget performSelector:targetSelector_];
		else isEndLoading_ = YES;
	}
	
	if(isEndLoading_){
		if(cmmFuncCommon_respondsToSelector(delegate,@selector(loadingObject_whenLoadingEnded:))){
			[delegate loadingObject_whenLoadingEnded:self];
			return;
		}
	}
	
	_curSequence++;
	[self _performLoadingSchedule];
}

-(void)dealloc{
	[delegate release];
	[loadingMethodFormatter release];
	[super dealloc];
}

@end