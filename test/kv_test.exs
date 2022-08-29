defmodule KVTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)

    %{bucket: bucket}
  end

  test "should store key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)

    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "should delete key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.delete(bucket, "milk") == 3

    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "are temporary workers" do
    assert Supervisor.child_spec(KV.Bucket, []).restart == :temporary
  end
end
