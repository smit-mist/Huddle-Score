import 'package:flutter/material.dart';
import 'package:huddle_and_score/screens/partner_with_us/how_it_works.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';

import '../../constants.dart';

List<String> list1 = [
  "  Phone Number",
  "Name",
  "Email",
  "Age",
  "Location",
  "Bank Details (Account Holder Name, Account Number, IFSC Code) UPI Details",
];
List<String> list2 = [
  "To enable the functioning of the App or the Website, the Company’s business and carry out data analytics to improve your user experience;",
  "In connection with any transaction where we are acquired by or merged with another company;",
  "To administer or otherwise carry out our obligations in relation to any agreement you have with us;",
  "Respond to subpoenas, court orders, or legal process, or to establish or exercise our legal rights or defend against legal claims; and",
  "To investigate, prevent, or take action regarding illegal activities, suspected fraud, violations of the website or as otherwise required by law."
];
TextStyle smallText = themeFont(s: 14, w: 'r');
TextStyle bigText = themeFont(s: 20, w: 'sb', color: kThemeColor);

class UserPrivacyPolicy extends StatefulWidget {
  @override
  _UserPrivacyPolicyState createState() => _UserPrivacyPolicyState();
}

class _UserPrivacyPolicyState extends State<UserPrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return CommonScaffold(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: bigText,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '''Grownited Private Limited (“Company”) is committed to respecting the privacy of every person who shares personal information with the Company either by accessing the Company website ‘ www.huddleandscore.com ’ (“Website”) using the mobile application ‘Huddle & Score’ or Huddle And Score (“App”) (collectively, "Personal Information"). Your privacy is important to us and we strive to take reasonable care in the protection of the information we receive from you.

The purpose of this Privacy Policy ("Policy"), as amended from time to time, is to give you an understanding on how we intend to collect, store, transfer and use the Personal Information you provide to us. The Policy may be subject to further changes. Upon updating the Policy, we may revise the "Updated" date at the bottom of this Policy. Your continued use of our platform and services will imply your acceptance of such updates to this Policy.

By providing us your information, you hereby consent to the collection, storage, disclosure, processing and transfer of such information for the purposes as disclosed in this Policy. You are providing the information out of your free will. You have the option not to provide us the data or Personal Information sought to be collected if you do not agree with this Policy.
      
Further, you have the option to not provide your consent, or withdraw any consent given earlier, provided that the decision to not provide consent / withdrawal of the consent is intimated to us in writing. If you do not provide us Personal Information or withdraw the consent to provide us with any of your Personal Information at any point in time, we shall have the option not to provide our services to you to the extent the said Personal Information is required.''',
                style: smallText,
              ),
              Text(
                '\nPersonal Information and its Usage',
                style: bigText,
              ),
              Text(
                'The kind of Personal Information that we collect may include:',
                style: smallText,
              ),
              ListView.builder(
                itemBuilder: (_, int ind) {
                  return BulletPoint(text: list1[ind]);
                },
                itemCount: list1.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),

              Text(
                '\nWe may collect, disclose, process and transfer your Personal Information:\n',
                style: smallText,
              ),

              ListView.builder(
                itemBuilder: (_, int ind) {
                  return BulletPoint(text: list2[ind]);
                },
                itemCount: list2.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              Text(
                '''\nWe may also remove all the personally identifiable information and use the rest of the data / information for historical or statistical purposes.

You hereby consent that the collection, disclosure, storage, processing and transfer of any Personal Information or any other information as disclosed under this Policy shall not cause any loss or wrongful gain to you if the same is used for the purposes stated in this Policy.''',
                style: smallText,
              ),
              Text(
                '\nAuthorization',
                style: bigText,
              ),
              Text(
                '''\nYou authorize us to transfer, share, part with your Personal Information, across borders and from your country and jurisdiction to any other countries and jurisdictions across the world (including India), with our affiliates / agent / third party service provider / partners and other agencies for purposes specified under this Policy or as may be required by law.''',style: smallText,
              ),
              Text('\nSecurity\n',style: bigText,),
              Text('''The security of your Personal Information is important to us. We have adopted reasonable security practices and procedure You agree that such measures are secure and adequate.

While we will endeavor to take all reasonable and appropriate steps to keep secure any information which we hold about you and prevent unauthorized access, you acknowledge that the no electronic medium / security measure is 100% secure and that we cannot provide any absolute assurance regarding the security of your Personal Information. We will not be liable in any way in relation to any breach of security or unintended loss or disclosure of information caused by us in relation to your Personal Information.''',style: smallText,),
              Text('\nAccess\n',style: bigText,),
              Text('''If you need to access your Personal Information, update or correct your Personal Information for any reason, you may send such requests, updates and corrections to us at support@huddleandscore.com and we may take all reasonable efforts to provide you with access to your Personal Information and incorporate the changes within a reasonable period of time. In the event you wish to know the names and addresses of the third parties your personal data has been disclosed to, you may request the Company for such information by writing to support@huddleandscore.com.''',style: smallText,),
              Text('\nGrievance Officer\n',style: bigText,),
              Text('''If you find any discrepancies or have any grievances in relation to the processing of information under this Policy, please contact D, Patel at: support@huddleandscore.com We will endeavor to respond within an appropriate time frame.''',style: smallText,),
              Text('\nContacting Us\n',style: bigText,),

              Text('''We can address any questions, comments and concerns about our online privacy practices and policy. Please write to D. Patel at: support@huddleandscore.com''',style: smallText,),
SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  String text;
  BulletPoint({@required this.text});
  @override
  Widget build(BuildContext context) {
    String here = "";
    for(int i=0;i<text.length;i++){
      if(i >0 &&i%50 ==0){
        here += '\n';
      }
      here += text[i];
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: smallText,
          ),
          Text(
            here,
            style: smallText,
          ),
        ],
      ),
    );
  }
}
