-- PL/SQL para gerar os relatórios com JOIN, GROUP BY e ORDER BY
SET SERVEROUTPUT ON;

-- Bloco anônimo com consultas usando JOIN, GROUP BY e ORDER BY
DECLARE
    CURSOR c_motos_por_zona IS
        SELECT z.id AS zona, COUNT(m.id) AS total_motos
        FROM zonas z
        LEFT JOIN motos m ON m.zona_atual_id = z.id
        GROUP BY z.id
        ORDER BY total_motos DESC;

    CURSOR c_motos_por_responsavel IS
        SELECT f.nome, COUNT(m.id) AS total_motos
        FROM funcionarios f
        LEFT JOIN motos m ON m.responsavel_id = f.id
        GROUP BY f.nome
        ORDER BY total_motos DESC;

    CURSOR c_movimentacoes_por_usuario IS
        SELECT u.nome, COUNT(mv.id) AS total_movimentacoes
        FROM usuarios1 u
        LEFT JOIN movimentacoes mv ON mv.usuario_id = u.id
        GROUP BY u.nome
        ORDER BY total_movimentacoes DESC;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Motos por Zona ---');
    FOR r IN c_motos_por_zona LOOP
        DBMS_OUTPUT.PUT_LINE('Zona: ' || r.zona || ' - Total Motos: ' || r.total_motos);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Motos por Responsável ---');
    FOR r IN c_motos_por_responsavel LOOP
        DBMS_OUTPUT.PUT_LINE('Funcionário: ' || r.nome || ' - Total Motos: ' || r.total_motos);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('--- Movimentações por Usuário ---');
    FOR r IN c_movimentacoes_por_usuario LOOP
        DBMS_OUTPUT.PUT_LINE('Usuário: ' || r.nome || ' - Total Movimentações: ' || r.total_movimentacoes);
    END LOOP;
END;
/