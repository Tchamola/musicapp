import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remonte_repository.dart';
import 'package:client/features/auth/view/pages/login_pages.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_botton.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Connectez-vous ! ",
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 25),
              CustomField(hintText: "Nom", controller: nameController),
              SizedBox(height: 15),
              CustomField(hintText: "Email", controller: emailController),
              SizedBox(height: 15),
              CustomField(
                hintText: "Mot de passe",
                controller: passwordController,
                isObscureText: true,
              ),
              SizedBox(height: 20),
              AuthGradientBotton(
                buttonText: "Connectez-vous",
                onTap: () async {
                  final res = await AuthRemonteRepository().signup(
                    nom: nameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                  );
                  final val = res.fold(
                    (l) => l, // cas Left (erreur)
                    (r) => r.name, // cas Right (succès)
                  );
                  print(val);

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text(val)),
                  // );
                },
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: "Vous n'avez pas un compte? ",
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: "Inscrivez-vous !",
                        style: TextStyle(
                          color: Pallete.gradient2,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
