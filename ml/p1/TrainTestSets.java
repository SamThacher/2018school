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
		this.test = this.test;
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
		if(options[0].contains("-t") )
		{
			try
			{
				java.lang.String fil = options[1];
				train.load(fil);

				// Attributes a = new Attributes();
				// java.nio.file.Path filePath = java.nio.file.Paths.get(fil);
				// java.util.Scanner sc = new java.util.Scanner(filePath);
				// a.parse(sc);
				// Examples e = new Examples(a);
				// e.parse(sc);
			}
			catch(java.lang.ArrayIndexOutOfBoundsException e) {
				System.out.println("Training file is required");
			}
			catch(java.lang.Exception e) 
			{
				e.printStackTrace();
			}
		}
	}
	public java.lang.String toString()
	{
		return train.toString();
	}
}