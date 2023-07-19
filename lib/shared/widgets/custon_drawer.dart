import 'package:appheroes/pages/heroes/characters_page.dart';
import 'package:appheroes/pages/home.dart';
import 'package:flutter/material.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    Color lighterColor = primaryColor.withOpacity(0.8);
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (BuildContext bc) {
                    return Wrap(
                      children: [
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Camera"),
                          leading: const Icon(Icons.camera),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          title: const Text("Galeria"),
                          leading: const Icon(Icons.album),
                        )
                      ],
                    );
                  });
            },
            child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: lighterColor),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Image.network(
                      "https://preview.redd.it/fv442lxogma71.jpg?width=1080&crop=smart&auto=webp&s=f40c7d5e707bcbdc0dfbd666fb722a6d790bbb98"),
                ),
                accountName: const Text("Arlindo"),
                accountEmail: const Text("email@email.com")),
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (bc) => const HomePage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    Icon(Icons.home),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Home"),
                  ],
                )),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () async {
              Navigator.pop(context);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (bc) => const CharactersPage()));
            },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    Icon(Icons.art_track),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Heroes"),
                  ],
                )),
          ),
          const Divider(),
          Expanded(
            child: Container(),
          ),
          InkWell(
            onTap: () {},
            child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                width: double.infinity,
                child: Row(
                  children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sair"),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
