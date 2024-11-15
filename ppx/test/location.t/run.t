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
                 (((txt (Lident hidden_include_dirs))
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
                   (pexp_loc_stack ())
                   (pexp_attributes
                    (((attr_name
                       ((txt ppxlib.migration.load_path)
                        (loc
                         ((loc_start
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_end
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_ghost true)))))
                      (attr_payload
                       (PStr
                        (((pstr_desc
                           (Pstr_eval
                            ((pexp_desc
                              (Pexp_tuple
                               (((pexp_desc
                                  (Pexp_construct
                                   ((txt (Lident []))
                                    (loc
                                     ((loc_start
                                       ((pos_fname _none_) (pos_lnum 0)
                                        (pos_bol 0) (pos_cnum -1)))
                                      (loc_end
                                       ((pos_fname _none_) (pos_lnum 0)
                                        (pos_bol 0) (pos_cnum -1)))
                                      (loc_ghost true))))
                                   ()))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname _none_) (pos_lnum 0)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_end
                                    ((pos_fname _none_) (pos_lnum 0)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_ghost true)))
                                 (pexp_loc_stack ()) (pexp_attributes ()))
                                ((pexp_desc
                                  (Pexp_construct
                                   ((txt (Lident []))
                                    (loc
                                     ((loc_start
                                       ((pos_fname _none_) (pos_lnum 0)
                                        (pos_bol 0) (pos_cnum -1)))
                                      (loc_end
                                       ((pos_fname _none_) (pos_lnum 0)
                                        (pos_bol 0) (pos_cnum -1)))
                                      (loc_ghost true))))
                                   ()))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname _none_) (pos_lnum 0)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_end
                                    ((pos_fname _none_) (pos_lnum 0)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_ghost true)))
                                 (pexp_loc_stack ()) (pexp_attributes ())))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                 (pos_cnum -1)))
                               (loc_end
                                ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                 (pos_cnum -1)))
                               (loc_ghost true)))
                             (pexp_loc_stack ()) (pexp_attributes ()))
                            ()))
                          (pstr_loc
                           ((loc_start
                             ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_end
                             ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                              (pos_cnum -1)))
                            (loc_ghost true)))))))
                      (attr_loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_ghost true))))))))
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
            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
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
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                      (pos_cnum 150)))
                    (loc_ghost true))))
                 ()))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                   (pos_cnum 150)))
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
                        ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                         (pos_cnum 150)))
                       (loc_ghost true))))
                    ()))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 0)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                      (pos_cnum 150)))
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
                        ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                         (pos_cnum 150)))
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
                                 (pos_bol 83) (pos_cnum 150)))
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
                             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                              (pos_cnum 150)))
                            (loc_ghost true)))
                          (pof_attributes ())))
                        Closed))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                          (pos_cnum 150)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ())))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 0)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                      (pos_cnum 150)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                   (pos_cnum 150)))
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
               ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
              (loc_ghost true)))))
          (attr_payload (PStr ()))
          (attr_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
            (loc_ghost true))))))
       (pval_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
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
                  ((txt (Ldot (Lident ReactDOM) jsx))
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 17)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 64)))
                     (loc_ghost false))))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 17)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 64)))
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
                      (pos_cnum 19)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 22)))
                    (loc_ghost false)))
                  (pexp_loc_stack ()) (pexp_attributes ())))
                (Nolabel
                 ((pexp_desc
                   (Pexp_apply
                    ((pexp_desc
                      (Pexp_ident
                       ((txt (Ldot (Lident ReactDOM) domProps))
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 19)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                            (pos_cnum 22)))
                          (loc_ghost false))))))
                     (pexp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 17)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                         (pos_cnum 64)))
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
                                 (pos_cnum 34)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                 (pos_cnum 46)))
                               (loc_ghost false))))))
                          (pexp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 34)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 46)))
                            (loc_ghost false)))
                          (pexp_loc_stack ()) (pexp_attributes ()))
                         ((Nolabel
                           ((pexp_desc
                             (Pexp_ident
                              ((txt (Lident lola))
                               (loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 1)
                                   (pos_bol 0) (pos_cnum 47)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 1)
                                   (pos_bol 0) (pos_cnum 51)))
                                 (loc_ghost false))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                (pos_cnum 47)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                                (pos_cnum 51)))
                              (loc_ghost false)))
                            (pexp_loc_stack ()) (pexp_attributes ()))))))
                       (pexp_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 34)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 51)))
                         (loc_ghost false)))
                       (pexp_loc_stack ()) (pexp_attributes ())))
                     (Nolabel
                      ((pexp_desc
                        (Pexp_construct
                         ((txt (Lident "()"))
                          (loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 53)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 55)))
                            (loc_ghost false))))
                         ()))
                       (pexp_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 53)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                           (pos_cnum 55)))
                         (loc_ghost false)))
                       (pexp_loc_stack ()) (pexp_attributes ()))))))
                  (pexp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 17)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                      (pos_cnum 64)))
                    (loc_ghost false)))
                  (pexp_loc_stack ()) (pexp_attributes ()))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 17)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 64)))
               (loc_ghost false)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 9)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 64)))
            (loc_ghost true)))
          (pexp_loc_stack ())
          (pexp_attributes
           (((attr_name
              ((txt warning)
               (loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                   (pos_cnum 150)))
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
                ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                 (pos_cnum 150)))
               (loc_ghost true))))))))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
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
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                       (pos_cnum 150)))
                     (loc_ghost true))))))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 0)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                    (pos_cnum 150)))
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
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                             (pos_cnum 150)))
                           (loc_ghost true))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                          (pos_cnum 150)))
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
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                             (pos_cnum 150)))
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
                                     (pos_bol 83) (pos_cnum 150)))
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
                                  (pos_bol 83) (pos_cnum 150)))
                                (loc_ghost true)))
                              (pof_attributes ())))
                            Closed))
                          (ptyp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                              (pos_cnum 0)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                              (pos_cnum 150)))
                            (loc_ghost true)))
                          (ptyp_loc_stack ()) (ptyp_attributes ())))))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                          (pos_cnum 150)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                       (pos_cnum 0)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                       (pos_cnum 150)))
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
                            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                             (pos_cnum 150)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                          (pos_cnum 0)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                          (pos_cnum 150)))
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
                      ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                       (pos_cnum 150)))
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
                 ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                  (pos_cnum 150)))
                (loc_ghost true)))))
            ((pexp_desc
              (Pexp_ident
               ((txt (Lident Output))
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0)
                    (pos_cnum 0)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                    (pos_cnum 150)))
                  (loc_ghost true))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83)
                 (pos_cnum 150)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
            (loc_ghost true)))
          (pexp_loc_stack ()) (pexp_attributes ())))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 2) (pos_bol 83) (pos_cnum 150)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_primitive
      ((pval_name
        ((txt makeProps)
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
           (loc_ghost true)))))
       (pval_type
        ((ptyp_desc
          (Ptyp_arrow (Optional initialValue)
           ((ptyp_desc (Ptyp_var initialValue))
            (ptyp_loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                (pos_cnum 162)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                (pos_cnum 174)))
              (loc_ghost false)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))
           ((ptyp_desc
             (Ptyp_arrow (Optional key)
              ((ptyp_desc
                (Ptyp_constr
                 ((txt (Lident string))
                  (loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                      (pos_cnum 151)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                      (pos_cnum 391)))
                    (loc_ghost true))))
                 ()))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                   (pos_cnum 151)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                   (pos_cnum 391)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))
              ((ptyp_desc
                (Ptyp_arrow Nolabel
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Lident unit))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                         (pos_cnum 151)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                         (pos_cnum 391)))
                       (loc_ghost true))))
                    ()))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                      (pos_cnum 151)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                      (pos_cnum 391)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Ldot (Lident Js) t))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                         (pos_cnum 151)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                         (pos_cnum 391)))
                       (loc_ghost true))))
                    (((ptyp_desc
                       (Ptyp_object
                        (((pof_desc
                           (Otag
                            ((txt initialValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 151)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 359) (pos_cnum 391)))
                               (loc_ghost true))))
                            ((ptyp_desc
                              (Ptyp_constr
                               ((txt (Lident option))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 162)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 174)))
                                  (loc_ghost false))))
                               (((ptyp_desc (Ptyp_var initialValue))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 151) (pos_cnum 162)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 151) (pos_cnum 174)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ())))))
                             (ptyp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 162)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 174)))
                               (loc_ghost false)))
                             (ptyp_loc_stack ()) (ptyp_attributes ()))))
                          (pof_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                              (pos_cnum 151)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                              (pos_cnum 391)))
                            (loc_ghost true)))
                          (pof_attributes ())))
                        Closed))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                          (pos_cnum 151)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                          (pos_cnum 391)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ())))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                      (pos_cnum 151)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                      (pos_cnum 391)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                   (pos_cnum 151)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                   (pos_cnum 391)))
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
               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                (pos_cnum 151)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                (pos_cnum 391)))
              (loc_ghost true)))))
          (attr_payload (PStr ()))
          (attr_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
            (loc_ghost true))))))
       (pval_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 155)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 159)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 155)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 159)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_fun (Optional initialValue)
            (((pexp_desc (Pexp_constant (Pconst_integer 0 ())))
              (pexp_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                  (pos_cnum 176)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                  (pos_cnum 177)))
                (loc_ghost false)))
              (pexp_loc_stack ()) (pexp_attributes ())))
            ((ppat_desc
              (Ppat_var
               ((txt initialValue)
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 162)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 174)))
                  (loc_ghost false))))))
             (ppat_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 162)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 174)))
               (loc_ghost false)))
             (ppat_loc_stack ()) (ppat_attributes ()))
            ((pexp_desc
              (Pexp_fun Nolabel ()
               ((ppat_desc
                 (Ppat_construct
                  ((txt (Lident "()"))
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                       (pos_cnum 179)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                       (pos_cnum 181)))
                     (loc_ghost false))))
                  ()))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 179)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 181)))
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
                                 (pos_bol 184) (pos_cnum 191)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 184) (pos_cnum 196)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                              (pos_cnum 191)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                              (pos_cnum 196)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ()))
                         ((ppat_desc
                           (Ppat_var
                            ((txt setValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 184) (pos_cnum 198)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 4)
                                 (pos_bol 184) (pos_cnum 206)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                              (pos_cnum 198)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                              (pos_cnum 206)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ())))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                          (pos_cnum 190)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                          (pos_cnum 207)))
                        (loc_ghost false)))
                      (ppat_loc_stack
                       (((loc_start
                          ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                           (pos_cnum 191)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                           (pos_cnum 206)))
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
                                (pos_bol 184) (pos_cnum 210)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 184) (pos_cnum 224)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                             (pos_cnum 210)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                             (pos_cnum 224)))
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
                                     (pos_bol 184) (pos_cnum 230)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 184) (pos_cnum 232)))
                                   (loc_ghost false))))
                                ()))
                              (ppat_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 184) (pos_cnum 230)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 184) (pos_cnum 232)))
                                (loc_ghost false)))
                              (ppat_loc_stack ()) (ppat_attributes ()))
                             ((pexp_desc
                               (Pexp_ident
                                ((txt (Lident initialValue))
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 184) (pos_cnum 236)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 4)
                                     (pos_bol 184) (pos_cnum 248)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 184) (pos_cnum 236)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 184) (pos_cnum 248)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                               (pos_cnum 225)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                               (pos_cnum 249)))
                             (loc_ghost false)))
                           (pexp_loc_stack
                            (((loc_start
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 184) (pos_cnum 226)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4)
                                (pos_bol 184) (pos_cnum 248)))
                              (loc_ghost false))))
                           (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                          (pos_cnum 210)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                          (pos_cnum 249)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ())))
                    (pvb_attributes ())
                    (pvb_loc
                     ((loc_start
                       ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                        (pos_cnum 186)))
                      (loc_end
                       ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                        (pos_cnum 249)))
                      (loc_ghost false)))))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Ldot (Lident ReactDOM) jsx))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                             (pos_cnum 255)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                             (pos_cnum 371)))
                           (loc_ghost false))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                          (pos_cnum 255)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                          (pos_cnum 371)))
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
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                            (pos_cnum 257)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                            (pos_cnum 263)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ())))
                      (Nolabel
                       ((pexp_desc
                         (Pexp_apply
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Ldot (Lident ReactDOM) domProps))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 253) (pos_cnum 257)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 253) (pos_cnum 263)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                               (pos_cnum 255)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                               (pos_cnum 371)))
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
                                       (pos_bol 318) (pos_cnum 341)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 6)
                                       (pos_bol 318) (pos_cnum 343)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 318) (pos_cnum 341)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 318) (pos_cnum 343)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))
                               ((Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Lident value))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 318) (pos_cnum 335)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 318) (pos_cnum 340)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 318) (pos_cnum 335)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 318) (pos_cnum 340)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ())))
                                (Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Ldot (Lident React) int))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 318) (pos_cnum 344)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 318) (pos_cnum 353)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 318) (pos_cnum 344)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 6)
                                      (pos_bol 318) (pos_cnum 353)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ()))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 318) (pos_cnum 335)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 318) (pos_cnum 353)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           ((Labelled onClick)
                            ((pexp_desc
                              (Pexp_fun Nolabel ()
                               ((ppat_desc Ppat_any)
                                (ppat_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 253) (pos_cnum 278)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 253) (pos_cnum 279)))
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
                                          (pos_bol 253) (pos_cnum 283)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 253) (pos_cnum 291)))
                                        (loc_ghost false))))))
                                   (pexp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 5)
                                       (pos_bol 253) (pos_cnum 283)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 5)
                                       (pos_bol 253) (pos_cnum 291)))
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
                                               (pos_lnum 5) (pos_bol 253)
                                               (pos_cnum 297)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 253)
                                               (pos_cnum 302)))
                                             (loc_ghost false))))))
                                        (ppat_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 253) (pos_cnum 297)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 253) (pos_cnum 302)))
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
                                                  (pos_lnum 5) (pos_bol 253)
                                                  (pos_cnum 312)))
                                                (loc_end
                                                 ((pos_fname output.ml)
                                                  (pos_lnum 5) (pos_bol 253)
                                                  (pos_cnum 313)))
                                                (loc_ghost false))))))
                                           (pexp_loc
                                            ((loc_start
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 253)
                                               (pos_cnum 312)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 5) (pos_bol 253)
                                               (pos_cnum 313)))
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
                                                    (pos_lnum 5) (pos_bol 253)
                                                    (pos_cnum 306)))
                                                  (loc_end
                                                   ((pos_fname output.ml)
                                                    (pos_lnum 5) (pos_bol 253)
                                                    (pos_cnum 311)))
                                                  (loc_ghost false))))))
                                             (pexp_loc
                                              ((loc_start
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 253)
                                                 (pos_cnum 306)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 253)
                                                 (pos_cnum 311)))
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
                                                 (pos_lnum 5) (pos_bol 253)
                                                 (pos_cnum 314)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 5) (pos_bol 253)
                                                 (pos_cnum 315)))
                                               (loc_ghost false)))
                                             (pexp_loc_stack ())
                                             (pexp_attributes ()))))))
                                        (pexp_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 253) (pos_cnum 306)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 5)
                                            (pos_bol 253) (pos_cnum 315)))
                                          (loc_ghost false)))
                                        (pexp_loc_stack ())
                                        (pexp_attributes ()))))
                                     (pexp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 5)
                                         (pos_bol 253) (pos_cnum 292)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 5)
                                         (pos_bol 253) (pos_cnum 316)))
                                       (loc_ghost false)))
                                     (pexp_loc_stack
                                      (((loc_start
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 253) (pos_cnum 293)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 5)
                                          (pos_bol 253) (pos_cnum 315)))
                                        (loc_ghost false))))
                                     (pexp_attributes ()))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 253) (pos_cnum 283)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 5)
                                    (pos_bol 253) (pos_cnum 316)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 5)
                                 (pos_bol 253) (pos_cnum 273)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 5)
                                 (pos_bol 253) (pos_cnum 317)))
                               (loc_ghost false)))
                             (pexp_loc_stack
                              (((loc_start
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 253) (pos_cnum 274)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 5)
                                  (pos_bol 253) (pos_cnum 316)))
                                (loc_ghost false))))
                             (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_construct
                               ((txt (Lident "()"))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 318) (pos_cnum 355)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 318) (pos_cnum 357)))
                                  (loc_ghost false))))
                               ()))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 318) (pos_cnum 355)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 318) (pos_cnum 357)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                            (pos_cnum 255)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                            (pos_cnum 371)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 5) (pos_bol 253)
                       (pos_cnum 255)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                       (pos_cnum 371)))
                     (loc_ghost false)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 4) (pos_bol 184)
                    (pos_cnum 186)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                    (pos_cnum 371)))
                  (loc_ghost false)))
                (pexp_loc_stack ()) (pexp_attributes ()))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 179)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                 (pos_cnum 371)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 160)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 371)))
            (loc_ghost true)))
          (pexp_loc_stack ())
          (pexp_attributes
           (((attr_name
              ((txt warning)
               (loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                   (pos_cnum 151)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                   (pos_cnum 391)))
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
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 151)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                 (pos_cnum 391)))
               (loc_ghost true))))))))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
      (loc_ghost false))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 155)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 159)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 155)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 159)))
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
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                       (pos_cnum 151)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                       (pos_cnum 391)))
                     (loc_ghost true))))))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 151)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                    (pos_cnum 391)))
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
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                             (pos_cnum 151)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                             (pos_cnum 391)))
                           (loc_ghost true))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                          (pos_cnum 151)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                          (pos_cnum 391)))
                        (loc_ghost true)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((ptyp_desc
                       (Ptyp_constr
                        ((txt (Ldot (Lident Js) t))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                             (pos_cnum 151)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                             (pos_cnum 391)))
                           (loc_ghost true))))
                        (((ptyp_desc
                           (Ptyp_object
                            (((pof_desc
                               (Otag
                                ((txt initialValue)
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 151) (pos_cnum 151)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 359) (pos_cnum 391)))
                                   (loc_ghost true))))
                                ((ptyp_desc
                                  (Ptyp_constr
                                   ((txt (Lident option))
                                    (loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 151) (pos_cnum 162)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 151) (pos_cnum 174)))
                                      (loc_ghost false))))
                                   (((ptyp_desc (Ptyp_var initialValue))
                                     (ptyp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 151) (pos_cnum 162)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 151) (pos_cnum 174)))
                                       (loc_ghost false)))
                                     (ptyp_loc_stack ()) (ptyp_attributes ())))))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 151) (pos_cnum 162)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 151) (pos_cnum 174)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ()))))
                              (pof_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 151) (pos_cnum 151)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 359) (pos_cnum 391)))
                                (loc_ghost true)))
                              (pof_attributes ())))
                            Closed))
                          (ptyp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                              (pos_cnum 151)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                              (pos_cnum 391)))
                            (loc_ghost true)))
                          (ptyp_loc_stack ()) (ptyp_attributes ())))))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                          (pos_cnum 151)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                          (pos_cnum 391)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                       (pos_cnum 151)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                       (pos_cnum 391)))
                     (loc_ghost true)))
                   (ppat_loc_stack ()) (ppat_attributes ()))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident make))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                             (pos_cnum 151)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                             (pos_cnum 391)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                          (pos_cnum 151)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                          (pos_cnum 391)))
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
                                  (pos_bol 151) (pos_cnum 162)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 151) (pos_cnum 174)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                               (pos_cnum 162)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                               (pos_cnum 174)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))
                          ((Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident Props))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 162)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 174)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 162)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 174)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident initialValue))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 162)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 151) (pos_cnum 174)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 162)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 3)
                                 (pos_bol 151) (pos_cnum 174)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                            (pos_cnum 162)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                            (pos_cnum 174)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ())))
                      (Nolabel
                       ((pexp_desc
                         (Pexp_construct
                          ((txt (Lident "()"))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                               (pos_cnum 151)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                               (pos_cnum 391)))
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
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                       (pos_cnum 151)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                       (pos_cnum 391)))
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
                 ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                  (pos_cnum 151)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                  (pos_cnum 391)))
                (loc_ghost true)))))
            ((pexp_desc
              (Pexp_ident
               ((txt (Lident Output))
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                    (pos_cnum 151)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                    (pos_cnum 391)))
                  (loc_ghost true))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151)
                 (pos_cnum 151)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359)
                 (pos_cnum 391)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
            (loc_ghost true)))
          (pexp_loc_stack ()) (pexp_attributes ())))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 3) (pos_bol 151) (pos_cnum 151)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 359) (pos_cnum 391)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_module
      ((pmb_name
        ((txt (Uppercase))
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 8) (pos_bol 392) (pos_cnum 399)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 8) (pos_bol 392) (pos_cnum 408)))
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
                     ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                      (pos_cnum 424)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                      (pos_cnum 618)))
                    (loc_ghost true)))))
                (pval_type
                 ((ptyp_desc
                   (Ptyp_arrow (Labelled children)
                    ((ptyp_desc (Ptyp_var children))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                         (pos_cnum 443)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                         (pos_cnum 460)))
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
                               (pos_bol 420) (pos_cnum 424)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 549) (pos_cnum 618)))
                             (loc_ghost true))))
                          ()))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                            (pos_cnum 424)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                            (pos_cnum 618)))
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
                                  (pos_bol 420) (pos_cnum 424)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 12)
                                  (pos_bol 549) (pos_cnum 618)))
                                (loc_ghost true))))
                             ()))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 420) (pos_cnum 424)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 549) (pos_cnum 618)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Ldot (Lident Js) t))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 10)
                                  (pos_bol 420) (pos_cnum 424)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 12)
                                  (pos_bol 549) (pos_cnum 618)))
                                (loc_ghost true))))
                             (((ptyp_desc
                                (Ptyp_object
                                 (((pof_desc
                                    (Otag
                                     ((txt children)
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 424)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 12)
                                          (pos_bol 549) (pos_cnum 618)))
                                        (loc_ghost true))))
                                     ((ptyp_desc (Ptyp_var children))
                                      (ptyp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 443)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 460)))
                                        (loc_ghost false)))
                                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                                   (pof_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 10)
                                       (pos_bol 420) (pos_cnum 424)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 12)
                                       (pos_bol 549) (pos_cnum 618)))
                                     (loc_ghost true)))
                                   (pof_attributes ())))
                                 Closed))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 420) (pos_cnum 424)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 549) (pos_cnum 618)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ())))))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 420) (pos_cnum 424)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 12)
                               (pos_bol 549) (pos_cnum 618)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                            (pos_cnum 424)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                            (pos_cnum 618)))
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
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                         (pos_cnum 424)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                         (pos_cnum 618)))
                       (loc_ghost true)))))
                   (attr_payload (PStr ()))
                   (attr_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 424)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                       (pos_cnum 618)))
                     (loc_ghost true))))))
                (pval_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                    (pos_cnum 424)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                    (pos_cnum 618)))
                  (loc_ghost true))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                 (pos_cnum 424)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                 (pos_cnum 618)))
               (loc_ghost true))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 428)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 432)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 428)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 432)))
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
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                             (pos_cnum 443)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                             (pos_cnum 460)))
                           (loc_ghost false))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 443)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 460)))
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
                                (pos_bol 463) (pos_cnum 469)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 11)
                                (pos_bol 463) (pos_cnum 530)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 463)
                             (pos_cnum 469)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 463)
                             (pos_cnum 530)))
                           (loc_ghost false)))
                         (pexp_loc_stack ()) (pexp_attributes ()))
                        ((Nolabel
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Ldot (Lident Box) make))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 463) (pos_cnum 469)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 463) (pos_cnum 530)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 463) (pos_cnum 469)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 463) (pos_cnum 530)))
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
                                     (pos_bol 463) (pos_cnum 469)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 11)
                                     (pos_bol 463) (pos_cnum 530)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 463) (pos_cnum 469)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 11)
                                  (pos_bol 463) (pos_cnum 530)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))
                             (((Labelled children)
                               ((pexp_desc
                                 (Pexp_ident
                                  ((txt (Lident upperCaseChildren))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 463) (pos_cnum 500)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 463) (pos_cnum 517)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 463) (pos_cnum 500)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 463) (pos_cnum 517)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ())))
                              (Nolabel
                               ((pexp_desc
                                 (Pexp_construct
                                  ((txt (Lident "()"))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 463) (pos_cnum 519)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 11)
                                       (pos_bol 463) (pos_cnum 521)))
                                     (loc_ghost false))))
                                  ()))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 463) (pos_cnum 519)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 11)
                                    (pos_bol 463) (pos_cnum 521)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 463) (pos_cnum 469)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 11)
                               (pos_bol 463) (pos_cnum 530)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 11) (pos_bol 463)
                          (pos_cnum 469)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 11) (pos_bol 463)
                          (pos_cnum 530)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 433)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 11) (pos_bol 463)
                       (pos_cnum 530)))
                     (loc_ghost true)))
                   (pexp_loc_stack ())
                   (pexp_attributes
                    (((attr_name
                       ((txt warning)
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                            (pos_cnum 424)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                            (pos_cnum 618)))
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
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 424)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                          (pos_cnum 618)))
                        (loc_ghost true))))))))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                     (pos_cnum 424)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                     (pos_cnum 618)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                 (pos_cnum 424)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                 (pos_cnum 618)))
               (loc_ghost false))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 428)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 432)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 428)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 432)))
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
                                (pos_bol 420) (pos_cnum 424)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 549) (pos_cnum 618)))
                              (loc_ghost true))))))
                         (ppat_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                             (pos_cnum 424)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                             (pos_cnum 618)))
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
                                      (pos_bol 420) (pos_cnum 424)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 549) (pos_cnum 618)))
                                    (loc_ghost true))))))
                               (ppat_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 420) (pos_cnum 424)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 549) (pos_cnum 618)))
                                 (loc_ghost true)))
                               (ppat_loc_stack ()) (ppat_attributes ()))
                              ((ptyp_desc
                                (Ptyp_constr
                                 ((txt (Ldot (Lident Js) t))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 10)
                                      (pos_bol 420) (pos_cnum 424)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 549) (pos_cnum 618)))
                                    (loc_ghost true))))
                                 (((ptyp_desc
                                    (Ptyp_object
                                     (((pof_desc
                                        (Otag
                                         ((txt children)
                                          (loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 420)
                                              (pos_cnum 424)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 12) (pos_bol 549)
                                              (pos_cnum 618)))
                                            (loc_ghost true))))
                                         ((ptyp_desc (Ptyp_var children))
                                          (ptyp_loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 420)
                                              (pos_cnum 443)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 10) (pos_bol 420)
                                              (pos_cnum 460)))
                                            (loc_ghost false)))
                                          (ptyp_loc_stack ())
                                          (ptyp_attributes ()))))
                                       (pof_loc
                                        ((loc_start
                                          ((pos_fname output.ml) (pos_lnum 10)
                                           (pos_bol 420) (pos_cnum 424)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 12)
                                           (pos_bol 549) (pos_cnum 618)))
                                         (loc_ghost true)))
                                       (pof_attributes ())))
                                     Closed))
                                   (ptyp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 10)
                                       (pos_bol 420) (pos_cnum 424)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 12)
                                       (pos_bol 549) (pos_cnum 618)))
                                     (loc_ghost true)))
                                   (ptyp_loc_stack ()) (ptyp_attributes ())))))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 420) (pos_cnum 424)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 549) (pos_cnum 618)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ()))))
                            (ppat_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 10)
                                (pos_bol 420) (pos_cnum 424)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 549) (pos_cnum 618)))
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
                                      (pos_bol 420) (pos_cnum 424)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 12)
                                      (pos_bol 549) (pos_cnum 618)))
                                    (loc_ghost true))))))
                               (pexp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 10)
                                   (pos_bol 420) (pos_cnum 424)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 12)
                                   (pos_bol 549) (pos_cnum 618)))
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
                                           (pos_bol 420) (pos_cnum 443)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 10)
                                           (pos_bol 420) (pos_cnum 460)))
                                         (loc_ghost false))))))
                                    (pexp_loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 10)
                                        (pos_bol 420) (pos_cnum 443)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 10)
                                        (pos_bol 420) (pos_cnum 460)))
                                      (loc_ghost false)))
                                    (pexp_loc_stack ()) (pexp_attributes ()))
                                   ((Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident Props))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 420)
                                             (pos_cnum 443)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 420)
                                             (pos_cnum 460)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 443)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 460)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ())))
                                    (Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident children))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 420)
                                             (pos_cnum 443)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 10) (pos_bol 420)
                                             (pos_cnum 460)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 443)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 10)
                                          (pos_bol 420) (pos_cnum 460)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ()))))))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 10)
                                     (pos_bol 420) (pos_cnum 443)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 10)
                                     (pos_bol 420) (pos_cnum 460)))
                                   (loc_ghost false)))
                                 (pexp_loc_stack ()) (pexp_attributes ()))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 10)
                                (pos_bol 420) (pos_cnum 424)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 12)
                                (pos_bol 549) (pos_cnum 618)))
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
                          ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                           (pos_cnum 424)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                           (pos_cnum 618)))
                         (loc_ghost true)))))
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident Output$Uppercase))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                             (pos_cnum 424)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                             (pos_cnum 618)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                          (pos_cnum 424)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                          (pos_cnum 618)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                       (pos_cnum 424)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                       (pos_cnum 618)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                     (pos_cnum 424)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                     (pos_cnum 618)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 420)
                 (pos_cnum 424)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 12) (pos_bol 549)
                 (pos_cnum 618)))
               (loc_ghost true)))))))
         (pmod_loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 9) (pos_bol 411) (pos_cnum 413)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 619) (pos_cnum 624)))
           (loc_ghost false)))
         (pmod_attributes ())))
       (pmb_attributes ())
       (pmb_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 8) (pos_bol 392) (pos_cnum 392)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 13) (pos_bol 619) (pos_cnum 624)))
         (loc_ghost false))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 8) (pos_bol 392) (pos_cnum 392)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 13) (pos_bol 619) (pos_cnum 624)))
      (loc_ghost false)))))
