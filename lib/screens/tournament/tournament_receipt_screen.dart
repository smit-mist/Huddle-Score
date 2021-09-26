import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/models/booking.dart';
import 'package:huddle_and_score/models/feedback.dart';
import 'package:huddle_and_score/repositories/feedback_repository.dart';
import 'package:huddle_and_score/screens/widgets/action_button.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';
import '../home_navbar_screen.dart';

class TournamentReceiptGenerator extends StatefulWidget {
  String bookingId;
  bool freshBooking;
  TournamentReceiptGenerator({this.bookingId, this.freshBooking});
  @override
  _TournamentReceiptGeneratorState createState() =>
      _TournamentReceiptGeneratorState();
}

class _TournamentReceiptGeneratorState
    extends State<TournamentReceiptGenerator> {
  BookingDetails details;
  formType type;
  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder<DocumentSnapshot>(
      stream:
          FirebaseFirestore.instance.doc('users/$uid/records/tour').snapshots(),
      builder: (_, snap) {
        print(snap.hasData);
        if (snap.hasData == false) return LoadingWidget();
        if (snap.data.data() == null) return LoadingWidget();
        bool fnd = false;
        var here = Map<String, dynamic>.from(snap.data.data());
        here.forEach((key, value) {
          if (key.endsWith(widget.bookingId)) {
            fnd = true;
            details = BookingDetails.fromMap(value);
            if (getFormType(details.data.type.toLowerCase()) == formType.Team) {
              type = formType.Team;
            } else {
              if (details.regDetails.viceCaptain == null ||
                  details.regDetails.viceCaptain.contact == 373737) {
                type = formType.Single;
              } else
                type = formType.Double;
            }
          }
        });

        if (fnd) {
          return TournamentReceiptScreen(
            details: details,
            currForm: type,
            freshBooking: widget.freshBooking,
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}

class TournamentReceiptScreen extends StatefulWidget {
  BookingDetails details;
  formType currForm;
  bool freshBooking;
  TournamentReceiptScreen({
    @required this.details,
    @required this.currForm,
    this.freshBooking,
  });

  @override
  _TournamentReceiptScreenState createState() =>
      _TournamentReceiptScreenState();
}

// TODO: Update receipt as per form type.
class _TournamentReceiptScreenState extends State<TournamentReceiptScreen> {
  List<String> first = ['Definitely', 'Maybe', 'Not at all'];
  List<String> second = [
    'Social Media',
    'Search Engine',
    'At a turf',
    'Word of mouth',
    'Other'
  ];
  List<pw.TableRow> getList() {
    if (widget.currForm != formType.Single) {
      return [
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('Team Name'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.teamName}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 1 Name'
                  : 'Captain Name'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.captain.fullName}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 1 Contact'
                  : 'Captain Contact'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.captain.contact}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 1 Email ID'
                  : 'Captain Email ID'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.captain.email}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 1 Age'
                  : 'Captain Age'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.captain.age}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 2 Name'
                  : 'Vice Captain Name'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child:
                  pw.Text('${widget.details.regDetails.viceCaptain.fullName}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 2 Contact'
                  : 'Vice Captain Contact'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child:
                  pw.Text('${widget.details.regDetails.viceCaptain.contact}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 2 Email ID'
                  : 'Vice Captain Email ID'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.viceCaptain.email}'),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text(widget.currForm == formType.Double
                  ? 'Player 2 Age'
                  : 'Vice Captain Age'),
            ),
            pw.Container(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Text('${widget.details.regDetails.viceCaptain.age}'),
            ),
          ],
        ),
      ];
    }
    return [
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('Player Name'),
          ),
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('${widget.details.regDetails.captain.fullName}'),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('Contact Number'),
          ),
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('${widget.details.regDetails.captain.contact}'),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('Email ID'),
          ),
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('${widget.details.regDetails.captain.email}'),
          ),
        ],
      ),
      pw.TableRow(
        children: [
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('Age'),
          ),
          pw.Container(
            padding: pw.EdgeInsets.all(8.0),
            child: pw.Text('${widget.details.regDetails.captain.age}'),
          ),
        ],
      ),
    ];
  }

  TextEditingController suggestion = TextEditingController(),
      otherText = TextEditingController();
  double liked = 0.0;
  int firstOption = 0, secondOption = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.currForm);
    String timeLine = "";
    var st = WeirdDateFormat(date: widget.details.data.timeLine[0]);
    var en = WeirdDateFormat(date: widget.details.data.timeLine[1]);
    timeLine += st.getDate();
    timeLine += '- ';
    timeLine += en.getDate();
    timeLine += ' ';
    timeLine += st.getMonth();
    timeLine += ' ';
    timeLine += st.getYear();
    String address = widget.details.data.venue.address.join(', ');
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print(widget.details.regDetails.captain == null);

    Widget feedBackFrom = StatefulBuilder(
      builder: (context, setState) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: h * (550 / kScreenH),
              width: w * (400 / kScreenW),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * (480 / kScreenH),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'We\'d love your feedback!',
                              style: themeFont(
                                color: kThemeColor,
                                s: 20,
                                w: 'sb',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How satisfied are you with the booking experience?',
                              style: themeFont(
                                s: 15,
                                w: 'r',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset('assets/icons/sad.svg'),
                                Slider(
                                  min: 0.0,
                                  max: 100.0,
                                  value: liked,
                                  onChanged: (double nw) {
                                    setState(() {
                                      liked = nw;
                                    });
                                  },
                                ),
                                SvgPicture.asset('assets/icons/happy.svg'),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Would you recommend Huddle & Score to your friends?',
                              style: themeFont(s: 15),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 0;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Definitely',
                                          style: themeFont(
                                            color: (firstOption == 0)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 0)
                                              ? kThemeColor
                                              : Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 1;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Maybe',
                                          style: themeFont(
                                            color: (firstOption == 1)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 1)
                                              ? kThemeColor
                                              : Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        firstOption = 2;
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      child: Center(
                                        child: Text(
                                          'Not at all',
                                          style: themeFont(
                                            color: (firstOption == 2)
                                                ? kThemeColor
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: ((firstOption == 2)
                                              ? kThemeColor
                                              : Colors.transparent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'How did you hear about us?',
                              style: themeFont(),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 20,
                              runSpacing: 10,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (otherText.text.length > 0) return;

                                    setState(() {
                                      secondOption = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (130 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Social Media',
                                        style: themeFont(
                                          color: (secondOption == 0)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 0)
                                            ? kThemeColor
                                            : Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (otherText.text.length > 0) return;

                                    setState(() {
                                      secondOption = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (130 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Search Engine',
                                        style: themeFont(
                                          color: (secondOption == 1)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 1)
                                            ? kThemeColor
                                            : Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (otherText.text.length > 0) return;

                                    setState(() {
                                      secondOption = 2;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (130 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'Word of Mouth',
                                        style: themeFont(
                                          color: (secondOption == 2)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 2)
                                            ? kThemeColor
                                            : Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (otherText.text.length > 0) return;
                                    setState(() {
                                      secondOption = 3;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: w * (130 / kScreenW),
                                    child: Center(
                                      child: Text(
                                        'At a Turf',
                                        style: themeFont(
                                          color: (secondOption == 3)
                                              ? kThemeColor
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: ((secondOption == 3)
                                            ? kThemeColor
                                            : Colors.transparent),
                                      ),
                                    ),
                                  ),
                                ),
                                TextField(
                                  onTap: () {
                                    setState(() {
                                      secondOption = 4;
                                    });
                                  },
                                  controller: otherText,
                                  decoration: normalTextDecoration('Other'),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'How can we make your experience even better?',
                              style: themeFont(),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            TextField(
                              controller: suggestion,
                              decoration: normalTextDecoration(
                                'Leave a suggestion to us..',
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Spacer(),
                          Container(
                            width: 100,
                            height: 40,
                            child: ActionButton(
                              onTap: () async {
                                print(suggestion.text + 'here22');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoadingScreen(),
                                    ));
                                await FeedBackRepository().sendFeedbackData(
                                  FeedBack(
                                    satisfied: liked.toInt(),
                                    chooseUs: '',
                                    recommendOthers: first[firstOption],
                                    comeToKnowUs: (secondOption < 4)
                                        ? second[secondOption]
                                        : otherText.text,
                                    suggestion: suggestion.text,
                                  ),
                                );
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HomeNavBar(
                                        curr: (widget.freshBooking == null ||
                                                widget.freshBooking == false)
                                            ? screen.Book
                                            : screen.Home,
                                      ),
                                    ),
                                    (route) => false);
                                Fluttertoast.showToast(
                                    msg: 'Thanks for your FeedBack');
                              },
                              child: Text(
                                'Submit',
                                style: themeFont(
                                  color: Colors.white,
                                ),
                              ),
                              bgColor: kThemeColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return CommonScaffold(
      bottomBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: w,
        height: h * 0.08,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 1,
            )
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
            ),
            TextButton(
              onPressed: () {
                if (widget.freshBooking == null ||
                    widget.freshBooking == false) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomeNavBar(
                          curr: (widget.freshBooking == null ||
                                  widget.freshBooking == false)
                              ? screen.Book
                              : screen.Home,
                        ),
                      ),
                      (route) => false);
                  return;
                }
                showDialog(
                    context: context,
                    builder: (BuildContext _) => feedBackFrom);
              },
              child: Text(
                (widget.freshBooking == null || widget.freshBooking == false)
                    ? 'Back'
                    : 'Back to Home',
                style: themeFont(),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () async {
                final status = await Permission.storage.request();
                if (status.isGranted) {
                  final doc = pw.Document();
                  doc.addPage(pw.Page(
                      pageFormat: PdfPageFormat.a4,
                      build: (pw.Context context) {
                        return pw.Center(
                          child: pw.Column(
                            children: [
                              pw.Text(
                                'Receipt',
                                style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold,
                                  fontSize: 24.0,
                                ),
                              ),
                              pw.SizedBox(height: 20.0),
                              pw.Text('Online Tournament Details'),
                              pw.SizedBox(height: 10.0),
                              pw.Table(
                                columnWidths: {
                                  0: pw.FractionColumnWidth(.3),
                                  1: pw.FractionColumnWidth(.7),
                                },
                                border: pw.TableBorder.all(
                                  width: 2.0,
                                  color: PdfColor.fromHex('#248232'),
                                ),
                                children: [
                                  pw.TableRow(
                                    children: [
                                      pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Text('Name of Tournament'),
                                      ),
                                      pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Text(
                                            '${widget.details.data.title}'),
                                      ),
                                    ],
                                  ),
                                  pw.TableRow(children: [
                                    pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Text('Timeline')),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(8.0),
                                      child: pw.Text(
                                          '${widget.details.data.timeLine.join(' - ')}'),
                                    ),
                                  ]),
                                  pw.TableRow(children: [
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(8.0),
                                      child: pw.Text('Address'),
                                    ),
                                    pw.Container(
                                      padding: pw.EdgeInsets.all(8.0),
                                      child: pw.Text(
                                          '${widget.details.data.venue.address.join(', ')}'),
                                    ),
                                  ]),
                                  pw.TableRow(
                                    children: [
                                      pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Text('Age Restriction'),
                                      ),
                                      pw.Container(
                                        padding: pw.EdgeInsets.all(8.0),
                                        child: pw.Text(
                                            '${widget.details.data.ageRec}'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              pw.SizedBox(height: 10.0),
                              pw.Text(widget.currForm != formType.Single
                                  ? 'Team Details'
                                  : 'Player Details'),
                              pw.SizedBox(height: 10.0),
                              pw.Table(
                                columnWidths: {
                                  0: pw.FractionColumnWidth(.3),
                                  1: pw.FractionColumnWidth(.7),
                                },
                                border: pw.TableBorder.all(
                                  width: 2.0,
                                  color: PdfColor.fromHex('#248232'),
                                ),
                                children: getList(),
                              ),
                            ],
                          ),
                        );
                      }));
                  if (Platform.isAndroid) {
                    final path = '/storage/emulated/0/Download';
                    final file = File("$path/${widget.details.data.title}.pdf");
                    await file.writeAsBytes(await doc.save());
                    OpenFile.open('$path/${widget.details.data.title}.pdf');
                  } else if (Platform.isIOS) {
                    final path = (await getApplicationDocumentsDirectory())
                        .absolute
                        .path;
                    final file = File("$path/${widget.details.data.title}.pdf");
                    await file.writeAsBytes(await doc.save());
                    OpenFile.open('$path/${widget.details.data.title}.pdf');
                  }
                  print("Saved");
                }
              },
              child: Container(
                height: 40,
                width: w * 0.45,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.download_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        'Download Receipt',
                        style: themeFont(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kThemeColor,
                ),
              ),
            ),
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h * (0.04),
              ),
              Text(
                'Receipt',
                style: themeFont(
                  color: kThemeColor,
                  s: 23,
                  w: 'sb',
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: h * (350 / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(5, 5),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              height: h * (150 / kScreenH),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    widget.details.data.title,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    timeLine,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    address,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  Text(
                                    widget.details.data.ageRec,
                                    style: themeFont(
                                      w: 'sb',
                                      s: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: h * (147 / kScreenH),
                            width: w * (130 / kScreenW),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                widget.details.data.poster,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          '*All players will be required to show proof of identity at the time of the tournament.',
                          style: themeFont(s: 12, w: 'r'),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Following documents for identification will be accepted:',
                              style: themeFont(s: 13, w: 'r'),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(
                                      color: kThemeColor, s: 13, w: 'r'),
                                ),
                                Text(
                                  'Aadhar Card',
                                  style: themeFont(s: 13, w: 'r'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(
                                      color: kThemeColor, s: 13, w: 'r'),
                                ),
                                Text(
                                  'Driver\'s License',
                                  style: themeFont(
                                      color: Colors.black, s: 13, w: 'r'),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Text(
                                  '• ',
                                  style: themeFont(
                                      color: kThemeColor, s: 13, w: 'r'),
                                ),
                                Text(
                                  'Pan Card',
                                  style: themeFont(
                                      color: Colors.black, s: 13, w: 'r'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: h *
                      (((widget.currForm == formType.Single) ? 200 : 300) /
                          kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(3, 3),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Your participation has been confirmed.',
                        style: themeFont(
                          color: kThemeColor,
                          s: 14,
                          w: 'm',
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      /*
                * -1 - Means Empty Container.
                * 0 - Means Team Form (Cap, Vice Cap)
                * 1 - Means 2 Player Form (Player 1, Player 2)
                * 2 - Means 1 Player Form. (PLayer 1)
                * */
                      (widget.currForm == formType.Team ||
                              widget.currForm == formType.Double)
                          ? DataShower(
                              type: 'Team Name',
                              data: widget.details.regDetails.teamName,
                            )
                          : Container(),
                      DataShower(
                          type: (widget.currForm == formType.Team)
                              ? 'Captain\'s Name'
                              : 'Player 1 Name',
                          data: widget.details.regDetails.captain.fullName),
                      DataShower(
                          type: 'Contact Number',
                          data: widget.details.regDetails.captain.contact
                              .toString()),
                      DataShower(
                          type: 'Email ID',
                          data: widget.details.regDetails.captain.email),
                      (widget.currForm != formType.Single)
                          ? DataShower(
                              type: (widget.currForm == formType.Team)
                                  ? 'Vice Captain\'s Name'
                                  : 'Player 2',
                              data: widget
                                  .details.regDetails.viceCaptain.fullName)
                          : Container(),
                      (widget.currForm != formType.Single)
                          ? DataShower(
                              type: 'Contact Number',
                              data: widget
                                  .details.regDetails.viceCaptain.contact
                                  .toString())
                          : Container(),
                      (widget.currForm != formType.Single)
                          ? DataShower(
                              type: 'Email ID',
                              data: widget.details.regDetails.viceCaptain.email)
                          : Container(),
                      DataShower(
                          type: 'Mode of Payment',
                          data: widget.details.paymentMethod),
                      SizedBox(
                        height: 1,
                      ),
                      // SizedBox(
                      //   width: double.infinity,
                      //   child: Text(
                      //     '*All communication regarding the tournament will be done with the captain or vice-captain of the team.',
                      //     style: themeFont(
                      //       s: 11,
                      //       w: 'm',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: h * (130 / kScreenH),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(5, 5),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Charges',
                            style: themeFont(
                              s: 12,
                              w: 'm',
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹ ${widget.details.amount / 100}',
                            style: themeFont(
                              s: 12,
                              w: 'm',
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Taxes',
                            style: themeFont(
                              s: 12,
                              w: 'm',
                            ),
                          ),
                          Spacer(),
                          Text(
                            widget.details.taxes.toString(),
                            style: themeFont(
                              s: 12,
                              w: 'm',
                            ),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      Row(
                        children: [
                          Text(
                            'Total Amount',
                            style: themeFont(
                              s: 15,
                              w: 'm',
                            ),
                          ),
                          Spacer(),
                          Text(
                            '₹ ${widget.details.amount / 100 + widget.details.taxes}',
                            style: themeFont(
                              s: 15,
                              w: 'sb',
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      SizedBox(
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataShower extends StatelessWidget {
  String type, data;
  DataShower({this.type, this.data});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              this.type,
              style: themeFont(
                s: 14,
                w: 'm',
              ),
            ),
            Spacer(),
            SizedBox(
              width: w * (0.35),
              child: Text(
                this.data ?? "This is NULL",
                style: themeFont(
                  s: 14,
                  w: 'sb',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
