import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart'; // to convert the DateTime format

class StepsCall extends ChangeNotifier {
  int? sumsteps; //sum of steps to display in the bar
  String? userId; //set to null when i open the app the first time or when i'm not authenticated
  bool fetchbuttonloading =
      false; //manage to avoid to re-press button while loading steps data
  bool errorfetchsteps = false; //to manage error when retrieving steps data: if error becomes true
  late String errorMessage; //errorMessage to be displayed

  DateTime? startdate; //start day date for fetching steps  (late cause i promise i will provide NOT NULL value)

  String? savedlastdate; //to manage the fetch of steps of the same day (cause i'm fetching data day by day: avoid put in sumsteps steps already accumulated)
  int? savedlaststeps; //to manage the fetch of steps of the same day
  late bool firstabsolutefetch; //check if it's the first absolute for one egg

  SharedPreferences? prefs;
  StepsCall(this.prefs){ //StepsCall constructor
    sumsteps = prefs?.getInt('sumsteps') ?? 0; //if i have values restore, else set it to 0 (means we have not fetched yet valid steps to open)
    //print(sumsteps);
    
    userId = prefs?.getString('userId'); //restore the userId if present to fetch fitbitdata, else is null
    //print(userId);

    var stringstartdate = prefs?.getString('startdate');
    if (stringstartdate != null){
      startdate = DateTime.parse(stringstartdate); //retrieve the value of startdate if stored, else it has to be setted when i press start (so the value is again null)
    } //parse to convert String to DateTime
    //print(startdate);

    savedlastdate = prefs?.getString('savedlastdate'); //if not defined null --> no pressed start
    //print(savedlastdate);

    savedlaststeps = prefs?.getInt('savedlaststeps'); //if not defined null --> no pressed start
    //print(savedlaststeps);

    firstabsolutefetch = prefs?.getBool('firstabsolutefetch') ?? true; //if not defined true
    //print(firstabsolutefetch);
  }


  void updateFetchButtonLoading(){
    fetchbuttonloading = !fetchbuttonloading; //change if something is loading or not
    //print(fetchbuttonloading);
    notifyListeners();
  }

  Future<void> authorizationFitbit() async {
    //function to perform authorization with fibit credentials

    //print('Authorization started');

    userId == null
        ? //never been authorized
        userId = await FitbitConnector.authorize(
            clientID: '238CG7',
            clientSecret: '6814538ffe2fa5708f85373a80bc2d4e',
            redirectUri: 'example://fitbit/auth',
            callbackUrlScheme: 'example') //gives me the userId
        : null;
    
    if (userId != null){
      await prefs?.setString('userId', userId!); //! for sure userId != null (check above)
      errorfetchsteps = false;
    }
    else{
      errorfetchsteps = true;
      errorMessage = 'Retry authorization';
    }
    //print(userId);
  }

  Future<void> fetchsteps() async {
    //function to retrieve steps data
    //print('Check if need fetch steps');
    //print(startdate);
    //print(userId);

    if (userId != null) {
      //if i'm authorized correctly
      //print('Doing fetch steps');
      try {
        FitbitActivityTimeseriesDataManager
            fitbitActivityTimeseriesDataManager =
            FitbitActivityTimeseriesDataManager(
          clientID: '238CG7',
          clientSecret: '6814538ffe2fa5708f85373a80bc2d4e',
          type: 'steps',
        );
        //print(fitbitActivityTimeseriesDataManager);
        final stepsData = await fitbitActivityTimeseriesDataManager
            .fetch(FitbitActivityTimeseriesAPIURL.dateRangeWithResource( //fetched only day by day data
          startDate: startdate!,
          endDate: DateTime.now(), //fetch until data of today
          userID: userId,
          resource: fitbitActivityTimeseriesDataManager.type,
        )) as List<FitbitActivityTimeseriesData>;

        //print(stepsData);
        //print(stepsData[0].value); //print first value of list

        
        if(firstabsolutefetch == true) { //if first absolute fetch for the egg (i assume ALL the steps of the enddate day when i press start to be removed (last day remove: it's today, unless particular cases: if i press button between two days-->remove steps of the enddate to be sure))
          savedlastdate = DateFormat('yyyy-MM-dd').format(stepsData[stepsData.length-1].dateOfMonitoring!); //save last data of the list(! to promise not null)
          savedlaststeps = stepsData[stepsData.length-1].value!.round(); //save steps of last data of the list (round to pass from double to int)
          firstabsolutefetch = false;
          //sumsteps = 0;
          await prefs?.setBool('firstabsolutefetch', false);

          //print(sumsteps);
          //print(savedlastdate);
          //print(savedlaststeps);

        }
        else{ //firstabsolutefetch = false (now perform sum of steps we have)

          for (int i = 0; i < stepsData.length; i++) {
            //sum steps data fetched to get sumsteps
            if (stepsData[i].value != null) { //sum steps different from null in the list
              sumsteps = sumsteps! +
                  stepsData[i].value!.round(); //round to pass from double to int
            }
          }
          sumsteps = sumsteps! - savedlaststeps!; //correct the steps subracting savedlaststeps
          savedlaststeps = stepsData[stepsData.length-1].value!.round(); //update the savedlaststeps to these of the last day fetched
          savedlastdate = DateFormat('yyyy-MM-dd').format(stepsData[stepsData.length-1].dateOfMonitoring!); //update the savedlastdate to the one of the last day fetched
          //print(savedlastdate);
          //print(savedlaststeps);
          //print(sumsteps);
        }

        startdate = stepsData[stepsData.length-1].dateOfMonitoring!; //if i fetch succesfully data, the startdate of the following fetch become last date of monitoring in fetch (last day fetched)
        
        await prefs?.setString('startdate', startdate!.toIso8601String());
        await prefs?.setInt('sumsteps', sumsteps!);
        await prefs?.setInt('savedlaststeps', savedlaststeps!);
        await prefs?.setString('savedlastdate', savedlastdate!);

        errorfetchsteps = false; //i have not an error

      } on Exception catch (tokenerr) { //Exception due to access token or user gives me wrong data to access
        print('tokenerr: $tokenerr');
        errorfetchsteps = true; //i have an error when fetching steps
        print('Need to re-authorize'); //i need to re-authorize --> so set userId to null so when call authorizationFitbit it now checks to authorize
        errorMessage = 'Re-authorize';
        userId = null;
        await prefs?.remove('userId');
      }
       catch (err) {
        print('error fetchsteps: $err');
        errorfetchsteps = true; //i have an error when fetching steps --> for example too many requests
        errorMessage = 'Ops, retry later';
      }
      notifyListeners();
    }
  }
  
  int get getSumSteps => sumsteps!;

  Future<void> clearSumSteps() async { //clear of info i need to perform when i want to take a new Egg or delete the account
    sumsteps = 0; //clear sumsteps value
    await prefs?.setInt('sumsteps', sumsteps!); //set value to 0 (for the new Egg)

    firstabsolutefetch = true; //set first absolute fetch for the new Egg
    await prefs?.setBool('firstabsolutefetch', true);

    await prefs?.remove('savedlaststeps'); //remove and reset savedlaststeps
    savedlaststeps = null;
    await prefs?.remove('savedlastdate'); //remove and reset savedlastdate
    savedlastdate = null;
  }

  Future<void> unauthorize() async { //to unauthorize Fitbit on delete account
    print('Unauthorize');
    await FitbitConnector.unauthorize(
      clientID: '238CG7',
      clientSecret: '6814538ffe2fa5708f85373a80bc2d4e',
    );

    userId = null; //remove the userId
    await prefs?.remove('userId');
  }
}
