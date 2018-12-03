/*
* CategoricalEstimator.java
* Copyright (c) 2018 Georgetown University.  All Rights Reserved.
*/

public class CategoricalEstimator extends Estimator
{

	protected java.util.ArrayList<Integer> dist;

	public CategoricalEstimator()
	{
		dist = new java.util.ArrayList<Integer>();
		// Collections.fill(0,dist);
	}
	public CategoricalEstimator( Integer k ) // number of categories
	{
		dist = new java.util.ArrayList<Integer>(k);
		// Collections.fill(0,dist);
	}
	public void add( Number x ) throws Exception
	{
		dist.add(x.intValue());
	}
	public Double getProbability( Number x )
	{
		return x.doubleValue()/dist.size();
	}

}
