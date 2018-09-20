
public class p1
{

	public static void main(java.lang.String[] args)
	{
		if(args.length > 0)
		{
			if(args[0].contains("-t"))
			{
				try
				{
					java.lang.String fil = args[1];
					Attributes a = new Attributes();
					java.nio.file.Path filePath = java.nio.file.Paths.get(fil);
					java.util.Scanner sc = new java.util.Scanner(filePath);
					a.parse(sc);
					Examples e = new Examples(a);
					e.parse(sc);
				}
				catch(java.lang.ArrayIndexOutOfBoundsException e) {
  					System.out.println("Training file is required");
				}
				catch(java.lang.Exception e) {
  					e.printStackTrace();
				}
			} 
		}

	}
	
}