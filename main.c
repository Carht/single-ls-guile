#define _XOPEN_SOURCE 700
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ftw.h>
#include <libguile.h>

// Estructura de lista link
typedef struct node {
  char *path;
  struct node *next;
} node_t;

//Asignación de lista link
static node_t *head = NULL;

// método, insertar en el header
static int add_path(node_t **old_node, const char *new_path) {
  node_t *new_node = malloc(sizeof(node_t));
  if (!new_node) return -1;
  new_node->path = strdup(new_path);
  if (!new_node->path) { free(new_node); return -1; }
  new_node->next = *old_node;
  *old_node = new_node;

  return 0;
}

// Liberar lista enlazada
static void free_node(node_t *h) {
  while(h) {
    node_t *tmp = h->next;
    free(h->path);
    free(h);
    h = tmp;
  }
}

// nftw callback
static int walker(const char *path, const struct stat *sb,
		  int typeflag, struct FTW *ftwbuf) {
  (void)sb;
  (void)typeflag;
  (void)ftwbuf;

  return add_path(&head, path);
}

// Lista C to Scheme
static SCM link_list_to_scheme_list(node_t *h) {
  SCM link_to_scm_lst = SCM_EOL;
  for (node_t *n = h; n; n = n->next) {
    link_to_scm_lst = scm_cons(scm_from_locale_string(n->path), link_to_scm_lst);
  }

  return link_to_scm_lst;
}

// Fn Guile con input de path para guardar información
static SCM scm_scan_dir(SCM directory) {
  char *dir = scm_to_locale_string(directory);
  if (!dir) scm_wrong_type_arg("list-dir", SCM_ARG1, directory);

  head = NULL;
  if (nftw(dir, walker, 20, FTW_PHYS) == -1) {
    free(dir);
    return SCM_BOOL_F;
  }
  free(dir);

  SCM list_directories = link_list_to_scheme_list(head);

  return list_directories;
}

// Registro
static void inner_main(void *closure, int argc, char **argv) {
  (void)closure;

  scm_c_define_gsubr("list-dir", 1, 0, 0, scm_scan_dir);

  if (argc < 3) {
    fprintf(stderr, "Uso: %s <directory> <script.scm> [arg ...]\n", argv[0]);
    exit(1);
  }

  scm_c_primitive_load(argv[2]);

  free_node(head);
}

int main(int argc, char **argv) {
  scm_boot_guile(argc, argv, inner_main, 0);

  return 0;
}
