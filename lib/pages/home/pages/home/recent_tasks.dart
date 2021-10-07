import 'package:flutter/material.dart';
import 'package:makerequest/utils/app_extension.dart';
import 'package:makerequest/utils/app_style.dart';
import 'package:makerequest/widgets/a_item_task.dart';
class RecentTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          borderRadius:const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          gradient:const LinearGradient(
            colors: [
              Colors.white,
              Color.fromRGBO(252,	251	,252	, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset:const Offset(0, 5), // changes position of shadow
            ),
          ]
      ),
      padding: EdgeInsets.only(
          left: 25.W, right: 25.W, top: 30.H),
      margin: EdgeInsets.only(top: 20.H),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Request',
            style: txt18BoldRoboto(),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(top:15.H,bottom:50.H),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:  EdgeInsets.only(bottom: 10.H),
                    child: AItemTask(),
                  );
                }),
          )
        ],
      ),
    );
  }
}
