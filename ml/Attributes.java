
public class Attributes 
{
	
	private java.util.ArrayList<Attribute> attributes;
	private int classIndex;
	private boolean hasNumericAttributes;

	public Attributes()
	{
		
	}

	public void add(Attribute attribute)
	{
		attributes.add(attribute);
	}

	public int getClassIndex()
	{
		return classIndex;
	}
	
	public boolean getHasNumericAttributes()
	{

	}

	public Attribute get(int i)
	{
		return attributes[i];
	}

	public Attribute getClassAttribute()
	{

	}

	public int getIndex(java.lang.String name) throws java.lang.Exception
	{
		for(int i = 0; i < attributes.size(); i++)
		{
			if(attributes[i].getName() == name)
			{
				return i;
			}
		}
		throw java.lang.Exception;
	}

	public int size()
	{
		return attributes.size();
	}

	public void parse(java.util.Scanner scanner) throws java.lang.Exception
	{

	}

	public void setClassIndex(int classIndex) throws java.lang.Exceptionpublic void s
	{
		classIndex = classIndex;
	}

	public java.lang.String toString()
	{

	}

	public static void main(java.lang.String[] args)
	{
		Scanner sc = new Scanner(new File("bikes.mff"));
		parse(sc);
	}
}