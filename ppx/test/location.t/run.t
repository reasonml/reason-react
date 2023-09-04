  $ refmt --parse re --print ml input.re > output.ml
  $ reason-react-ppx.standalone -dparsetree --impl output.ml -o temp.ml
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
     (Pstr_module
      ((pmb_name
        ((txt (Lola))
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 7)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 11)))
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
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                      (pos_cnum 27)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                      (pos_cnum 119)))
                    (loc_ghost true)))))
                (pval_type
                 ((ptyp_desc
                   (Ptyp_arrow (Labelled lola)
                    ((ptyp_desc (Ptyp_var lola))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                         (pos_cnum 37)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                         (pos_cnum 41)))
                       (loc_ghost false)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))
                    ((ptyp_desc
                      (Ptyp_arrow (Optional key)
                       ((ptyp_desc
                         (Ptyp_constr
                          ((txt (Lident string))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 27)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                               (pos_cnum 119)))
                             (loc_ghost true))))
                          ()))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                            (pos_cnum 27)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                            (pos_cnum 119)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))
                       ((ptyp_desc
                         (Ptyp_arrow Nolabel
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Lident unit))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 23) (pos_cnum 27)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 93) (pos_cnum 119)))
                                (loc_ghost true))))
                             ()))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 27)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                               (pos_cnum 119)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Ldot (Lident Js) t))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 23) (pos_cnum 27)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 4)
                                  (pos_bol 93) (pos_cnum 119)))
                                (loc_ghost true))))
                             (((ptyp_desc
                                (Ptyp_object
                                 (((pof_desc
                                    (Otag
                                     ((txt lola)
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 27)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 4)
                                          (pos_bol 93) (pos_cnum 119)))
                                        (loc_ghost true))))
                                     ((ptyp_desc (Ptyp_var lola))
                                      (ptyp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 37)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 41)))
                                        (loc_ghost false)))
                                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                                   (pof_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 27)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 4)
                                       (pos_bol 93) (pos_cnum 119)))
                                     (loc_ghost true)))
                                   (pof_attributes ())))
                                 Closed))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 3)
                                   (pos_bol 23) (pos_cnum 27)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 4)
                                   (pos_bol 93) (pos_cnum 119)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ())))))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 27)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                               (pos_cnum 119)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_end
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                         (pos_cnum 27)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                         (pos_cnum 119)))
                       (loc_ghost true)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                      (pos_cnum 37)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                      (pos_cnum 41)))
                    (loc_ghost false)))
                  (ptyp_loc_stack ()) (ptyp_attributes ())))
                (pval_prim (""))
                (pval_attributes
                 (((attr_name
                    ((txt bs.obj)
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                         (pos_cnum 27)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                         (pos_cnum 119)))
                       (loc_ghost true)))))
                   (attr_payload (PStr ()))
                   (attr_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 27)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                       (pos_cnum 119)))
                     (loc_ghost true))))))
                (pval_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                    (pos_cnum 27)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                    (pos_cnum 119)))
                  (loc_ghost true))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23) (pos_cnum 27)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                 (pos_cnum 119)))
               (loc_ghost true))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 31)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 35)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 31)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 35)))
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
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 37)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 41)))
                           (loc_ghost false))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 37)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 41)))
                        (loc_ghost false)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((pexp_desc
                       (Pexp_apply
                        ((pexp_desc
                          (Pexp_ident
                           ((txt (Ldot (Lident ReactDOM) jsx))
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                                (pos_cnum 45)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                                (pos_cnum 92)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 45)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 92)))
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
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 47)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 50)))
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
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 23) (pos_cnum 47)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 23) (pos_cnum 50)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 23) (pos_cnum 47)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 3)
                                  (pos_bol 23) (pos_cnum 50)))
                                (loc_ghost false)))
                              (pexp_loc_stack ())
                              (pexp_attributes
                               (((attr_name
                                  ((txt merlin.hide)
                                   (loc
                                    ((loc_start
                                      ((pos_fname _none_) (pos_lnum 1)
                                       (pos_bol 0) (pos_cnum -1)))
                                     (loc_end
                                      ((pos_fname _none_) (pos_lnum 1)
                                       (pos_bol 0) (pos_cnum -1)))
                                     (loc_ghost true)))))
                                 (attr_payload (PStr ()))
                                 (attr_loc
                                  ((loc_start
                                    ((pos_fname _none_) (pos_lnum 1)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_end
                                    ((pos_fname _none_) (pos_lnum 1)
                                     (pos_bol 0) (pos_cnum -1)))
                                   (loc_ghost true)))))))
                             (((Labelled children)
                               ((pexp_desc
                                 (Pexp_apply
                                  ((pexp_desc
                                    (Pexp_ident
                                     ((txt (Ldot (Lident React) string))
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 62)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 74)))
                                        (loc_ghost false))))))
                                   (pexp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 62)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 74)))
                                     (loc_ghost false)))
                                   (pexp_loc_stack ()) (pexp_attributes ()))
                                  ((Nolabel
                                    ((pexp_desc
                                      (Pexp_ident
                                       ((txt (Lident lola))
                                        (loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 3)
                                            (pos_bol 23) (pos_cnum 75)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 3)
                                            (pos_bol 23) (pos_cnum 79)))
                                          (loc_ghost false))))))
                                     (pexp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 23) (pos_cnum 75)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 3)
                                         (pos_bol 23) (pos_cnum 79)))
                                       (loc_ghost false)))
                                     (pexp_loc_stack ()) (pexp_attributes ()))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 23) (pos_cnum 62)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 23) (pos_cnum 79)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ())))
                              (Nolabel
                               ((pexp_desc
                                 (Pexp_construct
                                  ((txt (Lident "()"))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 81)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 83)))
                                     (loc_ghost false))))
                                  ()))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 23) (pos_cnum 81)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 3)
                                    (pos_bol 23) (pos_cnum 83)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 45)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                               (pos_cnum 92)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 45)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 92)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 36)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 92)))
                     (loc_ghost true)))
                   (pexp_loc_stack ())
                   (pexp_attributes
                    (((attr_name
                       ((txt warning)
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                            (pos_cnum 27)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                            (pos_cnum 119)))
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
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 27)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                          (pos_cnum 119)))
                        (loc_ghost true))))))))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                     (pos_cnum 27)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                     (pos_cnum 119)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23) (pos_cnum 27)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                 (pos_cnum 119)))
               (loc_ghost false))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 31)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 35)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 31)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                       (pos_cnum 35)))
                     (loc_ghost false)))
                   (ppat_loc_stack ()) (ppat_attributes ())))
                 (pvb_expr
                  ((pexp_desc
                    (Pexp_let Nonrecursive
                     (((pvb_pat
                        ((ppat_desc
                          (Ppat_var
                           ((txt Output$Lola)
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                                (pos_cnum 27)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                                (pos_cnum 119)))
                              (loc_ghost true))))))
                         (ppat_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 27)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                             (pos_cnum 119)))
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
                                     ((pos_fname output.ml) (pos_lnum 3)
                                      (pos_bol 23) (pos_cnum 27)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 4)
                                      (pos_bol 93) (pos_cnum 119)))
                                    (loc_ghost true))))))
                               (ppat_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 3)
                                   (pos_bol 23) (pos_cnum 27)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 4)
                                   (pos_bol 93) (pos_cnum 119)))
                                 (loc_ghost true)))
                               (ppat_loc_stack ()) (ppat_attributes ()))
                              ((ptyp_desc
                                (Ptyp_constr
                                 ((txt (Ldot (Lident Js) t))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 3)
                                      (pos_bol 23) (pos_cnum 27)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 4)
                                      (pos_bol 93) (pos_cnum 119)))
                                    (loc_ghost true))))
                                 (((ptyp_desc
                                    (Ptyp_object
                                     (((pof_desc
                                        (Otag
                                         ((txt lola)
                                          (loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 3) (pos_bol 23)
                                              (pos_cnum 27)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 4) (pos_bol 93)
                                              (pos_cnum 119)))
                                            (loc_ghost true))))
                                         ((ptyp_desc (Ptyp_var lola))
                                          (ptyp_loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 3) (pos_bol 23)
                                              (pos_cnum 37)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 3) (pos_bol 23)
                                              (pos_cnum 41)))
                                            (loc_ghost false)))
                                          (ptyp_loc_stack ())
                                          (ptyp_attributes ()))))
                                       (pof_loc
                                        ((loc_start
                                          ((pos_fname output.ml) (pos_lnum 3)
                                           (pos_bol 23) (pos_cnum 27)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 4)
                                           (pos_bol 93) (pos_cnum 119)))
                                         (loc_ghost true)))
                                       (pof_attributes ())))
                                     Closed))
                                   (ptyp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 3)
                                       (pos_bol 23) (pos_cnum 27)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 4)
                                       (pos_bol 93) (pos_cnum 119)))
                                     (loc_ghost true)))
                                   (ptyp_loc_stack ()) (ptyp_attributes ())))))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 3)
                                   (pos_bol 23) (pos_cnum 27)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 4)
                                   (pos_bol 93) (pos_cnum 119)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ()))))
                            (ppat_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                                (pos_cnum 27)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                                (pos_cnum 119)))
                              (loc_ghost true)))
                            (ppat_loc_stack ()) (ppat_attributes ()))
                           ((pexp_desc
                             (Pexp_apply
                              ((pexp_desc
                                (Pexp_ident
                                 ((txt (Lident make))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 3)
                                      (pos_bol 23) (pos_cnum 27)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 4)
                                      (pos_bol 93) (pos_cnum 119)))
                                    (loc_ghost true))))))
                               (pexp_loc
                                ((loc_start
                                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                   (pos_cnum -1)))
                                 (loc_end
                                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                   (pos_cnum -1)))
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
                                          ((pos_fname output.ml) (pos_lnum 3)
                                           (pos_bol 23) (pos_cnum 37)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 3)
                                           (pos_bol 23) (pos_cnum 41)))
                                         (loc_ghost false))))))
                                    (pexp_loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 23) (pos_cnum 37)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 3)
                                        (pos_bol 23) (pos_cnum 41)))
                                      (loc_ghost false)))
                                    (pexp_loc_stack ()) (pexp_attributes ()))
                                   ((Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident Props))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml) (pos_lnum 3)
                                             (pos_bol 23) (pos_cnum 37)))
                                           (loc_end
                                            ((pos_fname output.ml) (pos_lnum 3)
                                             (pos_bol 23) (pos_cnum 41)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 37)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 41)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ())))
                                    (Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident lola))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml) (pos_lnum 3)
                                             (pos_bol 23) (pos_cnum 37)))
                                           (loc_end
                                            ((pos_fname output.ml) (pos_lnum 3)
                                             (pos_bol 23) (pos_cnum 41)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 37)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 3)
                                          (pos_bol 23) (pos_cnum 41)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ()))))))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 23) (pos_cnum 37)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 3)
                                     (pos_bol 23) (pos_cnum 41)))
                                   (loc_ghost false)))
                                 (pexp_loc_stack ()) (pexp_attributes ()))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                                (pos_cnum 27)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                                (pos_cnum 119)))
                              (loc_ghost true)))
                            (pexp_loc_stack ()) (pexp_attributes ()))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_end
                            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_ghost true)))
                         (pexp_loc_stack ()) (pexp_attributes ())))
                       (pvb_attributes ())
                       (pvb_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                           (pos_cnum 27)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                           (pos_cnum 119)))
                         (loc_ghost true)))))
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident Output$Lola))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                             (pos_cnum 27)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                             (pos_cnum 119)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                          (pos_cnum 27)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                          (pos_cnum 119)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23)
                     (pos_cnum 27)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                     (pos_cnum 119)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 3) (pos_bol 23) (pos_cnum 27)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 4) (pos_bol 93)
                 (pos_cnum 119)))
               (loc_ghost true)))))))
         (pmod_loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 2) (pos_bol 14) (pos_cnum 16)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 5) (pos_bol 120) (pos_cnum 125)))
           (loc_ghost false)))
         (pmod_attributes ())))
       (pmb_attributes ())
       (pmb_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 5) (pos_bol 120) (pos_cnum 125)))
         (loc_ghost false))))))
    (pstr_loc
     ((loc_start ((pos_fname output.ml) (pos_lnum 1) (pos_bol 0) (pos_cnum 0)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 5) (pos_bol 120) (pos_cnum 125)))
      (loc_ghost false))))
   ((pstr_desc
     (Pstr_primitive
      ((pval_name
        ((txt makeProps)
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
           (loc_ghost true)))))
       (pval_type
        ((ptyp_desc
          (Ptyp_arrow (Optional initialValue)
           ((ptyp_desc (Ptyp_var initialValue))
            (ptyp_loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                (pos_cnum 137)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                (pos_cnum 149)))
              (loc_ghost false)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))
           ((ptyp_desc
             (Ptyp_arrow (Optional key)
              ((ptyp_desc
                (Ptyp_constr
                 ((txt (Lident string))
                  (loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                      (pos_cnum 126)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                      (pos_cnum 367)))
                    (loc_ghost true))))
                 ()))
               (ptyp_loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                   (pos_cnum 126)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                   (pos_cnum 367)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))
              ((ptyp_desc
                (Ptyp_arrow Nolabel
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Lident unit))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                         (pos_cnum 126)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                         (pos_cnum 367)))
                       (loc_ghost true))))
                    ()))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                      (pos_cnum 126)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                      (pos_cnum 367)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))
                 ((ptyp_desc
                   (Ptyp_constr
                    ((txt (Ldot (Lident Js) t))
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                         (pos_cnum 126)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                         (pos_cnum 367)))
                       (loc_ghost true))))
                    (((ptyp_desc
                       (Ptyp_object
                        (((pof_desc
                           (Otag
                            ((txt initialValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 126)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 10)
                                 (pos_bol 335) (pos_cnum 367)))
                               (loc_ghost true))))
                            ((ptyp_desc
                              (Ptyp_constr
                               ((txt (Lident option))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 137)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 149)))
                                  (loc_ghost false))))
                               (((ptyp_desc (Ptyp_var initialValue))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 6)
                                     (pos_bol 126) (pos_cnum 137)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 6)
                                     (pos_bol 126) (pos_cnum 149)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ())))))
                             (ptyp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 137)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 149)))
                               (loc_ghost false)))
                             (ptyp_loc_stack ()) (ptyp_attributes ()))))
                          (pof_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                              (pos_cnum 126)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                              (pos_cnum 367)))
                            (loc_ghost true)))
                          (pof_attributes ())))
                        Closed))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                          (pos_cnum 126)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                          (pos_cnum 367)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ())))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                      (pos_cnum 126)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                      (pos_cnum 367)))
                    (loc_ghost true)))
                  (ptyp_loc_stack ()) (ptyp_attributes ()))))
               (ptyp_loc
                ((loc_start
                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                 (loc_end
                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                 (loc_ghost true)))
               (ptyp_loc_stack ()) (ptyp_attributes ()))))
            (ptyp_loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                (pos_cnum 126)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                (pos_cnum 367)))
              (loc_ghost true)))
            (ptyp_loc_stack ()) (ptyp_attributes ()))))
         (ptyp_loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 137)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 149)))
           (loc_ghost false)))
         (ptyp_loc_stack ()) (ptyp_attributes ())))
       (pval_prim (""))
       (pval_attributes
        (((attr_name
           ((txt bs.obj)
            (loc
             ((loc_start
               ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                (pos_cnum 126)))
              (loc_end
               ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                (pos_cnum 367)))
              (loc_ghost true)))))
          (attr_payload (PStr ()))
          (attr_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
            (loc_ghost true))))))
       (pval_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
         (loc_ghost true))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 130)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 134)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 130)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 134)))
            (loc_ghost false)))
          (ppat_loc_stack ()) (ppat_attributes ())))
        (pvb_expr
         ((pexp_desc
           (Pexp_fun (Optional initialValue)
            (((pexp_desc (Pexp_constant (Pconst_integer 0 ())))
              (pexp_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                  (pos_cnum 151)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                  (pos_cnum 152)))
                (loc_ghost false)))
              (pexp_loc_stack ()) (pexp_attributes ())))
            ((ppat_desc
              (Ppat_var
               ((txt initialValue)
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 137)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 149)))
                  (loc_ghost false))))))
             (ppat_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 137)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 149)))
               (loc_ghost false)))
             (ppat_loc_stack ()) (ppat_attributes ()))
            ((pexp_desc
              (Pexp_fun Nolabel ()
               ((ppat_desc
                 (Ppat_construct
                  ((txt (Lident "()"))
                   (loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                       (pos_cnum 155)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                       (pos_cnum 157)))
                     (loc_ghost false))))
                  ()))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 155)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 157)))
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
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 160) (pos_cnum 167)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 160) (pos_cnum 172)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                              (pos_cnum 167)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                              (pos_cnum 172)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ()))
                         ((ppat_desc
                           (Ppat_var
                            ((txt setValue)
                             (loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 160) (pos_cnum 174)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 7)
                                 (pos_bol 160) (pos_cnum 182)))
                               (loc_ghost false))))))
                          (ppat_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                              (pos_cnum 174)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                              (pos_cnum 182)))
                            (loc_ghost false)))
                          (ppat_loc_stack ()) (ppat_attributes ())))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                          (pos_cnum 166)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                          (pos_cnum 183)))
                        (loc_ghost false)))
                      (ppat_loc_stack
                       (((loc_start
                          ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                           (pos_cnum 167)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                           (pos_cnum 182)))
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
                               ((pos_fname output.ml) (pos_lnum 7)
                                (pos_bol 160) (pos_cnum 186)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 7)
                                (pos_bol 160) (pos_cnum 200)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                             (pos_cnum 186)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                             (pos_cnum 200)))
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
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 160) (pos_cnum 206)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 160) (pos_cnum 208)))
                                   (loc_ghost false))))
                                ()))
                              (ppat_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 160) (pos_cnum 206)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 160) (pos_cnum 208)))
                                (loc_ghost false)))
                              (ppat_loc_stack ()) (ppat_attributes ()))
                             ((pexp_desc
                               (Pexp_ident
                                ((txt (Lident initialValue))
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 160) (pos_cnum 212)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 7)
                                     (pos_bol 160) (pos_cnum 224)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 160) (pos_cnum 212)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 7)
                                  (pos_bol 160) (pos_cnum 224)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                               (pos_cnum 201)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                               (pos_cnum 225)))
                             (loc_ghost false)))
                           (pexp_loc_stack
                            (((loc_start
                               ((pos_fname output.ml) (pos_lnum 7)
                                (pos_bol 160) (pos_cnum 202)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 7)
                                (pos_bol 160) (pos_cnum 224)))
                              (loc_ghost false))))
                           (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                          (pos_cnum 186)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                          (pos_cnum 225)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ())))
                    (pvb_attributes ())
                    (pvb_loc
                     ((loc_start
                       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                        (pos_cnum 162)))
                      (loc_end
                       ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                        (pos_cnum 225)))
                      (loc_ghost false)))))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Ldot (Lident ReactDOM) jsx))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                             (pos_cnum 231)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                             (pos_cnum 347)))
                           (loc_ghost false))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                          (pos_cnum 231)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                          (pos_cnum 347)))
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
                           ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                            (pos_cnum 233)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                            (pos_cnum 239)))
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
                                 ((pos_fname output.ml) (pos_lnum 8)
                                  (pos_bol 229) (pos_cnum 233)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 8)
                                  (pos_bol 229) (pos_cnum 239)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                               (pos_cnum 233)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                               (pos_cnum 239)))
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
                                      ((pos_fname output.ml) (pos_lnum 9)
                                       (pos_bol 294) (pos_cnum 317)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 9)
                                       (pos_bol 294) (pos_cnum 319)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 9)
                                    (pos_bol 294) (pos_cnum 317)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 9)
                                    (pos_bol 294) (pos_cnum 319)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))
                               ((Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Lident value))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 9)
                                         (pos_bol 294) (pos_cnum 311)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 9)
                                         (pos_bol 294) (pos_cnum 316)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 9)
                                      (pos_bol 294) (pos_cnum 311)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 9)
                                      (pos_bol 294) (pos_cnum 316)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ())))
                                (Nolabel
                                 ((pexp_desc
                                   (Pexp_ident
                                    ((txt (Ldot (Lident React) int))
                                     (loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 9)
                                         (pos_bol 294) (pos_cnum 320)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 9)
                                         (pos_bol 294) (pos_cnum 329)))
                                       (loc_ghost false))))))
                                  (pexp_loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 9)
                                      (pos_bol 294) (pos_cnum 320)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 9)
                                      (pos_bol 294) (pos_cnum 329)))
                                    (loc_ghost false)))
                                  (pexp_loc_stack ()) (pexp_attributes ()))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 9)
                                 (pos_bol 294) (pos_cnum 311)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 9)
                                 (pos_bol 294) (pos_cnum 329)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           ((Labelled onClick)
                            ((pexp_desc
                              (Pexp_fun Nolabel ()
                               ((ppat_desc Ppat_any)
                                (ppat_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 8)
                                    (pos_bol 229) (pos_cnum 254)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 8)
                                    (pos_bol 229) (pos_cnum 255)))
                                  (loc_ghost false)))
                                (ppat_loc_stack ()) (ppat_attributes ()))
                               ((pexp_desc
                                 (Pexp_apply
                                  ((pexp_desc
                                    (Pexp_ident
                                     ((txt (Lident setValue))
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 8)
                                          (pos_bol 229) (pos_cnum 259)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 8)
                                          (pos_bol 229) (pos_cnum 267)))
                                        (loc_ghost false))))))
                                   (pexp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 8)
                                       (pos_bol 229) (pos_cnum 259)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 8)
                                       (pos_bol 229) (pos_cnum 267)))
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
                                               (pos_lnum 8) (pos_bol 229)
                                               (pos_cnum 273)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 8) (pos_bol 229)
                                               (pos_cnum 278)))
                                             (loc_ghost false))))))
                                        (ppat_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 8)
                                            (pos_bol 229) (pos_cnum 273)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 8)
                                            (pos_bol 229) (pos_cnum 278)))
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
                                                  (pos_lnum 8) (pos_bol 229)
                                                  (pos_cnum 288)))
                                                (loc_end
                                                 ((pos_fname output.ml)
                                                  (pos_lnum 8) (pos_bol 229)
                                                  (pos_cnum 289)))
                                                (loc_ghost false))))))
                                           (pexp_loc
                                            ((loc_start
                                              ((pos_fname output.ml)
                                               (pos_lnum 8) (pos_bol 229)
                                               (pos_cnum 288)))
                                             (loc_end
                                              ((pos_fname output.ml)
                                               (pos_lnum 8) (pos_bol 229)
                                               (pos_cnum 289)))
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
                                                    (pos_lnum 8) (pos_bol 229)
                                                    (pos_cnum 282)))
                                                  (loc_end
                                                   ((pos_fname output.ml)
                                                    (pos_lnum 8) (pos_bol 229)
                                                    (pos_cnum 287)))
                                                  (loc_ghost false))))))
                                             (pexp_loc
                                              ((loc_start
                                                ((pos_fname output.ml)
                                                 (pos_lnum 8) (pos_bol 229)
                                                 (pos_cnum 282)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 8) (pos_bol 229)
                                                 (pos_cnum 287)))
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
                                                 (pos_lnum 8) (pos_bol 229)
                                                 (pos_cnum 290)))
                                               (loc_end
                                                ((pos_fname output.ml)
                                                 (pos_lnum 8) (pos_bol 229)
                                                 (pos_cnum 291)))
                                               (loc_ghost false)))
                                             (pexp_loc_stack ())
                                             (pexp_attributes ()))))))
                                        (pexp_loc
                                         ((loc_start
                                           ((pos_fname output.ml) (pos_lnum 8)
                                            (pos_bol 229) (pos_cnum 282)))
                                          (loc_end
                                           ((pos_fname output.ml) (pos_lnum 8)
                                            (pos_bol 229) (pos_cnum 291)))
                                          (loc_ghost false)))
                                        (pexp_loc_stack ())
                                        (pexp_attributes ()))))
                                     (pexp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 8)
                                         (pos_bol 229) (pos_cnum 268)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 8)
                                         (pos_bol 229) (pos_cnum 292)))
                                       (loc_ghost false)))
                                     (pexp_loc_stack
                                      (((loc_start
                                         ((pos_fname output.ml) (pos_lnum 8)
                                          (pos_bol 229) (pos_cnum 269)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 8)
                                          (pos_bol 229) (pos_cnum 291)))
                                        (loc_ghost false))))
                                     (pexp_attributes ()))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 8)
                                    (pos_bol 229) (pos_cnum 259)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 8)
                                    (pos_bol 229) (pos_cnum 292)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 8)
                                 (pos_bol 229) (pos_cnum 249)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 8)
                                 (pos_bol 229) (pos_cnum 293)))
                               (loc_ghost false)))
                             (pexp_loc_stack
                              (((loc_start
                                 ((pos_fname output.ml) (pos_lnum 8)
                                  (pos_bol 229) (pos_cnum 250)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 8)
                                  (pos_bol 229) (pos_cnum 292)))
                                (loc_ghost false))))
                             (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_construct
                               ((txt (Lident "()"))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 9)
                                    (pos_bol 294) (pos_cnum 331)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 9)
                                    (pos_bol 294) (pos_cnum 333)))
                                  (loc_ghost false))))
                               ()))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 9)
                                 (pos_bol 294) (pos_cnum 331)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 9)
                                 (pos_bol 294) (pos_cnum 333)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                            (pos_cnum 231)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                            (pos_cnum 347)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 8) (pos_bol 229)
                       (pos_cnum 231)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                       (pos_cnum 347)))
                     (loc_ghost false)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 7) (pos_bol 160)
                    (pos_cnum 162)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                    (pos_cnum 347)))
                  (loc_ghost false)))
                (pexp_loc_stack ()) (pexp_attributes ()))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 155)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                 (pos_cnum 347)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 135)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 347)))
            (loc_ghost true)))
          (pexp_loc_stack ())
          (pexp_attributes
           (((attr_name
              ((txt warning)
               (loc
                ((loc_start
                  ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                   (pos_cnum 126)))
                 (loc_end
                  ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                   (pos_cnum 367)))
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
                    ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                   (loc_end
                    ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                   (loc_ghost true)))))))
             (attr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 126)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                 (pos_cnum 367)))
               (loc_ghost true))))))))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
      (loc_ghost false))))
   ((pstr_desc
     (Pstr_value Nonrecursive
      (((pvb_pat
         ((ppat_desc
           (Ppat_var
            ((txt make)
             (loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 130)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 134)))
               (loc_ghost false))))))
          (ppat_loc
           ((loc_start
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 130)))
            (loc_end
             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 134)))
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
                      ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                       (pos_cnum 126)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                       (pos_cnum 367)))
                     (loc_ghost true))))))
                (ppat_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 126)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                    (pos_cnum 367)))
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
                            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                             (pos_cnum 126)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                             (pos_cnum 367)))
                           (loc_ghost true))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                          (pos_cnum 126)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                          (pos_cnum 367)))
                        (loc_ghost true)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((ptyp_desc
                       (Ptyp_constr
                        ((txt (Ldot (Lident Js) t))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                             (pos_cnum 126)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                             (pos_cnum 367)))
                           (loc_ghost true))))
                        (((ptyp_desc
                           (Ptyp_object
                            (((pof_desc
                               (Otag
                                ((txt initialValue)
                                 (loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 6)
                                     (pos_bol 126) (pos_cnum 126)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 10)
                                     (pos_bol 335) (pos_cnum 367)))
                                   (loc_ghost true))))
                                ((ptyp_desc
                                  (Ptyp_constr
                                   ((txt (Lident option))
                                    (loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 6)
                                        (pos_bol 126) (pos_cnum 137)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 6)
                                        (pos_bol 126) (pos_cnum 149)))
                                      (loc_ghost false))))
                                   (((ptyp_desc (Ptyp_var initialValue))
                                     (ptyp_loc
                                      ((loc_start
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 126) (pos_cnum 137)))
                                       (loc_end
                                        ((pos_fname output.ml) (pos_lnum 6)
                                         (pos_bol 126) (pos_cnum 149)))
                                       (loc_ghost false)))
                                     (ptyp_loc_stack ()) (ptyp_attributes ())))))
                                 (ptyp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 6)
                                     (pos_bol 126) (pos_cnum 137)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 6)
                                     (pos_bol 126) (pos_cnum 149)))
                                   (loc_ghost false)))
                                 (ptyp_loc_stack ()) (ptyp_attributes ()))))
                              (pof_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 6)
                                  (pos_bol 126) (pos_cnum 126)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 10)
                                  (pos_bol 335) (pos_cnum 367)))
                                (loc_ghost true)))
                              (pof_attributes ())))
                            Closed))
                          (ptyp_loc
                           ((loc_start
                             ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                              (pos_cnum 126)))
                            (loc_end
                             ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                              (pos_cnum 367)))
                            (loc_ghost true)))
                          (ptyp_loc_stack ()) (ptyp_attributes ())))))
                      (ptyp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                          (pos_cnum 126)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                          (pos_cnum 367)))
                        (loc_ghost true)))
                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                       (pos_cnum 126)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                       (pos_cnum 367)))
                     (loc_ghost true)))
                   (ppat_loc_stack ()) (ppat_attributes ()))
                  ((pexp_desc
                    (Pexp_apply
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident make))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                             (pos_cnum 126)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                             (pos_cnum 367)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
                        (loc_end
                         ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                          (pos_cnum -1)))
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
                                 ((pos_fname output.ml) (pos_lnum 6)
                                  (pos_bol 126) (pos_cnum 137)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 6)
                                  (pos_bol 126) (pos_cnum 149)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                               (pos_cnum 137)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                               (pos_cnum 149)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))
                          ((Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident Props))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 137)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 149)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 137)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 149)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ())))
                           (Nolabel
                            ((pexp_desc
                              (Pexp_ident
                               ((txt (Lident initialValue))
                                (loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 137)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 6)
                                    (pos_bol 126) (pos_cnum 149)))
                                  (loc_ghost false))))))
                             (pexp_loc
                              ((loc_start
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 137)))
                               (loc_end
                                ((pos_fname output.ml) (pos_lnum 6)
                                 (pos_bol 126) (pos_cnum 149)))
                               (loc_ghost false)))
                             (pexp_loc_stack ()) (pexp_attributes ()))))))
                        (pexp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                            (pos_cnum 137)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                            (pos_cnum 149)))
                          (loc_ghost false)))
                        (pexp_loc_stack ()) (pexp_attributes ())))
                      (Nolabel
                       ((pexp_desc
                         (Pexp_construct
                          ((txt (Lident "()"))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                               (pos_cnum 126)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 10)
                               (pos_bol 335) (pos_cnum 367)))
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
                        (pexp_loc_stack ()) (pexp_attributes ()))))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                       (pos_cnum 126)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                       (pos_cnum 367)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ()))))
                (pexp_loc
                 ((loc_start
                   ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                  (loc_end
                   ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
                  (loc_ghost true)))
                (pexp_loc_stack ()) (pexp_attributes ())))
              (pvb_attributes ())
              (pvb_loc
               ((loc_start
                 ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                  (pos_cnum 126)))
                (loc_end
                 ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                  (pos_cnum 367)))
                (loc_ghost true)))))
            ((pexp_desc
              (Pexp_ident
               ((txt (Lident Output))
                (loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                    (pos_cnum 126)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                    (pos_cnum 367)))
                  (loc_ghost true))))))
             (pexp_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126)
                 (pos_cnum 126)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335)
                 (pos_cnum 367)))
               (loc_ghost true)))
             (pexp_loc_stack ()) (pexp_attributes ()))))
          (pexp_loc
           ((loc_start
             ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
            (loc_end
             ((pos_fname _none_) (pos_lnum 0) (pos_bol 0) (pos_cnum -1)))
            (loc_ghost true)))
          (pexp_loc_stack ()) (pexp_attributes ())))
        (pvb_attributes ())
        (pvb_loc
         ((loc_start
           ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
          (loc_end
           ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
          (loc_ghost false)))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 6) (pos_bol 126) (pos_cnum 126)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 10) (pos_bol 335) (pos_cnum 367)))
      (loc_ghost true))))
   ((pstr_desc
     (Pstr_module
      ((pmb_name
        ((txt (Uppercase))
         (loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 368) (pos_cnum 375)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 11) (pos_bol 368) (pos_cnum 384)))
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
                     ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                      (pos_cnum 400)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                      (pos_cnum 595)))
                    (loc_ghost true)))))
                (pval_type
                 ((ptyp_desc
                   (Ptyp_arrow (Labelled children)
                    ((ptyp_desc (Ptyp_var children))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                         (pos_cnum 419)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                         (pos_cnum 436)))
                       (loc_ghost false)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))
                    ((ptyp_desc
                      (Ptyp_arrow (Optional key)
                       ((ptyp_desc
                         (Ptyp_constr
                          ((txt (Lident string))
                           (loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 13)
                               (pos_bol 396) (pos_cnum 400)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 15)
                               (pos_bol 526) (pos_cnum 595)))
                             (loc_ghost true))))
                          ()))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                            (pos_cnum 400)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                            (pos_cnum 595)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))
                       ((ptyp_desc
                         (Ptyp_arrow Nolabel
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Lident unit))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 13)
                                  (pos_bol 396) (pos_cnum 400)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 15)
                                  (pos_bol 526) (pos_cnum 595)))
                                (loc_ghost true))))
                             ()))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 13)
                               (pos_bol 396) (pos_cnum 400)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 15)
                               (pos_bol 526) (pos_cnum 595)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))
                          ((ptyp_desc
                            (Ptyp_constr
                             ((txt (Ldot (Lident Js) t))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 13)
                                  (pos_bol 396) (pos_cnum 400)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 15)
                                  (pos_bol 526) (pos_cnum 595)))
                                (loc_ghost true))))
                             (((ptyp_desc
                                (Ptyp_object
                                 (((pof_desc
                                    (Otag
                                     ((txt children)
                                      (loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 400)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 15)
                                          (pos_bol 526) (pos_cnum 595)))
                                        (loc_ghost true))))
                                     ((ptyp_desc (Ptyp_var children))
                                      (ptyp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 419)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 436)))
                                        (loc_ghost false)))
                                      (ptyp_loc_stack ()) (ptyp_attributes ()))))
                                   (pof_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 13)
                                       (pos_bol 396) (pos_cnum 400)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 15)
                                       (pos_bol 526) (pos_cnum 595)))
                                     (loc_ghost true)))
                                   (pof_attributes ())))
                                 Closed))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 13)
                                   (pos_bol 396) (pos_cnum 400)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 15)
                                   (pos_bol 526) (pos_cnum 595)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ())))))
                           (ptyp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 13)
                               (pos_bol 396) (pos_cnum 400)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 15)
                               (pos_bol 526) (pos_cnum 595)))
                             (loc_ghost true)))
                           (ptyp_loc_stack ()) (ptyp_attributes ()))))
                        (ptyp_loc
                         ((loc_start
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_end
                           ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                            (pos_cnum -1)))
                          (loc_ghost true)))
                        (ptyp_loc_stack ()) (ptyp_attributes ()))))
                     (ptyp_loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                         (pos_cnum 400)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                         (pos_cnum 595)))
                       (loc_ghost true)))
                     (ptyp_loc_stack ()) (ptyp_attributes ()))))
                  (ptyp_loc
                   ((loc_start
                     ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                      (pos_cnum 419)))
                    (loc_end
                     ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                      (pos_cnum 436)))
                    (loc_ghost false)))
                  (ptyp_loc_stack ()) (ptyp_attributes ())))
                (pval_prim (""))
                (pval_attributes
                 (((attr_name
                    ((txt bs.obj)
                     (loc
                      ((loc_start
                        ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                         (pos_cnum 400)))
                       (loc_end
                        ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                         (pos_cnum 595)))
                       (loc_ghost true)))))
                   (attr_payload (PStr ()))
                   (attr_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 400)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                       (pos_cnum 595)))
                     (loc_ghost true))))))
                (pval_loc
                 ((loc_start
                   ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                    (pos_cnum 400)))
                  (loc_end
                   ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                    (pos_cnum 595)))
                  (loc_ghost true))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                 (pos_cnum 400)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                 (pos_cnum 595)))
               (loc_ghost true))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 404)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 408)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 404)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 408)))
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
                            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                             (pos_cnum 419)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                             (pos_cnum 436)))
                           (loc_ghost false))))))
                      (ppat_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 419)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 436)))
                        (loc_ghost false)))
                      (ppat_loc_stack ()) (ppat_attributes ()))
                     ((pexp_desc
                       (Pexp_apply
                        ((pexp_desc
                          (Pexp_ident
                           ((txt (Ldot (Lident React) jsx))
                            (loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 14)
                                (pos_bol 440) (pos_cnum 446)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 14)
                                (pos_bol 440) (pos_cnum 507)))
                              (loc_ghost false))))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 14) (pos_bol 440)
                             (pos_cnum 446)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 14) (pos_bol 440)
                             (pos_cnum 507)))
                           (loc_ghost false)))
                         (pexp_loc_stack ()) (pexp_attributes ()))
                        ((Nolabel
                          ((pexp_desc
                            (Pexp_ident
                             ((txt (Ldot (Lident Box) make))
                              (loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 14)
                                  (pos_bol 440) (pos_cnum 446)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 14)
                                  (pos_bol 440) (pos_cnum 507)))
                                (loc_ghost false))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 14)
                               (pos_bol 440) (pos_cnum 446)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 14)
                               (pos_bol 440) (pos_cnum 507)))
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
                                    ((pos_fname output.ml) (pos_lnum 14)
                                     (pos_bol 440) (pos_cnum 446)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 14)
                                     (pos_bol 440) (pos_cnum 507)))
                                   (loc_ghost false))))))
                              (pexp_loc
                               ((loc_start
                                 ((pos_fname output.ml) (pos_lnum 14)
                                  (pos_bol 440) (pos_cnum 446)))
                                (loc_end
                                 ((pos_fname output.ml) (pos_lnum 14)
                                  (pos_bol 440) (pos_cnum 507)))
                                (loc_ghost false)))
                              (pexp_loc_stack ()) (pexp_attributes ()))
                             (((Labelled children)
                               ((pexp_desc
                                 (Pexp_ident
                                  ((txt (Lident upperCaseChildren))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 14)
                                       (pos_bol 440) (pos_cnum 477)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 14)
                                       (pos_bol 440) (pos_cnum 494)))
                                     (loc_ghost false))))))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 14)
                                    (pos_bol 440) (pos_cnum 477)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 14)
                                    (pos_bol 440) (pos_cnum 494)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ())))
                              (Nolabel
                               ((pexp_desc
                                 (Pexp_construct
                                  ((txt (Lident "()"))
                                   (loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 14)
                                       (pos_bol 440) (pos_cnum 496)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 14)
                                       (pos_bol 440) (pos_cnum 498)))
                                     (loc_ghost false))))
                                  ()))
                                (pexp_loc
                                 ((loc_start
                                   ((pos_fname output.ml) (pos_lnum 14)
                                    (pos_bol 440) (pos_cnum 496)))
                                  (loc_end
                                   ((pos_fname output.ml) (pos_lnum 14)
                                    (pos_bol 440) (pos_cnum 498)))
                                  (loc_ghost false)))
                                (pexp_loc_stack ()) (pexp_attributes ()))))))
                           (pexp_loc
                            ((loc_start
                              ((pos_fname output.ml) (pos_lnum 14)
                               (pos_bol 440) (pos_cnum 446)))
                             (loc_end
                              ((pos_fname output.ml) (pos_lnum 14)
                               (pos_bol 440) (pos_cnum 507)))
                             (loc_ghost false)))
                           (pexp_loc_stack ()) (pexp_attributes ()))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 14) (pos_bol 440)
                          (pos_cnum 446)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 14) (pos_bol 440)
                          (pos_cnum 507)))
                        (loc_ghost false)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 409)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 14) (pos_bol 440)
                       (pos_cnum 507)))
                     (loc_ghost true)))
                   (pexp_loc_stack ())
                   (pexp_attributes
                    (((attr_name
                       ((txt warning)
                        (loc
                         ((loc_start
                           ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                            (pos_cnum 400)))
                          (loc_end
                           ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                            (pos_cnum 595)))
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
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 400)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                          (pos_cnum 595)))
                        (loc_ghost true))))))))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                     (pos_cnum 400)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                     (pos_cnum 595)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                 (pos_cnum 400)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                 (pos_cnum 595)))
               (loc_ghost false))))
            ((pstr_desc
              (Pstr_value Nonrecursive
               (((pvb_pat
                  ((ppat_desc
                    (Ppat_var
                     ((txt make)
                      (loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 404)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 408)))
                        (loc_ghost false))))))
                   (ppat_loc
                    ((loc_start
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 404)))
                     (loc_end
                      ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                       (pos_cnum 408)))
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
                               ((pos_fname output.ml) (pos_lnum 13)
                                (pos_bol 396) (pos_cnum 400)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 15)
                                (pos_bol 526) (pos_cnum 595)))
                              (loc_ghost true))))))
                         (ppat_loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                             (pos_cnum 400)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                             (pos_cnum 595)))
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
                                     ((pos_fname output.ml) (pos_lnum 13)
                                      (pos_bol 396) (pos_cnum 400)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 15)
                                      (pos_bol 526) (pos_cnum 595)))
                                    (loc_ghost true))))))
                               (ppat_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 13)
                                   (pos_bol 396) (pos_cnum 400)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 15)
                                   (pos_bol 526) (pos_cnum 595)))
                                 (loc_ghost true)))
                               (ppat_loc_stack ()) (ppat_attributes ()))
                              ((ptyp_desc
                                (Ptyp_constr
                                 ((txt (Ldot (Lident Js) t))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 13)
                                      (pos_bol 396) (pos_cnum 400)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 15)
                                      (pos_bol 526) (pos_cnum 595)))
                                    (loc_ghost true))))
                                 (((ptyp_desc
                                    (Ptyp_object
                                     (((pof_desc
                                        (Otag
                                         ((txt children)
                                          (loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 13) (pos_bol 396)
                                              (pos_cnum 400)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 15) (pos_bol 526)
                                              (pos_cnum 595)))
                                            (loc_ghost true))))
                                         ((ptyp_desc (Ptyp_var children))
                                          (ptyp_loc
                                           ((loc_start
                                             ((pos_fname output.ml)
                                              (pos_lnum 13) (pos_bol 396)
                                              (pos_cnum 419)))
                                            (loc_end
                                             ((pos_fname output.ml)
                                              (pos_lnum 13) (pos_bol 396)
                                              (pos_cnum 436)))
                                            (loc_ghost false)))
                                          (ptyp_loc_stack ())
                                          (ptyp_attributes ()))))
                                       (pof_loc
                                        ((loc_start
                                          ((pos_fname output.ml) (pos_lnum 13)
                                           (pos_bol 396) (pos_cnum 400)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 15)
                                           (pos_bol 526) (pos_cnum 595)))
                                         (loc_ghost true)))
                                       (pof_attributes ())))
                                     Closed))
                                   (ptyp_loc
                                    ((loc_start
                                      ((pos_fname output.ml) (pos_lnum 13)
                                       (pos_bol 396) (pos_cnum 400)))
                                     (loc_end
                                      ((pos_fname output.ml) (pos_lnum 15)
                                       (pos_bol 526) (pos_cnum 595)))
                                     (loc_ghost true)))
                                   (ptyp_loc_stack ()) (ptyp_attributes ())))))
                               (ptyp_loc
                                ((loc_start
                                  ((pos_fname output.ml) (pos_lnum 13)
                                   (pos_bol 396) (pos_cnum 400)))
                                 (loc_end
                                  ((pos_fname output.ml) (pos_lnum 15)
                                   (pos_bol 526) (pos_cnum 595)))
                                 (loc_ghost true)))
                               (ptyp_loc_stack ()) (ptyp_attributes ()))))
                            (ppat_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 13)
                                (pos_bol 396) (pos_cnum 400)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 15)
                                (pos_bol 526) (pos_cnum 595)))
                              (loc_ghost true)))
                            (ppat_loc_stack ()) (ppat_attributes ()))
                           ((pexp_desc
                             (Pexp_apply
                              ((pexp_desc
                                (Pexp_ident
                                 ((txt (Lident make))
                                  (loc
                                   ((loc_start
                                     ((pos_fname output.ml) (pos_lnum 13)
                                      (pos_bol 396) (pos_cnum 400)))
                                    (loc_end
                                     ((pos_fname output.ml) (pos_lnum 15)
                                      (pos_bol 526) (pos_cnum 595)))
                                    (loc_ghost true))))))
                               (pexp_loc
                                ((loc_start
                                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                   (pos_cnum -1)))
                                 (loc_end
                                  ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                                   (pos_cnum -1)))
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
                                          ((pos_fname output.ml) (pos_lnum 13)
                                           (pos_bol 396) (pos_cnum 419)))
                                         (loc_end
                                          ((pos_fname output.ml) (pos_lnum 13)
                                           (pos_bol 396) (pos_cnum 436)))
                                         (loc_ghost false))))))
                                    (pexp_loc
                                     ((loc_start
                                       ((pos_fname output.ml) (pos_lnum 13)
                                        (pos_bol 396) (pos_cnum 419)))
                                      (loc_end
                                       ((pos_fname output.ml) (pos_lnum 13)
                                        (pos_bol 396) (pos_cnum 436)))
                                      (loc_ghost false)))
                                    (pexp_loc_stack ()) (pexp_attributes ()))
                                   ((Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident Props))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 13) (pos_bol 396)
                                             (pos_cnum 419)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 13) (pos_bol 396)
                                             (pos_cnum 436)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 419)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 436)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ())))
                                    (Nolabel
                                     ((pexp_desc
                                       (Pexp_ident
                                        ((txt (Lident children))
                                         (loc
                                          ((loc_start
                                            ((pos_fname output.ml)
                                             (pos_lnum 13) (pos_bol 396)
                                             (pos_cnum 419)))
                                           (loc_end
                                            ((pos_fname output.ml)
                                             (pos_lnum 13) (pos_bol 396)
                                             (pos_cnum 436)))
                                           (loc_ghost false))))))
                                      (pexp_loc
                                       ((loc_start
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 419)))
                                        (loc_end
                                         ((pos_fname output.ml) (pos_lnum 13)
                                          (pos_bol 396) (pos_cnum 436)))
                                        (loc_ghost false)))
                                      (pexp_loc_stack ()) (pexp_attributes ()))))))
                                 (pexp_loc
                                  ((loc_start
                                    ((pos_fname output.ml) (pos_lnum 13)
                                     (pos_bol 396) (pos_cnum 419)))
                                   (loc_end
                                    ((pos_fname output.ml) (pos_lnum 13)
                                     (pos_bol 396) (pos_cnum 436)))
                                   (loc_ghost false)))
                                 (pexp_loc_stack ()) (pexp_attributes ()))))))
                            (pexp_loc
                             ((loc_start
                               ((pos_fname output.ml) (pos_lnum 13)
                                (pos_bol 396) (pos_cnum 400)))
                              (loc_end
                               ((pos_fname output.ml) (pos_lnum 15)
                                (pos_bol 526) (pos_cnum 595)))
                              (loc_ghost true)))
                            (pexp_loc_stack ()) (pexp_attributes ()))))
                         (pexp_loc
                          ((loc_start
                            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_end
                            ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                             (pos_cnum -1)))
                           (loc_ghost true)))
                         (pexp_loc_stack ()) (pexp_attributes ())))
                       (pvb_attributes ())
                       (pvb_loc
                        ((loc_start
                          ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                           (pos_cnum 400)))
                         (loc_end
                          ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                           (pos_cnum 595)))
                         (loc_ghost true)))))
                     ((pexp_desc
                       (Pexp_ident
                        ((txt (Lident Output$Uppercase))
                         (loc
                          ((loc_start
                            ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                             (pos_cnum 400)))
                           (loc_end
                            ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                             (pos_cnum 595)))
                           (loc_ghost true))))))
                      (pexp_loc
                       ((loc_start
                         ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                          (pos_cnum 400)))
                        (loc_end
                         ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                          (pos_cnum 595)))
                        (loc_ghost true)))
                      (pexp_loc_stack ()) (pexp_attributes ()))))
                   (pexp_loc
                    ((loc_start
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_end
                      ((pos_fname _none_) (pos_lnum 0) (pos_bol 0)
                       (pos_cnum -1)))
                     (loc_ghost true)))
                   (pexp_loc_stack ()) (pexp_attributes ())))
                 (pvb_attributes ())
                 (pvb_loc
                  ((loc_start
                    ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                     (pos_cnum 400)))
                   (loc_end
                    ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                     (pos_cnum 595)))
                   (loc_ghost false)))))))
             (pstr_loc
              ((loc_start
                ((pos_fname output.ml) (pos_lnum 13) (pos_bol 396)
                 (pos_cnum 400)))
               (loc_end
                ((pos_fname output.ml) (pos_lnum 15) (pos_bol 526)
                 (pos_cnum 595)))
               (loc_ghost true)))))))
         (pmod_loc
          ((loc_start
            ((pos_fname output.ml) (pos_lnum 12) (pos_bol 387) (pos_cnum 389)))
           (loc_end
            ((pos_fname output.ml) (pos_lnum 16) (pos_bol 596) (pos_cnum 601)))
           (loc_ghost false)))
         (pmod_attributes ())))
       (pmb_attributes ())
       (pmb_loc
        ((loc_start
          ((pos_fname output.ml) (pos_lnum 11) (pos_bol 368) (pos_cnum 368)))
         (loc_end
          ((pos_fname output.ml) (pos_lnum 16) (pos_bol 596) (pos_cnum 601)))
         (loc_ghost false))))))
    (pstr_loc
     ((loc_start
       ((pos_fname output.ml) (pos_lnum 11) (pos_bol 368) (pos_cnum 368)))
      (loc_end
       ((pos_fname output.ml) (pos_lnum 16) (pos_bol 596) (pos_cnum 601)))
      (loc_ghost false)))))
