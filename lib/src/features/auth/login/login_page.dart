import 'package:barbearia_tcc/src/core/ui/constants.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/form_helper.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/messages.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_state.dart';
import 'package:barbearia_tcc/src/features/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao  realizar login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
        case LoginState(status: LoginStateStatus.employeelogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/employee', (route) => false);
      }
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body: Form(
          key: _formKey,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AssetsImage.background2),
                  fit: BoxFit.cover,
                  opacity: 0.3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AssetsImage.logoBarbearia),
                            TextFormField(
                              validator: Validatorless.multiple([
                                Validatorless.required('E-mail obrigatório'),
                                Validatorless.email('E-mail inválido')
                              ]),
                              controller: _emailEC,
                              onTapOutside: (_) => unfocus(context),
                              decoration: const InputDecoration(
                                label: Text('E-mail'),
                                hintText: 'E-mail',
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            TextFormField(
                              validator: Validatorless.multiple([
                                Validatorless.required('Senha obrigatória'),
                                Validatorless.min(6, 'senha incorreta')
                              ]),
                              controller: _passwordEC,
                              obscureText: true,
                              onTapOutside: (_) => unfocus(context),
                              decoration: const InputDecoration(
                                label: Text('senha'),
                                hintText: 'senha',
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Esqueceu a senha?',
                                style:
                                    TextStyle(color: ColorsConstants.primary),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  //! mesma coisa que
                                  //size(width, height)
                                  //size(double.infinity, 56)
                                  minimumSize: const Size.fromHeight(56)),
                              onPressed: () {
                                switch (_formKey.currentState?.validate()) {
                                  case (false || null):
                                    Messages.showError(
                                        'Campo inválido', context);

                                  case true:
                                    login(
                                        email: _emailEC.text,
                                        password: _passwordEC.text);
                                }
                              },
                              child: const Text('ACESSAR'),
                            )
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/auth/register/user');
                            },
                            child: const Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
