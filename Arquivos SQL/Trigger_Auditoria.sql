-- TRIGGER DE AUDITORIA
CREATE OR REPLACE TRIGGER trg_aud_ordem_servico
AFTER INSERT OR UPDATE OR DELETE ON tb_ordem_servico
FOR EACH ROW
DECLARE l_old CLOB; l_new CLOB;
BEGIN
  IF UPDATING OR DELETING THEN
    l_old := '{"id":"'||:OLD.id||'","descricao":"'||:OLD.descricao||'"}';
  END IF;
  IF INSERTING OR UPDATING THEN
    l_new := '{"id":"'||:NEW.id||'","descricao":"'||:NEW.descricao||'"}';
  END IF;
  INSERT INTO auditoria_operacoes(tabela,usuario_bd,operacao,data_hora,valores_old,valores_new)
  VALUES('TB_ORDEM_SERVICO',USER,
         CASE WHEN INSERTING THEN 'INSERT' WHEN UPDATING THEN 'UPDATE' WHEN DELETING THEN 'DELETE' END,
         SYSTIMESTAMP,l_old,l_new);
END;
/
