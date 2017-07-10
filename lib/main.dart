import 'package:flutter/material.dart';
import 'package:ski_park/components/cams/cams.dart';
import 'package:ski_park/components/deals/deals.dart';
import 'package:ski_park/components/events/events.dart';

void main() {
  runApp(new MainScaffold());
}

class MainScaffold extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Ski Park",
      home: new SkiParkHome(),
    );
  }
}

enum Section {
  cams,
  deals,
  events
}

class SkiParkHomeState extends State<SkiParkHome> {

  Section section = Section.cams;

  @override
  Widget build(BuildContext context) {
    var drawer = new Drawer(
        child: new ListView(
          children: _menuSections(context),
          primary: true,
        )
    );
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Mt. Shasta Ski Park"),
        ),
        drawer: drawer,
      body: currentSectionWidget,
    );
  }

  List<Widget> _menuSections(BuildContext context) {
    var sections = new List();

    var header = new DrawerHeader(
      decoration: new BoxDecoration(
          color: Theme.of(context).accentColor
      ),
      child: new Column(
        children: <Widget>[
          new Card(
            child: new Container(
              margin: new EdgeInsets.all(10.0),
              child: new Image.network("https://www.skipark.com/wp-content/uploads/2016/11/Shasta-Logo-New-22-Nov-2016.png")
            ),
            elevation: 1.0,
          ),
          new Padding(padding: new EdgeInsets.only(top: 16.0)),
          new Text("Current Temp: 78°",
            style: new TextStyle(color: Colors.white)
            )
        ],
      ),
    );

    sections.add(header);
    var camSection = new ListTile(
      title: new Text("Cams"),
      subtitle: new Text("See the latest snowfall. Get excited!"),
      leading: const Icon(Icons.camera),
      onTap: () => showCams(context),
      key: new Key("cams"),
      selected: section == Section.cams,
    );
    sections.add(camSection);

    var dealsSection = new ListTile(
      title: new Text("Deals"),
      subtitle: new Text("Find awesome places to stay & eat"),
      leading: const Icon(Icons.shop),
      onTap: () => showDeals(context),
      key: new Key("deals"),
      selected: section == Section.deals,
    );
    sections.add(dealsSection);

    var eventsSection = new ListTile(
      title: new Text("Events"),
      subtitle: new Text("What's happening around Mt. Shasta"),
      leading: const Icon(Icons.event),
      onTap: () => showEvents(context),
      selected: section == Section.events,
    );
    sections.add(eventsSection);
    return sections;
  }

  showCams(BuildContext context) {
    setState(() => section = Section.cams);
    Navigator.pop(context);
  }
  showDeals(BuildContext context) {
    setState(() => section = Section.deals);
    Navigator.pop(context);
  }

  showEvents(BuildContext context) {
    setState(() => section = Section.events);
    Navigator.pop(context);
  }

  Widget get currentSectionWidget {
    switch (section) {
      case Section.cams:
        return new Cams();
      case Section.deals:
        return new Deals();
      case Section.events:
        return new Events();
    }
    return null;
  }
}

class SkiParkHome extends StatefulWidget {

  @override
  State createState() => new SkiParkHomeState();
}