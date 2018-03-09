package samples.wso2.gmail;

import wso2.gmail;
import ballerina.io;

function main (string[] args) {
    endpoint<gmail:ClientConnector> gmailConnector {
        create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);
    }

    gmail:Error e = {};

    if (args[0] == "getUserProfile") {
        io:println("-----Calling getUserProfile action-----");
        gmail:UserProfile gmailResponse = {};
        gmailResponse, e = gmailConnector.getUserProfile();
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "sendEmail") {
        io:println("-----Calling sendEmail action-----");
        gmail:GmailAPI gmailResponse = {};
        gmail:Options options = {contentType:args[9], htmlBody:args[10]};
        gmail:Message sendEmail = {recipient:args[6], subject:args[7], body:args[8], options:options};
        gmailResponse, e = gmailConnector.sendEmail(sendEmail);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "createDraft") {
        io:println("-----Calling createDraft action-----");
        gmail:Draft gmailResponse = {};
        gmail:Options options = {contentType:args[9], htmlBody:args[10]};
        gmail:Message createDraft = {recipient:args[6], subject:args[7], body:args[8], options:options};
        gmailResponse, e = gmailConnector.createDraft(createDraft);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "update") {
        io:println("-----Calling update action-----");
        gmail:Draft gmailResponse = {};
        gmail:Options options = {contentType:args[10], htmlBody:args[11]};
        gmail:Message update = {recipient:args[7], subject:args[8], body:args[9], options:options};
        gmail:Draft draft = {id:args[6]};
        gmailResponse, e = gmailConnector.update(draft, update);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "send") {
        io:println("-----Calling send action-----");
        gmail:GmailAPI gmailResponse = {};
        string draftId = args[6];
        gmailResponse, e = gmailConnector.send(draftId);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    }  else if (args[0] == "getDrafts") {
        io:println("-----Calling getDrafts action-----");
        gmail:Drafts gmailResponse = {};
        gmail:DraftsListFilter getDrafts = {maxResults:args[6]};
        gmailResponse, e = gmailConnector.getDrafts(getDrafts);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    } else if (args[0] == "deleteDraft") {
        io:println("-----Calling deleteDraft action-----");
        gmail:StatusCode gmailResponse = {};
        gmail:Draft draft = {id:args[6]};
        gmailResponse, e = gmailConnector.deleteDraft(draft);
        if (e.errorMessage == null) {
            io:println(gmailResponse);
        } else {
            io:println(e);
        }
    }
}