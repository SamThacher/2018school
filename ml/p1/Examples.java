
public class Examples extends java.util.ArrayList<Example>
{
	
	private Attributes attributes;

	public Examples(Attributes attributes)
	{
		super();
		this.attributes = attributes;
	}

	public void parse(java.util.Scanner scanner) throws java.lang.Exception
	{
		while(!scanner.hasNext("@examples"))
		{
			System.out.println(scanner.nextLine());
		}
		while(scanner.hasNext())
		{
			Example e = new Example();
			int i = 0;
			System.out.println(i);
			while(i < attributes.size())
			{	
				if(attributes.get(i) instanceof NumericAttribute)
				{
					e.add(Double.parseDouble(scanner.next()));
				}
				else
				{
					e.add((double)((NominalAttribute)attributes.get(i)).getIndex(scanner.next()));
				}
				System.out.print(i++);
			}	
			for(int j = 0; j < e.size(); j++)
			{
				System.out.print(e.get(j) + " ");
			}	
			scanner.nextLine();
		}
	}

	public java.lang.String toString()
	{
		return "@examples";
	}
	
}