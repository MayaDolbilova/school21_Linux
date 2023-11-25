#include "s21_cat.h"

void reader(char *argv[], int index, flags *options, int check);
void parser(int argc, char *argv[], flags *options, int *file_adres,
            int *amountfiles);
void printer(int string_counter, int real_string, char ch, flags *options,
             int check, int firstornot, int checkempty, int check_str_real,
             int check_str_unreal, int firstemptystr, int last_string);
void doing_logic(flags *options);

int main(int argc, char *argv[]) {
  flags options = {0, 0, 0, 0, 0, 0};
  if (argc == 2) {  //просто открыть файл и вывести его на экран
    int check = 1;
    reader(argv, 1, &options, check);
  } else if (argc > 2) {  // c флажками
    int file_adr[10];
    int amount_files = 0;
    int check = 0;
    parser(argc, argv, &options, file_adr, &amount_files);
    if (options.b + options.n + options.e + options.s + options.v + options.t ==
        0) {
      check = 1;
    }
    doing_logic(&options);
    for (int i = 0; i < amount_files; i++) {
      reader(argv, file_adr[i], &options, check);
    }

  } else {
    printf("MISTAKE");
  }
  return 0;
}

void doing_logic(flags *options) {
  if (options->n == 1 && options->b == 1) {
    options->n = 0;
  }
}

void parser(int argc, char *argv[], flags *options, int *file_adres,
            int *amountfiles) {
  int checkingfile = 0;
  int counter = 1;
  while (counter < argc) {
    if (argv[counter][0] == '-') {
      if (checkingfile == 0) {
        if (argv[counter][1] == '-') {  //для длинных флагов
          if (strcmp(argv[counter], "--number-nonblank") == 0) {
            options->b = 1;
          } else if (strcmp(argv[counter], "--number") == 0) {
            options->n = 1;
          } else if (strcmp(argv[counter], "--squeeze-blank") == 0) {
            options->s = 1;
          } else {
            printf("Strange arguments!");
          }
        } else {  //для коротких флагов
          int len = strlen(argv[counter]);
          char symbol;
          for (int i = 1; i < len; i++) {
            symbol = argv[counter][i];
            switch (symbol) {
              case 'b':
                options->b = 1;
                break;
              case 'e':
                options->e = 1;
                options->v = 1;
                break;
              case 'n':
                options->n = 1;
                break;
              case 's':
                options->s = 1;
                break;
              case 't':
                options->t = 1;
                options->v = 1;
                break;
              case 'v':
                options->v = 1;
                break;
              case 'E':
                options->e = 1;
                break;
              case 'T':
                options->t = 1;
                break;
              default:
                printf("Strange arguments!");
            }
          }
        }
      }
    } else {  // для записи названия файла
      int count = *amountfiles;
      file_adres[count] = counter;
      checkingfile += 1;
      *amountfiles += 1;
    }
    counter++;
  }
}

void reader(char *argv[], int index, flags *options, int check) {
  char future_char;
  FILE *file = NULL;
  int string = 1;
  int string_unreal = 1;
  int gothrstr = 0;
  char previous_ch = '\0';
  int emptyornot = 0;
  int firstornot = 0;
  int amount_emptystr = 0;
  int check_str_real = 1;
  int check_str_unreal = 1;
  int firstemptystr = 0;
  int laststring = 0;
  if ((file = fopen(argv[index], "r")) != NULL) {
    while ((future_char = getc(file)) != EOF) {
      if (future_char == '\n' && firstornot > 0) {
        string_unreal++;
        gothrstr = 0;
      }
      if (gothrstr == 0 && future_char == '\n' && previous_ch == '\n') {
        emptyornot = 1;
        string_unreal--;
        amount_emptystr++;
      } else {
        emptyornot = 0;
        amount_emptystr = 0;
      }
      if (previous_ch == '\n') {
        string++;
      }
      if (amount_emptystr <= 1 && previous_ch == '\n') {
        check_str_real++;
        if (emptyornot == 0) {
          check_str_unreal++;
        }
      }
      if (firstornot > 0) {
        if (firstemptystr == 1) {
          string--;
        }
        if (options->s == 1) {
          if (amount_emptystr < 2) {
            printer(string, string_unreal, previous_ch, options, check,
                    firstornot, emptyornot, check_str_real, check_str_unreal,
                    firstemptystr, laststring);
          }
        } else {
          printer(string, string_unreal, previous_ch, options, check,
                  firstornot, emptyornot, check_str_real, check_str_unreal,
                  firstemptystr, laststring);
        }
        if (firstemptystr == 1) {
          firstemptystr = 0;
        }
      } else {
        if (future_char == '\n') {
          amount_emptystr++;
          firstemptystr++;
          if (options->n == 1) {
            fprintf(stdout, "%6d\t", string);
            string++;
          }
        }
      }
      if (firstemptystr == 1) {
        check_str_unreal = 0;
      }
      firstornot++;
      gothrstr++;
      previous_ch = future_char;
    }
    if (check != 1) {
      if (previous_ch == '\n') {
        if (options->n == 1) {
          laststring = 1;
        }
        amount_emptystr++;
        emptyornot = 1;
        string++;
        if (options->e == 1) {
          printf("$");
        }
      }
      if (options->s == 1) {
        if (amount_emptystr < 2) {
          printer(string, string_unreal, previous_ch, options, check,
                  firstornot, emptyornot, check_str_real, check_str_unreal,
                  firstemptystr, laststring);
        } else {
          fprintf(stdout, "\n");
        }
      } else {
        printer(string, string_unreal, previous_ch, options, check, firstornot,
                emptyornot, check_str_real, check_str_unreal, firstemptystr,
                laststring);
      }
    } else {
      printer(string, string_unreal, previous_ch, options, check, firstornot,
              emptyornot, check_str_real, check_str_unreal, firstemptystr,
              laststring);
    }
    fclose(file);
  }
}

