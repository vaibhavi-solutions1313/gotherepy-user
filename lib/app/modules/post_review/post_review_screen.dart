import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:gotherepy/app/app_constants/constants_end_points.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class PostReviewScreen extends StatelessWidget {
  final TextEditingController reviewController = TextEditingController();
  double userrating = 1;
  String doctorid='';
  @override
  Widget build(BuildContext context) {
    // getthepassedargument
    String doctorid = Get.arguments ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Post Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Rate this profile:',
              style: TextStyle(fontSize: 18),
            ),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
                userrating = rating;
              },
            ),
            SizedBox(height: 20),
            Text(
              'Write a review:',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              controller: reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Type your review here...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                postReview(context);
              },
              child: Text('Post Review'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> postReview(BuildContext context) async {
    final url = Uri.parse(
        'http://gotherapy.care/backend/public/api/user/submit-ratings');

    // Replace these values with your actual data
    final Map<String, String> data = {
      'ratings': userrating.toString(), // Replace with the actual rating
      'doctor_id': doctorid, // Replace with the actual doctor ID
      'review': reviewController.text, // Get review text from the controller
    };

    try {
      final response = await http.post(
        url,
        headers: {'Authorization': 'Bearer ${EndPoints.accessToken}'},
        body: data,
      );

      if (response.statusCode == 200) {
        // Successful request, handle the response accordingly
        Navigator.of(context).pop();
      
        showToast("Rating Submitted Successfully ${doctorid}'");
      } else {
        // Request failed, handle the error
        print('Failed to post review. Status code: ${response.statusCode}');
        showToast(
            "Failed to submit rating. Status code: ${response.statusCode}");
      }
    } catch (e) {
      // Handle any other exceptions that may occur
      print('Error: $e');
      showToast("Error: $e");
    }
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
    );
  }
}
