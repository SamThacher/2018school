
public class Attribute 
{
	
	// Constructor
	protected java.lang.String name;

	public Attribute()
	{
		name = "default";
	}

	public Attribute(java.lang.String n)
	{
		name = n;
	}

    public void setName(java.lang.String n)
    {
    	name = n;
    }

    public java.lang.String getName()
    {
    	return name;
    }

    public java.lang.String toString()
    {
    	return "@attribute " + name;
    }

    public int size()
    {

    }

    public static void main(java.lang.String[] args)
	{

    }
	
}