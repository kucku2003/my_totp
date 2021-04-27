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
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext bc) => [
                PopupMenuItem (
                  child: Row (
                    children: <Widget> [
                      Icon(Icons.info, size: 28, color: Colors.blue,),
                      SizedBox(width: 6,),
                      Text('About'),
                    ],
                  ),
                  value: "/about"
                ),
              ], 
              onSelected: (route) {
                Navigator.pushNamed(context, route);
              },
            )
          ]
        ),
        body: Column(
          children: [
            SizedBox(height: 6,),  
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(width: 0.5, color: Colors.lightBlueAccent, style: BorderStyle.solid),
                bottom: BorderSide(width: 0.5, color: Colors.lightBlueAccent, style: BorderStyle.solid)
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(20),
                1: FixedColumnWidth(20),
                2: FlexColumnWidth(),
                3: FixedColumnWidth(140),
                4: FixedColumnWidth(14),
                5: FixedColumnWidth(20),
                6: FixedColumnWidth(14),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                for (var otp in appModel.otpList) 
                  TableRow(children: [
                    IconButton(icon: Icon(Icons.delete), onPressed: () => {
                      showDialog(
                        context: context, 
                        builder: (_) => AlertDialog(
                          title: Text("Remove account?", style: Theme.of(context).textTheme.headline6, textAlign: TextAlign.left,),
                          content: Text('${otp.name}', style: Theme.of(context).textTheme.bodyText2, textAlign: TextAlign.left,),
                          elevation: 24,
                          actions: [
                            TextButton(
                              autofocus: false,
                              child: Text("Yes", style: TextStyle(fontSize: 18)), 
                              onPressed: () => {
                                appModel.deleteOTP(otp.uuid),
                                Navigator.pop(context),
                              }
                            ),
                            TextButton(                      
                              autofocus: true,
                              child: Text("No", style: TextStyle(color: Colors.red, fontSize: 18)), 
                              onPressed: () => Navigator.pop(context)
                            ),
                          ],
                        ),
                        barrierDismissible: false,
                      ),
                    }),
                    SizedBox(width: 10),
                    Text('${otp.name}', style: Theme.of(context).textTheme.subtitle1, textAlign: TextAlign.left,),
                    Text('${otp.value}', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.right,),
                    SizedBox(width: 10),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(  
                        strokeWidth: 6,  
                        backgroundColor: Colors.grey[300],  
                        valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),  
                        value: otp.progress,  
                      ),
                    ),
                    SizedBox(width: 10),
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

