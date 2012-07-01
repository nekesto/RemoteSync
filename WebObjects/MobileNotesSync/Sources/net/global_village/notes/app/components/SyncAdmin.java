package net.global_village.notes.app.components;

import com.webobjects.appserver.WOContext;
import com.webobjects.appserver.WOComponent;

public class SyncAdmin extends WOComponent {
    public SyncAdmin(WOContext context) {
        super(context);
    }


	public WOComponent showNotesPage()
	{    	
    	return pageWithName( "NotesPage" );
	}
}