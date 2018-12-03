
public class NumericAttribute extends Attribute
{
	
	// Constructor
	public NumericAttribute()
	{
		super();
	}

	public NumericAttribute(java.lang.String name)
	{
		super(name);
	}

	public java.lang.String toString()
	{
		StringBuilder s = new StringBuilder();
		s.append(super.toString());
		s.append(" numeric");
		return s.toString();
	}
	public boolean validValue(java.lang.Double value)
	{
		return true;
	}
	
}