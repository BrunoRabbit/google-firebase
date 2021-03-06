import 'package:email_validator/email_validator.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_google_bloc/blocs/auth/auth_bloc.dart';
import 'package:firebase_google_bloc/blocs/pass_visibility/pass_visibility_bloc.dart';
import 'package:firebase_google_bloc/views/login/login_view.dart';
import 'package:firebase_google_bloc/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key}) : super(key: key);

  @override
  State<RegisterComponent> createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  late final TextEditingController _controllerEmail;
  late final TextEditingController _controllerPassword;
  late final TextEditingController _controllerUsername;
  final _formKey = GlobalKey<FormState>();
  late AuthBloc _authBloc;
  late PassVisibilityBloc _passBloc;

  @override
  void initState() {
    _controllerUsername = TextEditingController();
    _controllerEmail = TextEditingController();
    _controllerPassword = TextEditingController();
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _passBloc = BlocProvider.of<PassVisibilityBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  void _createAccountWithEmailAndPassword(context) {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        SignUpRequested(
          _controllerEmail.text,
          _controllerPassword.text,
          _controllerUsername.text,
        ),
      );
    }
  }

  void _authenticateWithGoogle(context) {
    _authBloc.add(
      GoogleSignInRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: 665,
            child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Registrar",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        'Crie sua nova conta',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextFormField(
                        isObscureText: false,
                        controller: _controllerEmail,
                        isNeedContrast: false,
                        hintText: 'E-mail',
                        validator: (value) {
                          return value != null &&
                                  !EmailValidator.validate(value)
                              ? 'Email inv??lido!'
                              : null;
                        },
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.orange,
                        ),
                      ),
                      CustomTextFormField(
                        isObscureText: false,
                        controller: _controllerUsername,
                        isNeedContrast: false,
                        hintText: 'Usuario',
                        validator: (value) {
                          return value!.isEmpty
                              ? 'Nome n??o pode ser vazio!'
                              : null;
                        },
                        suffixIcon: const Icon(
                          FeatherIcons.user,
                          color: Colors.orange,
                        ),
                      ),
                      BlocBuilder<PassVisibilityBloc, PassVisibilityState>(
                        bloc: _passBloc,
                        builder: (context, state) {
                          return CustomTextFormField(
                            isObscureText: state.isObscureText,
                            controller: _controllerPassword,
                            isNeedContrast: false,
                            hintText: 'Senha',
                            validator: (value) {
                              return value != null && value.length < 6
                                  ? "Tenha no min. 6 caracteres!"
                                  : null;
                            },
                            suffixIcon: InkWell(
                              onTap: () {
                                _passBloc.add(
                                  ChangeVisibility(!state.isObscureText),
                                );
                              },
                              child: state.isObscureText
                                  ? const Icon(
                                      FeatherIcons.eyeOff,
                                      color: Colors.orange,
                                    )
                                  : const Icon(
                                      FeatherIcons.eye,
                                      color: Colors.orange,
                                    ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 1.40,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrangeAccent,
                            ),
                            child: const Text(
                              'Registrar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () =>
                                _createAccountWithEmailAndPassword(context),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'ou',
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.40,
                        height: 50,
                        child: ElevatedButton.icon(
                          icon: SvgPicture.asset(
                            'assets/svgs/google-logo.svg',
                          ),
                          label: const Text(
                            'Registrar com o Google',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              // side: const BorderSide(
                              //   color: Colors.black54,
                              // ),
                            ),
                          ),
                          onPressed: () => _authenticateWithGoogle(context),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'J?? tem uma conta?',
                        style: TextStyle(
                          color: Colors.black87.withOpacity(0.5),
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
