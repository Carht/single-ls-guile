#include <libguile.h>
#include <stdio.h>
#include "listdir.h"

int main(int argc, char **argv) {
  scm_init_guile();

  export_to_guile_get_files();

  scm_c_primitive_load("filter.scm");

  return 0;
}
