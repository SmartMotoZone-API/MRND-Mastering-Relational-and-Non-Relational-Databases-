-- Ativa a sa�da no console
SET SERVEROUTPUT ON;

-- Bloco an�nimo: mostra valor atual, anterior e pr�ximo da coluna 'modelo' da tabela 'motos'
DECLARE
    CURSOR c_motos_contexto IS
        SELECT 
            NVL(LAG(modelo) OVER (ORDER BY id), 'Vazio') AS modelo_anterior,
            modelo,
            NVL(LEAD(modelo) OVER (ORDER BY id), 'Vazio') AS modelo_proximo
        FROM motos;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Modelo Anterior     | Modelo Atual   | Modelo Pr�ximo   ');
    DBMS_OUTPUT.PUT_LINE('---------------------|----------------|-------------------');

    FOR r IN c_motos_contexto LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(r.modelo_anterior, 21) || ' | ' ||
            RPAD(r.modelo, 16)          || ' | ' ||
            RPAD(r.modelo_proximo, 18)
        );
    END LOOP;
END;
/
