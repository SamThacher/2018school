
public class Attributes
{
	
	private java.util.ArrayList<Attribute> attributes;
	private int classIndex;
	private boolean hasNumericAttributes;

	public Attributes()
	{
		attributes = new java.util.ArrayList<Attribute>();
	}

	public void add(Attribute attribute)
	{
		attributes.add(attribute);
	}

	public int getClassIndex()
	{
		return attributes.size()-1;
	}
	
	public boolean getHasNumericAttributes()
	{
		return false;
		//FIX
	}

	public Attribute get(int i)
	{
		return attributes.get(i);
	}

	public Attribute getClassAttribute()
	{
		return attributes.get(0);

		//FIX
	}

	public int getIndex(java.lang.String name) throws java.lang.Exception
	{
		for(int i = 0; i < attributes.size(); i++)
		{
			if(attributes.get(i).getName() == name)
			{
				return i;
			}
		}
		throw new java.lang.Exception("name not in array");
	}

	public int size()
	{
		return attributes.size();
	}

	public void parse(java.util.Scanner scanner) throws java.lang.Exception
	{
		AttributeFactory factory = new AttributeFactory();
		while(!scanner.hasNext("@attribute"))
		{
			System.out.println(scanner.nextLine());
		}
		while(true)
		{
			if(!scanner.hasNext("@attribute"))
			{
				break;
			}
			else
			{
				this.add(factory.make(scanner));
			}
		}
	}

	public void setClassIndex(int classIndex) throws java.lang.Exception
	{
		this.classIndex = classIndex;
	}

	public java.lang.String toString()
	{
		return "@attributes";
	}

	public static void main(java.lang.String[] args)
	{
		try 
		{
			Attributes a = new Attributes();
			java.nio.file.Path filePath = java.nio.file.Paths.get("bikes.mff");
			java.util.Scanner sc = new java.util.Scanner(filePath);
			a.parse(sc);
		}
		catch(java.lang.Exception e) {
  			e.printStackTrace();
		}
	}
}