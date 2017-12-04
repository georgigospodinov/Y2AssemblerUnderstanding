#include "bst.h"
#include <stdio.h>
bst_node make_node( bst_node l, bst_node r, long data ) {
  bst_node n = (bst_node)malloc(sizeof(struct s_bst_node));
  n->l = l;
  n->r = r;
  n->data = data;
  return n;
}

/* Standard recursive traversals */
void preorder( bst_node root, void (*visit)(bst_node)) {
  if (root != NULL) {
    (*visit)(root);
    preorder(root->l, visit);
    preorder(root->r, visit);
  }
}

void inorder( bst_node root, void (*visit)(bst_node)) {
  if (root != NULL) {
    inorder(root->l, visit);
    (*visit)(root);
    inorder(root->r, visit);
  }
}

void postorder( bst_node root, void (*visit)(bst_node)){
  if (root != NULL) {
    postorder(root->l, visit);
    postorder(root->r, visit);
    (*visit)(root);
  }
} 

/* Key routine that descends the tree looking for a value,
   or for the place where a value would need to be added */
bst_node * find( bst_node *root_ptr, long x)
{
    static int new_descend = 1;
    if (new_descend) {
        printf("NEW TREE DESCEND, x = %d\n", x);
        new_descend = 0;
    }
    else printf("New Stack Frame:\n");
    
    long ip, sp, bp;
    asm ("movq\t(%%rip), %0": "=c" (ip));
    asm("movq\t%%rsp, %0": "=c" (sp));
    asm("movq\t%%rbp, %0": "=c" (bp));
    long frame_size = bp-sp, location_x = bp-80;
        
    printf("Current Instruction Pointer:\t0x%08X\n", ip);
    printf("Size of Stack Frame:\t\t%d Bytes\n", frame_size);
    printf("Value of Stack Pointer:\t\t0x%8X\n", sp);
    printf("Location of argument x:\t\t0x%8X\n", location_x);
//    long* lx = &x;  // Produces the same result as above.
//    printf("Pointer to x = 0x%8X----------------------\n", lx);

    if (*root_ptr == NULL) {
        /* can't descend further and we haven't found x,
         * so return this location
         */
        printf("END OF TREE DESCEND\n\n");
        new_descend = 1;
        return root_ptr;
    }
    long d = (*root_ptr)->data; 
    long location_d = bp-48;
    printf("Location of local d:\t\t0x%8X\n", location_d);
    if (x < d) // go left
        return find(&((*root_ptr)->l), x);
    if (x == d) { // found it
        new_descend = 1;
        printf("END OF TREE DESCEND\n\n");
        return root_ptr;
    }
    // if (x > d) go right
    return find(&((*root_ptr)->r), x);
}
  

int contains( bst_node root, long x) {
  bst_node *np = find(&root, x);
  /* has find found an actual node, or a place where a new one
     should go? */
  return *np != NULL;
}
  
void insert( bst_node *root_ptr, long x) {
  /* descend the tree */
  bst_node *np = find(root_ptr, x);
  /* insert if not already present */
  if (*np == NULL)
    /* new leaf node */
    *np = make_node(NULL, NULL, x);
}

