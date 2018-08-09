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

documentation {
    FacebookConfiguration is used to set up the Facebook configuration. In order to use this connector, you need
    to provide the valid access token.
    F{{clientConfig}} - The HTTP client congiguration
}
public type FacebookConfiguration record {
    http:ClientEndpointConfig clientConfig = {};
};

documentation {
    Facebook Endpoint object.
    E{{}}
    F{{facebookConfig}} - Facebook client endpoint configuration object
    F{{facebookConnector}} - Facebook connector object
}
public type Client object {

    public FacebookConfiguration facebookConfig = {};
    public FacebookConnector facebookConnector = new;

    documentation {
        Facebook endpoint initialization function
        P{{config}} - Facebook client endpoint configuration object
    }
    public function init(FacebookConfiguration config);

    documentation {
        Get Facebook connector client
        R{{}} - Facebook connector client
    }
    public function getCallerActions() returns FacebookConnector;
};

documentation {
    Facebook client connector
    F{{httpClient}} - The HTTP Client
}
public type FacebookConnector object {

    public http:Client httpClient = new;

    documentation {
        Create a new post
        P{{id}} - The identifier
        P{{msg}} - The main body of the post
        P{{link}} - The URL of a link to attach to the post
        P{{place}} - Page ID of a location associated with this post
        R{{}} - Post object on success and FacebookError on failure
    }
    public function createPost(string id, string msg, string link, string place) returns Post|FacebookError;

    documentation {
        Retrieve a post
        P{{postId}} - The post ID
        R{{}} - Post object on success and FacebookError on failure
    }
    public function retrievePost(string postId) returns Post|FacebookError;

    documentation {
        Delete a post
        P{{postId}} - The post ID
        R{{}} - True on success and FacebookError on failure
    }
    public function deletePost(string postId) returns (boolean)|FacebookError;

    documentation {
        Get the User's friends who have installed the app making the query
        Get the User's total number of friends (including those who have not installed the app making the query)
        P{{userId}} - The user ID
        R{{}} - FriendList object on success and FacebookError on failure
    }
    public function getFriendListDetails(string userId) returns FriendList|FacebookError;

    documentation {
        Get a list of all the Pages managed by that User, as well as a Page access tokens for each Page
        P{{userId}} - The user ID
        R{{}} - AccessTokens object on success and FacebookError on failure
    }
    public function getPageAccessTokens(string userId) returns AccessTokens|FacebookError;

};

documentation {
    Facebook error.
    F{{message}} - Error message.
    F{{cause}} - The error which caused the Facebook error.
    F{{statusCode}} - The status code.
}
public type FacebookError record {
    string message;
    error? cause;
    int statusCode;
};

documentation {
    Post object.
    F{{id}} - The post ID.
    F{{message}} - The status message in the post.
    F{{createdTime}} - The time the post was initially published.
    F{{updatedTime}} - The time when the Post was created, edited, or commented upon.
    F{{postType}} - A string indicating the object type of this post (link, status, photo, video, offer).
    F{{fromObject}} - Information (name and id) about the Profile that created the Post.
    F{{isPublished}} - Indicates whether a scheduled post was published (applies to scheduled Page Post
    only, for users post and instantly published posts this value is always true). Note that this value is
    always false
}
public type Post record {
    string id;
    string message;
    string createdTime;
    string updatedTime;
    string postType;
    Profile fromObject;
    boolean isPublished;
};

documentation {
    The profile object is used within the Graph API to refer to the generic type that includes all of these
     (User/Page/Group)other objects.
     F{{id}} - The object ID.
     F{{name}} - The object name.
}
public type Profile record {
    string id;
    string name;
};

documentation {
    Friend list object.
    F{{data}} - A list of User nodes.
    F{{summary}} - Aggregated information about the edge, such as counts.
}
public type FriendList record {
    Data[] data;
    Summary summary;
};

documentation {
    A user node.
    F{{id}} - The user ID.
    F{{name}} - The user name.
}
public type Data record {
    string id;
    string name;
};

documentation {
    A Summary object.
    F{{totalCount}} - Total number of objects on this edge.
}
public type Summary record {
    string totalCount;
};

documentation {
    Contains page accesstoken object.
    F{{data}} - AccessTokenData objects.
}
public type AccessTokens record {
    AccessTokenData[] data;
};

documentation {
    Contains page accesstoken details.
    F{{category}} - Product category.
    F{{pageName}} - Page name.
    F{{pageAccessToken}} - Page accessToken.
    F{{pageId}} - A page id.
}
public type AccessTokenData record {
    string category;
    string pageName;
    string pageAccessToken;
    string pageId;
};