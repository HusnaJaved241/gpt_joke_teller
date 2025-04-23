import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _apiKey = "your api key";
  static const String _baseUrl = "https://v2.jokeapi.dev/joke/Any?safe-mode";

  static Future<String> fetchJoke() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['type'] == 'single') {
          return data['joke'];
        } else if (data['type'] == 'twopart') {
          return "${data['setup']}\n\n${data['delivery']}";
        } else {
          return "Unexpected joke format.";
        }
      } else {
        return "Failed to fetch joke. Status: ${response.statusCode}";
      }
      // final response = await http.post(
      //   Uri.parse(_baseUrl),
      //   headers: {
      //     'Authorization': 'Bearer $_apiKey',
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode({
      //     "model": "gpt-3.5-turbo",
      //     "messages": [
      //       {"role": "user", "content": "Tell me a short funny joke."},
      //     ],
      //   }),
      // );
      // if (response.statusCode == 200) {
      //   final Map<String, dynamic> data = json.decode(response.body);
      //   final String joke = data['choices'][0]['message']['content'];
      //   return joke.trim();
      // } else {
      //   return 'Failed to fetch joke: ${response.reasonPhrase}';
      // }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
