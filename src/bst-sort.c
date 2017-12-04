#include "bst.h"
#include <stdio.h>


/* We want to do the printing via a tree traversal, so 
   we need a visit function to pass  and that needs to 
   know where it is supposed to print to */
static FILE *outfile;

static void visit(bst_node n) {
  fprintf(outfile,"%li\n",n->data);
}

/* Read integers separated by whitespace from a file until there are no more,
   and then print them, one per line, in ascending order and without 
   duplicates. Input and output files are the first and second command line
   arguments and default to stdin and stdout respectively*/

int main(int argc, char * argv[]) {
  /* open input file if needed */
  FILE *infile = stdin;
  if (argc > 1) {
    infile = fopen(argv[1],"r");
    if (!infile) {
      perror("Can't open input file");
      exit(EXIT_FAILURE);
    }
  }
  /* Read integers and build the tree */
  bst_node root = NULL;
  while (!feof(infile)) {
    long x;
    if (1 == fscanf(infile,"%li",&x))
      insert(&root,x);
  }
  fclose(infile);
  /* open output file */
  if (argc > 2) {
    outfile = fopen(argv[2],"w");
    if (!outfile) {
      perror("Can't open output file");
      exit(EXIT_FAILURE);
    }
  }
  else
    outfile = stdout;
  /* traverse the tree printing integers */
  inorder(root,visit);
  /* and clean up */
  fclose(outfile);
  exit(EXIT_SUCCESS);
}