void printer(int string_counter, int real_string, char ch, flags *options,
             int check, int firstornot, int checkempty, int check_str_real,
             int check_str_unreal, int firstemptystr, int last_string) {
  if (check == 1) {
    fprintf(stdout, "%c", ch);
  } else {
    int checking_ch = 0;
    if (options->e == 1) {
      if (ch == '\n') {
        fprintf(stdout, "$");
        if (options->b + options->n + options->s == 0) {
          fprintf(stdout, "\n");
        }
      }
    }
    if (options->b == 1) {
      if (options->s == 0) {
        if (checkempty != 0) {
          fprintf(stdout, "%c", ch);
        } else {
          if (firstornot == 1 && firstemptystr == 0) {
            fprintf(stdout, "%6d\t", real_string);
          }
          if ((ch == '\n')) {
            fprintf(stdout, "%c%6d\t", ch, real_string);
          }
        }
      } else {
        if (firstornot == 1 && firstemptystr == 0) {
          fprintf(stdout, "%6d\t", check_str_unreal);
        }
        if (ch == '\n') {
          if (checkempty == 0) {
            fprintf(stdout, "\n%6d\t", check_str_unreal);
          } else {
            fprintf(stdout, "\n");
          }
        }
      }
    }
    if (options->n == 1) {
      if (options->s == 1) {
        string_counter = check_str_real;
      }
      if (firstornot == 1 && firstemptystr == 0) {
        if (checkempty != 0) {
          fprintf(stdout, "\n%6d\t", string_counter);
        } else {
          fprintf(stdout, "%6d\t", string_counter);
        }
      } else {
        if (ch == '\n') {
          if (last_string == 1) {
            fprintf(stdout, "\n");
          } else {
            fprintf(stdout, "\n%6d\t", string_counter);
          }
        }
      }
    }
    if (options->t) {
      if (ch == 9) {
        fprintf(stdout, "^I");
      }
    }
    if (options->v) {
      char *arr1[32] = {"^@", "^A", "^B", "^C", "^D",  "^E", "^F", "^G",
                        "^H", "	",  "\n", "^K", "^L",  "^M", "^N", "^O",
                        "^P", "^Q", "^R", "^S", "^T",  "^U", "^V", "^W",
                        "^X", "^Y", "^Z", "^[", "^\\", "^]", "^^", "^_"};
      int index = (int)ch;
      if (index != 10) {
        if (index >= 0 && index < 32) {
          if (index == 9) {
            if (options->t != 1) {
              fprintf(stdout, "%s", arr1[index]);
              checking_ch = 1;
            } else {
              checking_ch = 1;
            }
          } else {
            fprintf(stdout, "%s", arr1[index]);
            checking_ch = 1;
          }
        } else if (index == 127) {
          fprintf(stdout, "^?");
          checking_ch = 1;
        }
      } else {
        if (options->b + options->e + options->s + options->n == 0) {
          fprintf(stdout, "\n");
          checking_ch = 1;
        }
      }
    }
    if (checking_ch == 0) {
      if (options->s == 1) {
        if (options->n + options->b == 0) {
          fprintf(stdout, "%c", ch);
        } else {
          if (ch != '\n') {
            fprintf(stdout, "%c", ch);
          }
        }
      } else {
        if (ch != '\n') {
          fprintf(stdout, "%c", ch);
        }
      }
    }
  }
}
