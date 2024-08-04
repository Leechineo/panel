bool cpfValidator(String cpf) {
  // Remove caracteres não numéricos do CPF
  cpf = cpf.replaceAll(RegExp(r'[^\d]'), '');

  if (cpf.length != 11) {
    return false;
  }

  // Verifica se todos os dígitos são iguais
  if (RegExp(r'^(\d)\1*$').hasMatch(cpf)) {
    return false;
  }

  // Calcula o primeiro dígito verificador
  var soma = 0;
  for (var i = 0; i < 9; i++) {
    soma += int.parse(cpf[i]) * (10 - i);
  }
  var primeiroDigito = 11 - (soma % 11);

  if (primeiroDigito >= 10) {
    primeiroDigito = 0;
  }

  // Calcula o segundo dígito verificador
  soma = 0;
  for (var i = 0; i < 10; i++) {
    soma += int.parse(cpf[i]) * (11 - i);
  }
  var segundoDigito = 11 - (soma % 11);

  if (segundoDigito >= 10) {
    segundoDigito = 0;
  }

  return cpf.endsWith('$primeiroDigito$segundoDigito');
}
