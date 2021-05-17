import 'package:dartcompiler/authentication/bloc/auth_bloc/auth_bloc.dart';
import 'package:dartcompiler/authentication/bloc/auth_bloc/auth_event.dart';
import 'package:dartcompiler/authentication/bloc/auth_bloc/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //TODO: Make User Header Dynamic
        const UserAccountsDrawerHeader(
          accountName: Text('Aadarsha Dhakal'),
          accountEmail: Text('braveboy2058@gmail.com'),
        ),
        Expanded(
          child: Container(),
        ),
        InkWell(
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(
              UserLogoutButtonPressedEvent(),
            );
          },
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LogoutFailedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${state.message}'),
                  ),
                );
              } else if (state is UnAuthenticatedState) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/loginpage',
                  ModalRoute.withName('/invalid'),
                );
              }
            },
            builder: (context, state) {
              if (!(state is LogoutLoadingState)) {
                return Container(
                  width: 100,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                        color: Colors.blue,
                      )),
                  child: const Center(child: Text('Sign out')),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: 'Powered by:  ',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => {await launch('https://appwrite.io')},
                text: 'Appwrite',
                style: const TextStyle(
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}