#include "s21_grep.h"

void parser(int argc, char *argv[], flags *options, int *file_adres,
            int *sample_adres, int *amountfiles, int *amountsamples);
void reader(char *argv[], int argc, int index, int *sample_adr,
            int amount_samples, flags *options, int amount_files,
            char arr[][1024], int numb, int check_flags);
void search(char *argv[], int argc, int *sample_adr, int amount_samples,
            char *string, int *check, flags *opt, char arr[][1024], int numb,
            int index, int amount_files, int count_string_n);
void search_func(char *argv[], int sample_adr, char *string, int cflags,
                 int eflag, int *check, flags *opt, char *pointer, int index,
                 int amount_files, int count_string_n);
void func_f(char *argv[], int argc, char array[100][1024], int *numb,
            flags *options);
void doing_logic(flags *options);

int main(int argc, char *argv[]) {
  flags options = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  int file_adr[10];
  int sample_adr[10];
  int amount_files = 0;
  int amount_samples = 0;
  int numb = 0;
  int check_flags = 0;
  char array[100][1024];
  if (argc == 3) {
    check_flags = 1;
    parser(argc, argv, &options, file_adr, sample_adr, &amount_files,
           &amount_samples);
    if (amount_samples > 0 && amount_files > 0) {
      doing_logic(&options);
      reader(argv, argc, file_adr[0], sample_adr, amount_samples, &options,
             amount_files, array, numb, check_flags);
    }

  } else if (argc > 3) {
    parser(argc, argv, &options, file_adr, sample_adr, &amount_files,
           &amount_samples);
    doing_logic(&options);
    if (options.i + options.e + options.n + options.l + options.c + options.v +
            options.h + options.s + options.f + options.o ==
        0) {
      check_flags = 1;
    }
    if (options.e == 1) {
      int file_adr_e[10];
      int sample_adr_e[10];
      int counter = 1;
      int count = 0;
      int len = 0;
      int amount = 0;
      while (counter < argc) {
        if (argv[counter][0] == '-' && argv[counter][1] == 'e') {
          sample_adr_e[count] = counter + 1;
          count++;
          counter++;
        } else {
          if (argv[counter][0] != '-') {
            file_adr_e[amount] = counter;
            amount++;
          } else {
            len = strlen(argv[counter]);
            for (int i = 0; i < len; i++) {
              if (argv[counter][i] == 'e') {
                sample_adr_e[count] = counter + 1;
                count++;
                counter++;
              }
            }
          }
        }
        counter++;
      }
      for (int i = 0; i < amount; i++) {
        reader(argv, argc, file_adr_e[i], sample_adr_e, count, &options, amount,
               array, numb, check_flags);
      }
    } else {
      if (options.f == 1) {
        func_f(argv, argc, array, &numb, &options);
        for (int i = 0; i < amount_files; i++) {
          reader(argv, argc, file_adr[i], sample_adr, amount_samples, &options,
                 amount_files, array, numb, check_flags);
        }

      } else {
        for (int i = 0; i < amount_files; i++) {
          reader(argv, argc, file_adr[i], sample_adr, amount_samples, &options,
                 amount_files, array, numb, check_flags);
          if (options.v == 1 &&
              options.i + options.e + options.l + options.c + options.s +
                      options.f + options.o + options.h + options.n ==
                  0 &&
              i <= amount_files - 1) {
            printf("\n");
          } else if (options.v == 1 && options.h == 1 &&
                     i == amount_files - 1 &&
                     options.i + options.e + options.l + options.c + options.s +
                             options.f + options.o ==
                         0 &&
                     amount_files >= 1) {
            printf("\n");
          } else if (options.v == 1 && options.h == 1 && options.o == 1 &&
                     amount_files >= 1 &&
                     options.i + options.e + options.l + options.c + options.s +
                             options.f ==
                         0) {
            printf("\n");
          } else if (options.v == 1 && options.n == 1 && amount_files == 1 &&
                     options.i + options.e + options.l + options.c + options.s +
                             options.f + options.h + options.o ==
                         0) {
            printf("\n");
          } else if (options.v + options.o == 2 &&
                     options.i + options.e + options.l + options.c + options.s +
                             options.f + options.h ==
                         0 &&
                     amount_files >= 1 && i == amount_files - 1) {
            printf("\n");
          } else if (options.v == 1 && options.h == 1 && options.n == 1 &&
                     amount_files == 1 &&
                     options.o + options.i + options.e + options.l + options.c +
                             options.s + options.f ==
                         0) {
            printf("\n");
          }
          if (amount_files > 1 &&
              options.n + options.i + options.v + options.h == 4) {
            printf("\n");
          }
        }
      }
    }
  }
  return 0;
}

