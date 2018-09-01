# Sistema de apoio a eventos científicos

Trabalho da disciplina DCC060 - Banco de dados

## Introdução

O Brasil, apesar das dificuldades enfrentadas, é um pais com uma enorme comunidade científica e que conta com uma grande diversidade de eventos científicos nas mais variadas áreas, indo desde as Ciências Humanas até as Ciências Exatas e Engenharias.
Uma vez que tais eventos, devido à grande extensão do nosso país, ocorrem de maneira paralela e em diversos estados diferentes, enxerga-se a necessidade de tornar a divulgação destes eventos científicos mais abrangente e centralizada. Partindo desta premissa, participantes de eventos científicos terão maior facilidade para buscar eventos de seus interesses em suas regiões, enquanto que palestrantes e organizações poderão divulgar e detalhar com mais propriedade seus eventos científicos. 
Este documento propõe o modelo de uma base dados que visa sanar as principais dificuldades deste cenário de aplicação, oferecendo aos participantes da plataforma meios para que possam contribuir com o desenvolvimento e divulgação científica nacional. A partir da implantação desta base de dados, pretende-se:

*  Incluir artigos científicos para divulgação;
*  Avaliação de artigos;
*  Catalogar eventos por àrea do conhecimento e localidade;
*  Controlar as inscrições dos participantes nos eventos;
*  Realizar emissão de ingressos por participante;
*  Emitir certificados para os participantes referentes aos eventos;
*  Localizar universidades onde ocorrem eventos;
*  Identificar organizadores dos eventos.

Bem como outros relacionamentos que possam vir a enriquecer o projeto.

## Requisitos do projeto 

1. O sistema deverá permitir cadastro de participantes no sistema, a partir dos dados: nome, data de nascimento, e-mail e senha.

2. O sistema deverá permitir o login de participantes no sistema, a partir do dados: e-mail e senha.

3. O sistema deverá permitir ao administrador realizar o cadastro de áreas do conhecimento, a partir do dados: área pai (se houver) e nome.

4. O sistema deverá permitir ao participante enviar um artigo cientifico, a partir dos dados: título, resumo, co-autores (selecionando participantes pré-cadastrados e, caso um dos co-autores não seja cadastrado, informar o nome do mesmo), arquivo (contendo o artigo em si em formato PDF), área do conhecimento (selecionando a partir de áreas pré-cadastradas) e status (aguardando aprovação, aprovado ou recusado - todos os artigos cadastrados são inicialmente classificados como aguardando aprovação).

5. O sistema deverá permitir ao administrador selecionar um participante cadastrado e classificá-lo como avaliador de artigos.

6. O sistema deverá permitir a um participante avaliador aprovar ou recusar artigos que estão aguardando aprovação.

7. O sistema deverá permitir ao participante criar evento como palestrante, a partir dos dados: nome, tipo (congresso, conferência, curso, encontro, fórum, jornada, mesa-redonda, seminário, simpósio ou workshop), data de realização, área do conhecimento, co-palestrantes (selecionando participantes pré-cadastrados no sistema), horário de começo, horário de término, local (país, estado, cidade, logradouro, bairro, CEP, número e complemento), artigo cientifico relacionado (se houver - selecionando a partir de artigos aprovados), data máxima de inscrição, descrição, valor, formas de pagamento (cartão de crédito, boleto ou transferência bancária), e número máximo de participantes.

8. O sistema deverá permitir ao usuário realizar inscrição em um evento, emitindo um ingresso contendo os dados: código, nome do participante, nome do evento, valor, status do pagamento (aguardando aprovação, aprovado ou recusado), forma de pagamento e data de emissão.

9. O sistema deverá permitir ao participante gerar um certificado de um evento que o mesmo participou, contendo os dados: nome do evento, nome do participante, data de realização do evento e carga horária (calculado a partir do horário de inicio e término do evento).

10. O sistema deverá permitir ao participante visualizar e editar seus dados pessoais e cadastrais.

11. O sistema deverá permitir ao participante visualizar uma lista com todos os artigos científicos disponíveis.

12. O sistema deverá permitir ao participante visualizar todos seus artigos publicados no sistema.

13. O sistema deverá permitir ao participante visualizar uma lista com todos os eventos disponíveis (que ainda irão ocorrer).

14. O sistema deverá permitir ao participante visualizar todos os eventos em que está inscrito e todos os eventos que já participou.

15. O sistema deverá permitir ao participante consultar seu ingresso de acesso para todos os eventos em que está inscrito e eventos que já participou.

16. O sistema deverá permitir ao participante visualizar uma lista com todos os seus certificados.
