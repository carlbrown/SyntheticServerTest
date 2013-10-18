//
//  PDBackgroundHTTPServer.h
//  SyntheticServerTest
//
//  Created by Carl Brown on 10/29/11.
//  Copyright 2011 PDAgent, LLC. Released under MIT License.
//

#import <Foundation/Foundation.h>

#import "GTMTestHTTPServer.h"

@interface PDBackgroundHTTPServer : NSObject {
    GTMTestHTTPServer *server;
	NSString *serverDocumentRoot;
	BOOL shouldStop;
}

@property (nonatomic, strong) GTMTestHTTPServer *server;
@property (nonatomic, strong) NSString *serverDocumentRoot;
@property (nonatomic, readwrite) BOOL shouldStop;

- (void) startServerWithDocumentRoot:(NSString *) documentRoot;

// fetch the port the server is running on
- (uint16_t)port;

@end
