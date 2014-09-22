
//
//  SyntheticServerTestTests.m
//  SyntheticServerTestTests
//
//  Created by Carl Brown on 10/29/11.
//  Copyright (c) 2011 PDAgent, LLC. Released under MIT License.
//

#import <XCTest/XCTest.h>
#import "PDBackgroundHTTPServer.h"

@interface SyntheticServerTestTests : XCTestCase {
    PDBackgroundHTTPServer *testServer;
}

@end

@implementation SyntheticServerTestTests

- (void)setUp
{
    [super setUp];
    
    testServer = [[PDBackgroundHTTPServer alloc] init];
}

- (void)tearDown
{
    [testServer setShouldStop:YES];
     testServer=nil;
    
    [super tearDown];
}

- (void)testExample
{
    NSString *testDataDirectory=[[[NSBundle bundleForClass:[self class]] pathForResource:@"carlbrown"
											 ofType:@"json"] stringByDeletingLastPathComponent];
    [testServer startServerWithDocumentRoot:testDataDirectory];
    XCTAssertTrue(([testServer port] > 0), @"should have a port assigned");
    NSString *urlString=[NSString stringWithFormat:@"http://localhost:%u/%@",[testServer port],@"carlbrown.json"];
    NSURL *testURL=[NSURL URLWithString:urlString];
    NSError *error=nil;
    NSStringEncoding encoding;
    NSString *test_json_String=[NSString stringWithContentsOfURL:testURL usedEncoding:&encoding error:&error];
    XCTAssertNil(error, @"should not have gotten an error");
    XCTAssertNotNil(test_json_String, @"Should have gotten data back");
}

- (void)testAsyncExample
{
    NSString *testDataDirectory=[[[NSBundle bundleForClass:[self class]] pathForResource:@"carlbrown"
                                                                                  ofType:@"json"] stringByDeletingLastPathComponent];
    [testServer startServerWithDocumentRoot:testDataDirectory];
    XCTAssertTrue(([testServer port] > 0), @"should have a port assigned");
    NSString *urlString=[NSString stringWithFormat:@"http://localhost:%u/%@",[testServer port],@"carlbrown.json"];
    NSURL *testURL=[NSURL URLWithString:urlString];
    XCTestExpectation *expectation = [self expectationWithDescription:@"Fetcher Expectation"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:nil];
    NSURLSessionDownloadTask *fetcher = [session downloadTaskWithURL:testURL completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        XCTAssertNil(error, @"should not have gotten an error");
        XCTAssertNotNil(location, @"Should have gotten location of the data back");
        [expectation fulfill];

    }];
    [fetcher resume];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];

}


@end
