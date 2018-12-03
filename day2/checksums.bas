Function count(s As String, n As Integer) As Integer
    Dim letters(26) as Integer
    Dim i As Integer = 0 
    
    For i = 0 to len(s)
        letters(Asc(s,i)-97) += 1
    Next 

    For i = 0 TO 26 
        If letters(i) = n Then
            Return 1
        End If
    Next

    Return 0

End Function 

Open "input.txt" for Input As #1
Dim line_ As String
Dim c2 as Integer
Dim c3 as Integer

c2 = 0
c3 = 0

While Not Eof(1)
  Line Input #1, line_
  c2 += count(line_,2)
  c3 += count(line_,3)
Wend


print c2 * c3

Close #1
