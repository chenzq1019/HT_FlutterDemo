import 'package:flutter/material.dart';


class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  final String title;
  @override

  //第二步实现按键

  Widget build(BuildContext context) {
    //第一不实现标题行
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Oeschinen Lake Campground",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Kandersteg, Switerland",
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              )
          ),
//          Icon(Icons.star,color: Colors.red[500],),
//          Text("41")
          FavoriteWidget(),
        ],
      ),
    );
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildButtonColum(Colors.blue, Icons.call , "CALL"),
          _buildButtonColum(Colors.blue, Icons.near_me, "ROUTE"),
          _buildButtonColum(Colors.blue, Icons.share, "SHARE")
        ],
      ),
    );
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese'
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run',
        softWrap: true,
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: Center(
        child: ListView(
          children: <Widget>[
            Image.asset("image/lake.jpg",width: 600,height: 240,fit: BoxFit.cover,),
            titleSection,
            buttonSection,
            textSection,
          ],
        ),
      ),
    );
  }


  Column _buildButtonColum(Color color,IconData icon,String label){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon,color: color,),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: color),
          ),
        )
      ],
    );
  }


}

//构建StateFullWidget

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFaovorited = false;
  int _favoriteCount = 41;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
              padding: EdgeInsets.all(0),
              alignment: Alignment.centerRight,
              icon: (_isFaovorited? Icon(Icons.star):Icon(Icons.star_border)),
              color: Colors.red[500],
              onPressed: _toggleFavorite),

        ),
        SizedBox(width: 18,
          child: Text("$_favoriteCount"),),
      ],
    );
  }

  void _toggleFavorite(){
    setState(() {
      if(_isFaovorited){
        _favoriteCount -= 1;
        _isFaovorited = false;
      }else{
        _favoriteCount += 1;
        _isFaovorited = true;
      }
    });
  }
}