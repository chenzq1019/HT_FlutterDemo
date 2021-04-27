import 'package:flutter/material.dart';


class Todo{
  final String title;
  final String description;
  Todo(this.title,this.description);
}

//final todos1 = List<Todo>.generate(20, (index) => Todo("Todo $index", "A description of what needs to be donw for Todo $index"));


class TodeScreen extends StatelessWidget {
  final List<Todo> todos;
  TodeScreen({Key key,@required this.todos}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todos"),),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index){
            return ListTile(
              title: Text(todos[index].title),
              onTap: (){
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailScreen(todo: todos[index]))
                );
              },
            );
          },

          ),
    );
  }
}


class DetailScreen extends StatelessWidget {
  final Todo todo;
  DetailScreen({Key key, this.todo}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(todo.title),),
//      body: Padding(
//        padding: EdgeInsets.all(16.0),
//        child: Text(todo.description),
//      ),
       body: ListView(children: [
         TestContainer(),
         CustemButton(width: 200 ,height:80),

       ],),
    );
  }
}

class TestContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.subtitle1.fontSize * 1.1 + 200,
      ),
      decoration: BoxDecoration(
        border: Border.all(width: 2.0,color: Colors.red),
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        image: DecorationImage(
          image: NetworkImage("http://h.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0d023672312ac65c67506e77cec29e27/9f2f070828381f30dea167bbad014c086e06f06c.jpg"),
          centerSlice: Rect.fromLTRB(270, 180, 1360, 730),
        ),
      ),
      padding: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text("Hello World", style: TextStyle(color: Colors.red),),
      transform: Matrix4.rotationZ(0.3),
    );
  }
}

class CustemButton extends StatelessWidget {
  final double height;
  final double width;
  CustemButton({Key key,this.height,this.width}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.all(Radius.circular(this.height /2.0)),

      ),
      child: GestureDetector(
        child: Text("I am a Custem button", style: TextStyle(fontSize: 20),),
        onTap: (){
          print("====button click ===");
        },
      ),
      alignment: Alignment.center,
      width: width,
      height: height,
    );
  }
}


