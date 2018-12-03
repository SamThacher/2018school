
public class DistKey implements Comparable<DistKey> 
{	
	// Constructor
	protected double distance;
	protected int index;
	public DistKey(double distance, int index)
	{
		this.distance = distance;
		this.index = index;
	}
	public double getKey()
	{
		return distance;
	}
	public int getValue()
	{
		return index;
	}
	@Override
    public int compareTo(DistKey rhsObj) 
    {
        return Double.compare(this.getKey(),rhsObj.getKey());
    }
	
}