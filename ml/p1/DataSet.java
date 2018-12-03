/*
 * DataSet.java
 * Copyright (c) 2018 Georgetown University.  All Rights Reserved.
 */

public class DataSet {

	protected java.lang.String name;
	protected Attributes attributes = null;
	protected Examples examples = null;
	protected java.util.Random random;

	public DataSet()
	{
		name = "";
		attributes = new Attributes();
		examples = new Examples(attributes);
	}
	public DataSet( java.lang.String[] options )
	{

	}
	public DataSet( Attributes attributes )
	{
		this.attributes = attributes;
	}
	public void add( Example example )
	{
		this.examples.add(example);
	}
	public Attributes getAttributes()
	{
		return this.attributes;
	}
	public Examples getExamples()
	{
		return this.examples;
	}
	public boolean getHasNumericAttributes()
	{
		return attributes.getHasNumericAttributes();
	}
	public void load( java.lang.String filename ) throws Exception
	{
		java.nio.file.Path filePath = java.nio.file.Paths.get(filename);
		java.util.Scanner sc = new java.util.Scanner(filePath);
		this.parse(sc);
	}
	private void parse( java.util.Scanner scanner ) throws Exception
	{
		this.attributes.parse(scanner);
		this.examples = new Examples(this.attributes);
		this.examples.parse(scanner);
	}
	public void setRandom( java.util.Random random )
	{
		this.random = random;
	}
	public java.lang.String toString()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(attributes.toString());
		sb.append(examples.toString());
		return sb.toString();
	}
}