void parser(int argc, char *argv[], flags *options, int *file_adres,
            int *sample_adres, int *amountfiles, int *amountsamples) {
  int counter = 1;
  int sample_check = 0;
  int checkingfile = 0;
  while (counter < argc) {
    if (argv[counter][0] == '-') {
      int len = strlen(argv[counter]);
      char symbol;
      for (int i = 1; i < len; i++) {
        symbol = argv[counter][i];
        switch (symbol) {
          case 'o':
            options->o = 1;
            break;
          case 'e':
            options->e = 1;
            break;
          case 'n':
            options->n = 1;
            break;
          case 's':
            options->s = 1;
            break;
          case 'i':
            options->i = 1;
            break;
          case 'v':
            options->v = 1;
            break;
          case 'l':
            options->l = 1;
            break;
          case 'c':
            options->c = 1;
            break;
          case 'f':
            options->f = 1;
            break;
          case 'h':
            options->h = 1;
            break;
          default:
            break;
        }
      }
    } else {
      if (sample_check >= 1) {
        checkingfile++;

        int count = *amountfiles;
        file_adres[count] = counter;
        *amountfiles += 1;
      } else {
        sample_check++;
        if (options->e == 0) {
          int counting = *amountsamples;
          sample_adres[counting] = counter;
          *amountsamples += 1;
        } else {
          sample_adres[0] = counter;
          *amountsamples = 1;
        }
      }
    }
    counter++;
  }
}

void reader(char *argv[], int argc, int index, int *sample_adr,
            int amount_samples, flags *options, int amount_files,
            char arr[][1024], int numb, int check_flags) {
  FILE *file = NULL;
  char str[1024];
  char *string_pointer = NULL;
  int check = 0;
  int count = 0;
  int count_string_n = 1;
  int flag = 0;
  if ((file = fopen(argv[index], "r")) != NULL) {
    while (1) {
      string_pointer = fgets(str, 1024, file);
      if (string_pointer == NULL) {
        if (feof(file) != 0) {
          break;
        } else {
          break;
        }
      }
      if (options->f == 1) {
        search(argv, argc, sample_adr, amount_samples, string_pointer, &check,
               options, arr, numb, index, amount_files, count_string_n);
      } else if (options->e == 1) {
        search(argv, argc, sample_adr, amount_samples, string_pointer, &check,
               options, arr, numb, index, amount_files, count_string_n);
      } else {
        search(argv, argc, sample_adr, amount_samples, string_pointer, &check,
               options, arr, numb, index, amount_files, count_string_n);
      }
      if (check >= 1) {
        flag = 1;
        if (check_flags == 1 && amount_files > 1) {
          printf("%s:", argv[index]);
        }
        if (check_flags == 0 && amount_files > 1) {
          if (options->s == 1 || options->i == 1 || options->v == 1) {
            if (options->h == 0 && options->l == 0 && options->c == 0) {
              printf("%s:", argv[index]);
            }
          }
        }
        if (options->n == 1 && options->o == 0) {
          if (options->h == 0 && amount_files > 1 && options->l == 0) {
            printf("%s:", argv[index]);
          }
          printf("%d:", count_string_n);
          if (options->o == 0) {
            printf("%s", str);
          }
        }
        if (options->c == 0 && options->l == 0 && options->o == 0 &&
            options->n == 0) {
          if (options->h == 0 && amount_files > 1 &&
              (options->f == 1 || options->e == 1)) {
            printf("%s:", argv[index]);
          }

          printf("%s", str);
        }
        if (options->o == 1 && options->v == 1 &&
            options->i + options->l + options->e + options->f + options->c ==
                0) {
          if (options->n == 1) {
            printf("%d:", count_string_n);
          }
          printf("%s", str);
        }
        count++;
      }
      count_string_n++;
    }
    if (options->l == 1) {
      if (count > 0) {
        if (options->c == 1) {
          if (amount_files == 1) {
            printf("%d\n", 1);
          } else {
            printf("%s:%d\n", argv[index], 1);
          }
        }
        printf("%s\n", argv[index]);
      } else {
        if (options->c == 1) {
          if (amount_files == 1) {
            printf("%d\n", 1);
          } else {
            printf("%s:%d\n", argv[index], flag);
          }
        }
      }
    }
    fclose(file);
    if (options->h != 1 && options->n == 0 && options->l == 0 &&
        check_flags == 0 && options->i == 0 && options->s == 0 &&
        options->o == 0 && options->e == 0 && options->v == 0 &&
        options->f == 0) {
      if (amount_files > 1) {
        printf("%s:", argv[index]);
      }
    }
    if (options->c == 1 && options->n == 0) {
      if (amount_files > 1 && options->e == 1 && options->h != 1) {
        printf("%s:", argv[index]);
      } else if (amount_files > 1 && options->v == 1) {
        printf("%s:", argv[index]);
      }
      if (options->l == 0) {
        printf("%d\n", count);
      }
    }
    if (options->e + options->n == 2) {
      printf("\n");
    }

  } else {
    if (options->s == 0) {
      fprintf(stderr, "%s: No such file or directory\n", argv[index]);
    }
  }
}

