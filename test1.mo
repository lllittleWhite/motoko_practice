import Nat "mo:base/Bool";
import Text "mo:base/Text";

actor {
  public type HeaderField = (Text, Text);
  public type HttpRequest = {
    url : Text;
    method : Text;
    body : [Nat8];
    headers : [HeaderField];
  };
  public type HttpResponse = {
    body : Blob;
    headers : [HeaderField];
    streaming_strategy : ?StreamingStrategy;
    status_code : Nat16;
  };
  public type Key = Text;
  public type Path = Text;
  public type ChunkId = Nat;
  public type SetAssetContentArguments = {
    key : Key;
    sha256 : ?[Nat8];
    chunk_ids : [ChunkId];
    content_encoding : Text;
  };
  public type StreamingCallbackHttpResponse = {
    token : ?StreamingCallbackToken;
    body : [Nat8];
  };
  public type StreamingCallbackToken = {
    key : Text;
    sha256 : ?[Nat8];
    index : Nat;
    content_encoding : Text;
  };
  public type StreamingStrategy = {
    #Callback : {
      token : StreamingCallbackToken;
      callback : shared query StreamingCallbackToken -> async StreamingCallbackHttpResponse;
    };
  };

  public shared query func http_request(request: HttpRequest): async HttpResponse {
      var temp : Nat = 12;
      var show_string = "<html><body><h1>"# Nat.toText(temp) #"</h1></body></html>";
    {
      body = Text.encodeUtf8(show_string);
      headers = [];
      streaming_strategy = null;
      status_code = 200;
    }
  }
};

