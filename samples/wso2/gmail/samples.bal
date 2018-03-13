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

package samples.wso2.gmail;

import wso2.gmail;
import ballerina.io;

function main (string[] args) {
    endpoint<gmail:ClientConnector> gmailConnector {
        create gmail:ClientConnector(args[0], args[1], args[2], args[3], args[4]);
    }

    gmail:Error e = {};

    gmail:Draft createDraftResponse = {};
    gmail:GmailAPI sendEmailResponse = {};
    gmail:Drafts getDraftsResponse = {};
    gmail:Draft updateResponse = {};
    gmail:StatusCode deleteDraftResponse = {};

    gmail:Options options = {contentType:args[8], htmlBody:args[9]};
    gmail:Message createDraftParams = {recipient:args[5], subject:args[6], body:args[7], options:options};
    createDraftResponse, e = gmailConnector.createDraft(createDraftParams);
    io:println("-----Calling createDraft action-----\n");
    if (e.errorMessage == null) {
        io:println(createDraftResponse);
    } else {
        io:println(e);
    }

    gmail:Message sendEmailParams = {recipient:args[5], subject:"TestSend", body:args[7], options:options};
    sendEmailResponse, e = gmailConnector.sendEmail(sendEmailParams);
    io:println("-----Calling sendEmail action-----\n");
    if (e.errorMessage == null) {
        io:println(sendEmailResponse);
    } else {
        io:println(e);
    }

    gmail:DraftsListFilter getDraftsParams = {maxResults:args[10]};
    getDraftsResponse, e = gmailConnector.getDrafts(getDraftsParams);
    io:println("-----Calling getDrafts action-----\n");
    if (e.errorMessage == null) {
        io:println(getDraftsResponse);

        gmail:Message updateParams = {recipient:args[5], subject:"UpdateSub", body:args[7], options:options};
        gmail:Draft draft = {id:getDraftsResponse.drafts[0].id};
        updateResponse, e = gmailConnector.update(draft, updateParams);
        io:println("-----Calling update action-----\n");
        if (e.errorMessage == null) {
            io:println(updateResponse);
            deleteDraftResponse, e = gmailConnector.deleteDraft({id:updateResponse.id});
            io:println("-----Calling deleteDraft action-----\n");
            if (e.errorMessage == null) {
                io:println(deleteDraftResponse);
            } else {
                io:println(e);
            }
        } else {
            io:println(e);
        }
    } else {
        io:println(e);
    }
}

//function main (string[] args) {
//    endpoint<gmail:ClientConnector> gmailConnector {
//        create gmail:ClientConnector(args[0], args[1], args[2], args[3], args[4]);
//    }
//    gmail:Error e = {};
//
//    gmail:Draft createDraftResponse = {};
//    gmail:GmailAPI sendEmailResponse = {};
//    gmail:Drafts getDraftsResponse = {};
//    gmail:Draft updateResponse = {};
//    gmail:StatusCode deleteDraftResponse = {};
//
//    gmail:Options options = {contentType:text/html, htmlBody:"<h1> Meeting Room </h1> <b> Hanthana </b>"};
//    gmail:Message createDraftParams = {recipient:"sam@example.com", subject:"Meeting Notes", body:null, options:options};
//    createDraftResponse, e = gmailConnector.createDraft(createDraftParams);
//
//    gmail:Message sendEmailParams = {recipient:"ram@example.com", subject:"Meeting", body:"", options:options};
//    sendEmailResponse, e = gmailConnector.sendEmail(sendEmailParams);
//
//    gmail:DraftsListFilter getDraftsParams = {maxResults:1};
//    getDraftsResponse, e = gmailConnector.getDrafts(getDraftsParams);
//
//    gmail:Message updateParams = {recipient:"sam@example.com", subject:"Meeting Notes", body:"Put struct in new file", options:{}};
//    gmail:Draft draft = {id:getDraftsResponse.drafts[0].id};
//    updateResponse, e = gmailConnector.update(draft, updateParams);
//
//    deleteDraftResponse, e = gmailConnector.deleteDraft({id:updateResponse.id});
//    io:println(deleteDraftResponse);
//}
