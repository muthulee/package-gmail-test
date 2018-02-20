package samples.wso2.gmail;

import wso2.gmail;

function main (string[] args) {
    endpoint<gmail:ClientConnector> gMailConnector {
        create gmail:ClientConnector(args[1], args[2], args[3], args[4], args[5]);
    }

    gmail:Error e = {};

    if (args[0] == "getUserProfile") {
        println("-----Calling getUserProfile action-----");
        gmail:UserProfile gMailResponse = {};
        gMailResponse, e = gMailConnector.getUserProfile();
        if (e == null) {
            println(gMailResponse);
        } else {
            println(e);
        }
    }
}