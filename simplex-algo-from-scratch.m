% %defining the A matrix
   A =[ 1	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0
   	 0	0	0	0	0	0	1	1	1	0	1	0	0	0	0	0	0	0
   	 0	0	0	1	1	1	0	0	0	0	0	1	0	0	0	0	0	0
   	 1	0	0	1	0	0	1	0	0	0	0	0	1	0	0	0	0	0
   	 0	1	0	0	1	0	0	1	0	0	0	0	0	1	0	0	0	0
   	 0	0	1	0	0	1	0	0	1	0	0	0	0	0	1	0	0	0
   	 9	0	0	21	0	0	17	0	0	0	0	0	0	0	0	1	0	0
   	 0	9	0	0	21	0	0	17	0	0	0	0	0	0	0	0	1	0
   	 0	0	9	0	0	21	0	0	17	0	0	0	0	0	0	0	0	1];
 	 
% % % %defining vector for b values	 
   B = [340; 900 ; 700 ; 550 ; 750  ; 275 ; 10000; 7000 ; 4200;];
% % % %defining C matrix, since the Maximisation prob has been coverte in
% to a minimization problem,C has been defined the way it will appear in 
% the Tableau 
   C = [9;9;9;12;12;12;10;10;10;0;0;0;0;0;0;0;0;0;];
% % % %Reducing the redundant constraints, checking what is the rank and
% then reducing the reduntant columns
   X = A';
   [R,basiccol] = rref(X);
    X= X(:,basiccol)';
    Anew = X;
    %There are no redundant constraints in our problem
    
% % % Checking for initial basis, from our A matrix we will try to see what
% the last columns look like, if they are an identity matrix we will say
% yes we have an initial basis

    if Anew(:,10:18) == eye(9,9)
        disp('Initial identity is present')
    else
        disp('Two phase method will be needed')
    end
    
 
% % %  %Getting dimensions of the A matrix
    [m,n] = size(Anew);
% % % Now we will get rank of [A] and [A b] matrices to compare later for
% feasibility
    rank_Anew = rank(Anew);
    rank_B = rank([Anew B]);
% % %  %since C is defined as a vector , we transpose to fit into the 
% % %  %first tableau, since the zeroth row of the tableau is C
    Crow = C' ;
% % %  
% % %  %This tableau doesnt have the RHS part
    IniTab = [C';Anew;];
% % %  %defining the RHS
    RHS = [0;B;];
% % %  
% % %  %defining the final initial tableau
    IniTab = [IniTab RHS];
%  
 %Now we have the initial tableau and need to perform the
 %row operations to get the pivot row and then proceed with
 %further iterations of the tableau to get the optimal value
 %But before that we must check the feasibility, if the LP is 
 %feasible we will go ahead and solve it otherwise we will break out of the
 %program
 if rank_Anew == rank_B
     
     disp('The problem is feasible');
     while sum(IniTab(1,1:18)>0)>0
     %Finding the max value in the top row
     
         [MaxTop,MaxIndex] = max(IniTab(1,1:18));

         %SInce the max value returns the first max value it comes
         %across, Bland's rule is automatically applied
         RatioTab= ones(1,9);
         %Now we fill divide b/y to get which row to pivot
         for i = 2:1:10
             RatioTab(1,i-1) = IniTab(i,19)/IniTab(i,MaxIndex);
             if isfinite(RatioTab(1,i-1))==0
                 RatioTab(1,i-1)=0;
             end


        end

         %Checking for unboundedness, based on this we will decide whether
         %to terminate the tableau or to continue further
         if sum(IniTab(2:10,MaxIndex)<=0) == 9
             unbdd =1;
             disp('Problem is unbounded');
             break;
         else
             unbdd = 0 ;
         end


         %Now we will find the minimum value in the ratio
         %to get the pivot variable
         TempRatioTab = RatioTab;
         TempRatioTab(TempRatioTab<=0)=NaN;


         [MinRat,MinRatIndex] = min(TempRatioTab);
         % Here as well the bland rule is automatically applied becuase in
         % Matlab, it chooses the minimum index value in case two values
         % are same
         %Now we know that we need to convert IniTab(MinRatIndex+1,MaxIndex)
          TempPivotRow = ones(1,19);

          TempValInitab = IniTab(MinRatIndex+1,MaxIndex) ;
          TempPivotRow(1,:) = IniTab(MinRatIndex+1,:);
          IniTab(MinRatIndex+1,:) = IniTab(MinRatIndex+1,:)./TempValInitab;

          for i = 1:1:10
              if (i == MinRatIndex+1) ||  IniTab(i,MaxIndex) ==0
                  continue
              else 
                  %IniTab(i,:) =
                  %IniTab(i,:)+((abs(IniTab(i,MaxIndex))/IniTab(i,MaxIndex))*IniTab(i,MaxIndex)/TempValInitab)*(TempPivotRow(1,:));
                  IniTab(i,:) = IniTab(i,:)+(-1*IniTab(i,MaxIndex)/TempValInitab)*(TempPivotRow(1,:));
              end
          end

     end  
     
     
 else
     disp('The problem  is infeasible')
 end
 
 
%Now the linear program is solved, all we need is the optimal
%objective value and the X solution
Final_X = zeros(9,1);
IniTab_subset = IniTab(1:10,1:9);

for i = 1:1:9
    if IniTab_subset(1,i) == 0
        for j = 2:1:10
            if IniTab_subset(j,i)==1
                Final_X(i,1)= IniTab(j,19);
            end
        end
    end
end

           


disp('The optimal X is:');
disp(Final_X);
fprintf('The objective value obtained is %d \n',IniTab(1,19));
        
 
 
 
 
 

