
public class NominalAttribute extends Attribute
{
	
	// Constructor
	java.util.ArrayList<java.lang.String> domain;

	public NominalAttribute()
	{
		super();
		domain = new java.util.ArrayList<java.lang.String>();
	}

	public NominalAttribute(java.lang.String name)
	{
		super(name);
		this.domain = new java.util.ArrayList<java.lang.String>();
	}

	public void addValue(java.lang.String value)
	{
		this.domain.add(value);
	}

	public int getIndex(java.lang.String value) throws java.lang.Exception
	{
		for(int i = 0; i < this.domain.size(); i++)
		{
			if(this.domain.get(i).contains(value))
			{
				return i;
			}
		}
		throw new java.lang.Exception("value not found.");
	}

	public java.lang.String getValue(int index)
	{
		return this.domain.get(index);
	}

	public int size()
	{
		return this.domain.size();
	}

	public java.lang.String toString()
	{
		StringBuilder tester = new StringBuilder();
		tester.append(super.toString());
		for(int i = 0; i < this.domain.size(); i++)
		{
			tester.append(" " + this.domain.get(i));
		}
		return tester.toString();
	}

	public boolean validValue(java.lang.String value)
	{
		return true;
	}

	public static void main(java.lang.String[] args)
	{
		
	}
	
}