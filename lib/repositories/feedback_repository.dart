import 'dart:convert';

import 'package:huddle_and_score/models/feedback.dart';
import 'package:http/http.dart' as http;

class FeedBackRepository {
  Future<void> sendFeedbackData(FeedBack feedBack) async {
    try {
      final String baseUrl =
          "https://asia-south1-huddleandscore-prod.cloudfunctions.net/openApis/feedback";
      var response = await http.post(Uri.parse(baseUrl),
          headers: {'Content-Type': 'Application/json'},
          body: jsonEncode(<String, dynamic>{
            'satisfied': feedBack.satisfied==0 || feedBack.satisfied==100 ? null : feedBack.satisfied,
            'chooseUs': null,
            'recommandOthers': feedBack.recommendOthers == 'Not at all'
                ? 'notAtAll'
                : feedBack.recommendOthers == 'May be'
                    ? 'mayBe'
                    : 'definetly',
            'comeToKnowUs': feedBack.comeToKnowUs=='' ? null : feedBack.comeToKnowUs,
            'suggestion': feedBack.suggestion=='' ? null : feedBack.suggestion,
          }));
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      print("Failed Feedback");
      print(e.toString());
    }
  }
}
