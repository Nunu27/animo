import 'package:animo/controllers/auth_controller.dart';
import 'package:animo/widgets/custom_input_form.dart';
import 'package:animo/widgets/loader_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  bool passwordLocked = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    FocusManager.instance.primaryFocus?.unfocus();
    ref.read(authControllerProvider.notifier).signIn(
          context: context,
          email: emailController.text,
          password: passwordController.text,
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLoading = ref.watch(authControllerProvider);

    return LoaderOverlay(
      isLoading: isLoading,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  const Center(
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        image: AssetImage('assets/images/icon.png'),
                        height: 150,
                        width: 150,
                      ),
                    ),
                  ),
                  Text(
                    'Animo',
                    style: theme.textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'all your weebs stuff in a single app',
                    style: theme.textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  CustomInputForm(
                    controller: emailController,
                    hintText: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomInputForm(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: passwordLocked,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordLocked = !passwordLocked;
                        });
                      },
                      icon: Icon(
                        passwordLocked
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      child: Text(
                        'Forgot password',
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  FilledButton(
                    onPressed: signIn,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SignIn'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const Row(
                    children: [
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(child: Divider()),
                      SizedBox(
                        width: 14,
                      ),
                      Text('or'),
                      SizedBox(
                        width: 14,
                      ),
                      Expanded(child: Divider()),
                      SizedBox(
                        width: 14,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      FilledButton.icon(
                        onPressed: () {},
                        label: const Text('Google'),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                          foregroundColor: Colors.black87,
                        ),
                        icon: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset('assets/images/google.png'),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () {},
                        label: const Text('MAL'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff2e51a2),
                          foregroundColor: Colors.white,
                        ),
                        icon: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset('assets/images/mal.png'),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () {},
                        label: const Text('Anilist'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff2b2d42),
                          foregroundColor: Colors.white,
                        ),
                        icon: SizedBox(
                          height: 24,
                          width: 24,
                          child: Image.asset('assets/images/anilist.png'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  OutlinedButton(
                    onPressed: () => context.go('/explore'),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Login as guest'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have account yet?",
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      GestureDetector(
                        child: Text(
                          'Register!',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
