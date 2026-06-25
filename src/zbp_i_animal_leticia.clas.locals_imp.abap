CLASS lhc_Animais DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.

  CLASS-DATA t_zanimal_leticia TYPE STANDARD TABLE OF ztanimal_leticia.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Animais RESULT result.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Animais.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Animais.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Animais.

    METHODS read FOR READ
      IMPORTING keys FOR READ Animais RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK Animais.

ENDCLASS.

CLASS lhc_Animais IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD create.

    IF entities IS NOT INITIAL.

        SELECT SINGLE MAX( id )
          FROM ztanimal_leticia
          INTO @DATA(lv_max_id).

         LOOP AT entities INTO DATA(ls_entity).

            IF ls_entity-%data-sexo <> 'M'
              AND ls_entity-%data-sexo <> 'F'.

                APPEND VALUE #(
                %cid = ls_entity-%cid
                ) TO failed-animais.

                APPEND VALUE #(
                %cid = ls_entity-%cid
                %msg = new_message_with_text(
                severity = if_abap_behv_message=>severity-error
                text     = 'Inválido. Utilize M (Masculino) ou F (Feminino).'
               )
               ) TO reported-animais.
               CONTINUE.

            ENDIF.

               lv_max_id += 1.
               ls_entity-%data-id = lv_max_id.
               INSERT CORRESPONDING #( ls_entity-%data )
               INTO TABLE t_zanimal_leticia.

         ENDLOOP.

    ENDIF.

  ENDMETHOD.

  METHOD update.

    LOOP AT entities INTO DATA(ls_entity).
      DATA(ls_animal) =
        CORRESPONDING ztanimal_leticia( ls_entity-%data ).
      MODIFY ztanimal_leticia FROM @ls_animal.
    ENDLOOP.

  ENDMETHOD.

  METHOD delete.

     LOOP AT keys INTO DATA(ls_key).
        DELETE FROM ztanimal_leticia
        WHERE id = @ls_key-id.
     ENDLOOP.

  ENDMETHOD.

  METHOD read.

    SELECT *
    FROM ztanimal_leticia
    FOR ALL ENTRIES IN @keys
    WHERE id EQ @keys-id
    INTO CORRESPONDING FIELDS OF TABLE @result.

  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_ANIMAL_LETICIA DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_ANIMAL_LETICIA IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.

    INSERT ztanimal_leticia
    FROM TABLE @lhc_animais=>t_zanimal_leticia.

  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
