import 'package:flutter/material.dart';

import '../../constants.dart';

class FifaReceiptScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
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
              Container(
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
                        style: themeFont(color: Colors.white, ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: kThemeColor,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          height: double.infinity,
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
                  s: 23,w:'sb'
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (150 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 7,
                      spreadRadius: 0.1,
                        offset: Offset(7,7)

                    )
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Text(
                          'Fifa Championship',
                          style: themeFont(w: 'sb',s:14),
                        ),
                        Text(
                          '8 September 2021',
                          style: themeFont(w: 'sb',s:14),
                        ),
                        Text(
                          'LD College, Ahmedabad',
                          style: themeFont(w: 'sb',s:14),
                        ),
                        Text(
                          '4 p.m. onwards',
                          style: themeFont(w: 'sb',s:14),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                      ],
                    ),
                    Container(
                      height: h * (102 / kScreenH),
                      width: h * (102 / kScreenH),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          'https://picsum.photos/300/300',
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: h * (220 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                                    spreadRadius: 0.1,

                        offset: Offset(7,7)

                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Your participation has been confirmed.',
                      style: themeFont(color: kThemeColor,w: 'sb',s:14),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    DataShower(type: 'Participant Name', data: 'Person Name'),
                    DataShower(type: 'Phone No.', data: '9934923912'),
                    DataShower(type: 'Email Id', data: 'abc@gmail.com'),
                    DataShower(type: 'Mode of Payment', data: 'Net Banking'),
                    SizedBox(
                      height: 1,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: h * (120 / kScreenH),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                        spreadRadius: 0.1,

                        offset: Offset(7,7)
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
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '₹ 750',
                          style: themeFont(w: 'r'),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Taxes',
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '0',
                          style: themeFont(w: 'r'),
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
                          style: themeFont(),
                        ),
                        Spacer(),
                        Text(
                          '₹ 750',
                          style: themeFont(w: 'r'),
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
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            this.type,
            style: themeFont(w: 'm',s:14),
          ),
          Spacer(),
          SizedBox(
            width: w * (0.35),
            child: Text(
              this.data,
              style: themeFont(w: 'm',s:14),
            ),
          ),
        ],
      ),
    );
  }
}
