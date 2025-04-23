import 'package:flutter/material.dart';
import 'package:gpt_joke_teller/services/openAI_service.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _joke = 'Press the button to get the joke';

  void _getJoke() async {
    setState(() {
      _joke = "Fetching Joke...";
    });
    final joke = await OpenAIService.fetchJoke();
    setState(() {
      _joke = joke;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/navy_blue_bg.jpg', fit: BoxFit.cover),
          ),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'GPT-Powered Joke Generator',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                    color: Colors.black.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _joke,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _getJoke,
                    child: Text('Tell me a Joke'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
