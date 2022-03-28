import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_google_bloc/blocs/auth/auth_bloc.dart';
import 'package:firebase_google_bloc/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final user = FirebaseAuth.instance.currentUser!;
  final firestoreRef = FirebaseFirestore.instance;
  List<String> itemList = [
    'Sair',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuth) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: const Text('Home Page'),
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                onChanged: (a) {
                  context.read<AuthBloc>().add(SignOutRequested());
                },
                items: itemList
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                icon: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: const Icon(
                    FeatherIcons.logOut,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: user.displayName == null
                    ? Container(
                        height: 150,
                        width: 150,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(
                              'https://www.freeiconspng.com/download/23494',
                            ),
                          ),
                        ),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.transparent,
                        backgroundImage: NetworkImage(
                          user.photoURL!,
                        ),
                      ),
              ),
              user.displayName != null
                  ? Text(
                      'Olá, ${user.displayName![0].toUpperCase()}${user.displayName!.substring(1).toLowerCase()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream: firestoreRef.collection('Users').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<QueryDocumentSnapshot<Object?>> items =
                              snapshot.data!.docs;

                          return Text(
                            'Olá, ' + items[0]['displayName'],
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 24,
                            ),
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Autenticado!!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