void search(char *argv[], int argc, int *sample_adr, int amount_samples,
            char *string, int *check, flags *opt, char arr[][1024], int numb,
            int index, int amount_files, int count_string_n) {
  int cflag = REG_EXTENDED;
  int eflag = 0;
  int checking = 0;
  (void)argc;
  char *pointer = NULL;
  int save_index;

  if (opt->f == 1) {
    for (int i = 0; i < numb; i++) {
      pointer = arr[i];
      if (pointer[strlen(pointer) - 1] == '\n' && strlen(pointer) > 1) {
        pointer[strlen(pointer) - 1] = '\0';
      }
      search_func(argv, 0, string, cflag, eflag, &checking, opt, pointer, index,
                  amount_files, count_string_n);
      if (checking == 1) {
        continue;
      }
    }
  } else if (opt->e == 1) {
    for (int i = 0; i < amount_samples; i++) {
      pointer = argv[sample_adr[i]];
      search_func(argv, index, string, cflag, eflag, &checking, opt, pointer,
                  index, amount_files, count_string_n);
      if (checking == 1) {
        break;
      }
    }
  } else {
    save_index = index;
    int index = sample_adr[0];
    search_func(argv, index, string, cflag, eflag, &checking, opt, pointer,
                index, amount_files, count_string_n);
    if (opt->o == 1 && opt->l == 0 && checking == 1 && opt->v == 0) {
      if (opt->h == 0 && amount_files > 1) {
        printf("%s:", argv[save_index]);
      }
      if (opt->n == 1) {
        printf("%d:", count_string_n);
      }
      printf("%s\n", argv[index]);
    }
  }
  if (opt->v == 1) {
    if (checking == 1) {
      checking = 0;
    } else {
      checking = 1;
    }
  }
  *check = checking;
}

void search_func(char *argv[], int sample_adr, char *string, int cflags,
                 int eflag, int *check, flags *opt, char *pointer, int index,
                 int amount_files, int count_string_n) {
  if (opt->i == 1) {
    cflags = REG_ICASE;
  }
  regex_t regs;
  int status = 1;
  char pattern[1024];
  char str[1024];
  const size_t nmatch = 100;
  regmatch_t pm[100];
  if (opt->f == 1) {
    strcpy(pattern, pointer);
    strcpy(str, string);
    regcomp(&regs, pattern, cflags);
    status = regexec(&regs, string, nmatch, pm, eflag);
    regfree(&regs);
  } else if (opt->e == 1) {
    strcpy(pattern, pointer);
    strcpy(str, string);
    regcomp(&regs, pattern, cflags);
    status = regexec(&regs, string, nmatch, pm, eflag);

    regfree(&regs);
  } else {
    strcpy(pattern, argv[sample_adr]);
    strcpy(str, string);
    if (opt->o == 1 && strlen(pattern) == 1) {
      for (long unsigned int i = 0; i < strlen(str); i++) {
        if (str[i] == pattern[0]) {
          char a[1];
          a[0] = pattern[0];
          char b[1];
          b[0] = str[i];
          regcomp(&regs, a, cflags);
          status = regexec(&regs, b, nmatch, pm, eflag);
          if (status == 0 && opt->l == 0 && opt->v == 0) {
            *check += 1;
            if (opt->n == 1) {
              if (*check == 1) {
                printf("%d:", count_string_n);
              }
            }
            printf("%c\n", a[0]);
          }
          regfree(&regs);
        }
      }
    } else {
      regcomp(&regs, pattern, cflags);
      status = regexec(&regs, string, nmatch, pm, eflag);
      regfree(&regs);
    }
  }
  if (status == 0) {
    *check += 1;
    if (opt->f == 1) {
      if (*check < 1) {
        if (opt->h == 0 && amount_files > 1) {
          printf("%s:", argv[index]);
        }
        printf("%s", string);
      }
    }
  }
}

void func_f(char *argv[], int argc, char array[100][1024], int *numb,
            flags *options) {
  int file_adr;
  int counter = 0;
  int number = 0;
  while (counter < argc) {
    if (argv[counter][0] == '-' && argv[counter][1] == 'f') {
      file_adr = counter + 1;
      break;
    }
    counter++;
  }
  FILE *file = NULL;
  char sample[1024];
  char *string_pointer = NULL;

  if ((file = fopen(argv[file_adr], "r")) != NULL) {
    while (1) {
      string_pointer = fgets(sample, 1024, file);
      if (string_pointer == NULL) {
        break;
      }
      strcpy(array[number], sample);
      number++;
    }
    fclose(file);
  } else {
    if (options->s == 0) {
      fprintf(stderr, "%s: No such file or directory", argv[file_adr]);
    }
  }
  *numb = number;
}

void doing_logic(flags *options) {
  if (options->c == 1 && options->n == 1) {
    if (options->o == 1) {
      options->o = 0;
    }
    options->n = 0;
  }
  if (options->n == 1 && options->l == 1) {
    options->n = 0;
  }
  if (options->o + options->h + options->c == 3) {
    options->o = 0;
  }
  if (options->c == 1 && options->o == 1) {
    options->o = 0;
  }
}
