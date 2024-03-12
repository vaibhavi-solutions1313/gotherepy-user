import 'package:flutter/material.dart';
import 'package:gotherepy/app/appWidgets/appButtons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../app_model/conversation.dart';

class UserProfileView extends StatefulWidget {
  final Results? therapist;
  const UserProfileView({this.therapist, Key? key}) : super(key: key);
  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 5.sp),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25.sp),
                      child: Container(
                        width: 35.sp,
                        height: 35.sp,
                        color: Colors.blue,
                        child: Center(child: Text("P")),
                      ),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "John DOE",
                              style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Counselling Psychologist",
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.black54),
                            ),
                            Row(
                              children: List.generate(
                                  5,
                                      (index) => Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 17.sp,
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                          border: Border.all(width: 1.5, color: Colors.green.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.sp)),
                      child: const Icon(
                        Icons.notifications,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          border: Border.all(width: 1.5, color: Colors.orange.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.sp)),
                      child: Icon(
                        Icons.query_stats,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Text(
                      "250 Sessions",
                      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                    ),
                    SizedBox(
                      width: 15.sp,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.sp),
                      decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          border: Border.all(width: 1.5, color: Colors.orange.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(25.sp)),
                      child: Icon(
                        Icons.backpack,
                        color: Colors.orange,
                      ),
                    ),
                    SizedBox(
                      width: 10.sp,
                    ),
                    Text(
                      "1 yrs experience",
                      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
                    ),
                  ],
                ),

                // CHAT AND BOOK SESSION VIEW BELOW
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.sp),
                  child: Container(
                    padding: EdgeInsets.all(15.sp),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12.sp),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 15.sp,
                                      ),
                                      Text(
                                        "Chat",
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Connect with john doe for instant guidance.",
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "Starting at",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "\$90",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: Colors.orange,
                                      ),
                                      SizedBox(
                                        width: 15.sp,
                                      ),
                                      Text(
                                        "Book Session",
                                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Book a personal audio/video session for in-depth guidance.",
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "45mins",
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "\$1000",
                                    style: TextStyle(fontWeight: FontWeight.w600, color: Colors.orange),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // WHAT CAN YOU ASK ME VIEW BELOW
                Text(
                  "What can you ask me",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.format_quote_outlined,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Expanded(
                            child: Text(
                              "How do i manage my emotions and thoughts?",
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 10.sp,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.format_quote_outlined,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Expanded(
                            child: Text(
                              "How do i achieve a better work-life balance and manage stress?",
                              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  "Who can reach out to me",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Wrap(
                  children: [
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Students",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Young Adults",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Working Professionals",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Teenagers",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Job Aspirants",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Married Couples",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                    Container(
                        margin: EdgeInsets.all(8.sp),
                        decoration: BoxDecoration(color: Colors.orange.withOpacity(0.2), borderRadius: BorderRadius.circular(12.sp)),
                        padding: EdgeInsets.all(10.sp),
                        child: Text(
                          "Parents",
                          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.orange),
                        )),
                  ],
                ),
                SizedBox(
                  height: 15.sp,
                ),
                Text(
                  "Who can I help you achieve",
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.border_inner_rounded,
                            color: Colors.black38,
                          ),
                          Text(
                            "Emotional \nBalance",
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 25.sp,
                      width: 2.sp,
                      color: Colors.black38,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cruelty_free,
                            color: Colors.black38,
                          ),
                          Text(
                            "Trauma \nBalance",
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 25.sp,
                      width: 2.sp,
                      color: Colors.black38,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.heart_broken,
                            color: Colors.black38,
                          ),
                          Text(
                            "Relationship Problems",
                            style: TextStyle(color: Colors.black87),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
              minChildSize: 0.1,
              maxChildSize: 0.3,
              initialChildSize: 0.12,
              builder: (context, controller) {
                return Container(
                  padding: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.sp))
                  ),
                  child: Row(
                    children: [
                      Expanded(child: BorderButton(buttonText: 'Book', onClick: (){},)),
                      SizedBox(width: 6.0,),
                      Expanded(child: CustomSolidButton(buttonText: 'Chat', onClick: () {  },)),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }
}
