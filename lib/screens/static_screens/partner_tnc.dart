import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:huddle_and_score/constants.dart';
import 'package:huddle_and_score/screens/partner_with_us/how_it_works.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

TextStyle smallText = themeFont(s: 14, w: 'r');
TextStyle bigText = themeFont(s: 20, w: 'sb', color: kThemeColor);
TextStyle boldText = themeFont(
  color : kThemeColor,
  s: 16,
  w: 'sb',
);
List<String> subs = [
  '''i. In order to use the Services, you must first agree to the Terms. You may not use
the Services if you do not accept the Terms.
ii. You can accept the Terms by:
(a) clicking to accept or agree to the Terms, where this option is made available to
you by the Company in the user interface for any Service; or
(b) by actually using the Services. In this case, you understand and agree that the
Company will treat your use of the Services as acceptance of the Terms from that
point onwards.
iii. You may not use the Services and may not accept the Terms if (a) you are not of
legal age to form a binding contract with the Company, or (b) you are a person
barred from receiving the Services under the laws of the India or other countries
including the country in which you are resident or from which you use the Services.
iv. Before you continue, you should print off or save a local copy of the this Terms for
your records. 
''',
  '''The Participants, participating through the portal/application of the Company for the Registered Event(s) created by You (the Organiser) through and on the portal/application of the Company, authorise You to take all necessary steps to hold and arrange the Registered Event(s) for and on behalf of them, and You shall be solely and completely liable for all arrangement to be made and steps to be taken for holding, running and concluding such Registered Event(s) properly and peacefully.

The Participants may be provided with facility of rating and writing review of the Organisers and/or Registered Event(s) and You agree and authorise the Company to make such review and rating, with or without modification, list on the portal/application of the Company.''',
  '''i. The Participants shall pay to the Company for the Registered Event(s) as participated by them through the Service of the Company, out of which 50% shall be paid to you within 7 days of receipt of the payment and remaining 50% of the payment to You shall be made within 14 working days from the date of successful conclusion of the Registered Event(s) created and held by You; or 100% from date of receipt of payment from the Participants for such Registered Event(s) whichever is later, such payment is subject to the deduction as mentioned herein the agreement. The Company shall make the payment, after applicable deduction, as received by the Participants only for the Registered Event(s) which was created through the Service of the Company and shall in no case liable for any event held by the Organiser without registration/ creation of such event on the Service of the Company and participated by any person including the Participants of other Registered Event(s). The Company shall not be responsible for any payment or otherwise against any damage of the property (physical or intellectual) of the Organiser including sports kit, devices, etc. used for the Registered Event(s) by the Participants or any other person.

ii. The Company shall be provided with invoice including for service by You, if applicable, on concluding the Registered Event(s) properly and peacefully. In all case the Organiser shall bear all applicable charges and taxes, i.e. Goods and Service Tax (GST), Tax Deductible at Source, etc. applicable, as may be applicable from time to time, on such Registered Event(s) and the Service; and the Company shall reimburse the payment as referred herein the agreement only after deduction of the amount as equivalent to the amount of said taxes and charges.''',
  '''i. You shall not in any case contact the Participants through any other mean except through the portal/application of the Company and as authorised by the Company. Notwithstanding anything You shall not disclose any details directly or indirectly to the Participants of or in relation to the fees, charges or invoices raised/ conveyed/ intimated by You to the Company or vice a versa. Further, You shall not disclose or convey or retain any details about location, whereabout, any other address, any personal details or any such other details of the Participants/ from the Participants or any other person. You shall also refrain from disclosing any details about your contact number or other such details directly or indirectly to enable the Participants to contact You or for any other reason.

ii. The Organiser shall display the merchandise, leaflet, broachers, etc. (hereinafter referred to as the “Advertising Material”) of the Company as and when provided by the Company on such Registered Event(s) as held through the Company portal/application. Such display shall by no mean demeaning, defame or hurt the image of the Company, and shall be displayed in dignified manner only. The Advertising Material shall not be used or allowed to be used by the Organiser without prior approval of the Company.

iii. The Advertising Material of any other party apart from of the Company, as may be promoted on the Registered Event(s) created through the Service of the Company, promoted by the Organiser himself shall be first approved by the Company before promotion/ displayed. Any Advertising Material of any other party apart from the Company, as may be promoted on the Registered Event(s) created through the Service of the Company, as provided by the Company to be promoted shall be driven through separate terms and condition and such terms and condition shall be considered as extension of this agreement and not shall not be considered as separate agreement. Aany other agreement held between the party during the continuation of this agreement where any terms of such other agreement overlaps/contradicts with this agreement, in such situation, terms of such other agreement shall prevail, only if such other agreement is executed in writing by and between both the parties.''',
  '''This contract shall be considered binding upon you and your assignees or successors, including subsequent title holders for creating and organising the Registered Event(s).''',
  '''i. On execution of this Agreement You shall provide the Company with the selfattested photocopies of your PAN Card, Aadhar Card and such other documents as may be conveyed to you before execution of this agreement. In change of any details of the Documents submitted to the Company, the Organiser shall provide the Company with latest documents in the same manner as mentioned hereinbefore.

ii. You agree and acknowledge that Huddle and Score is merely a service provider for ease of connecting You with the Participants. Any damage or claim to, for or against the Registered Event(s) or ancillary service of the Registered Event(s) shall be responsibility of the Organiser, and the Company shall not in any possible way be held liable for such claim or damage by the Participants or any other person. However, any damage to the Participants or their properties or person related to the Registered Event(s), You agree to intimate such damage or loss with details of the extent of damage or loss to Company.

iii. You agree that you will take maximum care that the Registered Event(s) created by You on the Service of the Company are held properly and peacefully and no damages cause to any Participants or person related to the Registered Event(s) or person present near the Registered Event(s) or their properties.

iv. You shall adhere with the time, place and other details as conveyed during the creation of the Registered Event(s) through the Service of the Company, any change in any such details of the Registered Event shall be first requested with reason and details of such change, on receipt of the request of change of details to authorise the same or reject the same with or without cost/penalty of such change, in case where the change is allowed by the Company, the same shall not take place till the consent is received from the Participants as provided hereinafter in this clause.

v. The Organiser agrees and takes full responsibility of all the service related and ancillary to the Registered Event(s) and in no condition or manner the Company shall be held responsible for the same. The Organiser further agrees to take full responsibility of any claim or damages in relation to the Registered Event(s) created, whether held or not, through the portal/application of the Company.

vi. You agree to take all permission from respective authorities related to holding such Registered Event(s) and acknowledge You shall be solely responsible to bare any cost, damage, penalty, charges or any other expense including fine of any government authority or police as applicable under law of the land, in relation to the Registered Events.

vii. You shall be liable to pay the damages, claims both of the Company and the Participants as well as refund of the payment made by the Participants made to the Company, where the Registered Event(s) created through and on the Service of the Company but not held/ arranged later on or postponed by You. In case of the postponement of the Registered Event(s), You shall take consent of all the Participants registered and opt for such Registered Event(s). The Company shall not be liable to make payment to the Organiser for the Registered Event(s) which does not take place after created/ registered on the Service of the Company, in case of the postponement, the Company on its sole discretion pay to the Organiser only for those who provide consent for postponement.

viii. On completion of the Registered Event(s), You shall vacant the property where the Registered Event(s)take place peacefully and shall return all the Advertisement Material to the Company. You shall take maximum care that the Advertisement Material does not get damaged.''',
  '''The Organiser hereby consents, expresses and agrees that he has read and fully understands the Privacy Policy of Huddle & Score as provided on the Website of the Company, the Organiser further consents that the terms and contents of such Privacy Policy are acceptable to You and you shall adhere and follow the same.''',
  '''You agree that logo, name, website content and such other intellectual property of the Company may be protected by copyrights, trademarks, service marks, trade secrets and other intellectual property rights and laws. You shall in no condition claim on or have unauthorised use to any of the intellectual property of the Company, and acknowledge that the Company has sole right on the intellectual property of the Company. You agree to use the Service of the Company only for purposes that are permitted by these Terms and any applicable local, state, national or other law, rule or regulation. Any rights not expressly granted herein are reserved.''',
  '''The Organiser agrees to indemnify, defend and hold harmless the Company from and against any and all losses, liabilities, claims, damages, costs and expenses (including legal fees and disbursements in connection therewith and interest chargeable thereon) asserted against or incurred by the Company that arise out of, result from, or may be payable by virtue of, any breach or non-performance of any representation, warranty, covenant or agreement made or obligation to be performed by the Organiser pursuant to this Agreement.''',
  '''Without prejudice to the other remedies available to the Company under this agreement or under applicable laws, the Company may limit the Organiser’s activity, or end the Organiser’s listing of Registered Event(s) immediately temporarily/indefinitely suspend or terminate the Organiser’s registration, and/or refuse to provide the Organiser with access to the website if:

a) the Organiser is in breach of this agreement and/or fails to provide necessary documents required under this agreement;

b) the Company is unable to verify or authenticate any information provided by the Organiser; or

c) the Company believes that the Organiser’s actions may infringe on any third-party rights or breach any applicable law or otherwise result in any liability for the Organiser, Participants, other users of the service of the Company and/or the Company.

The Company may at any time in its sole discretion reinstate suspended the Organiser. Once the Organiser have been indefinitely suspended the Organiser may not register or attempt to register with the Company or use the Service of the Company in any manner whatsoever until such time that the Organiser is reinstated by the Company. Notwithstanding the foregoing, if the Organiser breaches this agreement, the Company reserves the right to recover any amounts due and owing by the Organiser to the Company and/or the Participants and to take strict legal action as the Company deems necessary.''',
  '''The Company reserves the right, in its sole discretion, to terminate the access to the Service of the Company and the related services or any portion thereof at any time, without notice.''',
  '''i. This Agreement shall be governed by and construed in accordance with the laws of India.

ii. The Parties hereto agree that they shall use all reasonable efforts to resolve between themselves any disputes, controversy or claim arising out of or relating to this Agreement in an amicable manner. In particular the Parties agree that discussions will be carried out between senior level officers of the Company and the Organiser to a maximum period of forty-five (45) days from the date that written notice of the details of the issue in dispute, controversy or claim shall have been given by one Party to the other.

iii. In the event the efforts and discussions described in Clause 12 (ii) fail to resolve the matter, such dispute, controversy or claim shall be settled by arbitration in accordance with the Indian Arbitration and Conciliation Act, 1996, and any statutory modification or re-enactment thereof. It is further agreed that the place of arbitration shall be Ahmedabad, Gujarat and the Arbitrator shall be appointed mutually by the Parties. The decision of the arbitrator shall be final and binding upon the Parties. The Courts at Ahmedabad, India shall have exclusive jurisdiction to determine any question, issue, difference, dispute or claim between the parties if the matter is not resolved through Arbitration.

iv. If any provision of this Agreement is held to be invalid or unenforceable to any extent, the remainder of this Agreement shall not be affected and each provision of this Agreement shall be valid and enforceable to the fullest extent permitted by law. Any invalid or unenforceable provision of this Agreement shall be replaced with a provision which is valid and enforceable and most nearly reflects the original intent of the unenforceable provision. A severed provision shall not alter the integrity of the Agreement, and the terms set forth in any severed provision shall be construed in such a way as to interpret the purpose for which it was drafted.''',
];
List<String> titles = [
  "1. ACCEPTING THE TERMS",
  "2. AUTHORIZATION",
  "3. PAYMENT",
  "4. COMMUNICATION WITH PARTICIPANTS",
  "5. BINDING CONTRACT",
  "6. RESPONSIBILITY",
  "7. PRIVACY POLICY",
  "8. INTELLECTUAL PROPERTY RIGHT:",
  "9. INDEMNIFICATION",
  "10. BREACH OF CONTRACT:",
  "11. ACCESS RESTRICTION:",
  "12. GOVERNING LAW AND ARBITRATION",
];

