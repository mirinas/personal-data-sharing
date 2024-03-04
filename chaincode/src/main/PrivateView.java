/*
 * SPDX-License-Identifier: Apache-2.0
 */

package main;

import static java.nio.charset.StandardCharsets.UTF_8;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.extern.java.Log;
import org.apache.commons.codec.digest.DigestUtils;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;
import org.json.JSONObject;

@Getter
@Setter
@ToString
@Log
@DataType()
public class PrivateView {

    @Property()
    private String compliantHash;
    private String data;

    public PrivateView(String data) {
        this.compliantHash = DigestUtils.sha256Hex(data);
        this.data = data;
    }

    public PrivateView(byte[] state) {

        var json = new JSONObject(new String(state, UTF_8));
        this.compliantHash = json.getString("compliantHash");
        this.data = null;
    }

    public byte[] toBytes() {
        return new JSONObject(this).toString().getBytes(UTF_8);
    }

    public static PrivateView fromState(byte[] state) {
        return new PrivateView(state);
    }
}
