package org.hyperledger.fabric.samples.assettransfer;

import com.owlike.genson.Genson;
import java.util.ArrayList;
import java.util.List;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.contract.annotation.Transaction.TYPE;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

@Contract(
    name = "basic",
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


  @Transaction(intent = Transaction.TYPE.EVALUATE)
  public String GetAllViews(final Context ctx) {
    ChaincodeStub stub = ctx.getStub();

    List<View> queryResults = new ArrayList<>();

    // To retrieve all assets from the ledger use getStateByRange with empty startKey & endKey.
    // Giving empty startKey & endKey is interpreted as all the keys from beginning to end.
    // As another example, if you use startKey = 'asset0', endKey = 'asset9' ,
    // then getStateByRange will retrieve asset with keys between asset0 (inclusive) and asset9 (exclusive) in lexical order.
    QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

    for (KeyValue result: results) {
      View view = genson.deserialize(result.getStringValue(), View.class);
      System.out.println(view);
      queryResults.add(view);
    }

    return genson.serialize(queryResults);
  }
}
