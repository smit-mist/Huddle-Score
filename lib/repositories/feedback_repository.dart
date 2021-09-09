import 'dart:convert';

import 'package:huddle_and_score/models/feedback.dart';
import 'package:http/http.dart' as http;

class FeedBackRepository {
  Future<void> sendFeedbackData(FeedBack feedBack) async {
    try {
      final String baseUrl =
          "https://us-central1-football-demo-3a80e.cloudfunctions.net/openApis/feedback";
      var response = await http.post(Uri.parse(baseUrl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode(<String, dynamic>{
            'satisfied': feedBack.satisfied,
            'chooseUs': feedBack.chooseUs,
            'recommandOthers': feedBack.recommendOthers,
            'comeToKnowUs': feedBack.comeToKnowUs,
            'suggestion': feedBack.suggestion,
          }));
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print("Failed Feedback");
      print(e.toString());
    }
  }
}
