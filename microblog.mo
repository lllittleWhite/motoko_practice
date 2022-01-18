import Blob "mo:base/Blob";
import Debug "mo:base/Debug";
import List "mo:base/List";
import Iter "mo:base/Iter";
import Principal "mo:base/Principal";
import Time "mo:base/Time";

actor {
  public type Message = {
      content : Text;
      time : Int;
  };

  public type Microblog = actor {
    follow: shared(Principal) -> async ();  // add subscribed object
    follows: shared query () -> async [Principal];  // return subscribed list
    post: shared (Text) -> async ();  // post new message
    posts: shared query (Time.Time) -> async [Message];  //return all posted messages
    timeline: shared () -> async [Message];  //return all messages that subscribed objects posted
  };

  stable var followed : List.List<Principal> = List.nil();

  public shared func follow(id: Principal) : async () {
    followed := List.push(id, followed);
  };

  public shared query func follows() : async [Principal] {
    List.toArray(followed);
  };

  stable var messages : List.List<Message> = List.nil();

  public shared func post(text: Text) : async () {
      var mesg = {
          content = text;
          time = Time.now();
      };

      messages := List.push(mesg, messages)
  };

  public shared query func posts(since: Time.Time) : async [Message] {
    var needMsgs : List.List<Message> = List.nil();

    for (msg in Iter.fromArray(List.toArray(messages))) {
      if (msg.time >= since) {
        needMsgs := List.push(msg,needMsgs);
      };
    };

    List.toArray(needMsgs)
  };

  public shared func timeline(since: Time.Time) : async [Message] {
    var all : List.List<Message> = List.nil();

    for (id in Iter.fromList(followed)) {
      let canister : Microblog = actor(Principal.toText(id));
      let msgs = await canister.posts(since); 
      for (msg in Iter.fromArray(msgs)) {
        all := List.push(msg,all)
      }
    };

    List.toArray(all)
  }

}
