import java.io.*;


class prep {

    public static void main (String args[]){

	String currentline;
	int k=0;
	int g=0;

	try {
	    
	    BufferedReader br = new BufferedReader(new FileReader(args[0]));
	    BufferedWriter bw = new BufferedWriter(new FileWriter(args[1]));
	    bw.write("DATE\tTIME\tVOLUME\tOPEN\tCLOSE\tLOW\tHIGH\n");
	    
	    while ((currentline = br.readLine())!= null) { // while loop begins here
		
		if(currentline.contains("\t0\t") || currentline.contains("DATE"))
		    k++;
		else {
		    
		    bw.write(currentline);
		    bw.newLine();
		}
		
		g++;
		if (g==4730)
		    System.out.println("loool");    
		
	    } // end while 
	    
	   
	    bw.flush();
	    bw.close();
	    
	}
	
	catch (IOException e) {
	    System.err.println("Error: " + e);
	}
	
	


	
    }

    
}

