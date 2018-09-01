# Sistema de apoio a eventos científicos

Trabalho da disciplina DCC060 - Banco de dados

## Introdução

O Brasil, apesar das dificuldades enfrentadas, é um pais com uma enorme comunidade científica e que conta com uma grande diversidade de eventos científicos nas mais variadas áreas, indo desde as Ciências Humanas até as Ciências Exatas e Engenharias.

Uma vez que tais eventos, devido à grande extensão do nosso país, ocorrem de maneira paralela e em diversos estados diferentes, enxerga-se a necessidade de tornar a divulgação destes eventos científicos mais abrangente e centralizada. Partindo desta premissa, participantes de eventos científicos terão maior facilidade para buscar eventos de seus interesses em suas regiões, enquanto que palestrantes e organizações poderão divulgar e detalhar com mais propriedade seus eventos científicos. 

Este documento propõe o modelo de uma base dados que visa sanar as principais dificuldades deste cenário de aplicação, oferecendo aos participantes da plataforma meios para que possam contribuir com o desenvolvimento e divulgação científica nacional. A partir da implantação desta base de dados, pretende-se:

*  Incluir artigos científicos para divulgação;
*  Avaliação de artigos;
*  Ranquear artigos;
*  Catalogar eventos por àrea do conhecimento, localidade e tipo;
*  Controlar as inscrições dos participantes nos eventos;
*  Realizar emissão de ingressos por participante;
*  Emitir certificados para os participantes referentes aos eventos;
*  Localizar instiuições de ensino onde ocorrem eventos;
*  Identificar organizadores dos eventos.

Bem como outros relacionamentos que possam vir a enriquecer o projeto.

## Requisitos do projeto

Como pretende-se otimizar e facilitar as consultas na base de dados que será desenvolvida, é necessário que algumas regras e requisitos sejam atendidos. São estes:

1. Instituiçoes de ensino contém código, sigla e nome;

2. Todo usuário do sistema é classificado como um participante. Participantes possuem os dados: CPF, nome, data de nascimento, e-mail,  e senha;

3. Um participante pertence a zero ou apenas uma instituição de ensino;

4. Áreas do conhecimento possuem código, área pai (se houver) e nome;

5. Uma área do conhecimento é classificada como subárea se contem uma área pai;

6. Artigos científicos contém título, resumo, arquivo (que é o artigo em si) e status ("aguardando aprovação", "aprovado" ou "recusado" - todos os artigos são inicialmente classificados como "aguardando aprovação").

7. Artigos científicos possuem relação de autoria com participantes cadastrados na plataforma. Cada artigo possui um único autor ou vários autores;

8. Artigos científicos são de uma única área do conhecimento e de zero ou várias subáreas;

9. Um participante pode ter zero ou vários artigos publicados;

10. Existe o administrador do sistema, que é um participante com privilégios especiais: pode classificar qualquer participante cadastrado como avaliador de artigos científicos. 

11. Deve ser possível contabilizar a quantidade total de artigos aprovados e a quantidade total de artigos recusados pelos participantes avaliadores;

12. O evento científico contém nome, tipo (congresso, conferência, curso, encontro, fórum, jornada, mesa-redonda, seminário, simpósio ou workshop), data de realização, horário de começo, horário de termino, endereço (país, estado, cidade, logradouro, bairro, CEP, número e complemento), data máxima de inscrição, descrição, valor, formas de pagamento (cartão de crédito, boleto ou transferência bancária) e número máximo de pariticipantes permitido.



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
