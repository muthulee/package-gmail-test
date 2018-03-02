package samples.wso2.gmail;

import wso2.gmail;

function main (string[] args) {
    endpoint<gmail:ClientConnector> gmailConnector {
        create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);
    }

    gmail:Error e = {};

    if (args[0] == "getUserProfile") {
        println("-----Calling getUserProfile action-----");
        gmail:UserProfile gmailResponse = {};
        gmailResponse, e = gmailConnector.getUserProfile();
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    } else if (args[0] == "sendMail") {
        println("-----Calling sendMail action-----");
        gmail:GmailAPI gmailResponse = {};
        gmail:Message sendMail = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"sendMail"};
        gmailResponse, e = gmailConnector.sendMail(sendMail);
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    } else if (args[0] == "createDraft") {
        println("-----Calling createDraft action-----");
        gmail:Draft gmailResponse = {};
        gmail:Message createDraft = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"createDraft"};
        gmailResponse, e = gmailConnector.createDraft(createDraft);
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    } else if (args[0] == "update") {
        println("-----Calling update action-----");
        gmail:Draft gmailResponse = {};
        gmail:Message update = {to:"janani22thangavel@gmail.com", subject:"Testing", messageBody:"update"};
        string draftId = args[6];
        gmailResponse, e = gmailConnector.update(draftId, update);
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    } else if (args[0] == "deleteDraft") {
        println("-----Calling deleteDraft action-----");
        gmail:StatusCode gmailResponse = {};
        string draftId = args[6];
        gmailResponse, e = gmailConnector.deleteDraft(draftId);
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    } else if (args[0] == "listDrafts") {
        println("-----Calling listDrafts action-----");
        gmail:Drafts gmailResponse = {};
        gmail:DraftsListFilter listDrafts = {maxResults:"3"};
        gmailResponse, e = gmailConnector.listDrafts(listDrafts);
        if (e.errorMessage == null) {
            println(gmailResponse);
        } else {
            println(e);
        }
    }
}