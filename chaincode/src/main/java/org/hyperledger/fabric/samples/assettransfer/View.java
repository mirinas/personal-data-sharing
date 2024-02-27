package org.hyperledger.fabric.samples.assettransfer;

import com.owlike.genson.annotation.JsonProperty;
import java.util.Objects;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

@DataType()
public class View {

  @Property()
  private final String label;

  @Property()
  private String hash;


  public View(@JsonProperty("label") final String label,
      @JsonProperty("hash") final String hash) {
    this.label = label;
    this.hash = hash;
  }


  public String getLabel() {
    return label;
  }

  public String getHash() {
    return hash;
  }

  public void setHash(String hash) {
    this.hash = hash;
  }



  @Override
  public boolean equals(final Object obj) {
    if (this == obj) {
      return true;
    }

    if ((obj == null) || (getClass() != obj.getClass())) {
      return false;
    }

    var other = (View) obj;
    return other.getLabel().equals(getLabel());
  }

  @Override
  public int hashCode() {
    return Objects.hash(getLabel(), getHash());
  }

  @Override
  public String toString() {
    return this.getClass().getSimpleName() + "@" +
        Integer.toHexString(hashCode()) + " " + getLabel();
  }
}
