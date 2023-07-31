M = LOAD '$M' using PigStorage(',') as (i:int,j:int,value:double);
N = LOAD '$N' using PigStorage(',') as (j:int,k:int,value:double);

--describe M;
--dump M;
--describe N;
--dump N;

joinMN = JOIN M by j, N by j;

multiplyMN = FOREACH joinMN GENERATE $0 as i, $4 as j, ($2*$5) as value;
--describe multiplyMN;
--dump multiplyMN;

generateIJ = GROUP multiplyMN by (i,j);
--describe generateIJ;
--dump generate IJ;

resultantMatrix = foreach generateIJ generate $0.$0 as i, $0.$1 as j, SUM($1.$2) as value;
--describe resultantMatrix;
--dump resultantMatrix;

sortedOrderResult = ORDER resultantMatrix BY i , j ;

store sortedOrderResult into '$O';