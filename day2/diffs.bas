Function cmp(s As String, n As String) As Integer
    Dim diffc as Integer 
    Dim i as Integer 
    diffc = -1
    
    For i = 0 to len(s)
        If s[i] <> n[i] THEN
            If diffc > -1 THEN
                Return -1 
            Else
                diffc = i
            End If 
        End If
    Next 

    Return diffc

End Function 

Open "input.txt" for Input As #1
Dim line_ As String
Dim lines(250) as String
Dim i As Integer
Dim j As Integer
Dim r As Integer

i = 0 

While Not Eof(1)
  Line Input #1, line_
  lines(i) = line_
  i += 1
Wend

For i = 0 TO 249/2
    For j = 0 TO 249
        r = cmp(lines(i),lines(j))
        if r >= 0 THEN
            print left(lines(i),r)+ right(lines(i),25-r)
        End If
    Next
Next
    

Close #1
