import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:demo_api/models/userViewModel.dart';

getUsersData(int displayData) async {
  var result = await http.get(
    "https://jsonplaceholder.typicode.com/todos",
  );
  var objectResult = json.decode(result.body);
  var userModelList = List<UserViewModel>();
  var cnt = 0;

  for (var item in objectResult) {
    if (cnt < displayData) {
      UserViewModel user = UserViewModel(
        completed: item['completed'],
        id: item['id'],
        title: item['title'],
        userId: item['userId'],
      );

      userModelList.add(user);
    }
    cnt++;
  }
  print(objectResult.length);
  return userModelList;

}
