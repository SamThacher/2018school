/*
 * NaiveBayes.java
 * Copyright (c) 2018 Georgetown University.  All Rights Reserved.
 */
import java.io.*;

public class NaiveBayes extends Classifier implements Serializable, OptionHandler
{

	protected Attributes attributes;
	protected CategoricalEstimator classDistribution;
	protected java.util.ArrayList< java.util.ArrayList<Estimator> > classConditionalDistributions;

	public NaiveBayes()
	{
		classConditionalDistributions = new java.util.ArrayList<java.util.ArrayList<Estimator>>();
		for(int i = 0; i < attributes.size(); i++)
		{
			java.util.ArrayList<Estimator> a = new java.util.ArrayList<Estimator>();
			classConditionalDistributions.add(a);
		}
	}
	public NaiveBayes( String[] options ) throws Exception
	{
		setOptions(options);
	}
	public Performance classify( DataSet dataSet ) throws Exception
	{
		Performance p = new Performance(dataSet.attributes);
		return p;
		// FIX
	}
	public int classify( Example example ) throws Exception
	{
		return 0;
		// FIX

	}
	public Classifier clone()
	{
		return this;
		// FIX
	}
	public void setOptions( String[] options )
	{
		try
		{
			for(int i = 0; i < options.length; i++)
			{
				if(options[i].contains("-t"))
				{
					System.out.println("LOADING");
					DataSet dataset = new DataSet();
					dataset.load(options[i+1]);
					train(dataset);
				}
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	public void train( DataSet dataset ) throws Exception
	{
		System.out.println("HERE");
		for(int i = 0; i < dataset.examples.size(); i++)
		{
			System.out.println(i);
			for(int j = 0; j < dataset.examples.get(i).size(); j++)
			{
				System.out.println(j);
				int value;
				if(classConditionalDistributions.get(i).get(j).getN()==null)
				{
					value = 0;
				}
				else
				{
					value = classConditionalDistributions.get(i).get(j).getN();
				}
				value = value + 1;
				classConditionalDistributions.get(i).get(j).add(value);
			}
		}

		for(int i = 0; i < classConditionalDistributions.size(); i++)
		{
			for(int j = 0; j < classConditionalDistributions.get(i).size(); j++)
			{
				System.out.print(classConditionalDistributions.get(i).get(j).n);
				System.out.print(" ");
			}
			System.out.println(".");
		}
	}

	public static void main( String args[] )
	{
		try
		{
			NaiveBayes n = new NaiveBayes();
			n.setOptions(args);
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}

	}
}
