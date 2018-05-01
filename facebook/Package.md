Connects to Facebook from Ballerina.

# Package Overview
The Facebook connector allows you to create retrieve and delete posts through the Facebook Graph API. It handles OAuth 2.0 authentication.

**Post Operations**

The `keerthu/facebook` package contains operations to create, get and delete posts.

## Compatibility

|                                 |       Version                  |
|  :---------------------------:  |  :---------------------------: |
|  Ballerina Language             |   0.970.0                      |
|  Facebook API                   |   v2.12                        |

## Sample

First, import the `keerthu/facebook` package into the Ballerina project.

```ballerina
import keerthu/facebook;
```

Instantiate the connector by giving authentication details in the HTTP client config. The HTTP client config has built-in support for BasicAuth and OAuth 2.0. Facebook uses OAuth 2.0 to authenticate and authorize requests. The Facebook connector can be instantiated in the HTTP client config using the access token.


**Obtaining Tokens to Run the Sample**

1. Setup a new web application client in the [Facebook APP console](https://developers.facebook.com/apps)
2. Obtain client_id, client_secret and register a callback URL.
3. Replace your client_id and redirect URI in the following URL and navigate to that URL in the browser. It will redirect you to a page allow the access with the required permission.
    `https://www.facebook.com/v2.12/dialog/oauth?client_id=<your_client_id>&redirect_uri=<your_redirect_uri>&scope=<scopes>`
4. After accepting the permission to allow access it will return a code in the url.
5. Send a post request to with the above code to the following endpoint to get the access_token. Replace your client_id, client_secret, redirect_uri, and code(retrieved from step4).
    `https://graph.facebook.com/oauth/access_token?client_id=<your_client_id>&redirect_uri=<your_redirect_uri>&client_secret=<your_client_secret>&code=<code>`
6. You will get a user access token in the response.
7. If you want to publish the post to a page you need to retrieve the page token by invoking the following endpoint:
    `https://graph.facebook.com/v2.12/me/accounts`
    Page token and page id will be returned in the response.

You can now enter the user token to publish a post in your facebook user account or page token to publish a post in a facebook page in the HTTP client config:
```ballerina
endpoint facebook:Client facebookEP {
    clientConfig:{
        auth:{
            accessToken:accessToken
        }
    }
};
```

The `createPost` function creates a post for a user, page, event, or group.
```ballerina
//Create post.
var response = facebookEP->createPost(id,message,link,place);
```

The response from `createPost` is a `Post` object if the request was successful or a `FacebookError` on failure. The `match` operation can be used to handle the response if an error occurs.
```ballerina
match response {
   //If successful, returns the Post object.
   facebook:Post fbRes => io:println(fbRes);
   //Unsuccessful attempts return a FacebookError.
   facebook:FacebookError err => io:println(err);
}
```

The `retrievePost` function retrieves the post specified by the ID. The `postId` represents the ID of the post to be retrieved. It returns the `Post` object on success and `FacebookError` on failure.
```ballerina
var fbRes = facebookEP.retrievePost(postId);
match fbRes {
    facebook:Post p => io:println(p);
    facebook:FacebookError e => io:println(e);
}
```

The `deletePost` function deletes the post specified by the ID. The `postId` represents the ID of the post to be deleted. It returns the `True` object on success and `FacebookError` on failure.
```ballerina
var fbRes = facebookEP.deletePost(postId);
match fbRes {
    boolean b => io:println(b);
    facebook:FacebookError e => io:println(e);
}
```
