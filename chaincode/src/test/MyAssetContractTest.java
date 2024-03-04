/*
 * SPDX-License-Identifier: Apache License 2.0
 */

package test;

import lombok.extern.java.Log;
import main.PrivateView;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

@Log
public final class MyAssetContractTest {

  @Nested
  class PrivateViewTest {
    @Test
    public void testPublishing() {

      var view = new PrivateView("fever;38");
      var bytes = view.toBytes();
    }
  }

//    @Nested
//    class AssetExists {
//        @Test
//        public void noProperAsset() {
//
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            when(stub.getState("10001")).thenReturn(new byte[] {});
//            boolean result = contract.myAssetExists(ctx,"10001");
//
//            assertFalse(result);
//        }
//
//        @Test
//        public void assetExists() {
//
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            when(stub.getState("10001")).thenReturn(new byte[] {42});
//            boolean result = contract.myAssetExists(ctx,"10001");
//
//            assertTrue(result);
//
//        }
//
//        @Test
//        public void noKey() {
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            when(stub.getState("10002")).thenReturn(null);
//            boolean result = contract.myAssetExists(ctx,"10002");
//
//            assertFalse(result);
//
//        }
//
//    }
//
//    @Nested
//    class AssetCreates {
//
//        @Test
//        public void newAssetCreate() {
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            String json = "{\"value\":\"TheAsset\"}";
//
//            contract.createMyAsset(ctx, "10001", "TheAsset");
//
//            verify(stub).putState("10001", json.getBytes(UTF_8));
//        }
//
//        @Test
//        public void alreadyExists() {
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            when(stub.getState("10002")).thenReturn(new byte[] { 42 });
//
//            Exception thrown = assertThrows(RuntimeException.class, () -> {
//                contract.createMyAsset(ctx, "10002", "TheAsset");
//            });
//
//            assertEquals(thrown.getMessage(), "The asset 10002 already exists");
//
//        }
//
//    }
//
//    @Test
//    public void assetRead() {
//        MyAssetContract contract = new  MyAssetContract();
//        Context ctx = mock(Context.class);
//        ChaincodeStub stub = mock(ChaincodeStub.class);
//        when(ctx.getStub()).thenReturn(stub);
//
//        MyAsset asset = new  MyAsset();
//        asset.setValue("Valuable");
//
//        String json = asset.toJSONString();
//        when(stub.getState("10001")).thenReturn(json.getBytes(StandardCharsets.UTF_8));
//
//        MyAsset returnedAsset = contract.readMyAsset(ctx, "10001");
//        assertEquals(returnedAsset.getValue(), asset.getValue());
//    }
//
//    @Nested
//    class AssetUpdates {
//        @Test
//        public void updateExisting() {
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//            when(stub.getState("10001")).thenReturn(new byte[] { 42 });
//
//            contract.updateMyAsset(ctx, "10001", "updates");
//
//            String json = "{\"value\":\"updates\"}";
//            verify(stub).putState("10001", json.getBytes(UTF_8));
//        }
//
//        @Test
//        public void updateMissing() {
//            MyAssetContract contract = new  MyAssetContract();
//            Context ctx = mock(Context.class);
//            ChaincodeStub stub = mock(ChaincodeStub.class);
//            when(ctx.getStub()).thenReturn(stub);
//
//            when(stub.getState("10001")).thenReturn(null);
//
//            Exception thrown = assertThrows(RuntimeException.class, () -> {
//                contract.updateMyAsset(ctx, "10001", "TheAsset");
//            });
//
//            assertEquals(thrown.getMessage(), "The asset 10001 does not exist");
//        }
//
//    }
//
//    @Test
//    public void assetDelete() {
//        MyAssetContract contract = new  MyAssetContract();
//        Context ctx = mock(Context.class);
//        ChaincodeStub stub = mock(ChaincodeStub.class);
//        when(ctx.getStub()).thenReturn(stub);
//        when(stub.getState("10001")).thenReturn(null);
//
//        Exception thrown = assertThrows(RuntimeException.class, () -> {
//            contract.deleteMyAsset(ctx, "10001");
//        });
//
//        assertEquals(thrown.getMessage(), "The asset 10001 does not exist");
//    }

}