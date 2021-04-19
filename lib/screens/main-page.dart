import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/app-model.dart';
import '../screens/setup-page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),
            if (appModel.otpList.length > 0) CircularProgressIndicator(  
              strokeWidth: 8,  
              backgroundColor: Colors.grey[200],  
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),  
              value: appModel.progress,  
            ),
            SizedBox(height: 15,),  
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(width: 0.5, color: Colors.lightBlueAccent, style: BorderStyle.solid),
                bottom: BorderSide(width: 0.5, color: Colors.lightBlueAccent, style: BorderStyle.solid)
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(20),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(140),
                3: FixedColumnWidth(50),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                for (var otp in appModel.otpList) 
                  TableRow(children: [
                      SizedBox(width: 10,),
                      Text('${otp.name}', style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.left,),
                      Text('${otp.value}', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.right,),
                      IconButton(icon: Icon(Icons.delete), onPressed: () => appModel.deleteOTP(otp.uuid))
                  ]
                ),
              ]
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SetupPage(title: 'Setup new account')),
            );
          },
          child: Icon(Icons.add),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }
}

