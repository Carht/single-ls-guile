#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <libguile.h>
#include "listdir.h"

// Lista de archivos a scheme
static SCM scm_get_files(SCM scm_path) {
  char *path  = scm_to_locale_string(scm_path);

  if (!path) {
    scm_misc_error("cget-files", "invalid path", SCM_EOL);
  }

  DIR *d = opendir(path);

  if (!d) {
    free(path);
    scm_misc_error("cget-files", "cannot open directory", SCM_EOL);
  }
   
  SCM result = SCM_EOL;
  struct dirent *entry;

  while ((entry = readdir(d)) != NULL) {
    if (strcmp(entry->d_name, ".") == 0 || strcmp(entry->d_name, "..") == 0)
      continue;

    SCM str = scm_from_locale_string(entry->d_name);
    result = scm_cons(str, result);
  }

  closedir(d);
  free(path);

  return scm_reverse(result);
}

void export_to_guile_get_files(void) {
  scm_c_define_gsubr("cget-files", 1, 0, 0, scm_get_files);
}
