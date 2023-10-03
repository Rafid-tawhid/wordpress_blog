import 'dart:convert';
import 'package:http/http.dart' as http;
class HelperFunction {

  static  Future<void> logout() async {
    final String apiUrl = 'https://dev.bitbirds.net/rafid/wp/v2/users/me/logout';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer <your_access_token>', // Replace with the access token
        },
        body: jsonEncode({}), // Empty JSON body
      );

      if (response.statusCode == 200) {
        // Successful logout
        print('User logged out successfully');
      } else {
        // Handle errors here
        print('Logout failed with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions here
      print('Error occurred: $e');
    }
  }
}