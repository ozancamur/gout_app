const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();

// EVENT
exports.newEventNotification = functions.firestore
    .document("event/{eventId}")
    .onCreate(async (snap, context) => {
      try {
        const {eventId} = context.params;
        const event = await db.collection("event").doc(eventId).get();
        const eventTitle = await event.get("eventTitle");
        const invitedList = snap.data().invited;
        invitedList.forEach(async (id) => {
          const user = await db.collection("user").doc(id).get();
          const token = await user.get("token");
          const payload = {
            notification: {
              title: "YOU INVITED A NEW EVENT",
              body: eventTitle,
              sound: "beep",
              channel_id: "gout-app",
              android_channel_id: "gout-app",
              priority: "high",
            },
          };
          return admin.messaging().sendToDevice(token, payload);
        });
        return true;
      } catch (e) {
        console.log("newEventNotification, ERROR => " + e);
        return true;
      }
    },
    );
// FRIEND
exports.newFriendNotification = functions.firestore
    .document("user/{userId}")
    .onUpdate(async (change, context) => {
      try {
        const {userId} = context.params;
        const user = await db.collection("user").doc(userId).get();
        const token = await user.get("token");
        const before = change.before.data().requests;
        const after = change.after.data().requests;
        after.forEach(async (id) => {
          if (before.includes(id) == false) {
            const request = await db.collection("user").doc(id).get();
            const nickname = await request.get("nickname");
            const payload = {
              notification: {
                title: "NEW FOLLOWER REQUEST",
                body: nickname + " is want to follow you.",
                sound: "beep",
                channel_id: "gout-app",
                android_channel_id: "gout-app",
                priority: "high",
              },
            };
            return admin.messaging().sendToDevice(token, payload);
          }
        });
        return true;
      } catch (e) {
        console.log("newFriendNotification, ERROR => " + e);
        return true;
      }
    },
    );
exports.yourRequestAccepted = functions.firestore
    .document("user/{userId}")
    .onUpdate(async (change, context) => {
      try {
        const {userId} = context.params;
        const user = await db.collection("user").doc(userId).get();
        const token = await user.get("token");
        const after = change.after.data().followers;
        const friendId = after[after.length-1];
        const friend = await db.collection("user").doc(friendId).get();
        const nickname = await friend.get("nickname");
        const payload = {
          notification: {
            title: "YOUR FOLLOW REQUEST ACCEPTED",
            body: "you can invite " + nickname + " to your events.",
            sound: "beep",
            channel_id: "gout-app",
            android_channel_id: "gout-app",
            priority: "high",
          },
        };
        return admin.messaging().sendToDevice(token, payload);
      } catch (e) {
        console.log("yourRequestAccepted, ERROR => " + e);
        return true;
      }
    });
/* eslint-disable eol-last */