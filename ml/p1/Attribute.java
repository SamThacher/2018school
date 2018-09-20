
public class Attribute 
{
	
	// Constructor
	protected java.lang.String name;

	public Attribute()
	{
		name = "default";
	}

	public Attribute(java.lang.String name)
	{
		this.name = name;
	}

    public void setName(java.lang.String name)
    {
    	this.name = name;
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
    	return 0;
    }

    public static void main(java.lang.String[] args)
	{

    }
	
}