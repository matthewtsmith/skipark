import 'package:flutter/material.dart';

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Friendly Chat",
      home: new ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _textController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  @override
  void dispose() {
    for(ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Friendly Chat"),
        ),
        body: new Column(
          children: <Widget>[
            new Flexible(
                child: new ListView.builder(
                  itemBuilder: (_, int index) => _messages[index],
                  padding: new EdgeInsets.all(8.0),
                  reverse: true,
                  itemCount: _messages.length,
                )
            ),
            new Divider(height: 1.0),
            new Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        )
    );
  }

  Widget _buildTextComposer() {
    var container =  new Container(
      margin: new EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                onChanged:  _updateComposing,
                decoration:
                new InputDecoration.collapsed(hintText: "Send a message"),
              )),
          new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: _isComposing ? () =>_handleSubmitted(_textController.text) : null
              )
          )
        ],
      ),
    );
    return new IconTheme(
        data: new IconThemeData(color: Theme.of(context).accentColor),
        child: container
    );
  }

  void _handleSubmitted(String text) {
    var message = new ChatMessage(
      text: text,
      animationController: new AnimationController(
          vsync: this,
          duration: new Duration(milliseconds: 300)
      ),
    );
    setState(() {
      _messages.insert(0, message);
      _isComposing = false;
    });
    _textController.clear();
    message.animationController.forward();
  }

  void _updateComposing(String text) {
    var composing = text.length > 0;
    setState(() {
      _isComposing = composing;
    });
  }
}

const String _name = "Matthew";
class ChatMessage extends StatelessWidget  {

  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    var mainContainer = new Container(
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          avatarImage(),
          userInfoColumn(context, text)
        ],
      ),
    );
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: mainContainer,
    );
  }

  Widget avatarImage() {
    return new Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: new CircleAvatar(
        child: new Text(_name[0]),
      ),
    );
  }

  Widget userInfoColumn(BuildContext context, String text) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(_name, style: Theme.of(context).textTheme.subhead),
        new Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: new Text(text),
        )
      ],
    );
  }

}