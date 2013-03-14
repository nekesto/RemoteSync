// $LastChangedRevision: 5773 $ DO NOT EDIT.  Make changes to ERSyncChangeLong.java instead.
package er.sync.eo;

import com.webobjects.eoaccess.*;
import com.webobjects.eocontrol.*;
import com.webobjects.foundation.*;
import java.math.*;
import java.util.*;
import org.apache.log4j.Logger;

@SuppressWarnings("all")
public abstract class _ERSyncChangeLong extends er.sync.eo.ERSyncChangeValue {
	public static final String ENTITY_NAME = "ERSyncChangeLong";

	// Attributes
	public static final String ATTRIBUTE_NAME_KEY = "attributeName";
	public static final String LONG_VALUE_KEY = "longValue";
	public static final String VALUE_TYPE_KEY = "valueType";

	// Relationships
	public static final String CHANGE_ENTITY_KEY = "changeEntity";
	public static final String CHANGESET_KEY = "changeset";

  private static Logger LOG = Logger.getLogger(_ERSyncChangeLong.class);

  public ERSyncChangeLong localInstanceIn(EOEditingContext editingContext) {
    ERSyncChangeLong localInstance = (ERSyncChangeLong)EOUtilities.localInstanceOfObject(editingContext, this);
    if (localInstance == null) {
      throw new IllegalStateException("You attempted to localInstance " + this + ", which has not yet committed.");
    }
    return localInstance;
  }

  public Long longValue() {
    return (Long) storedValueForKey("longValue");
  }

  public void setLongValue(Long value) {
    if (_ERSyncChangeLong.LOG.isDebugEnabled()) {
    	_ERSyncChangeLong.LOG.debug( "updating longValue from " + longValue() + " to " + value);
    }
    takeStoredValueForKey(value, "longValue");
  }


  public static ERSyncChangeLong createERSyncChangeLong(EOEditingContext editingContext, String attributeName
, er.sync.eo.ERSyncEntity changeEntity, er.sync.eo.ERSyncChangeset changeset) {
    ERSyncChangeLong eo = (ERSyncChangeLong) EOUtilities.createAndInsertInstance(editingContext, _ERSyncChangeLong.ENTITY_NAME);    
		eo.setAttributeName(attributeName);
    eo.setChangeEntityRelationship(changeEntity);
    eo.setChangesetRelationship(changeset);
    return eo;
  }

  public static NSArray<ERSyncChangeLong> fetchAllERSyncChangeLongs(EOEditingContext editingContext) {
    return _ERSyncChangeLong.fetchAllERSyncChangeLongs(editingContext, null);
  }

  public static NSArray<ERSyncChangeLong> fetchAllERSyncChangeLongs(EOEditingContext editingContext, NSArray<EOSortOrdering> sortOrderings) {
    return _ERSyncChangeLong.fetchERSyncChangeLongs(editingContext, null, sortOrderings);
  }

  public static NSArray<ERSyncChangeLong> fetchERSyncChangeLongs(EOEditingContext editingContext, EOQualifier qualifier, NSArray<EOSortOrdering> sortOrderings) {
    EOFetchSpecification fetchSpec = new EOFetchSpecification(_ERSyncChangeLong.ENTITY_NAME, qualifier, sortOrderings);
    fetchSpec.setIsDeep(true);
    NSArray<ERSyncChangeLong> eoObjects = (NSArray<ERSyncChangeLong>)editingContext.objectsWithFetchSpecification(fetchSpec);
    return eoObjects;
  }

  public static ERSyncChangeLong fetchERSyncChangeLong(EOEditingContext editingContext, String keyName, Object value) {
    return _ERSyncChangeLong.fetchERSyncChangeLong(editingContext, new EOKeyValueQualifier(keyName, EOQualifier.QualifierOperatorEqual, value));
  }

  public static ERSyncChangeLong fetchERSyncChangeLong(EOEditingContext editingContext, EOQualifier qualifier) {
    NSArray<ERSyncChangeLong> eoObjects = _ERSyncChangeLong.fetchERSyncChangeLongs(editingContext, qualifier, null);
    ERSyncChangeLong eoObject;
    int count = eoObjects.count();
    if (count == 0) {
      eoObject = null;
    }
    else if (count == 1) {
      eoObject = (ERSyncChangeLong)eoObjects.objectAtIndex(0);
    }
    else {
      throw new IllegalStateException("There was more than one ERSyncChangeLong that matched the qualifier '" + qualifier + "'.");
    }
    return eoObject;
  }

  public static ERSyncChangeLong fetchRequiredERSyncChangeLong(EOEditingContext editingContext, String keyName, Object value) {
    return _ERSyncChangeLong.fetchRequiredERSyncChangeLong(editingContext, new EOKeyValueQualifier(keyName, EOQualifier.QualifierOperatorEqual, value));
  }

  public static ERSyncChangeLong fetchRequiredERSyncChangeLong(EOEditingContext editingContext, EOQualifier qualifier) {
    ERSyncChangeLong eoObject = _ERSyncChangeLong.fetchERSyncChangeLong(editingContext, qualifier);
    if (eoObject == null) {
      throw new NoSuchElementException("There was no ERSyncChangeLong that matched the qualifier '" + qualifier + "'.");
    }
    return eoObject;
  }

  public static ERSyncChangeLong localInstanceIn(EOEditingContext editingContext, ERSyncChangeLong eo) {
    ERSyncChangeLong localInstance = (eo == null) ? null : (ERSyncChangeLong)EOUtilities.localInstanceOfObject(editingContext, eo);
    if (localInstance == null && eo != null) {
      throw new IllegalStateException("You attempted to localInstance " + eo + ", which has not yet committed.");
    }
    return localInstance;
  }
}
