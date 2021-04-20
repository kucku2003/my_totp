import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  AboutPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding (
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget> [
                SizedBox(height: 15),
                Text('Version', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.left,),
                Text('1.0.0', style: Theme.of(context).textTheme.overline, textAlign: TextAlign.left,),
                SizedBox(height: 15),
                Text('Contact', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.left,),
                Text('dnt_84@yahoo.com', style: Theme.of(context).textTheme.overline, textAlign: TextAlign.left,),
                SizedBox(height: 15),
                Text('Source', style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.left,),
                Text('https://github.com/kucku2003/simple_totp_authenticator', style: TextStyle(fontSize: 11, ), textAlign: TextAlign.left,),
                SizedBox(height: 15),
              ]
            ),
          ),
          new Expanded(
            child: new Align (
              alignment: Alignment.bottomCenter,
              child: new Row (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Padding (
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text('@github kucku2003 - 2021', style: Theme.of(context).textTheme.overline, textAlign: TextAlign.center,),
                  )
                ],
              )
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pop(context)
        },
        child: Icon(Icons.arrow_back),
      ), 
    );
  }

}

