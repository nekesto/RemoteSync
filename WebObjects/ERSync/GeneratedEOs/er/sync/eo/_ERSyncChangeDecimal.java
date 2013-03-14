// $LastChangedRevision: 5773 $ DO NOT EDIT.  Make changes to ERSyncChangeDecimal.java instead.
package er.sync.eo;

import com.webobjects.eoaccess.*;
import com.webobjects.eocontrol.*;
import com.webobjects.foundation.*;
import java.math.*;
import java.util.*;
import org.apache.log4j.Logger;

@SuppressWarnings("all")
public abstract class _ERSyncChangeDecimal extends er.sync.eo.ERSyncChangeValue {
	public static final String ENTITY_NAME = "ERSyncChangeDecimal";

	// Attributes
	public static final String ATTRIBUTE_NAME_KEY = "attributeName";
	public static final String DECIMAL_VALUE_KEY = "decimalValue";
	public static final String VALUE_TYPE_KEY = "valueType";

	// Relationships
	public static final String CHANGE_ENTITY_KEY = "changeEntity";
	public static final String CHANGESET_KEY = "changeset";

  private static Logger LOG = Logger.getLogger(_ERSyncChangeDecimal.class);

  public ERSyncChangeDecimal localInstanceIn(EOEditingContext editingContext) {
    ERSyncChangeDecimal localInstance = (ERSyncChangeDecimal)EOUtilities.localInstanceOfObject(editingContext, this);
    if (localInstance == null) {
      throw new IllegalStateException("You attempted to localInstance " + this + ", which has not yet committed.");
    }
    return localInstance;
  }

  public java.math.BigDecimal decimalValue() {
    return (java.math.BigDecimal) storedValueForKey("decimalValue");
  }

  public void setDecimalValue(java.math.BigDecimal value) {
    if (_ERSyncChangeDecimal.LOG.isDebugEnabled()) {
    	_ERSyncChangeDecimal.LOG.debug( "updating decimalValue from " + decimalValue() + " to " + value);
    }
    takeStoredValueForKey(value, "decimalValue");
  }


  public static ERSyncChangeDecimal createERSyncChangeDecimal(EOEditingContext editingContext, String attributeName
, er.sync.eo.ERSyncEntity changeEntity, er.sync.eo.ERSyncChangeset changeset) {
    ERSyncChangeDecimal eo = (ERSyncChangeDecimal) EOUtilities.createAndInsertInstance(editingContext, _ERSyncChangeDecimal.ENTITY_NAME);    
		eo.setAttributeName(attributeName);
    eo.setChangeEntityRelationship(changeEntity);
    eo.setChangesetRelationship(changeset);
    return eo;
  }

  public static NSArray<ERSyncChangeDecimal> fetchAllERSyncChangeDecimals(EOEditingContext editingContext) {
    return _ERSyncChangeDecimal.fetchAllERSyncChangeDecimals(editingContext, null);
  }

  public static NSArray<ERSyncChangeDecimal> fetchAllERSyncChangeDecimals(EOEditingContext editingContext, NSArray<EOSortOrdering> sortOrderings) {
    return _ERSyncChangeDecimal.fetchERSyncChangeDecimals(editingContext, null, sortOrderings);
  }

  public static NSArray<ERSyncChangeDecimal> fetchERSyncChangeDecimals(EOEditingContext editingContext, EOQualifier qualifier, NSArray<EOSortOrdering> sortOrderings) {
    EOFetchSpecification fetchSpec = new EOFetchSpecification(_ERSyncChangeDecimal.ENTITY_NAME, qualifier, sortOrderings);
    fetchSpec.setIsDeep(true);
    NSArray<ERSyncChangeDecimal> eoObjects = (NSArray<ERSyncChangeDecimal>)editingContext.objectsWithFetchSpecification(fetchSpec);
    return eoObjects;
  }

  public static ERSyncChangeDecimal fetchERSyncChangeDecimal(EOEditingContext editingContext, String keyName, Object value) {
    return _ERSyncChangeDecimal.fetchERSyncChangeDecimal(editingContext, new EOKeyValueQualifier(keyName, EOQualifier.QualifierOperatorEqual, value));
  }

  public static ERSyncChangeDecimal fetchERSyncChangeDecimal(EOEditingContext editingContext, EOQualifier qualifier) {
    NSArray<ERSyncChangeDecimal> eoObjects = _ERSyncChangeDecimal.fetchERSyncChangeDecimals(editingContext, qualifier, null);
    ERSyncChangeDecimal eoObject;
    int count = eoObjects.count();
    if (count == 0) {
      eoObject = null;
    }
    else if (count == 1) {
      eoObject = (ERSyncChangeDecimal)eoObjects.objectAtIndex(0);
    }
    else {
      throw new IllegalStateException("There was more than one ERSyncChangeDecimal that matched the qualifier '" + qualifier + "'.");
    }
    return eoObject;
  }

  public static ERSyncChangeDecimal fetchRequiredERSyncChangeDecimal(EOEditingContext editingContext, String keyName, Object value) {
    return _ERSyncChangeDecimal.fetchRequiredERSyncChangeDecimal(editingContext, new EOKeyValueQualifier(keyName, EOQualifier.QualifierOperatorEqual, value));
  }

  public static ERSyncChangeDecimal fetchRequiredERSyncChangeDecimal(EOEditingContext editingContext, EOQualifier qualifier) {
    ERSyncChangeDecimal eoObject = _ERSyncChangeDecimal.fetchERSyncChangeDecimal(editingContext, qualifier);
    if (eoObject == null) {
      throw new NoSuchElementException("There was no ERSyncChangeDecimal that matched the qualifier '" + qualifier + "'.");
    }
    return eoObject;
  }

  public static ERSyncChangeDecimal localInstanceIn(EOEditingContext editingContext, ERSyncChangeDecimal eo) {
    ERSyncChangeDecimal localInstance = (eo == null) ? null : (ERSyncChangeDecimal)EOUtilities.localInstanceOfObject(editingContext, eo);
    if (localInstance == null && eo != null) {
      throw new IllegalStateException("You attempted to localInstance " + eo + ", which has not yet committed.");
    }
    return localInstance;
  }
}
