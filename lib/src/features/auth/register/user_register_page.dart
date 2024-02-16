import 'package:barbearia_tcc/src/core/ui/helpers/form_helper.dart';
import 'package:barbearia_tcc/src/core/ui/helpers/messages.dart';
import 'package:barbearia_tcc/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError(
            'Erro ao criar conta',
            context,
          );
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameEC,
                  validator: Validatorless.required('Nome Obrigatório'),
                  onTapOutside: (_) => unfocus(context),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail Obrigatório'),
                    Validatorless.email('E-mail inválido'),
                  ]),
                  onTapOutside: (_) => unfocus(context),
                  decoration: const InputDecoration(
                    label: Text('E-mail'),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _passwordEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha Obrigatória'),
                    Validatorless.min(6, 'Senha muito curta'),
                  ]),
                  onTapOutside: (_) => unfocus(context),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  validator: Validatorless.multiple([
                    Validatorless.required('confirma Senha Obrigatória'),
                    Validatorless.compare(_passwordEC, 'senhas não conferem')
                  ]),
                  onTapOutside: (_) => unfocus(context),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Confirmar senha'),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (_formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Formulário inválido', context);

                      case true:
                        userRegisterVm.register(
                          name: _nameEC.text,
                          email: _emailEC.text,
                          password: _passwordEC.text,
                        );
                    }
                  },
                  child: const Text('Cadastrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
