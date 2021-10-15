import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_bloc.dart';
import 'package:huddle_and_score/blocs/home/home_state.dart';
import 'package:huddle_and_score/models/home_event.dart';
import 'package:huddle_and_score/screens/widgets/loading_screen.dart';
import 'package:huddle_and_score/screens/widgets/tournament_tile.dart';

import '../../constants.dart';
import 'fifa_tile.dart';

class SearchResult extends StatelessWidget {
  String currentSearch;
  String city;
  SearchResult({this.city = "Ahmedabad", this.currentSearch});
  HomeBloc _bloc;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    _bloc = BlocProvider.of<HomeBloc>(context);

    List<HomeTour> tours = [];
    List<HomeFifa> toShow = [];
    if (_bloc.state != null &&
        _bloc.state.allTournaments != null &&
        _bloc.state.allTournaments[city] != null) {
      for (int i = 0; i < _bloc.state.allTournaments[city].length; i++) {
        bool flag = false;

        if (startsWith(
            _bloc.state.allTournaments[city][i].name, currentSearch)) {
          // toShow.add(_bloc.state.allTournaments[i]);
          flag = true;
        }
        for (int j = 0;
            j < _bloc.state.allTournaments[city][i].venue.length;
            j++) {
          if (startsWith(
              currentSearch, _bloc.state.allTournaments[city][i].venue[j])) {
            flag = true;
          }
          if (flag) break;
        }
        if (flag) {
          tours.add(_bloc.state.allTournaments[city][i]);
        }
      }
    }
    if (_bloc.state.allFifa != null && _bloc.state.allFifa[city] != null) {
      for (int i = 0; i < _bloc.state.allFifa[city].length; i++) {
        bool flag = false;
        if (startsWith(_bloc.state.allFifa[city][i].name, currentSearch)) {
          flag = true;
        }
        for (var x in _bloc.state.allFifa[city][i].venue) {
          if (startsWith(x, currentSearch)) {
            print("match found:- " + x + " " + currentSearch);
            flag = true;
          }
          if (flag) break;
        }
        if (flag) {
          toShow.add(_bloc.state.allFifa[city][i]);
        }
      }
    }

    // 0 for fifa and 1 for tournament.
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state is Loading) {
          return LoadingWidget();
        } else if (state is Failure) {
          return Center(
            child: Text('Failed'),
          );
        } else if (state is InitialState) {
          return LoadingWidget();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Tournaments',
                style: themeFont(s: 16, w: 'sb'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                child: (tours.length > 0)
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tours.length,
                        itemBuilder: (_, ind) {
                          return TournamentTile(
                            here: tours[ind],
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // width: w * (145 / kScreenW),
//height: h * (212 / kScreenH)
                            childAspectRatio:
                                (w * (155 / kScreenW)) / (h * (230 / kScreenH)),
                            mainAxisSpacing: 0),
                      )
                    : Container(
                        child: Text(
                          'We couldn\'t find any Tournaments as per your search.',
                          style: themeFont(),
                        ),
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Upcoming Online Tournaments',
                style: themeFont(s: 16, w: 'sb'),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: w,
                child: (toShow.length > 0)
                    ? GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: toShow.length,
                        itemBuilder: (_, ind) {
                          return FifaTile(
                            fifa: toShow[ind],
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                (w * (155 / kScreenW)) / (h * (230 / kScreenH)),
                            mainAxisSpacing: 0),
                      )
                    : Container(
                        child: Text(
                          'We couldn\'t find any Online Tournaments as per your search. ',
                          style: themeFont(),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

bool startsWith(String a, String b) {
  a = a.toLowerCase();
  b = b.toLowerCase();
  if (a.isEmpty || b.isEmpty) return true;
  if (a.length < b.length) {
    String c = a;
    a = b;
    b = c;
  }
  for (int i = 0; i < a.length; i++) {
    bool flag = true;
    for (int j = 0; j < b.length; j++) {
      int here = i + j;
      if (here >= a.length) continue;
      if (a[here] != b[j]) {
        flag = false;
        break;
      }
    }
    if (flag) return true;
  }
  return false;
}
