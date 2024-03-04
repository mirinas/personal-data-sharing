/*
 * SPDX-License-Identifier: Apache-2.0
 */
package main;

import lombok.NoArgsConstructor;
import lombok.extern.java.Log;
import main.exceptions.ChaincodeError;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contact;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.License;
import org.hyperledger.fabric.contract.annotation.Transaction;

@Contract(name = "PrivateDataContract",
    info = @Info(title = "Private data contract",
                description = "Keeps track of information without losing privacy",
                version = "1.0",
                license =
                        @License(name = "SPDX-License-Identifier: Apache-2.0"),
                                contact =  @Contact(email = "am26g21@soton.ac.uk",
                                                name = "PrivateDataContract")))
@Default
@Log
@NoArgsConstructor
public class PrivateDataContract implements ContractInterface {

    @Transaction()
    public boolean viewExists(Context ctx, String viewId) {

        byte[] buffer = ctx.getStub().getState(viewId);
        return (buffer != null && buffer.length > 0);
    }

    @Transaction()
    public void publishView(Context ctx, String viewId, String data) {

        if(viewExists(ctx, viewId)) throw new ChaincodeError("View already exists");

        var asset = new PrivateView(data);
        ctx.getStub().putState(viewId, asset.toBytes());
    }

    @Transaction()
    public PrivateView readView(Context ctx, String viewId) {

        if(!viewExists(ctx, viewId)) throw new ChaincodeError("View does not exist");

        var state = ctx.getStub().getState(viewId);
        return PrivateView.fromState(state);
    }

    @Transaction()
    public void deleteView(Context ctx, String viewId) {

        if(!viewExists(ctx, viewId)) throw new ChaincodeError("View does not exist");
        ctx.getStub().delState(viewId);
    }

}