package org.hyperledger.fabric.samples.assettransfer;

import com.owlike.genson.Genson;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.contract.annotation.Transaction.TYPE;

@Contract(
    name = "private",
    info = @Info(
        title = "View update",
        description = "Update view to privately share data",
        version = "0.0.1-SNAPSHOT"))

@Default
public class ViewUpdate implements ContractInterface {

  private final Genson genson = new Genson();

  @Transaction(intent = TYPE.SUBMIT)
  public View CreateView(final Context ctx, final String label, final String hash) {

    var stub = ctx.getStub();
    var view = new View(label, hash);

    String sortedJson = genson.serialize(view);
    stub.putStringState(label, sortedJson);

    return view;
  }
}