class PartnerTnC extends StatefulWidget {

  @override
  _PartnerTnCState createState() => _PartnerTnCState();
}

class _PartnerTnCState extends State<PartnerTnC> {
  bool checked = true;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return CommonScaffold(
      bottomBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: w,
        height: h * 0.08,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              spreadRadius: 1)
        ]),
        child: Row(
          children: [
            Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
            ),
            TextButton(

              onPressed: () {

                Navigator.pop(context);
              },
              child: Text(
                'Back',
                style: themeFont(),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                print("Pressed");
                if(!checked){
                  Fluttertoast.showToast(msg: 'Please Agree Terms');
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HowItWorks(
                      isFirst: false,
                    ),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: w * 0.35,
                child: Center(
                  child: Text(
                    'Accept',
                    style: themeFont(color: Colors.white, s: 15, w: 'sb'),
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:(checked)? kThemeColor:Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Terms of Service for Organisers',
                    style: bigText,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '''Your use of the Company’s portal or application of the product Huddle & Score (the Service) is subject to terms and legal agreement between You and the Company. The Company or Huddle & Score herein shall mean “Grownite Private Limited”. Your agreement with the Company will always include, at a minimum, the terms and conditions set out in this document except and otherwise agreed in writing separately.''',
                style: smallText,
              ),
              ListView.builder(
                itemBuilder: (_, ind) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\n${titles[ind]}\n',
                        style: boldText,
                      ),
                      Text(
                        '''${subs[ind]}''',
                        style: smallText,
                      ),
                    ],
                  );
                },
                itemCount: titles.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        checked = !checked;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: (checked)
                            ? kThemeColor
                            : Colors.white,
                        border: Border.all(),
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/checkbox.svg',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text('I agree to the Terms and Conditions',style: smallText,),
                ],
              ),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
