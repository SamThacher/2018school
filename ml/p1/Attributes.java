
public class Attributes
{
	
	private java.util.ArrayList<Attribute> attributes;
	private int classIndex;
	private boolean hasNumericAttributes;

	public Attributes()
	{
		attributes = new java.util.ArrayList<Attribute>();
		hasNumericAttributes = false;
	}

	public void add(Attribute attribute)
	{
		if(!hasNumericAttributes && attribute instanceof NumericAttribute)
		{
			hasNumericAttributes = true;
		}
		attributes.add(attribute);
	}

	public int getClassIndex()
	{
		return attributes.size()-1;
	}
	
	public boolean getHasNumericAttributes()
	{
		return hasNumericAttributes;
	}

	public Attribute get(int i)
	{
		return attributes.get(i);
	}

	public Attribute getClassAttribute()
	{
		return attributes.get(attributes.size()-1);
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
			scanner.nextLine();
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
		StringBuilder s = new StringBuilder();
		for(int i = 0; i < attributes.size(); i++)
		{
			s.append(attributes.get(i).toString() + "\n");
		}
		return s.toString();
	}

	public static void main(java.lang.String[] args)
	{
		
	}
}