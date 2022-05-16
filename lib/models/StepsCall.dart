import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // to convert the DateTime format

class StepsCall extends ChangeNotifier { //provider to manage fetching steps data and to manage the number of steps fetched to hatch the egg
  int sumsteps = 0; //sum of steps to display in the bar
  String? userId;
  bool isauthenticated = false;
  bool fetchbuttonloading =
      false; //manage to avoid to re-press button while loading steps data
  bool errorfetchsteps = false; //to manage error when retrieving steps data: if error becomes true

  late DateTime startdate; //start day date for fetching steps  (late cause i promise i will provide NOT NULL value)

  late String savedlastdate; //to manage the fetch of steps of the same day (cause i'm fetching data day by day: avoid put in sumsteps steps already accumulated)
  int savedlaststeps = 0; //to manage the fetch of steps of the same day
  bool firstabsolutefetch = true; //check if it's the first absolute fetch of the app


  void updateFetchButtonLoading(){
    fetchbuttonloading = !fetchbuttonloading; //change if something is loading or not
    //print(fetchbuttonloading);
    notifyListeners();
  }

  Future authentication() async {
    //function to perform authentication with fibit credentials

    //print('Authentication started');

    isauthenticated == false
        ? //if i have never been authenticated
        userId = await FitbitConnector.authorize(
            //context: context,
            clientID: '238CG7',
            clientSecret: '6814538ffe2fa5708f85373a80bc2d4e',
            redirectUri: 'example://fitbit/auth',
            callbackUrlScheme: 'example')
        : null;
    userId != null
        ? isauthenticated = true
        : isauthenticated =
            false; //if i have userId != null so authentication finished, else repeat authentication step with the button (no fetch steps allowed)

    //print(userId);
    //print(isauthenticated);
  }

  Future fetchsteps() async {
    //function to retrieve steps data
    //print('Check if need fetch steps');

    if (isauthenticated == true) {
      //if i'm correctly authenticated
      //print('Doing fetch steps');
      try {
        //print(startdate);
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager =
            FitbitActivityTimeseriesDataManager(
          clientID: '238CG7',
          clientSecret: '6814538ffe2fa5708f85373a80bc2d4e',
          type: 'steps',
        );
        final stepsData = await fitbitActivityTimeseriesDataManager
            .fetch(FitbitActivityTimeseriesAPIURL.dateRangeWithResource( //fetched only day by day data
          startDate: startdate,
          endDate: DateTime.now(), //fetch until data of today
          userID: userId,
          resource: fitbitActivityTimeseriesDataManager.type,
        )) as List<FitbitActivityTimeseriesData>;

        for (int i = 0; i < stepsData.length; i++) {
          //sum steps data fetched to get sumsteps
          if (stepsData[i].value != null) { //sum steps different from null in the list
            sumsteps = sumsteps +
                stepsData[i].value!.round(); //round to pass from double to int
          }
        }
        errorfetchsteps = false; //i have not an error   

        //print(stepsData);
        //print(stepsData[0].value); //print first value of list
        
        if(firstabsolutefetch == true) { //if first absolute fetch
          savedlastdate = DateFormat('yyyy-MM-dd').format(DateTime.now()); //save last data of the list
          savedlaststeps = stepsData[stepsData.length-1].value!.round(); //save steps of last data of the list
          firstabsolutefetch = false;
        }
        else{ //firstabsolutefetch = false
          if(savedlastdate == DateFormat('yyyy-MM-dd').format(startdate)){ //if the saved date is equal to the startdate
            sumsteps = sumsteps - savedlaststeps; //correct the steps subracting savedlaststeps
            savedlaststeps = stepsData[0].value!.round(); //update che savedlaststeps
            savedlastdate = DateFormat('yyyy-MM-dd').format(startdate); //update the savedlastdate
            //print(savedlastdate);
            //print(savedlaststeps);
          }
        }

        startdate = DateTime.now(); //if i fetch succesfully data, the startdata of the following fetch become now, when i press the fetch button

      } catch (err) {
        //fetching steps gives error
        errorfetchsteps = true; //i have an error when fetching steps
      }
    }

    notifyListeners();
  }

  int get getSumSteps => sumsteps;

  void clearSumSteps() {
    sumsteps = 0; //clear sumsteps value when i want to take a new egg
  }
}
