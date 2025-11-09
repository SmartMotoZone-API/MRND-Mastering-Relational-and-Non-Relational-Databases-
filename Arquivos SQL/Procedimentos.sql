-- PROCEDIMENTO 1 - JOIN e JSON
CREATE OR REPLACE PROCEDURE prc_listar_os_json IS
BEGIN
  FOR r IN (
    SELECT c.id cliente_id,c.nome,m.placa,m.modelo,o.id os_id,o.descricao,o.valor
    FROM tb_cliente c JOIN tb_moto m ON c.id=m.cliente_id JOIN tb_ordem_servico o ON o.moto_id=m.id
  )
  LOOP
    DBMS_OUTPUT.PUT_LINE(
      fn_to_json(SYS.ODCIVARCHAR2LIST('cliente_id','nome','placa','modelo','os_id','descricao','valor'),
                 SYS.ODCIVARCHAR2LIST(r.cliente_id,r.nome,r.placa,r.modelo,r.os_id,r.descricao,r.valor))
    );
  END LOOP;
END;
/

-- PROCEDIMENTO 2 - Soma manual com subtotais e total geral
CREATE OR REPLACE PROCEDURE prc_soma_ag_conta IS
  l_ag_atual NUMBER := NULL; l_subtotal NUMBER := 0; l_total NUMBER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Agencia Conta Saldo');
  FOR r IN (SELECT * FROM fact_saldos ORDER BY agencia, conta) LOOP
    IF l_ag_atual IS NOT NULL AND r.agencia<>l_ag_atual THEN
      DBMS_OUTPUT.PUT_LINE('Sub Total: '||l_subtotal); l_subtotal:=0;
    END IF;
    DBMS_OUTPUT.PUT_LINE(r.agencia||' '||r.conta||' '||r.saldo);
    l_subtotal:=l_subtotal+r.saldo; l_total:=l_total+r.saldo; l_ag_atual:=r.agencia;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Sub Total: '||l_subtotal);
  DBMS_OUTPUT.PUT_LINE('Total Geral: '||l_total);
END;
/
