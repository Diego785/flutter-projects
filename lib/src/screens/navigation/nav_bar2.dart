import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:terminal_bimodal/src/screens/auth/auth.dart';
import 'package:terminal_bimodal/src/screens/auth/login2.dart';
import 'package:terminal_bimodal/src/screens/welcome/welcome_page.dart';

class NavBar2 extends StatelessWidget {
  const NavBar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(child: Consumer<Auth>(builder: (context, auth, child) {
      if (!auth.authenticated) {
        return ListView(
          children: [
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage2()));
              },
            ),
          ],
        );
      } else {
        String cargo;
        print(auth.user.idChofer.toString());
        if (auth.user.idChofer.toString() != "null") {
          cargo = "Chofer";
        } else {
          cargo = "Administrativo";
        }
        return ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(auth.user.name + " - " + cargo),
              accountEmail: Text(auth.user.email),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(auth.user.avatar),
                radius: 30,
                /*child: ClipOval(
                  child: Image.network(
                    "https://scontent.fvvi1-2.fna.fbcdn.net/v/t39.30808-6/240098961_2009137825918274_2290242819894292169_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Iyl09tHdGAEAX_pkOsu&_nc_oc=AQmbtlEa3qu0vja0zjjptnNUmJA-h1y1jJBv1xhJAaf8G8JL3bogQxGaMbGMx3wTjXQClVbz5RcQWPVDixg4ilz1&_nc_ht=scontent.fvvi1-2.fna&oh=00_AT9bPTulBMOTEqxw-GlClcHvJwudcsu3oig43uHGat-6HA&oe=62100A98",
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
              /*decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://scontent.fvvi1-1.fna.fbcdn.net/v/t1.6435-9/31120689_183711505587567_2007859058685509632_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=zAUV5JkkAbAAX-tS4HP&_nc_ht=scontent.fvvi1-1.fna&oh=00_AT84DFxqurVqkG1mZC1DnrQqIpz--wKk5Pr7htSbpLOUcw&oe=623119BA"),
                  fit: BoxFit.cover,
                ),
              ),*/
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text("Dashboard"),
              onTap: () => _home(context),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text("Personal"),
              onTap: () => _connection(context),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Users"),
              onTap: () => _user(context),
            ),
            ListTile(
              leading: Icon(Icons.person_pin_rounded),
              title: Text("Chofers"),
              onTap: () => _chofer(context),
            ),
            ListTile(
              leading: Icon(Icons.bus_alert),
              title: Text("Busses"),
              onTap: () => _bus(context),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text("Users"),
              onTap: () => _user2(context),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Share"),
              onTap: () => null,
              trailing: ClipOval(
                child: Container(
                  color: Colors.red,
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Text(
                      '8',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => WelcomePage()));
              },
            ),
          ],
        );
      }
    }));
  }
}

void _user(BuildContext context) {
  Navigator.of(context).pushNamed("/user");
}

void _chofer(BuildContext context) {
  Navigator.of(context).pushNamed("/chofer");
}

void _bus(BuildContext context) {
  Navigator.of(context).pushNamed("/bus");
}

void _user2(BuildContext context) {
  Navigator.of(context).pushNamed("/user2");
}

void _connection(BuildContext context) {
  Navigator.of(context).pushNamed("/usersApi");
}

void _home(BuildContext context) {
  Navigator.of(context).pushNamed("/home");
}
