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

package wso2.gmail;

public struct UserProfile {
    string emailAddress;
    int messagesTotal;
    int threadsTotal;
    string historyId;
}

public struct Message {
    string recipient;
    string subject;
    string body;
    Options options;
}

public struct Options {
    string contentType;
    string htmlBody;
    string from;
    string cc;
    string bcc;
}

public struct Header {
    string name;
    string value;
}

public struct Parts {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
}

public struct Body {
    string attachmentId;
    int size;
    string data;
}

public struct MessagePayload {
    string partId;
    string mimeType;
    string filename;
    Header[] headers;
    Body body;
    Parts[] parts;
}

public struct GmailAPI {
    string id;
    string threadId;
    string[] labelIds;
    string snippet;
    string historyId;
    string internalDate;
    MessagePayload payload;
    int sizeEstimate;
}

public struct Draft {
    string id;
    GmailAPI message;
}

public struct Drafts {
    Draft[] drafts;
    int resultSizeEstimate;
    string nextPageToken;
}

public struct DraftsListFilter {
    string includeSpamTrash;
    string maxResults;
    string pageToken;
    string q;
}

public struct Error {
    json errorMessage;
}

public struct StatusCode {
    int statusCode;
    string reasonPhrase;
}
