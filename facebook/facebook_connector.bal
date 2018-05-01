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

import ballerina/mime;
import ballerina/http;

documentation {Facebook client connector
    F{{httpClient}} - The HTTP Client
}
public type FacebookConnector object {
    public {
        http:Client httpClient = new;
    }

    documentation {Create a new post
        P{{id}} - The identifier
        P{{msg}} - The main body of the post
        P{{link}} - The URL of a link to attach to the post
        P{{place}} - Page ID of a location associated with this post
        R{{}} - Post object on success and FacebookError on failure
    }
    public function createPost(string id, string msg, string link, string place) returns Post|FacebookError;

    documentation {Retrieve a post
        P{{postId}} - The post ID
        R{{}} - Post object on success and FacebookError on failure
    }
    public function retrievePost(string postId) returns Post|FacebookError;

    documentation {Delete a post
        P{{postId}} - The post ID
        R{{}} - True on success and FacebookError on failure
    }
    public function deletePost(string postId) returns (boolean)|FacebookError;

};

public function FacebookConnector::createPost(string id, string msg, string link, string place)
                                                    returns Post|FacebookError {
    endpoint http:Client httpClient = self.httpClient;
    http:Request request = new;
    FacebookError facebookError = {};
    Post fbPost = {};
    string facebookPath = VERSION + PATH_SEPARATOR + id + FEED_PATH;
    string uriParams;
    uriParams = msg != EMPTY_STRING ? MESSAGE + check http:encode(msg, UTF_8) : uriParams;
    uriParams = link != EMPTY_STRING ? LINK + check http:encode(link, UTF_8) : uriParams;
    uriParams = place != EMPTY_STRING ? PLACE + check http:encode(place, UTF_8) : uriParams;
    facebookPath = facebookPath + QUESTION_MARK + uriParams.substring(1, uriParams.length());
    request.setHeader("Accept", "application/json");
    var httpResponse = httpClient->post(facebookPath, request = request);
    match httpResponse {
        error err => {
            facebookError.message = err.message;
            facebookError.cause = err.cause;
            return facebookError;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var facebookJSONResponse = response.getJsonPayload();
            match facebookJSONResponse {
                error err => {
                    facebookError.message = "Error occured while extracting Json Payload";
                    facebookError.cause = err.cause;
                    return facebookError;
                }
                json jsonResponse => {
                    if (statusCode == http:OK_200) {
                        fbPost = convertToPost(jsonResponse);
                        return fbPost;
                    } else {
                        facebookError.message = jsonResponse.error.message.toString();
                        facebookError.statusCode = statusCode;
                        return facebookError;
                    }
                }
            }
        }
    }
}

public function FacebookConnector::retrievePost(string postId) returns Post|FacebookError {
    endpoint http:Client httpClient = self.httpClient;
    http:Request request = new;
    FacebookError facebookError = {};
    Post fbPost = {};
    string facebookPath = VERSION + PATH_SEPARATOR + postId;
    request.setHeader("Accept", "application/json");
    var httpResponse = httpClient->get(facebookPath, request = request);
    match httpResponse {
        error err => {
            facebookError.message = err.message;
            facebookError.cause = err.cause;
            return facebookError;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var facebookJSONResponse = response.getJsonPayload();
            match facebookJSONResponse {
                error err => {
                    facebookError.message = "Error occured while extracting Json Payload";
                    facebookError.cause = err.cause;
                    return facebookError;
                }
                json jsonResponse => {
                    if (statusCode == http:OK_200) {
                        fbPost = convertToPost(jsonResponse);
                        return fbPost;
                    } else {
                        facebookError.message = jsonResponse.error.message.toString();
                        facebookError.statusCode = statusCode;
                        return facebookError;
                    }
                }
            }
        }
    }
}

    public function FacebookConnector::deletePost(string postId) returns (boolean)|FacebookError {
    endpoint http:Client httpClient = self.httpClient;
    http:Request request = new;
    FacebookError facebookError = {};
    Post fbPost = {};
    string facebookPath = VERSION + PATH_SEPARATOR + postId;
    request.setHeader("Accept", "application/json");
    var httpResponse = httpClient->get(facebookPath, request = request);
    match httpResponse {
        error err => {
            facebookError.message = err.message;
            facebookError.cause = err.cause;
            return facebookError;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var facebookJSONResponse = response.getJsonPayload();
            match facebookJSONResponse {
                error err => {
                    facebookError.message = "Error occured while extracting Json Payload";
                    facebookError.cause = err.cause;
                    return facebookError;
                }
                json jsonResponse => {
                    if (statusCode == http:OK_200) {
                        return true;
                    } else {
                        facebookError.message = jsonResponse.error.message.toString();
                        facebookError.statusCode = statusCode;
                        return facebookError;
                    }
                }
            }
        }
    }
}
