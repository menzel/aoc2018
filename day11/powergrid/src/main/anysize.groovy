package main

class anysize {
    static final size = 300
    static final serial = 6303

    static void main (String[] args) {
        List<List<Integer>> grid = new ArrayList<>()
        0.upto(300){ grid.add(new ArrayList<Integer>())}

        fillgrid(grid)
        findmax(grid)
    }

    static void findmax(ArrayList<List<Integer>> grid) {
        int max = 0
        Tuple3<Integer, Integer, Integer> pos = new Tuple3(0,0,0)

        1.upto(50) {
            for (int i = 0; i < size - it; i++) {
                for (int j = 0; j < size - it; j++) {
                    int sum = 0

                    for(int a = i; a < i+it; a++)
                        for(int b = j; b < j+it; b++)
                            sum += grid[a][b]

                    if (sum > max) {
                        max = sum
                        pos = new Tuple3(i, j, it)
                    }
                }
            }
        }

        print(pos)
    }

    static void fillgrid(List<List<Integer>> grid) {

        for(int i = 0 ; i < size; i++){
            for(int j = 0 ; j< size; j++){

                int powerlevel = ((i+10)* j + serial) * (i+10)
                String num = powerlevel.toString()

                grid[i][j] = Integer.parseInt(num[num.length() - 3]) - 5
            }
        }
    }
}
