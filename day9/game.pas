program MarbleGame; 

const
    size : longint = 7158801;
    playerc: longint = 430;
type
  Circles = array[0..7158801] of longint;

function insertval(value: longint; position: longint; var arr: Array of longint): Circles;

    var 
        newarray: Circles;
        i: longint;

    begin 

        for i := 0 to position do
        begin
            newarray[i] := arr[i]; 
        end;

        newarray[position] := value; 

        for i := position+1 to size do
        begin
            newarray[i] := arr[i-1]
        end; 

        { Last value of arr is lost }
        insertval := newarray;
end; 

function remove23(arr: Array of longint; remove: longint): Circles;
    var
        newarray: Circles;
        i: longint;

    begin

        for i := 0 to remove do
        begin
            newarray[i] := arr[i]; 
        end; 

        for i := remove+1 to size do
        begin
            newarray[i-1] := arr[i]; 
        end; 

        remove23 := newarray; 
    end; 

var
    i: longint; {current marble number}
    j: longint; {print loop index}
    x: longint; {position for next marble}
    curr: longint; {last marble}
    cc: longint; {current circle size}
    circle: Circles; 

    player: longint; {current player number}
    scores: array of longint;

    remove: longint; 
begin

    setLength(scores,playerc);

    curr := 0;
    cc := 1;
    x := 0; 
    player := -1;

    for i := 1 to size do
    begin
        player := (player + 1) mod playerc;

        if ((i mod 23) = 0) then 
        begin
            if (curr - 7 < 0) then
                remove := cc + curr - 7
            else
                remove := curr - 7;

            scores[player] := circle[remove] + i + scores[player];
            circle := remove23(circle, remove);
            cc := cc - 1;
            curr := remove;
        end
        else
        begin

            {get next pos to set}
            x := (curr+2); 
            if x > cc then
                x := x - cc;

            circle := insertval(i,x,circle); 
            cc := cc + 1;
            curr := x;
        end;
    end;
            for j := 0 to playerc-1 do
            begin 
                write(j+1);
                write(':'); 
                write(scores[j]);
                writeLn(' '); 
            end;
            writeLn(''); 
end.
