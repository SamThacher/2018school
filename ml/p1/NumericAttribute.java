
public class NumericAttribute extends Attribute
{
	
	// Constructor
	public NumericAttribute()
	{
		super();
	}

	public NumericAttribute(java.lang.String name)
	{
		super();
		this.name = name;
	}

	public java.lang.String toString()
	{
		return "@numericAttribute " + this.name;
	}
	public boolean validValue(java.lang.Double value)
	{
		return true;
		// FIX
	}
	public static void main(java.lang.String[] args)
	{

	}
	
}