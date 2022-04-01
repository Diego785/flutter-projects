import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Diego Hurtado Vargas'),
            accountEmail: Text('diegohurtado2412@gmail.com'),
            /*currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  "https://scontent.fvvi1-2.fna.fbcdn.net/v/t39.30808-6/240098961_2009137825918274_2290242819894292169_n.jpg?_nc_cat=105&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Iyl09tHdGAEAX_pkOsu&_nc_oc=AQmbtlEa3qu0vja0zjjptnNUmJA-h1y1jJBv1xhJAaf8G8JL3bogQxGaMbGMx3wTjXQClVbz5RcQWPVDixg4ilz1&_nc_ht=scontent.fvvi1-2.fna&oh=00_AT9bPTulBMOTEqxw-GlClcHvJwudcsu3oig43uHGat-6HA&oe=62100A98",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),*/
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://scontent.fvvi1-1.fna.fbcdn.net/v/t1.6435-9/31120689_183711505587567_2007859058685509632_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=8bfeb9&_nc_ohc=zAUV5JkkAbAAX-tS4HP&_nc_ht=scontent.fvvi1-1.fna&oh=00_AT84DFxqurVqkG1mZC1DnrQqIpz--wKk5Pr7htSbpLOUcw&oe=623119BA"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () => _home(context),
          ),
          ListTile(
            leading: Icon(Icons.bus_alert),
            title: Text("Busses"),
            onTap: () => null,
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
            leading: Icon(Icons.login),
            title: Text("Login"),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}

void _user(BuildContext context) {
  Navigator.of(context).pushNamed("/user");
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
