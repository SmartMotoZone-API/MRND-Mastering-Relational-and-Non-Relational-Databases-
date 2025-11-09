CREATE OR REPLACE FUNCTION fn_to_json(p_cols SYS.ODCIVARCHAR2LIST, p_vals SYS.ODCIVARCHAR2LIST)
RETURN CLOB IS
  l_json CLOB := '{';
BEGIN
  IF p_cols.COUNT != p_vals.COUNT THEN
    RAISE_APPLICATION_ERROR(-20001,'Listas de colunas e valores divergentes');
  END IF;
  FOR i IN 1..p_cols.COUNT LOOP
    IF i>1 THEN l_json:=l_json||','; END IF;
    l_json := l_json||'"'||p_cols(i)||'":"'||p_vals(i)||'"';
  END LOOP;
  RETURN l_json||'}';
END;
/

-- FUNÇÃO 2 - Validação de senha
CREATE OR REPLACE FUNCTION fn_valida_senha(p_senha VARCHAR2) RETURN NUMBER IS
BEGIN
  IF p_senha IS NULL THEN RAISE_APPLICATION_ERROR(-20010,'Senha nula'); END IF;
  IF LENGTH(p_senha)<8 THEN RAISE_APPLICATION_ERROR(-20011,'Senha curta'); END IF;
  IF NOT REGEXP_LIKE(p_senha,'[A-Z]') OR NOT REGEXP_LIKE(p_senha,'[a-z]') OR NOT REGEXP_LIKE(p_senha,'[0-9]')
  THEN RAISE_APPLICATION_ERROR(-20012,'Senha fraca'); END IF;
  RETURN 1;
END;
/
