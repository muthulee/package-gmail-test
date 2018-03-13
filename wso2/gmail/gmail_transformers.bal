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

transformer <json jsonUserProfile, UserProfile userProfile> userProfileTrans() {
    userProfile.emailAddress = jsonUserProfile.emailAddress.toString();
    userProfile.messagesTotal, _ = <int>jsonUserProfile.messagesTotal.toString();
    userProfile.threadsTotal, _ = <int>jsonUserProfile.threadsTotal.toString();
    userProfile.historyId = jsonUserProfile.historyId.toString();
}

transformer <json jsonMessage, Message message> messageTrans() {
    message.recipient = jsonMessage.to.toString();
    message.subject = jsonMessage.subject.toString();
    message.body = jsonMessage.messageBody.toString();
    message.options = jsonMessage.options != null?<Options, optionsTrans()>jsonMessage.options:{};
}

transformer <json jsonMessage, Options options> optionsTrans() {
    options.contentType = jsonMessage.contentType.toString();
    options.htmlBody = jsonMessage.htmlBody.toString();
    options.from = jsonMessage.from.toString();
    options.cc = jsonMessage.cc.toString();
    options.bcc = jsonMessage.bcc.toString();
}

transformer <json jsonHeader, Header header> headerTrans() {
    header.name = jsonHeader.name.toString();
    header.value = jsonHeader.value.toString();
}

transformer <json jsonParts, Parts parts> partsTrans() {
    parts.partId = jsonParts.partId.toString();
    parts.mimeType = jsonParts.mimeType.toString();
    parts.filename = jsonParts.filename.toString();
    parts.headers = jsonParts.headers != null?getHeaders(jsonParts.headers):[];
    parts.body = jsonParts.body != null?<Body, bodyTrans()>jsonParts.body:{};
}

transformer <json jsonBody, Body body> bodyTrans() {
    body.attachmentId = jsonBody.attachmentId.toString();
    body.size, _ = <int>jsonBody.size.toString();
    body.data = jsonBody.data.toString();
}

transformer <json jsonMessagePayload, MessagePayload messagePayload> messagePayloadTrans() {
    messagePayload.partId = jsonMessagePayload.partId.toString();
    messagePayload.mimeType = jsonMessagePayload.mimeType.toString();
    messagePayload.filename = jsonMessagePayload.filename.toString();
    messagePayload.headers = jsonMessagePayload.headers != null?getHeaders(jsonMessagePayload.headers):[];
    messagePayload.body = jsonMessagePayload.body != null?<Body, bodyTrans()>jsonMessagePayload.body:{};
    messagePayload.parts = jsonMessagePayload.parts != null?getParts(jsonMessagePayload.parts):[];
}

transformer <json jsonGmailAPI, GmailAPI gmailAPI> gmailAPITrans() {
    gmailAPI.id = jsonGmailAPI.id.toString();
    gmailAPI.threadId = jsonGmailAPI.threadId.toString();
    gmailAPI.labelIds = jsonGmailAPI.labelIds != null?getLabelIds(jsonGmailAPI.labelIds):[];
    gmailAPI.snippet = jsonGmailAPI.snippet != null?jsonGmailAPI.snippet.toString():null;
    gmailAPI.historyId = jsonGmailAPI.historyId != null?jsonGmailAPI.historyId.toString():null;
    gmailAPI.internalDate = jsonGmailAPI.internalDate != null?jsonGmailAPI.internalDate.toString():null;
    gmailAPI.payload = jsonGmailAPI.payload != null?<MessagePayload, messagePayloadTrans()>jsonGmailAPI.payload:{};
    gmailAPI.sizeEstimate = jsonGmailAPI.sizeEstimate != null?<int, convertToInt()>jsonGmailAPI.sizeEstimate:0;
}

transformer <json jsonDraft, Draft draft> draftTrans() {
    draft.id = jsonDraft.id.toString();
    draft.message = jsonDraft.message != null?<GmailAPI, gmailAPITrans()>jsonDraft.message:{};
}

transformer <json jsonDrafts, Drafts drafts> draftsTrans() {
    drafts.drafts = getDrafts(jsonDrafts.drafts);
    drafts.resultSizeEstimate = jsonDrafts.resultSizeEstimate != null?<int, convertToInt()>jsonDrafts.resultSizeEstimate:0;
    drafts.nextPageToken = jsonDrafts.nextPageToken != null?jsonDrafts.nextPageToken.toString():null;
}

transformer <json jsonDraftsListFilter, DraftsListFilter draftsListFilter> draftsListFilterTrans() {
    draftsListFilter.includeSpamTrash = jsonDraftsListFilter.includeSpamTrash != null?jsonDraftsListFilter.includeSpamTrash.toString():null;
    draftsListFilter.maxResults = jsonDraftsListFilter.maxResults != null?jsonDraftsListFilter.maxResults.toString():null;
    draftsListFilter.pageToken = jsonDraftsListFilter.pageToken != null?jsonDraftsListFilter.pageToken.toString():null;
    draftsListFilter.q = jsonDraftsListFilter.q != null?jsonDraftsListFilter.q.toString():null;
}

transformer <json jsonStatusCode, StatusCode statusCode> statusCodeTrans() {
    statusCode.statusCode, _ = <int>jsonStatusCode.statusCode.toString();
    statusCode.reasonPhrase = jsonStatusCode.reasonPhrase.toString();
}

transformer <json jsonVal, int intVal> convertToInt() {
    intVal, _ = (int)jsonVal;
}
