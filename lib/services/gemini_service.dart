import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:schedule_app/models/tasks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static const String _baseUrl = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";
  final String apiKey;
  GeminiService() : apiKey = dotenv.env["GEMINI_API_KEY"] ?? "";
  Future<String> generateSchedule(List<Task> tasks) async {
    _validateSchedule(tasks);
    final prompt = _buildPrompt(tasks);
    try{
      print("Prompt: \n$prompt");
      final response = await http.post(
        Uri.parse("$_baseUrl?key=apiKey"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "contents": [{
            "role": "user",
            "parts":[{
              "text": prompt
            }]
          }],
        }),
      );
      return _handleResponse(response);
    }catch(e){
      throw ArgumentError("Failed to generate schedule: $e");
    }
  }
  String _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);
    if(response.statusCode == 401){
      throw ArgumentError("Invalid API key or unauthorized akses");
    }else if (response.statusCode == 429) {
      throw ArgumentError("Rate limit exceeded");
    } else if (response.statusCode == 500){
      throw ArgumentError("Internal server error");
    } else if (response.statusCode == 503){
      throw ArgumentError("Service unavailable");
    } else if (response.statusCode == 200) {
      return data["contents"][0]["parts"][0]["text"];
    } else {
      throw ArgumentError("Unknown error");
    }
  }
  String _buildPrompt(List<Task> tasks){
    final tasksList = tasks.map((task) => "$task.name (Priority: ${task.priority}, Duration: ${task.duration} menute, Deadline: ${task.deadline})").join("\n");
    return "buatin lee, jadwal yang optimal berdasarkan task berikut:\n$tasksList";
  }
  void _validateSchedule(List<Task> tasks) {
    if(tasks.isEmpty) throw ArgumentError("Tasks can't be empty");
  }
}