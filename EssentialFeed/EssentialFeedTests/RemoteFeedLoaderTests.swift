//
//  Copyright © Essential Developer. All rights reserved.
//

import XCTest

class RemoteFeedLoader {

    func load() {
        HTTPClient.shared.get(from: URL(string: "https://a-url.com")!)
    }
}

//Singleton: This would be the production code
//Cons: requestedUrl is only used for testing
//Solved by Inheritance and override the function
class HTTPClient {
    static var shared = HTTPClient()
    
    func get(from url: URL){}
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?
    
    override func get(from url: URL) {
        requestedURL = url
    }
}



final class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
    
    func test_load_requestDataFromUrl() {
        let client = HTTPClientSpy()
        HTTPClient.shared = client
        let sut = RemoteFeedLoader()
        
        sut.load()
        
        XCTAssertNotNil(client.requestedURL)
    }

}
