# Sistema de apoio a eventos cientificos

Trabalho da disciplina DCC060 - Banco de dados

## Introdução

Eventos científicos precisam de um sistema para que os usuários possam enviar artigos, avaliadores possam avaliar esses artigos, controle de pagamento das inscrições, etc. Todos os requisitos necessários estão especificados na seção abaixo.

## Requisitos do projeto 

1. O sistema deverá permitir cadastro de usuários no sistema, a partir dos dados: nome, categoria (estudante, professor ou palestrante), e-mail e senha. Se for selecionado estudante ou professor, a universidade deve ser informada.

2. O sistema deverá permitir o login de usuários no sistema, a partir do dados: e-mail e senha.

3. O sistema deverá permitir ao administrador realizar o cadastro de áreas do conhecimento, a partir do dados: área pai (se houver) e nome.

4. O sistema deveŕá permitir ao usuário enviar um artigo, a partir dos dados: título, resumo, co-autores (selecionando usuários pré-cadastrados), arquivo (contendo o artigo), área do conhecimento (selecionando áreas pré-cadastradas) e status (aguardando aprovação, aprovado ou recusado - todos os artigos cadastrados são inicialmente classificados como aguardando aprovação).

5. O sistema deverá permitir ao administrador selecionar um usuário cadastrado e classificá-lo como avaliador de artigos.

6. O sistema deverá permitir a um usuário avaliador aprovar ou recusar artigo que estão aguardando aprovação.

7. O sistema deverá permitir ao palestrante criar eventos, a partir dos dados: nome, data de realização, área do conhecimento, co-palestrantes (selecionando palestrantes pré-cadastrados no sistema), local (país, estado, cidade, logradouro, bairro, cep, número e complemento), artigo relacionado (se houver e se o artigo tiver sido aprovado), data máxima de inscrição, valor e número máximo de participantes.

8. O sistema deverá permitir ao usuário realizar inscrição em um evento, emitindo um ingresso contendo os dados: código, nome do participante, nome do evento, valor e data de emissão.

9. O sistema deverá permitir
