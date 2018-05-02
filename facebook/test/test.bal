// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/config;
import ballerina/io;
import ballerina/test;

string accessToken = config:getAsString("ACCESS_TOKEN");

endpoint Client facebookClient {
    clientConfig:{
        auth:{
            accessToken:accessToken
        }
    }
};

Post fbPost = {};

@test:Config
function testCreatePost() {
    io:println("-----------------Test case for createPost method------------------");
    var fbRes = facebookClient->createPost("me","testBalMessage","","");
    match fbRes {
        Post post => fbPost = post;
        FacebookError e => test:assertFail(msg = e.message);
    }
    test:assertNotEquals(fbPost.id, null, msg = "Failed to create post");
}

@test:Config {
    dependsOn:["testCreatePost"]
}
function testRetrievePost() {
    io:println("-----------------Test case for retrievePost method------------------");
    var fbRes = facebookClient->retrievePost(fbPost.id);
    match fbRes {
        Post post => test:assertNotEquals(post.id, null, msg = "Failed to retrieve the post");
        FacebookError e => test:assertFail(msg = e.message);
    }
}

@test:Config {
    dependsOn:["testRetrievePost"]
}
function testDeletePost() {
    io:println("-----------------Test case for deletePost method------------------");
    var fbRes = facebookClient->deletePost(fbPost.id);
    match fbRes {
        boolean isDeleted => test:assertTrue(isDeleted, msg = "Failed to delete the post!");
        FacebookError e => test:assertFail(msg = e.message);
    }
}
