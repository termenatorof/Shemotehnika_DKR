module ALB ( 
    input [3:0] R,        
    input [3:0] S,        
    input CI,             
    input [2:0] H,       
    input [1:0] I,        
    output reg [3:0] Y,        
    output reg [3:0] Y_norm,   
    output reg CO,             
    output reg VO,             
    output reg NO,             
    output reg ZO              
); 
 
    // Попередній розрахунок усіх можливих результатів (паралельне виконання) 
    wire [4:0] add_res = R + S + CI;                
    wire [4:0] sub_res = R - S - 1 + CI;            
    wire [3:0] and_res = R & S;                     
    wire [3:0] or_res  = R | S;                     
 
    always @(*) begin 
        // Перевірка коду варіанта (h2=0, h3=1, h1=1) 
        if (H == 3'b011) begin 
            case (I) 
                2'b00: begin // Віднімання: R - S - 1 + CI 
                    Y = sub_res[3:0]; 
                    CO = sub_res[4]; 
                    VO = (R[3] != S[3]) && (Y[3] != R[3]);  
                end 
                2'b01: begin  
                    Y = and_res; 
                    CO = 0; 
                    VO = 0; 
                end 
                2'b10: begin  
                    Y = add_res[3:0]; 
                    CO = add_res[4]; 
                    VO = (R[3] == S[3]) && (Y[3] != R[3]);  
                end 
                2'b11: begin  
                    Y = or_res; 
                    CO = 0; 
                    VO = 0; 
                end 
                default: begin 
                    Y = 4'b0000; 
                    CO = 0; 
                    VO = 0; 
                end 
            endcase 
        end else begin 
             
            Y = 4'b0000; 
            CO = 0; 
            VO = 0; 
        end 
 
         
        NO = Y[3];                
        ZO = (Y == 4'b0000);      
 
         
        if (Y[3] != Y[2]) 
            Y_norm = {1'b0, Y[3:1]}; 
        else 
            Y_norm = Y; 
    end 
endmodule
