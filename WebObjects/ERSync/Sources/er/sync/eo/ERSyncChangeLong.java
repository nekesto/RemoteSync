package er.sync.eo;

import org.apache.log4j.Logger;

import com.webobjects.eoaccess.EOAttribute;
import com.webobjects.eocontrol.EOEditingContext;

public class ERSyncChangeLong extends _ERSyncChangeLong {
	private static Logger log = Logger.getLogger(ERSyncChangeLong.class);
	public void awakeFromInsertion( EOEditingContext ec ) 
	{
		super.awakeFromInsertion( ec );
		this.setValueType(String.valueOf(EOAttribute._VTLong));
	}

	public Object changeValue()
	{
		return longValue();
	}
}
