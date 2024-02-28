/*
 * SPDX-License-Identifier: Apache-2.0
 */

package org.hyperledger.fabric.samples.assettransfer;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import com.owlike.genson.Genson;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.junit.jupiter.api.Test;

public final class ViewUpdateTest {

    private static final String label = "users";
    private static final String hash = "hash of the data";

    private final Genson genson = new Genson();


    @Test
    public void testUpdateView() {
        var contract = new ViewUpdate();

        var stub = mock(ChaincodeStub.class);
        var ctx = mock(Context.class);
        when(ctx.getStub()).thenReturn(stub);

        var newView = contract.CreateView(ctx, label, hash);
        verify(stub).putStringState(label, genson.serialize(newView));

        var hash = stub.getStringState("users");
        System.out.println(hash);
    }
}
