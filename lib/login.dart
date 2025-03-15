import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/shared_prefs_provider.dart';
import 'providers/token_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool register = false;
  //final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();
  

  final registerAddress = Uri(
    scheme: 'http',
    host: '192.168.1.101',
    port: 5000,
    path: '/register'
  );
  final loginAddress = Uri(
    scheme: 'http',
    host: '192.168.1.101',
    port: 5000,
    path: '/login'
  );

  Future<void> _authenticate() async {
    if (_formKey.currentState?.validate() == false) return;

    if (register == true) {
      if (_formKey.currentState?.fields["password_confirmation"]?.value != _formKey.currentState?.fields["password"]?.value) {
        _formKey.currentState?.fields["password_confirmation"]?.invalidate("Password confirmation does not match.");
        return;
      }
      http.Response response = await http.post(registerAddress, body : {
        "email" : _formKey.currentState?.fields["email"]?.value,
        "password" : _formKey.currentState?.fields["password"]?.value
      });
      if (response.statusCode == 200 && response.body == 'Success' ) {
        // Registration successful - todo, put a message for successful registration
      }
    }
    else {
      SharedPreferencesWithCache prefs = ref.read(sharedPreferences);
      http.Response response = await http.post(loginAddress, body: {
        "email" : _formKey.currentState?.fields["email"]?.value,
        "password" : _formKey.currentState?.fields["password"]?.value 
      });
      if (response.statusCode == 200) {
        String? cookie = response.headers["set-cookie"];
        if (cookie != null) {
          int index = cookie.indexOf(';');
          String accessToken = cookie.substring(13, index);
          int index2 = cookie.indexOf("refresh_token=");
          index = cookie.indexOf(";", index2);
          String refreshToken = cookie.substring(index2+14, index);
          prefs.setString("access_token", accessToken);
          prefs.setString("refresh_token", refreshToken);
          ref.read(TokenNotifierProvider("access_token").notifier).update(accessToken);
          ref.read(TokenNotifierProvider("refresh_token").notifier).update(refreshToken);
        }
      }
    }
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Success',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        body: FormBuilder(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 50), //replace with fancy banner thing maybe
                FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.vpn_key),
                    labelText: 'Password',
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.password(minLength: 8, minUppercaseCount: 0, minLowercaseCount: 0, minNumberCount: 0, minSpecialCharCount: 0),
                  ]),
                ),
                if (register == true)
                  FormBuilderTextField(
                    name: 'password_confirmation',
                    obscureText: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Password Confirmation',
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.password(minLength: 8, minUppercaseCount: 0, minLowercaseCount: 0, minNumberCount: 0, minSpecialCharCount: 0),
                    ]),
                  ),
                SizedBox(height:20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _authenticate,
                  child: Text(
                    register == true ? 'Register' : 'Login',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    )
                  ),
                ),
                SizedBox(height:10),
                InkWell(
                  onTap: () {
                    setState(() => register = !register);
                    _formKey.currentState?.reset();
                  },
                  child: Text(
                    register == true ? 'Login' : 'Register',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
