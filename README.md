# Sistema de apoio a eventos cientificos

Trabalho da disciplina DCC060 - Banco de dados

## Introdução

Eventos científicos precisam de um sistema para que os usuários possam enviar artigos, avaliadores possam avaliar esses artigos, controle de pagamento das inscrições, etc. Todos os requisitos necessários estão especificados na seção abaixo.

## Requisitos do projeto 

1. O sistema deverá permitir cadastro de participantes no sistema, a partir dos dados: nome, e-mail e senha.

2. O sistema deverá permitir o login de participantes no sistema, a partir do dados: e-mail e senha.

3. O sistema deverá permitir ao administrador realizar o cadastro de áreas do conhecimento, a partir do dados: área pai (se houver) e nome.

4. O sistema deveŕá permitir ao participante enviar um artigo, a partir dos dados: título, resumo, co-autores (selecionando participantes pré-cadastrados e, caso um dos co-autores não seja cadastrado, informar o nome do mesmo), arquivo (contendo o artigo em si em formato PDF), área do conhecimento (selecionando áreas pré-cadastradas) e status (aguardando aprovação, aprovado ou recusado - todos os artigos cadastrados são inicialmente classificados como aguardando aprovação).

5. O sistema deverá permitir ao administrador selecionar um participante cadastrado e classificá-lo como avaliador de artigos.

6. O sistema deverá permitir a um participante avaliador aprovar ou recusar artigos que estão aguardando aprovação.

7. O sistema deverá permitir ao participante criar evento como palestrante, a partir dos dados: nome, data de realização, área do conhecimento, co-palestrantes (selecionando participantes pré-cadastrados no sistema), horário de começo, horário de termino, local (país, estado, cidade, logradouro, bairro, cep, número e complemento), artigo relacionado (se houver e se o artigo tiver sido aprovado), data máxima de inscrição, descrição, valor, formas de pagamento (cartão de crédito, boleto ou transferência bancária), e número máximo de participantes.

8. O sistema deverá permitir ao usuário realizar inscrição em um evento, emitindo um ingresso contendo os dados: código, nome do participante, nome do evento, valor, status do pagamento (aguardando aprovação, aprovado ou recusado), forma de pagamento e data de emissão.

9. O sistema deverá permitir ao participante gerar um certificado de um evento que o mesmo participou, contendo os dados: nome do evento, nome do participante, data de realização do evento e carga horária.
