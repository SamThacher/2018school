
public class AttributeFactory 
{
	
	// Constructor
	public AttributeFactory()
	{
		
	}

	public static Attribute make(java.util.Scanner scanner) throws java.lang.Exception
	{
		scanner.next();
		java.lang.String temp = scanner.next();
		if(scanner.hasNext("numeric"))
		{
			NumericAttribute num = new NumericAttribute(temp);
			scanner.nextLine();
			return num;
		}
		else
		{	
			NominalAttribute nom = new NominalAttribute(temp);
			boolean flag = false;
			while(!flag)
			{
				nom.addValue(scanner.next());
				if(scanner.hasNext("@attribute") || scanner.hasNext("@examples"))
				{
					flag = true;
				}
			}
			return nom;
		}
	}
	
}