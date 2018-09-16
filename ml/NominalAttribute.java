
public class NominalAttribute extends Attribute
{
	
	// Constructor
	java.util.ArrayList<java.lang.String> domain;

	public NominalAttribute()
	{
		super();
	}

	public NominalAttribute(java.lang.String name)
	{
		super();
		name = name;
	}

	public void addValue(java.lang.String value)
	{
		domain.add(value);
	}

	public int getIndex(java.lang.String value) throws java.lang.Exception
	{
		for(int i = 0; i < domain.size(); i++)
		{
			if(domain[i] == value)
			{
				return i;
			}
		}
		throw java.lang.Exception;
	}

	public java.lang.string getValue(int index)
	{
		return domain[index];
	}

	public int size()
	{
		return domain.size();
	}

	public java.lang.String toString()
	{
		return "@nominalAttribute ";
	}

	public boolean validValue(java.lang.String value)
	{
		for(int i = 0; i < domain.size(); i++)
		{
			if(domain[i] == value)
			{
				return true;
			}
		}
		return false;
	}

	public static void main(java.lang.String[] args)
	{

	}
	
}