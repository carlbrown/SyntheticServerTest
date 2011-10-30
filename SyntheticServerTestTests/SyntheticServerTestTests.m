
//
//  SyntheticServerTestTests.m
//  SyntheticServerTestTests
//
//  Created by Carl Brown on 10/29/11.
//  Copyright (c) 2011 PDAgent, LLC. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PDBackgroundHTTPServer.h"

@interface SyntheticServerTestTests : SenTestCase {
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
    [testServer release]; testServer=nil;
    
    [super tearDown];
}

- (void)testExample
{
    NSString *testDataDirectory=[[[NSBundle bundleForClass:[self class]] pathForResource:@"carlbrown"
											 ofType:@"json"] stringByDeletingLastPathComponent];
    [testServer startServerWithDocumentRoot:testDataDirectory];
    STAssertTrue(([testServer port] > 0), @"should have a port assigned");
    NSString *urlString=[NSString stringWithFormat:@"http://localhost:%u/%@",[testServer port],@"carlbrown.json"];
    NSURL *testURL=[NSURL URLWithString:urlString];
    NSError *error=nil;
    NSStringEncoding encoding;
    NSString *test_json_String=[NSString stringWithContentsOfURL:testURL usedEncoding:&encoding error:&error];
    STAssertNil(error, @"should not have gotten an error");
    STAssertNotNil(test_json_String, @"Should have gotten data back");
    
}

@end
