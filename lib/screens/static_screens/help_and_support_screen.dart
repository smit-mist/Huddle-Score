import 'package:flutter/material.dart';

import '../../constants.dart';

class HelpAndSupportScreen extends StatefulWidget {
  @override
  _HelpAndSupportScreenState createState() => _HelpAndSupportScreenState();
}

class _HelpAndSupportScreenState extends State<HelpAndSupportScreen> {
  bool ok = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25),
          width: w,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Help & Support',
                  style: themeFont(color: kThemeColor, s: 23),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Find answers from our support team or get in touch with us via support@huddleandscore.com',
                  style: themeFont(),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'About Huddle & Score',
                  style: themeFont(s: 15),
                ),
                Field(
                  ans:
                      'Huddle & Score is a digital connectivity platform wherein we facilitate a sports booking platform for turfs and tournaments amongst other services. We are the bridge between the owners/organizers and the players. With us, discover new turfs and tournaments around you, and book yourself a slot to play both casual games, and prize-winning tournaments.',
                  ques: 'What is Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is based out of Ahmedabad, India. However, our services are rendered pan India.',
                  ques: 'Where are we from?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Huddle & Score is not for just professionals, but for anyone who wishes to enjoy a game of… well, any sport at all.',
                  ques: 'Who is Huddle & Score for?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'We bridge the gap between players and the game with an easy booking destination with multiple options, to ensure your convenience.',
                  ques: 'What do we do?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'We are a hassle-free platform providing seamless and safe booking services. Huddle & Score offers authenticity and transparency that ensures trust.',
                  ques: 'Are there any benefits to registering with Huddle & Score?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Profile Information',
                  style: themeFont(s: 15),
                ),
                Field(
                  ans:
                      'Apart from your photograph, any details like your name can be altered.',
                  ques: 'Can i edit my profile details?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'No, you cannot link 1 Huddle & Score account with 2 email addresses.',
                  ques: 'Can I register with a different email address?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'It is always a good idea to carry your ID when going to a booked turf/tournament. However, the compulsory requirements change as per every turf/tournament. Please check “Download Terms & Conditions” for specific requirements of each tournament/turf before your match.',
                  ques: 'Do I need to carry identification for playing?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                  'Once registered for the tournament, you will be unable to change your personal details. We suggest that you thoroughly review your details before submitting.',
                  ques: 'Can I change my details once I have registered for a tournament?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Registration Information',
                  style: themeFont(s: 15),
                ),
                Field(
                  ans:
                      'Currently, Huddle & Score offers services in Ahmedabad. We will soon be coming to other cities of India.'
                      '\nIf you are a turf owner or a tournament organizer, we welcome you to list your turf/tournament with us.',
                  ques: 'In what cities are your services available?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'No, cancellation of bookings/registrations is not permissible.',
                  ques: 'Can I cancel my booking/registration?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'No, it is not possible for you to register in the same tournament twice.',
                  ques: 'Can I register more than once in the same tournament?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'No, registration for a tournament cannot be transferred to another person or user of Huddle & Score.',
                  ques: 'Can my registration be transferred to someone else?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'The “My Bookings”  section on the app and the website will reflect all your bookings. Huddle & Score also sends confirmation through Email.',
                  ques: 'Where can I find my booking receipt/confirmation?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'In the event of cancellation of a tournament, all refund related formalities of that specific tournament will be taken care of by the organizer of the tournament. For further clarification, it is advised to contact the organizer directly.',
                  ques: 'What if the tournament gets cancelled?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Payments & Refunds',
                  style: themeFont(s: 15),
                ),
                Field(
                  ans:
                      'We offer payment options like Credit/Debit Cards, UPI, and Net Banking. To ensure a secure and seamless payment system, we do not accept cash payments.',
                  ques: 'Can I make a payment through cash?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Razorpay is the secure payment gateway that Huddle & Score employs. Yes, it is completely safe.',
                  ques: 'What is Razorpay? Is it safe?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                Field(
                  ans:
                      'Well, that’s not great. Try cross-referencing your card details or your UPI details. You may have entered incorrect information. If that does not work, then we suggest that you use another payment method.',
                  ques: 'Why is my payment not going through?',
                  val: ok,
                  onPressed: (bool nw) {
                    setState(() {
                      ok = nw;
                    });
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Field extends StatefulWidget {
  String ques, ans;
  Function onPressed;
  bool val;
  Field({this.val, this.ques, this.ans, this.onPressed});
  @override
  _FieldState createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.all(0),
      title: Text(
        widget.ques,
        style: themeFont(),
      ),
      trailing: (widget.val == true)
          ? Icon(Icons.keyboard_arrow_up_outlined)
          : Icon(Icons.keyboard_arrow_down_outlined),
      children: [
        Text(
          widget.ans,
          style: themeFont(),
        ),
      ],
      onExpansionChanged: widget.onPressed,
    );
  }
}
