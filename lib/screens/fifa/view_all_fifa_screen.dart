import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/screens/widgets/common_scaffold.dart';
import 'package:huddle_and_score/screens/widgets/fifa_tile.dart';

import '../../constants.dart';

class ViewAllFifaScreen extends StatelessWidget {
  HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<HomeBloc>(context);
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return CommonScaffold(
      child: Container(
          height: h,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Online Tournaments',
                    style: themeFont(
                      color: kThemeColor,
                      s: 23,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: w,
                  //   height:100,
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is Failure) {
                        return Center(
                          child: Text('Failed'),
                        );
                      } else if (state is InitialState) {
                        return Container();
                      }
                      return GridView.builder(
                        itemCount: state.allFifa.length,
                        itemBuilder: (_, ind) {
                          return SizedBox(
                            child: FifaTile(fifa: state.allFifa[ind]),
                            width: w * (145 / kScreenW),
                            height: h * (212 / kScreenH),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          // width: w * (145 / kScreenW),
                          // height: h * (212 / kScreenH)
                          childAspectRatio:
                              (w * (155 / kScreenW)) / (h * (230 / kScreenH)),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),

    );
  }
}
