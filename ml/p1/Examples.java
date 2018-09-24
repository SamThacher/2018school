
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
			scanner.nextLine();
		}
		scanner.next();
		while(scanner.hasNext())
		{
			Example e = new Example();
			for(int i = 0; i < attributes.size(); i++)
			{	
				java.lang.String token = scanner.next();
				if(attributes.get(i) instanceof NumericAttribute)
				{
					e.add(Double.parseDouble(token));
				}
				else
				{
					e.add((double)((NominalAttribute)attributes.get(i)).getIndex(token));
				}
			}
			this.add(e);
			try
			{
				scanner.nextLine();
			}
			catch(java.util.NoSuchElementException ex)
			{
			}
		}
	}

	public java.lang.String toString()
	{
		java.lang.String s = "";
		s += "@examples\n";
		for(int j = 0; j < this.size(); j++)
		{
			for(int i = 0; i < attributes.size(); i++)
			{
				if(attributes.get(i) instanceof NumericAttribute)
				{
					s += Double.toString(this.get(j).get(i)) + " ";
				}
				else
				{
					s += ((NominalAttribute)attributes.get(i)).getValue(this.get(j).get(i).intValue()) + " ";
				}
			}
			s += "\n";
		}
		return s;
	}
	
}