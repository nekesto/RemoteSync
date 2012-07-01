package er.sync.components;

import com.webobjects.appserver.WOContext;
import com.webobjects.appserver.WOComponent;
import com.webobjects.foundation.NSArray;

import er.sync.eo.ERSyncClientApp;
import er.sync.eo.ERSyncClientDeveloper;
import er.sync.eo.ERSyncClientDevice;

public class DeveloperReport extends WOComponent {
	
	public ERSyncClientDeveloper developer = null;
	public ERSyncClientApp appItem;
	public ERSyncClientDevice deviceItem;
	public ERSyncClientDeveloper selected = null;
	
    public DeveloperReport(WOContext context) {
        super(context);
    }
    
    public NSArray<ERSyncClientDeveloper> developerList() {
    	return ERSyncClientDeveloper.fetchAllERSyncClientDevelopers(session().defaultEditingContext());
    }
    
    public WOComponent selectDeveloper()
    {
    	selected = developer;
    	System.err.println("apps " + selected.applications().valueForKey("name"));
    	return null;
    }
}