/*
* TrainTestSets.java
* Copyright (c) 2018 Georgetown University.All Rights Reserved.
*/

public class TrainTestSets implements OptionHandler
{

	protected DataSet train;
	protected DataSet test;

	public TrainTestSets()
	{
		train = new DataSet();
		test = new DataSet();
	}
	public TrainTestSets( java.lang.String [] options ) throws Exception
	{
		this.setOptions(options);

	}
	public TrainTestSets( DataSet train, DataSet test )
	{
		this.train = train;
		this.test = test;
	}
	public DataSet getTrainingSet()
	{
		return train;
	}
	public DataSet getTestingSet()
	{
		return test;
	}
	public void setTrainingSet( DataSet train )
	{
		this.train = train;
	}
	public void setTestingSet( DataSet test )
	{
		this.test = test;
	}
	public void setOptions( java.lang.String[] options ) throws Exception
	{
		for(int i = 0; i < options.length; i++)
		{
			if(options[i].contains("-t"))
			{
				train.load(options[i+1]);
			}
			else if(options[i].contains("-T"))
			{
				test.load(options[i+1]);
			}
		}

	}
	public java.lang.String toString()
	{
		return train.toString() + "\n\n" + test.toString();
	}
}