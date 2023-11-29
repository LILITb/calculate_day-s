import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: " Calculate day's ",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Counting down the days'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String startDay = "Enter start day";
  String endDay = "Enter end day";
  String? calculateDay = '';
  DateTime _startDate = new DateTime.now();
  DateTime _endDate = new DateTime.now();
  DateTime? newDate1;
  DateTime? newDate2;
   _selectStartDate(BuildContext context) async {
     newDate1 = (await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2200),
    ));
    if (newDate1 != null) {
      setState(() {
        startDay = new DateFormat('EEE d MMM').format(newDate1!).toString();
      });
    }
  }

   _selectEndDate(BuildContext context) async {
    newDate2 = (await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2200),
    ));
    if (newDate2 != null) {
      setState(() {
        endDay = new DateFormat('EEE d MMM').format(newDate2!).toString();
      });
    }
  }

   _compareTimes() {
    setState(() {
      if (newDate1 != null && newDate2 != null) {
       if(newDate1!.isBefore(newDate2!)){
         var calcDay = newDate2!.difference(newDate1!).inDays;
         var d = calcDay >1 ? " days":' day';
         calculateDay = calcDay.toString() + d;
       }else{calculateDay ="The end date cannot be less than the start date";}
      } else {
        calculateDay = "Enter start and end dates";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(calculateDay!,textAlign:TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w600, color: Colors.black38),),
            SizedBox(height: 150),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _selectStartDate(context),
                  child: Text(startDay),
                  style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(Size.fromWidth(150))),
                ),
                ElevatedButton(
                  onPressed: () => _selectEndDate(context),
                  child: Text(endDay),
                  style: ButtonStyle(
                      fixedSize:
                          MaterialStateProperty.all(Size.fromWidth(150))),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _compareTimes,
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      fixedSize:
                          MaterialStateProperty.all(Size.fromWidth(250))),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
