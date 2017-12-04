
/* CS2002 Architecture Practical 2017 
   Types and declarations for simple Binary Search Tree implementation */

#include <stdlib.h> /* for NULL */

/* Define the data structure -- no parent pointer */
typedef struct s_bst_node *bst_node;

struct s_bst_node {
  bst_node l;
  bst_node r;
  long data;
};

/* Function declarations */

/* "constructor" */
bst_node make_node( bst_node l, bst_node r, long data );

/* traversals -- calls the visit function on each node
   in the appropriate order */
void preorder( bst_node root, void (*visit)(bst_node));
void inorder( bst_node root, void (*visit)(bst_node));
void postorder( bst_node root, void (*visit)(bst_node));

/* find function -- returns a pointer to the place where either 
   (a) a node containing the data item x already is or
   (b) a new node would need to be inserted to contain the data item x
   Needs a pointer to a location containing the root, in case the tree is 
   currently empty
*/
bst_node *find( bst_node *root_ptr, long x);

/* returns non-zero if the tree contains data item x and zero if not */
int contains( bst_node root, long x);

/* modifies the tree by adding a node containing x unless there already is one.
   Takes a pointer to the root in case it needs to insert the very first node
   in a previously empty tree */
void insert( bst_node *root_ptr, long x);

