// $LastChangedRevision: 5773 $ DO NOT EDIT.  Make changes to TaskPerson.java instead.
package net.global_village.notes.model.entities;

import com.webobjects.eoaccess.*;
import com.webobjects.eocontrol.*;
import com.webobjects.foundation.*;
import java.math.*;
import java.util.*;
import org.apache.log4j.Logger;

@SuppressWarnings("all")
public abstract class _TaskPerson extends er.extensions.partials.ERXPartial<net.global_village.notes.model.entities.Person> {
	public static final String ENTITY_NAME = "Person";

	// Attributes

	// Relationships

  private static Logger LOG = Logger.getLogger(_TaskPerson.class);


  public TaskPerson initTaskPerson(EOEditingContext editingContext) {
    TaskPerson eo = (TaskPerson)this;    
    return eo;
  }
}
