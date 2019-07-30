class ModelAgent {
  /*
String agent_email, String agent_pwd, String device_num
    String agent_pass_code,
       */


  int id;
  String agentName, email;
  bool boolModelUpdated;
  String fcmToken;

  ModelAgent.named({this.fcmToken, this.id, this.agentName, this.boolModelUpdated = false,});

  @override
  String toString() {
    return 'ModelAgent{id: $id, email: $email, fcmToken: $fcmToken}';
  }


}