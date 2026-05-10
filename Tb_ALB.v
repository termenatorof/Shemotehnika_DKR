`timescale 1ns / 1ps 
 
module tb_ALB; 
    // Вхідні сигнали 
    reg [3:0] R, S; 
    reg CI; 
    reg [2:0] H; 
    reg [1:0] I; 
 
    // Вихідні сигнали 
    wire [3:0] Y, Y_norm; 
    wire CO, VO, NO, ZO; 
 
    // Створення екземпляра модуля 
    ALB uut ( 
        .R(R), .S(S), .CI(CI), .H(H), .I(I), 
        .Y(Y), .Y_norm(Y_norm), 
        .CO(CO), .VO(VO), .NO(NO), .ZO(ZO) 
    ); 
 
    initial begin 
        $display("=== Тестування АЛБ (Варіант 4613, H=011) ==="); 
         
        // Встановлюємо правильний код варіанта 
        H = 3'b011;  
        CI = 1; 
 
        // Тест 1: SUB (I=00) -> 8 - 4 - 1 + 1 = 4 
        R = 4'b1000; S = 4'b0100; I = 2'b00; #10; 
        $display("[00] SUB | R=%b S=%b | Y=%b Y_norm=%b | VO=%b", R, S, Y, Y_norm, 
VO); 
 
        // Тест 2: AND (I=01) -> 1101 & 0111 = 0101 
        R = 4'b1101; S = 4'b0111; I = 2'b01; #10; 
        $display("[01] AND | R=%b S=%b | Y=%b Y_norm=%b", R, S, Y, Y_norm); 
 
        // Тест 3: ADD (I=10) -> 5 + 3 + 1 = 9 (1001) - тут має бути нормалізація 
        R = 4'b0101; S = 4'b0011; I = 2'b10; #10; 
        $display("[10] ADD | R=%b S=%b | Y=%b Y_norm=%b | VO=%b", R, S, Y, Y_norm, 
VO); 
 
        // Тест 4: OR (I=11) -> 0101 | 1000 = 1101 
R = 4'b0101; S = 4'b1000; I = 2'b11; #10; 
$display("[11] OR  | R=%b S=%b | Y=%b Y_norm=%b", R, S, Y, Y_norm); 
$display("=== Тестування завершено ==="); 
$stop; 
end 
endmodule
