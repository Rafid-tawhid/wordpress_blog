import 'dart:convert';
import 'package:http/http.dart' as http;


class RequestClass{
  static Future<String> uploadImageToWordPress(String base64Image) async {
    final String apiUrl = 'https://your-wordpress-site.com/wp-json/wp/v2/media';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_ACCESS_TOKEN', // Replace with your authentication method
      },
      body: json.encode({
        'file': base64Image,
        // You can add additional parameters or metadata here if needed
      }),
    );

    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final imageUrl = responseData['source_url'];
      return imageUrl;
    } else {
      throw Exception('Failed to upload image to WordPress');
    }
  }


  static Future<List<dynamic>> fetchBlogPosts() async {
    final response = await http.get(Uri.parse('https://dev.bitbirds.net/rafid/wp-json/wp/v2/posts'));

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error as needed.
      throw Exception('Failed to load blog posts');
    }
  }
}