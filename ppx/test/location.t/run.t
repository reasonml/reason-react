  $ refmt --parse re --print ml input.re > output.ml
  $ reason-react-ppx -dparsetree --impl output.ml -o temp.ml
  $ cat temp.ml
  (((pstr_desc
     (Pstr_attribute
      ((attr_name
        ((txt ocaml.ppx.context)
         (loc
          ((loc_start
            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
           (loc_end
            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
           (loc_ghost true)))))
       (attr_payload
        (PStr
         (((pstr_desc
            (Pstr_eval
             ((pexp_desc
               (Pexp_record
                ((((txt (Lident tool_name))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_constant
                     (Pconst_string ppxlib_driver
                      ((loc_start
                        ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                         (pos_cnum -1)))
                       (loc_end
                        ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                         (pos_cnum -1)))
                       (loc_ghost true))
                      ())))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident include_dirs))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident []))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident load_path))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident []))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident open_modules))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident []))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident for_package))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident None))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident debug))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident use_threads))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident use_vmthreads))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident recursive_types))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident principal))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident transparent_modules))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident unboxed_types))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident unsafe_string))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident false))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (((txt (Lident cookies))
                   (loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true))))
                  ((pexp_desc
                    (Pexp_construct
                     ((txt (Lident []))
                      (loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))
                     ()))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                ()))
              (pexp_loc
               ((loc_start
                 ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                (loc_end
                 ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                (loc_ghost true)))
              (pexp_loc_stack ()) (pexp_attributes ()))
             ()))
           (pstr_loc
            ((loc_start
              ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
             (loc_end
              ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
             (loc_ghost true)))))))
       (attr_loc
        ((loc_start
          ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
         (loc_end ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
      (loc_end ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_primitive
      ((pval_name
        ((txt makeProps)
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
           (loc_ghost true)))))
       (pval_type
        ((ptyp_desc
          (Ptyp_arrow (Labelled lola)
           ((ptyp_desc (Ptyp_var lola))
            (ptyp_loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 10)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 14)))
              (loc_ghost false)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))
           ((ptyp_desc
             (Ptyp_arrow (Optional key)
              ((ptyp_desc
                (Ptyp_constr
                 ((txt (Lident string))
                  (loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 0)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                      (pos_cnum 152)))
                    (loc_ghost true))))
                 ()))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                   (pos_cnum 152)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))
              ((ptyp_desc
                (Ptyp_arrow Nolabel
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Lident unit))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 0)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                         (pos_cnum 152)))
                       (loc_ghost true))))
                    ()))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 0)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                      (pos_cnum 152)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Ldot (Lident Js) t))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 0)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                         (pos_cnum 152)))
                       (loc_ghost true))))
                    (((ptyp_desc
                       (Ptyp_object
                        (((pof_desc
                           (Otag
                            ((txt lola)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 0)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 2)
                                 (pos_bol 84) (pos_cnum 152)))
                               (loc_ghost true))))
                            ((ptyp_desc (Ptyp_var lola))
                             (ptyp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 10)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 14)))
                               (loc_ghost false)))
                             (ptyp_loc_stack ()) (ptyp_attributes ()))))
                          (pof_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 0)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                              (pos_cnum 152)))
                            (loc_ghost true)))
                          (pof_attributes ())))
                        Closed))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                          (pos_cnum 152)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ())))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 0)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                      (pos_cnum 152)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                   (pos_cnum 152)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))))
            (ptyp_loc
             ((loc_start
               ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
              (loc_end
               ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
              (loc_ghost true)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))))
         (ptyp_loc
          ((loc_start
            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
           (loc_end
            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
           (loc_ghost true)))
         (ptyp_loc_stack ()) (ptyp_attributes ())))
       (pval_prim (""))
       (pval_attributes
        (((attr_name
           ((txt mel.obj)
            (loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
              (loc_ghost true)))))
          (attr_payload (PStr ()))
          (attr_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
            (loc_ghost true))))))
       (pval_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 4)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 8)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 4)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 8)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_fun (Labelled lola) ()
            ((ppat_desc
              (Ppat_var
               ((txt lola)
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 10)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 14)))
                  (loc_ghost false))))))
             (ppat_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 10)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 14)))
               (loc_ghost false)))
             (ppat_loc_stack ()) (ppat_attributes ()))
            ((pexp_desc
              (Pexp_apply
               ((pexp_desc
                 (Pexp_ident
                  ((txt (Ldot (Ldot (Lident React) DOM) jsx))
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 18)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 65)))
                     (loc_ghost false))))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 18)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 65)))
                  (loc_ghost false)))
                (pexp_loc_stack ()) (pexp_attributes ()))
               ((Nolabel
                 ((pexp_desc
                   (Pexp_constant
                    (Pconst_string div
                     ((loc_start
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_end
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_ghost true))
                     ())))
                  (pexp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 20)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 23)))
                    (loc_ghost false)))
                  (pexp_loc_stack ()) (pexp_attributes ())))
                (Nolabel
                 ((pexp_desc
                   (Pexp_apply
                    ((pexp_desc
                      (Pexp_ident
                       ((txt (Ldot (Ldot (Lident React) DOM) domProps))
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 20)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 23)))
                          (loc_ghost false))))))
                     (pexp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 18)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 65)))
                       (loc_ghost false)))
                     (pexp_loc_stack ())
                     (pexp_attributes
                      (((attr_name
                         ((txt merlin.hide)
                          (loc
                           ((loc_start
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_end
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_ghost true)))))
                        (attr_payload (PStr ()))
                        (attr_loc
                         ((loc_start
                           ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_end
                           ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_ghost true)))))))
                    (((Labelled children)
                      ((pexp_desc
                        (Pexp_apply
                         ((pexp_desc
                           (Pexp_ident
                            ((txt (Ldot (Lident React) string))
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 35)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 47)))
                               (loc_ghost false))))))
                          (pexp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 35)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 47)))
                            (loc_ghost false)))
                          (pexp_loc_stack ()) (pexp_attributes ()))
                         ((Nolabel
                           ((pexp_desc
                             (Pexp_ident
                              ((txt (Lident lola))
                               (loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 1)
                                   (pos_bol 0) (pos_cnum 48)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 1)
                                   (pos_bol 0) (pos_cnum 52)))
                                 (loc_ghost false))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                (pos_cnum 48)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                (pos_cnum 52)))
                              (loc_ghost false)))
                            (pexp_loc_stack ()) (pexp_attributes ()))))))
                       (pexp_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 35)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 52)))
                         (loc_ghost false)))
                       (pexp_loc_stack ()) (pexp_attributes ())))
                     (Nolabel
                      ((pexp_desc
                        (Pexp_construct
                         ((txt (Lident "()"))
                          (loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 54)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 56)))
                            (loc_ghost false))))
                         ()))
                       (pexp_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 54)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 56)))
                         (loc_ghost false)))
                       (pexp_loc_stack ()) (pexp_attributes ()))))))
                  (pexp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 18)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 65)))
                    (loc_ghost false)))
                  (pexp_loc_stack ()) (pexp_attributes ()))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 18)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 65)))
               (loc_ghost false)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 9)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 65)))
            (loc_ghost true)))
          (pexp_loc_stack ())
          (pexp_attributes
           (((attr_name
              ((txt warning)
               (loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                   (pos_cnum 152)))
                 (loc_ghost true)))))
             (attr_payload
              (PStr
               (((pstr_desc
                  (Pstr_eval
                   ((pexp_desc
                     (Pexp_constant
                      (Pconst_string -16
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))
                       ())))
                    (pexp_loc
                     ((loc_start
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_end
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_ghost true)))
                    (pexp_loc_stack ()) (pexp_attributes ()))
                   ()))
                 (pstr_loc
                  ((loc_start
                    ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                   (loc_end
                    ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                   (loc_ghost true)))))))
             (attr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                 (pos_cnum 152)))
               (loc_ghost true))))))))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
      (loc_ghost false))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 4)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 8)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 4)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 8)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_let Nonrecursive
            (((pvb_pat
               ((ppat_desc
                 (Ppat_var
                  ((txt Output)
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 0)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                       (pos_cnum 152)))
                     (loc_ghost true))))))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 0)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                    (pos_cnum 152)))
                  (loc_ghost true)))
                (ppat_loc_stack ()) (ppat_attributes ())))
              (pvb_expr
               ((pexp_desc
                 (Pexp_fun Nolabel ()
                  ((ppat_desc
                    (Ppat_constraint
                     ((ppat_desc
                       (Ppat_var
                        ((txt Props)
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                             (pos_cnum 0)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                             (pos_cnum 152)))
                           (loc_ghost true))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                          (pos_cnum 152)))
                        (loc_ghost true)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((ptyp_desc
                       (Ptyp_constr
                        ((txt (Ldot (Lident Js) t))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                             (pos_cnum 0)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                             (pos_cnum 152)))
                           (loc_ghost true))))
                        (((ptyp_desc
                           (Ptyp_object
                            (((pof_desc
                               (Otag
                                ((txt lola)
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 1)
                                     (pos_bol 0) (pos_cnum 0)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 2)
                                     (pos_bol 84) (pos_cnum 152)))
                                   (loc_ghost true))))
                                ((ptyp_desc (Ptyp_var lola))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 1)
                                     (pos_bol 0) (pos_cnum 10)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 1)
                                     (pos_bol 0) (pos_cnum 14)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ()))))
                              (pof_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 1)
                                  (pos_bol 0) (pos_cnum 0)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 2)
                                  (pos_bol 84) (pos_cnum 152)))
                                (loc_ghost true)))
                              (pof_attributes ())))
                            Closed))
                          (ptyp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 0)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                              (pos_cnum 152)))
                            (loc_ghost true)))
                          (ptyp_loc_stack ()) (ptyp_attributes ())))))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                          (pos_cnum 152)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 0)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                       (pos_cnum 152)))
                     (loc_ghost true)))
                   (ppat_loc_stack ()) (ppat_attributes ()))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident make))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                             (pos_cnum 0)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                             (pos_cnum 152)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                          (pos_cnum 152)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))
                     (((Labelled lola)
                       ((pexp_desc
                         (Pexp_apply
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Lident ##))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 1)
                                  (pos_bol 0) (pos_cnum 10)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 1)
                                  (pos_bol 0) (pos_cnum 14)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                               (pos_cnum 10)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                               (pos_cnum 14)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))
                          ((Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident Props))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 1)
                                    (pos_bol 0) (pos_cnum 10)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 1)
                                    (pos_bol 0) (pos_cnum 14)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 10)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 14)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident lola))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 1)
                                    (pos_bol 0) (pos_cnum 10)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 1)
                                    (pos_bol 0) (pos_cnum 14)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 10)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 14)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 10)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 14)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 0)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                       (pos_cnum 152)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                  (loc_end
                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                  (loc_ghost true)))
                (pexp_loc_stack ()) (pexp_attributes ())))
              (pvb_attributes ())
              (pvb_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                  (pos_cnum 152)))
                (loc_ghost true)))))
            ((pexp_desc
              (Pexp_ident
               ((txt (Lident Output))
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 0)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                    (pos_cnum 152)))
                  (loc_ghost true))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84)
                 (pos_cnum 152)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
            (loc_ghost true)))
          (pexp_loc_stack ()) (pexp_attributes ())))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 84) (pos_cnum 152)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_primitive
      ((pval_name
        ((txt makeProps)
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
           (loc_ghost true)))))
       (pval_type
        ((ptyp_desc
          (Ptyp_arrow (Optional initialValue)
           ((ptyp_desc (Ptyp_var initialValue))
            (ptyp_loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                (pos_cnum 164)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                (pos_cnum 176)))
              (loc_ghost false)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))
           ((ptyp_desc
             (Ptyp_arrow (Optional key)
              ((ptyp_desc
                (Ptyp_constr
                 ((txt (Lident string))
                  (loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                      (pos_cnum 153)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                      (pos_cnum 394)))
                    (loc_ghost true))))
                 ()))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                   (pos_cnum 153)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                   (pos_cnum 394)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))
              ((ptyp_desc
                (Ptyp_arrow Nolabel
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Lident unit))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                         (pos_cnum 153)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                         (pos_cnum 394)))
                       (loc_ghost true))))
                    ()))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                      (pos_cnum 153)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                      (pos_cnum 394)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Ldot (Lident Js) t))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                         (pos_cnum 153)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                         (pos_cnum 394)))
                       (loc_ghost true))))
                    (((ptyp_desc
                       (Ptyp_object
                        (((pof_desc
                           (Otag
                            ((txt initialValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 153)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 362) (pos_cnum 394)))
                               (loc_ghost true))))
                            ((ptyp_desc
                              (Ptyp_constr
                               ((txt (Lident option))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 164)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 176)))
                                  (loc_ghost false))))
                               (((ptyp_desc (Ptyp_var initialValue))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 153) (pos_cnum 164)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 153) (pos_cnum 176)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ())))))
                             (ptyp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 164)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 176)))
                               (loc_ghost false)))
                             (ptyp_loc_stack ()) (ptyp_attributes ()))))
                          (pof_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                              (pos_cnum 153)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                              (pos_cnum 394)))
                            (loc_ghost true)))
                          (pof_attributes ())))
                        Closed))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                          (pos_cnum 153)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                          (pos_cnum 394)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ())))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                      (pos_cnum 153)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                      (pos_cnum 394)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                   (pos_cnum 153)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                   (pos_cnum 394)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))))
            (ptyp_loc
             ((loc_start
               ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
              (loc_end
               ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
              (loc_ghost true)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))))
         (ptyp_loc
          ((loc_start
            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
           (loc_end
            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
           (loc_ghost true)))
         (ptyp_loc_stack ()) (ptyp_attributes ())))
       (pval_prim (""))
       (pval_attributes
        (((attr_name
           ((txt mel.obj)
            (loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                (pos_cnum 153)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                (pos_cnum 394)))
              (loc_ghost true)))))
          (attr_payload (PStr ()))
          (attr_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
            (loc_ghost true))))))
       (pval_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 157)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 161)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 157)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 161)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_fun (Optional initialValue)
            (((pexp_desc (Pexp_constant (Pconst_integer 0 ())))
              (pexp_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                  (pos_cnum 178)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                  (pos_cnum 179)))
                (loc_ghost false)))
              (pexp_loc_stack ()) (pexp_attributes ())))
            ((ppat_desc
              (Ppat_var
               ((txt initialValue)
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 164)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 176)))
                  (loc_ghost false))))))
             (ppat_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 164)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 176)))
               (loc_ghost false)))
             (ppat_loc_stack ()) (ppat_attributes ()))
            ((pexp_desc
              (Pexp_fun Nolabel ()
               ((ppat_desc
                 (Ppat_construct
                  ((txt (Lident "()"))
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                       (pos_cnum 182)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                       (pos_cnum 184)))
                     (loc_ghost false))))
                  ()))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 182)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 184)))
                  (loc_ghost false)))
                (ppat_loc_stack ()) (ppat_attributes ()))
               ((pexp_desc
                 (Pexp_let Nonrecursive
                  (((pvb_pat
                     ((ppat_desc
                       (Ppat_tuple
                        (((ppat_desc
                           (Ppat_var
                            ((txt value)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 187) (pos_cnum 194)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 187) (pos_cnum 199)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                              (pos_cnum 194)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                              (pos_cnum 199)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ()))
                         ((ppat_desc
                           (Ppat_var
                            ((txt setValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 187) (pos_cnum 201)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 187) (pos_cnum 209)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                              (pos_cnum 201)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                              (pos_cnum 209)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ())))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                          (pos_cnum 193)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                          (pos_cnum 210)))
                        (loc_ghost false)))
                      (ppat_loc_stack
                       (((loc_start
                          ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                           (pos_cnum 194)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                           (pos_cnum 209)))
                         (loc_ghost false))))
                      (ppat_attributes ())))
                    (pvb_expr
                     ((pexp_desc
                       (Pexp_apply
                        ((pexp_desc
                          (Pexp_ident
                           ((txt (Ldot (Lident React) useState))
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 187) (pos_cnum 213)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 187) (pos_cnum 227)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                             (pos_cnum 213)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                             (pos_cnum 227)))
                           (loc_ghost false)))
                         (pexp_loc_stack ()) (pexp_attributes ()))
                        ((Nolabel
                          ((pexp_desc
                            (Pexp_fun Nolabel ()
                             ((ppat_desc
                               (Ppat_construct
                                ((txt (Lident "()"))
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 187) (pos_cnum 233)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 187) (pos_cnum 235)))
                                   (loc_ghost false))))
                                ()))
                              (ppat_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 187) (pos_cnum 233)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 187) (pos_cnum 235)))
                                (loc_ghost false)))
                              (ppat_loc_stack ()) (ppat_attributes ()))
                             ((pexp_desc
                               (Pexp_ident
                                ((txt (Lident initialValue))
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 187) (pos_cnum 239)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 187) (pos_cnum 251)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 187) (pos_cnum 239)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 187) (pos_cnum 251)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                               (pos_cnum 228)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                               (pos_cnum 252)))
                             (loc_ghost false)))
                           (pexp_loc_stack
                            (((loc_start
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 187) (pos_cnum 229)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 187) (pos_cnum 251)))
                              (loc_ghost false))))
                           (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                          (pos_cnum 213)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                          (pos_cnum 252)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ())))
                    (pvb_attributes ())
                    (pvb_loc
                     ((loc_start
                       ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                        (pos_cnum 189)))
                      (loc_end
                       ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                        (pos_cnum 252)))
                      (loc_ghost false)))))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Ldot (Ldot (Lident React) DOM) jsx))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                             (pos_cnum 258)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                             (pos_cnum 374)))
                           (loc_ghost false))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                          (pos_cnum 258)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                          (pos_cnum 374)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ()))
                     ((Nolabel
                       ((pexp_desc
                         (Pexp_constant
                          (Pconst_string button
                           ((loc_start
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_end
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_ghost true))
                           ())))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                            (pos_cnum 260)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                            (pos_cnum 266)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ())))
                      (Nolabel
                       ((pexp_desc
                         (Pexp_apply
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Ldot (Ldot (Lident React) DOM) domProps))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 256) (pos_cnum 260)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 256) (pos_cnum 266)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                               (pos_cnum 258)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                               (pos_cnum 374)))
                             (loc_ghost false)))
                           (pexp_loc_stack ())
                           (pexp_attributes
                            (((attr_name
                               ((txt merlin.hide)
                                (loc
                                 ((loc_start
                                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                    (pos_cnum -1)))
                                  (loc_end
                                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                    (pos_cnum -1)))
                                  (loc_ghost true)))))
                              (attr_payload (PStr ()))
                              (attr_loc
                               ((loc_start
                                 ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                  (pos_cnum -1)))
                                (loc_end
                                 ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                  (pos_cnum -1)))
                                (loc_ghost true)))))))
                          (((Labelled children)
                            ((pexp_desc
                              (Pexp_apply
                               ((pexp_desc
                                 (Pexp_ident
                                  ((txt (Lident |.))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 6)
                                       (pos_bol 321) (pos_cnum 344)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 6)
                                       (pos_bol 321) (pos_cnum 346)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 321) (pos_cnum 344)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 321) (pos_cnum 346)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))
                               ((Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Lident value))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 321) (pos_cnum 338)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 321) (pos_cnum 343)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 321) (pos_cnum 338)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 321) (pos_cnum 343)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ())))
                                (Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Ldot (Lident React) int))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 321) (pos_cnum 347)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 321) (pos_cnum 356)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 321) (pos_cnum 347)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 321) (pos_cnum 356)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ()))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 321) (pos_cnum 338)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 321) (pos_cnum 356)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           ((Labelled onClick)
                            ((pexp_desc
                              (Pexp_fun Nolabel ()
                               ((ppat_desc Ppat_any)
                                (ppat_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 256) (pos_cnum 281)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 256) (pos_cnum 282)))
                                  (loc_ghost false)))
                                (ppat_loc_stack ()) (ppat_attributes ()))
                               ((pexp_desc
                                 (Pexp_apply
                                  ((pexp_desc
                                    (Pexp_ident
                                     ((txt (Lident setValue))
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 256) (pos_cnum 286)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 256) (pos_cnum 294)))
                                        (loc_ghost false))))))
                                   (pexp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 5)
                                       (pos_bol 256) (pos_cnum 286)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 5)
                                       (pos_bol 256) (pos_cnum 294)))
                                     (loc_ghost false)))
                                   (pexp_loc_stack ()) (pexp_attributes ()))
                                  ((Nolabel
                                    ((pexp_desc
                                      (Pexp_fun Nolabel ()
                                       ((ppat_desc
                                         (Ppat_var
                                          ((txt value)
                                           (loc
                                            ((loc_start
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 256)
                                               (pos_cnum 300)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 256)
                                               (pos_cnum 305)))
                                             (loc_ghost false))))))
                                        (ppat_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 256) (pos_cnum 300)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 256) (pos_cnum 305)))
                                          (loc_ghost false)))
                                        (ppat_loc_stack ())
                                        (ppat_attributes ()))
                                       ((pexp_desc
                                         (Pexp_apply
                                          ((pexp_desc
                                            (Pexp_ident
                                             ((txt (Lident +))
                                              (loc
                                               ((loc_start
                                                 ((pos_fname output.ml)
                                                  (pos_lnum 5) (pos_bol 256)
                                                  (pos_cnum 315)))
                                                (loc_end
                                                 ((pos_fname output.ml)
                                                  (pos_lnum 5) (pos_bol 256)
                                                  (pos_cnum 316)))
                                                (loc_ghost false))))))
                                           (pexp_loc
                                            ((loc_start
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 256)
                                               (pos_cnum 315)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 256)
                                               (pos_cnum 316)))
                                             (loc_ghost false)))
                                           (pexp_loc_stack ())
                                           (pexp_attributes ()))
                                          ((Nolabel
                                            ((pexp_desc
                                              (Pexp_ident
                                               ((txt (Lident value))
                                                (loc
                                                 ((loc_start
                                                   ((pos_fname output.ml)
                                                    (pos_lnum 5) (pos_bol 256)
                                                    (pos_cnum 309)))
                                                  (loc_end
                                                   ((pos_fname output.ml)
                                                    (pos_lnum 5) (pos_bol 256)
                                                    (pos_cnum 314)))
                                                  (loc_ghost false))))))
                                             (pexp_loc
                                              ((loc_start
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 256)
                                                 (pos_cnum 309)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 256)
                                                 (pos_cnum 314)))
                                               (loc_ghost false)))
                                             (pexp_loc_stack ())
                                             (pexp_attributes ())))
                                           (Nolabel
                                            ((pexp_desc
                                              (Pexp_constant
                                               (Pconst_integer 1 ())))
                                             (pexp_loc
                                              ((loc_start
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 256)
                                                 (pos_cnum 317)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 256)
                                                 (pos_cnum 318)))
                                               (loc_ghost false)))
                                             (pexp_loc_stack ())
                                             (pexp_attributes ()))))))
                                        (pexp_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 256) (pos_cnum 309)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 256) (pos_cnum 318)))
                                          (loc_ghost false)))
                                        (pexp_loc_stack ())
                                        (pexp_attributes ()))))
                                     (pexp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 5)
                                         (pos_bol 256) (pos_cnum 295)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 5)
                                         (pos_bol 256) (pos_cnum 319)))
                                       (loc_ghost false)))
                                     (pexp_loc_stack
                                      (((loc_start
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 256) (pos_cnum 296)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 256) (pos_cnum 318)))
                                        (loc_ghost false))))
                                     (pexp_attributes ()))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 256) (pos_cnum 286)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 256) (pos_cnum 319)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 5)
                                 (pos_bol 256) (pos_cnum 276)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 5)
                                 (pos_bol 256) (pos_cnum 320)))
                               (loc_ghost false)))
                             (pexp_loc_stack
                              (((loc_start
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 256) (pos_cnum 277)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 256) (pos_cnum 319)))
                                (loc_ghost false))))
                             (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_construct
                               ((txt (Lident "()"))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 321) (pos_cnum 358)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 321) (pos_cnum 360)))
                                  (loc_ghost false))))
                               ()))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 321) (pos_cnum 358)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 321) (pos_cnum 360)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                            (pos_cnum 258)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                            (pos_cnum 374)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 5) (pos_bol 256)
                       (pos_cnum 258)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                       (pos_cnum 374)))
                     (loc_ghost false)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 4) (pos_bol 187)
                    (pos_cnum 189)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                    (pos_cnum 374)))
                  (loc_ghost false)))
                (pexp_loc_stack ()) (pexp_attributes ()))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 182)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                 (pos_cnum 374)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 162)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 374)))
            (loc_ghost true)))
          (pexp_loc_stack ())
          (pexp_attributes
           (((attr_name
              ((txt warning)
               (loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                   (pos_cnum 153)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                   (pos_cnum 394)))
                 (loc_ghost true)))))
             (attr_payload
              (PStr
               (((pstr_desc
                  (Pstr_eval
                   ((pexp_desc
                     (Pexp_constant
                      (Pconst_string -16
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))
                       ())))
                    (pexp_loc
                     ((loc_start
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_end
                       ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                        (pos_cnum -1)))
                      (loc_ghost true)))
                    (pexp_loc_stack ()) (pexp_attributes ()))
                   ()))
                 (pstr_loc
                  ((loc_start
                    ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                   (loc_end
                    ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                   (loc_ghost true)))))))
             (attr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 153)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                 (pos_cnum 394)))
               (loc_ghost true))))))))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
      (loc_ghost false))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 157)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 161)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 157)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 161)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_let Nonrecursive
            (((pvb_pat
               ((ppat_desc
                 (Ppat_var
                  ((txt Output)
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                       (pos_cnum 153)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                       (pos_cnum 394)))
                     (loc_ghost true))))))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 153)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                    (pos_cnum 394)))
                  (loc_ghost true)))
                (ppat_loc_stack ()) (ppat_attributes ())))
              (pvb_expr
               ((pexp_desc
                 (Pexp_fun Nolabel ()
                  ((ppat_desc
                    (Ppat_constraint
                     ((ppat_desc
                       (Ppat_var
                        ((txt Props)
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                             (pos_cnum 153)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                             (pos_cnum 394)))
                           (loc_ghost true))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                          (pos_cnum 153)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                          (pos_cnum 394)))
                        (loc_ghost true)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((ptyp_desc
                       (Ptyp_constr
                        ((txt (Ldot (Lident Js) t))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                             (pos_cnum 153)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                             (pos_cnum 394)))
                           (loc_ghost true))))
                        (((ptyp_desc
                           (Ptyp_object
                            (((pof_desc
                               (Otag
                                ((txt initialValue)
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 153) (pos_cnum 153)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 362) (pos_cnum 394)))
                                   (loc_ghost true))))
                                ((ptyp_desc
                                  (Ptyp_constr
                                   ((txt (Lident option))
                                    (loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 153) (pos_cnum 164)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 153) (pos_cnum 176)))
                                      (loc_ghost false))))
                                   (((ptyp_desc (Ptyp_var initialValue))
                                     (ptyp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 153) (pos_cnum 164)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 153) (pos_cnum 176)))
                                       (loc_ghost false)))
                                     (ptyp_loc_stack ()) (ptyp_attributes ())))))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 153) (pos_cnum 164)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 153) (pos_cnum 176)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ()))))
                              (pof_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 153) (pos_cnum 153)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 362) (pos_cnum 394)))
                                (loc_ghost true)))
                              (pof_attributes ())))
                            Closed))
                          (ptyp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                              (pos_cnum 153)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                              (pos_cnum 394)))
                            (loc_ghost true)))
                          (ptyp_loc_stack ()) (ptyp_attributes ())))))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                          (pos_cnum 153)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                          (pos_cnum 394)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                       (pos_cnum 153)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                       (pos_cnum 394)))
                     (loc_ghost true)))
                   (ppat_loc_stack ()) (ppat_attributes ()))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident make))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                             (pos_cnum 153)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                             (pos_cnum 394)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                          (pos_cnum 153)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                          (pos_cnum 394)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))
                     (((Optional initialValue)
                       ((pexp_desc
                         (Pexp_apply
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Lident ##))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 153) (pos_cnum 164)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 153) (pos_cnum 176)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                               (pos_cnum 164)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                               (pos_cnum 176)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))
                          ((Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident Props))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 164)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 176)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 164)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 176)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident initialValue))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 164)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 153) (pos_cnum 176)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 164)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 153) (pos_cnum 176)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                            (pos_cnum 164)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                            (pos_cnum 176)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ())))
                      (Nolabel
                       ((pexp_desc
                         (Pexp_construct
                          ((txt (Lident "()"))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                               (pos_cnum 153)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                               (pos_cnum 394)))
                             (loc_ghost true))))
                          ()))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_end
                           ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_ghost true)))
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                       (pos_cnum 153)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                       (pos_cnum 394)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                  (loc_end
                   ((pos_fname _none_) (pos_lnum 1) (pos_bol 0) (pos_cnum -1)))
                  (loc_ghost true)))
                (pexp_loc_stack ()) (pexp_attributes ())))
              (pvb_attributes ())
              (pvb_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                  (pos_cnum 153)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                  (pos_cnum 394)))
                (loc_ghost true)))))
            ((pexp_desc
              (Pexp_ident
               ((txt (Lident Output))
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                    (pos_cnum 153)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                    (pos_cnum 394)))
                  (loc_ghost true))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153)
                 (pos_cnum 153)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362)
                 (pos_cnum 394)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
            (loc_ghost true)))
          (pexp_loc_stack ()) (pexp_attributes ())))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 153) (pos_cnum 153)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 362) (pos_cnum 394)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_module
      ((pmb_name
        ((txt (Uppercase))
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 8) (pos_bol 395) (pos_cnum 402)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 8) (pos_bol 395) (pos_cnum 411)))
           (loc_ghost false)))))
       (pmb_expr
        ((pmod_desc
          (Pmod_structure
           (((pstr_desc
              (Pstr_primitive
               ((pval_name
                 ((txt makeProps)
                  (loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                      (pos_cnum 427)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                      (pos_cnum 622)))
                    (loc_ghost true)))))
                (pval_type
                 ((ptyp_desc
                   (Ptyp_arrow (Labelled children)
                    ((ptyp_desc (Ptyp_var children))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                         (pos_cnum 446)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                         (pos_cnum 463)))
                       (loc_ghost false)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))
                    ((ptyp_desc
                      (Ptyp_arrow (Optional key)
                       ((ptyp_desc
                         (Ptyp_constr
                          ((txt (Lident string))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 423) (pos_cnum 427)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 553) (pos_cnum 622)))
                             (loc_ghost true))))
                          ()))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                            (pos_cnum 427)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                            (pos_cnum 622)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))
                       ((ptyp_desc
                         (Ptyp_arrow Nolabel
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Lident unit))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 10)
                                  (pos_bol 423) (pos_cnum 427)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 12)
                                  (pos_bol 553) (pos_cnum 622)))
                                (loc_ghost true))))
                             ()))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 423) (pos_cnum 427)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 553) (pos_cnum 622)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Ldot (Lident Js) t))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 10)
                                  (pos_bol 423) (pos_cnum 427)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 12)
                                  (pos_bol 553) (pos_cnum 622)))
                                (loc_ghost true))))
                             (((ptyp_desc
                                (Ptyp_object
                                 (((pof_desc
                                    (Otag
                                     ((txt children)
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 427)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 12)
                                          (pos_bol 553) (pos_cnum 622)))
                                        (loc_ghost true))))
                                     ((ptyp_desc (Ptyp_var children))
                                      (ptyp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 446)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 463)))
                                        (loc_ghost false)))
                                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                                   (pof_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 10)
                                       (pos_bol 423) (pos_cnum 427)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 12)
                                       (pos_bol 553) (pos_cnum 622)))
                                     (loc_ghost true)))
                                   (pof_attributes ())))
                                 Closed))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 423) (pos_cnum 427)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 553) (pos_cnum 622)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ())))))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 423) (pos_cnum 427)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 553) (pos_cnum 622)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                            (pos_cnum 427)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                            (pos_cnum 622)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum -1)))
                       (loc_end
                        ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum -1)))
                       (loc_ghost true)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum -1)))
                    (loc_end
                     ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum -1)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ())))
                (pval_prim (""))
                (pval_attributes
                 (((attr_name
                    ((txt mel.obj)
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                         (pos_cnum 427)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                         (pos_cnum 622)))
                       (loc_ghost true)))))
                   (attr_payload (PStr ()))
                   (attr_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 427)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                       (pos_cnum 622)))
                     (loc_ghost true))))))
                (pval_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                    (pos_cnum 427)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                    (pos_cnum 622)))
                  (loc_ghost true))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                 (pos_cnum 427)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                 (pos_cnum 622)))
               (loc_ghost true))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 431)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 435)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 431)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 435)))
                     (loc_ghost false)))
                   (ppat_loc_stack ()) (ppat_attributes ())))
                 (pvb_expr
                  ((pexp_desc
                    (Pexp_fun (Labelled children) ()
                     ((ppat_desc
                       (Ppat_var
                        ((txt upperCaseChildren)
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                             (pos_cnum 446)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                             (pos_cnum 463)))
                           (loc_ghost false))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 446)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 463)))
                        (loc_ghost false)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((pexp_desc
                       (Pexp_apply
                        ((pexp_desc
                          (Pexp_ident
                           ((txt (Ldot (Lident React) jsx))
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 11)
                                (pos_bol 467) (pos_cnum 473)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 11)
                                (pos_bol 467) (pos_cnum 534)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 467)
                             (pos_cnum 473)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 467)
                             (pos_cnum 534)))
                           (loc_ghost false)))
                         (pexp_loc_stack ()) (pexp_attributes ()))
                        ((Nolabel
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Ldot (Lident Box) make))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 467) (pos_cnum 473)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 467) (pos_cnum 534)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 467) (pos_cnum 473)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 467) (pos_cnum 534)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ())))
                         (Nolabel
                          ((pexp_desc
                            (Pexp_apply
                             ((pexp_desc
                               (Pexp_ident
                                ((txt (Ldot (Lident Box) makeProps))
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 11)
                                     (pos_bol 467) (pos_cnum 473)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 11)
                                     (pos_bol 467) (pos_cnum 534)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 467) (pos_cnum 473)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 467) (pos_cnum 534)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))
                             (((Labelled children)
                               ((pexp_desc
                                 (Pexp_ident
                                  ((txt (Lident upperCaseChildren))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 467) (pos_cnum 504)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 467) (pos_cnum 521)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 467) (pos_cnum 504)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 467) (pos_cnum 521)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ())))
                              (Nolabel
                               ((pexp_desc
                                 (Pexp_construct
                                  ((txt (Lident "()"))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 467) (pos_cnum 523)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 467) (pos_cnum 525)))
                                     (loc_ghost false))))
                                  ()))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 467) (pos_cnum 523)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 467) (pos_cnum 525)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 467) (pos_cnum 473)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 467) (pos_cnum 534)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 11) (pos_bol 467)
                          (pos_cnum 473)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 11) (pos_bol 467)
                          (pos_cnum 534)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 436)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 11) (pos_bol 467)
                       (pos_cnum 534)))
                     (loc_ghost true)))
                   (pexp_loc_stack ())
                   (pexp_attributes
                    (((attr_name
                       ((txt warning)
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                            (pos_cnum 427)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                            (pos_cnum 622)))
                          (loc_ghost true)))))
                      (attr_payload
                       (PStr
                        (((pstr_desc
                           (Pstr_eval
                            ((pexp_desc
                              (Pexp_constant
                               (Pconst_string -16
                                ((loc_start
                                  ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                   (pos_cnum -1)))
                                 (loc_end
                                  ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                   (pos_cnum -1)))
                                 (loc_ghost true))
                                ())))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum -1)))
                               (loc_end
                                ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum -1)))
                               (loc_ghost true)))
                             (pexp_loc_stack ()) (pexp_attributes ()))
                            ()))
                          (pstr_loc
                           ((loc_start
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_end
                             ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_ghost true)))))))
                      (attr_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 427)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                          (pos_cnum 622)))
                        (loc_ghost true))))))))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                     (pos_cnum 427)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                     (pos_cnum 622)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                 (pos_cnum 427)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                 (pos_cnum 622)))
               (loc_ghost false))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 431)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 435)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 431)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 435)))
                     (loc_ghost false)))
                   (ppat_loc_stack ()) (ppat_attributes ())))
                 (pvb_expr
                  ((pexp_desc
                    (Pexp_let Nonrecursive
                     (((pvb_pat
                        ((ppat_desc
                          (Ppat_var
                           ((txt Output$Uppercase)
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 10)
                                (pos_bol 423) (pos_cnum 427)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 553) (pos_cnum 622)))
                              (loc_ghost true))))))
                         (ppat_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                             (pos_cnum 427)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                             (pos_cnum 622)))
                           (loc_ghost true)))
                         (ppat_loc_stack ()) (ppat_attributes ())))
                       (pvb_expr
                        ((pexp_desc
                          (Pexp_fun Nolabel ()
                           ((ppat_desc
                             (Ppat_constraint
                              ((ppat_desc
                                (Ppat_var
                                 ((txt Props)
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 10)
                                      (pos_bol 423) (pos_cnum 427)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 553) (pos_cnum 622)))
                                    (loc_ghost true))))))
                               (ppat_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 423) (pos_cnum 427)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 553) (pos_cnum 622)))
                                 (loc_ghost true)))
                               (ppat_loc_stack ()) (ppat_attributes ()))
                              ((ptyp_desc
                                (Ptyp_constr
                                 ((txt (Ldot (Lident Js) t))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 10)
                                      (pos_bol 423) (pos_cnum 427)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 553) (pos_cnum 622)))
                                    (loc_ghost true))))
                                 (((ptyp_desc
                                    (Ptyp_object
                                     (((pof_desc
                                        (Otag
                                         ((txt children)
                                          (loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 423)
                                              (pos_cnum 427)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 12) (pos_bol 553)
                                              (pos_cnum 622)))
                                            (loc_ghost true))))
                                         ((ptyp_desc (Ptyp_var children))
                                          (ptyp_loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 423)
                                              (pos_cnum 446)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 423)
                                              (pos_cnum 463)))
                                            (loc_ghost false)))
                                          (ptyp_loc_stack ())
                                          (ptyp_attributes ()))))
                                       (pof_loc
                                        ((loc_start
                                          ((pos_fname output.ml) (pos_lnum 10)
                                           (pos_bol 423) (pos_cnum 427)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 12)
                                           (pos_bol 553) (pos_cnum 622)))
                                         (loc_ghost true)))
                                       (pof_attributes ())))
                                     Closed))
                                   (ptyp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 10)
                                       (pos_bol 423) (pos_cnum 427)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 12)
                                       (pos_bol 553) (pos_cnum 622)))
                                     (loc_ghost true)))
                                   (ptyp_loc_stack ()) (ptyp_attributes ())))))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 423) (pos_cnum 427)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 553) (pos_cnum 622)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ()))))
                            (ppat_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 10)
                                (pos_bol 423) (pos_cnum 427)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 553) (pos_cnum 622)))
                              (loc_ghost true)))
                            (ppat_loc_stack ()) (ppat_attributes ()))
                           ((pexp_desc
                             (Pexp_apply
                              ((pexp_desc
                                (Pexp_ident
                                 ((txt (Lident make))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 10)
                                      (pos_bol 423) (pos_cnum 427)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 553) (pos_cnum 622)))
                                    (loc_ghost true))))))
                               (pexp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 423) (pos_cnum 427)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 553) (pos_cnum 622)))
                                 (loc_ghost true)))
                               (pexp_loc_stack ()) (pexp_attributes ()))
                              (((Labelled children)
                                ((pexp_desc
                                  (Pexp_apply
                                   ((pexp_desc
                                     (Pexp_ident
                                      ((txt (Lident ##))
                                       (loc
                                        ((loc_start
                                          ((pos_fname output.ml) (pos_lnum 10)
                                           (pos_bol 423) (pos_cnum 446)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 10)
                                           (pos_bol 423) (pos_cnum 463)))
                                         (loc_ghost false))))))
                                    (pexp_loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 10)
                                        (pos_bol 423) (pos_cnum 446)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 10)
                                        (pos_bol 423) (pos_cnum 463)))
                                      (loc_ghost false)))
                                    (pexp_loc_stack ()) (pexp_attributes ()))
                                   ((Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident Props))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 423)
                                             (pos_cnum 446)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 423)
                                             (pos_cnum 463)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 446)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 463)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ())))
                                    (Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident children))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 423)
                                             (pos_cnum 446)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 423)
                                             (pos_cnum 463)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 446)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 423) (pos_cnum 463)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ()))))))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 10)
                                     (pos_bol 423) (pos_cnum 446)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 10)
                                     (pos_bol 423) (pos_cnum 463)))
                                   (loc_ghost false)))
                                 (pexp_loc_stack ()) (pexp_attributes ()))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 10)
                                (pos_bol 423) (pos_cnum 427)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 553) (pos_cnum 622)))
                              (loc_ghost true)))
                            (pexp_loc_stack ()) (pexp_attributes ()))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_end
                            ((pos_fname _none_) (pos_lnum 1) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_ghost true)))
                         (pexp_loc_stack ()) (pexp_attributes ())))
                       (pvb_attributes ())
                       (pvb_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                           (pos_cnum 427)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                           (pos_cnum 622)))
                         (loc_ghost true)))))
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident Output$Uppercase))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                             (pos_cnum 427)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                             (pos_cnum 622)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                          (pos_cnum 427)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                          (pos_cnum 622)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                       (pos_cnum 427)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                       (pos_cnum 622)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                     (pos_cnum 427)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                     (pos_cnum 622)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 423)
                 (pos_cnum 427)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 553)
                 (pos_cnum 622)))
               (loc_ghost true)))))))
         (pmod_loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 9) (pos_bol 414) (pos_cnum 416)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 623) (pos_cnum 628)))
           (loc_ghost false)))
         (pmod_attributes ())))
       (pmb_attributes ())
       (pmb_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 8) (pos_bol 395) (pos_cnum 395)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 13) (pos_bol 623) (pos_cnum 628)))
         (loc_ghost false))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 8) (pos_bol 395) (pos_cnum 395)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 13) (pos_bol 623) (pos_cnum 628)))
      (loc_ghost false)))))
