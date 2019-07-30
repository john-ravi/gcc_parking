import 'package:gcc_parking/models/model_agent.dart';
import 'package:gcc_parking/utils/appConstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future setUserPrefs(ModelAgent modelUser, String text) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(LOGGED_IN, true);
  print(prefs.getBool(LOGGED_IN) ?? false);
  prefs.setInt(USER_ID, modelUser.id);
  print(prefs.getBool(LOGGED_IN) ?? false);

  prefs.setString(CURRENT_USER, text);
  print(prefs.getString(CURRENT_USER));
}

Future<ModelAgent> getAgentFromPrefs() async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userId = prefs.getInt(USER_ID);
  ModelAgent modelAgent;
  if(userId != null) {
  modelAgent = ModelAgent.named(id: userId, boolModelUpdated:  true);
  } else {
  modelAgent = ModelAgent.named(boolModelUpdated:  false);
  }
  return modelAgent;
}
