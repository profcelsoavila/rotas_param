import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          name:"Home",
          path: "/",
        builder: (context,state) => const HomePage(),
            routes: [
              GoRoute(
                  name: "segunda",
                  //a rota segunda recebe um parâmetro obrigatório nome
                  path: "segunda/:nome",
                  //criação dos queryparams
                  builder: (context, state) {
                    /*envia uma query com um conjunto de parâmetros
                    com chave e valor*/
                    state.uri.queryParameters.forEach(
                          (key, value) {
                        print("$key:$value");
                      },
                    );
                    return SegundaPagina(nome: state.pathParameters["nome"]!);
          })
        ],),
      ],
      //trata o erro 404
      errorBuilder: (context, state) => const PaginaErro(),
    );
    //construir a tela do app baseada na lista de rotas
    return MaterialApp.router(
      //define qual lista de rotas será utilizada
      routerConfig: _router,
      title: 'Exemplo GoRouter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tela Incial"),
      ),
      body: Center(
          child: ElevatedButton(
            //chama a segunda rota, passando um valor para o parâmetro
            //obrigatório nome
            onPressed: () =>
                context.goNamed("segunda", pathParameters: {
                  "nome": "Celso"
                  //envia outros parâmetros por query
                }, queryParameters: {
                  "e-mail": "celso.ramos@unifenas.br",
                  "idade": "50",
                  "cidade": "Alfenas"
                }),
            child: const Text("Ir para a segunda página"),
          )
      ),
    );
  }
}

    class SegundaPagina extends StatelessWidget {
      final String nome;
		  const SegundaPagina({super.key, required this.nome});

		  @override
		  Widget build(BuildContext context) {
		  return Scaffold(
		    appBar: AppBar(
		    //insere o valor do parâmetro nome na barra de título do app
		    title: Text(nome),
		    ),
		    body: Center(
		    child: ElevatedButton(
		        onPressed: () => context.go("/"),
		        child: const Text('Ir para a página Inicial')),
		    ),
		  );
		}
	}

class PaginaErro extends StatelessWidget {
  const PaginaErro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tela de Erro'),
        ),
        body: Center(
            child: ElevatedButton(
              onPressed: () => context.go("/"),
              child: const Text('Voltar para página inicial'),
            )));
  }
}
