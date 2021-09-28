import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter4_planner/widgets/chart.dart';
import 'package:flutter4_planner/widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'flutter app',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                button: TextStyle(color:Colors.white),
              ),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  
                ),
          ),
        
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'beer',
    //   amount: 170,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'RUM',
    //   amount: 170,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart=false;
  List<Transaction> get _recentTranstions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount,DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }
   void _deleteTransaction(String id){
     setState(() {
       _userTransactions.removeWhere((tx) {
         return tx.id==id;
       });
     });
   }
   List <Widget> _buildLandscapeContent(Widget txListWidget,AppBar appBar){
     return [Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text( "switch to chart",style: Theme.of(context).textTheme.title,),
              Switch.adaptive(activeColor: Theme.of(context).accentColor,
                value: _showChart,
              onChanged: (val){
                setState(() {
                  _showChart=val;

                });
              },)
            ],),_showChart? Container(height: 
            (MediaQuery.of(context).size.height-appBar.preferredSize.height
            -MediaQuery.of(context).padding.top)*.7,
              child: Chart(_recentTranstions))
           : txListWidget,];
   }


   List <Widget> _buildPortraitContent(AppBar appBar,Widget txListWidget )
   {
    return [Container(height: 
            (MediaQuery.of(context).size.height-appBar.preferredSize.height
            -MediaQuery.of(context).padding.top)*.3,
              child: Chart(_recentTranstions)),txListWidget];
   }
   Widget _getAppBar()
   {
     return Platform.isIOS? CupertinoNavigationBar(
       middle: Text('Personal Expenses'),
       trailing: Row(mainAxisSize: MainAxisSize.min,
         children: [
         GestureDetector(
         child: Icon(CupertinoIcons.add),
         onTap:  () => _startAddNewTransaction(),
       ),],),
     ): AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(),
          ),
        ],
      );
   }
  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
    // String titleInput;
    // String amountInput;
     final PreferredSizeWidget appBar=_getAppBar();
      final txListWidget=Container(height: 
            (MediaQuery.of(context).size.height-appBar.preferredSize.height
            -MediaQuery.of(context).padding.top)*.75,
              child: TransactionList
              (_userTransactions,_deleteTransaction));
       final pageBody=SafeArea(child:SingleChildScrollView
       (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if(isLandscape)
            ..._buildLandscapeContent(txListWidget,appBar),
            
            if(!isLandscape)
            ..._buildPortraitContent(appBar,txListWidget),
           ],
        ),
       ),
      );
    return Platform.isIOS? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar ,
      ) 
    
    :Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:Platform.isIOS?Container() : FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction();
        },
      ),
    );
  }
}
