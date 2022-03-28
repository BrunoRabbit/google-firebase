import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_google_bloc/blocs/auth/auth_bloc.dart';
import 'package:firebase_google_bloc/blocs/pass_visibility/pass_visibility_bloc.dart';
import 'package:firebase_google_bloc/repositories/auth_repository.dart';
import 'package:firebase_google_bloc/views/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void application() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const Application(),
  );
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PassVisibilityBloc>(
            create: (context) => PassVisibilityBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            ),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: RegisterView(),
        ),
      ),
    );
  }
}
