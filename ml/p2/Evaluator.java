/*
 * Evaluator.java
 * Copyright (c) 2018 Georgetown University.  All Rights Reserved.
 */

public class Evaluator implements OptionHandler
{

	private long seed = 2026875034;
	private Random random;
	private int folds = 10;
	private Classifier classifier;
	private TrainTestSets tts;

	public Evaluator( Classifier classifier, String[] options ) throws Exception
	{

	}
	public Performance evaluate() throws Exception
	{
		
	}
	public long getSeed()
	{
		return seed;
	}
	public void setOptions( String args[] ) throws Exception
	{

	}
	public void setSeed( long seed )
	{
		this.seed = seed;
	}
}
