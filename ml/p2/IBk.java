/*
 * IBk.java
 * Copyright (c) 2018 Georgetown University.  All Rights Reserved.
 */
import java.util.*;
import java.io.*;

public class IBk extends Classifier implements Serializable, OptionHandler
	{

	protected DataSet dataset;
	protected int k = 3;

	public IBk()
	{
		dataset = new DataSet();
	}
	public IBk( String[] options ) throws Exception
	{
		setOptions(options);
	}
	public Performance classify( DataSet dataset ) throws Exception
	{
		Performance perf = new Performance(this.dataset.getAttributes());
		for(Example e : dataset.getExamples())
		{
			Double actual = e.get(dataset.getAttributes().getClassIndex());


			// CHANGE TO INT
			int pred = classify(e);
			if(actual == pred)
			{
				System.out.println("correct!");
				System.out.print("you guessed ");
				System.out.print(pred);
				System.out.print("and the answer is ");
				System.out.println(actual);
			}
			else
			{
				System.out.println("incorrect!");
				System.out.print("you guessed ");
				System.out.print(pred);
				System.out.print("and the answer is ");
				System.out.println(actual);
			}
			perf.add(actual, pred);
		}
		return perf;

	}
	public int classify( Example query ) throws Exception
	{
		// returns the value of the class index - like 1 for bike type or something

		// if k > 1 then get the majority vote of the neighbor

		System.out.print("new example: ");
		PriorityQueue<DistKey> queue = new PriorityQueue<DistKey>();
		for(Example e : dataset.getExamples())
		{
			int dist = 0;
			for(int i = 0; i < e.size(); i++)
			{
				if(e.get(i) != query.get(i))
				{
					dist+= 1;
				}
			}
			Double sqdist = Math.sqrt(dist);
			System.out.print(sqdist);
			System.out.print(" ");
			queue.add(new DistKey(sqdist,e.get(dataset.getAttributes().getClassIndex()).intValue()));
			// m.put(sqdist,)
			// queue.add(((i/nt)sqdist));
		}

		// The problem here is im returning the dist and not the class label.. thats wrong
		return queue.peek().getValue();
	}
	public Classifier clone()
	{
		return this;
	}
	public void setK( int k )
	{
		this.k = k;
	}
	public void setOptions( String options[] )
	{
		try{		// super.setOptions(options);
		for(int i = 0; i < options.length; i++)
		{
			if(options[i].contains("-t"))
			{
				dataset.load(options[i+1]);
				Performance p = new Performance(dataset.getAttributes());
				// TrainTestSets t = new TrainTestSets();
				for(int j = 0; j < dataset.getFolds(); j++)
				{
					TrainTestSets t = new TrainTestSets();
					t = dataset.getCVSets(j);
					train(t.getTrainingSet());
					Performance toAdd = new Performance(dataset.getAttributes());
					toAdd = classify(t.getTestingSet());
					p.add(toAdd);
					System.out.println("DATASET RECHECK");
					System.out.println(dataset.toString());
				}
				System.out.println(p.getAccuracy());
				System.out.println(" ^ Accuracy ");
				// train(t.getTrainingSet());
				// p = classify(t.getTestingSet());
			}
			// else if(options[i].contains("-T"))
			// {
			// 	test.load(options[i+1]);
			// }
		}
	}
		catch(Exception e)
		{
			System.out.println("ERROR");
			System.out.println(e.getMessage());
		}
	}
	public void train( DataSet dataset ) throws Exception
	{
		this.dataset = dataset;
	}
	public static void main( String args[] )
	{
		try
		{
			IBk i = new IBk();
			i.setOptions(args);
		}
		catch(Exception e)
		{
			System.out.println("ERROR");
			System.out.println(e.getMessage());
		}

	}
}
