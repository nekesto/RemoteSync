package er.sync.eo;

import org.apache.log4j.Logger;

import com.webobjects.eoaccess.EOAttribute;
import com.webobjects.eocontrol.EOEditingContext;

public class ERSyncChangeDecimal extends _ERSyncChangeDecimal {
  private static Logger log = Logger.getLogger(ERSyncChangeDecimal.class);
  
	public void awakeFromInsertion( EOEditingContext ec ) 
	{
		super.awakeFromInsertion( ec );
		this.setValueType(String.valueOf(EOAttribute._VTBigDecimal));
	}

	public Object changeValue()
	{
		return decimalValue();
	}

}
