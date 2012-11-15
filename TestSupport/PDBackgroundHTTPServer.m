//
//  PDBackgroundHTTPServer.m
//  SyntheticServerTest
//
//  Created by Carl Brown on 10/29/11.
//  Copyright 2011 PDAgent, LLC. Released under MIT License.
//

#import "PDBackgroundHTTPServer.h"

@implementation PDBackgroundHTTPServer

@synthesize server;
@synthesize serverDocumentRoot;
@synthesize shouldStop;

static const NSTimeInterval kRunLoopInterval = 0.01; 
static const NSTimeInterval kGiveUpInterval = 15.0; // bail on the test if 15 seconds elapse

- (void) startServerWithDocumentRoot:(NSString *) documentRoot {
    [self setShouldStop:NO];
    [self setServerDocumentRoot:documentRoot];
    
    //wait two seconds for the server to spin up before returning
    NSDate* twoSeconds = [NSDate dateWithTimeIntervalSinceNow:2.0];
	[self performSelectorInBackground:@selector(runServer) withObject:nil];
	while ([self server]==nil &&
		   [twoSeconds timeIntervalSinceNow] > 0) {
		//fire up a run loop
		NSDate* loopIntervalDate =
		[NSDate dateWithTimeIntervalSinceNow:kRunLoopInterval];
		[[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate]; 
	}

}

- (void) runServer {
	NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];    
    NSDate* giveUpDate = [NSDate dateWithTimeIntervalSinceNow:kGiveUpInterval];
    self.server = [[GTMTestHTTPServer alloc] initWithDocRoot:self.serverDocumentRoot];

	while ([self shouldStop]==NO &&
		   [giveUpDate timeIntervalSinceNow] > 0) {
		//fire up a run loop
		NSDate* loopIntervalDate =
		[NSDate dateWithTimeIntervalSinceNow:kRunLoopInterval];
		[[NSRunLoop currentRunLoop] runUntilDate:loopIntervalDate]; 
	}
	[pool release];
}

// fetch the port the server is running on
- (uint16_t)port {
    return [self.server port];
}

-(void) dealloc {
    [server release], server = nil;
    [serverDocumentRoot release], serverDocumentRoot = nil;
    [super dealloc];
}
@end
