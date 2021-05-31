import 'package:memstuff_final/helpers/date_helper.dart';

const kRequiredField = 'Campo obrigatório';
const kFieldNegative = 'Precisa ser positivo';
const kNumberZero = 'Precisa ser diferente de zero';
double numero;

class ValidatorHelper {
  static String validation(String text) {
    if (text.isEmpty) {
      return kRequiredField;
    } else {
      return null;
    }
  }

  static String dateValidation(String text) {
    return DateHelper.parse(text).isAfter(DateTime.now())
        ? 'Selecione uma data válida.'
        : null;
  }
}
