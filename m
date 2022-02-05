Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72004AA5EA
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Feb 2022 03:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379102AbiBECem (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Feb 2022 21:34:42 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45090 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379017AbiBECe0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Feb 2022 21:34:26 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 008FC20B83FE;
        Fri,  4 Feb 2022 18:34:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 008FC20B83FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644028466;
        bh=d18zkhHC6TSDSRAJZCBoNwae432DSb+vi0iUQIZ2+2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm81vx8xLDieSop1ezQt+3SgI07jVKH4zxif5JK2xTK+ziMrtE2uG6Jeh6lhTC639
         ovtcZphfqzJQ8B1bF0eRgzcxF2KMEgUn54fqH+krZG56vKPuM7LA0znoHB/EpfASBw
         qEgYWhIjEbkMLBSAme7BaETXPFv1mwz/aAO7E++w=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v2 15/24] drivers: hv: dxgkrnl: IOCTL to get the dxgdevice state LX_DXGETDEVICESTATE
Date:   Fri,  4 Feb 2022 18:34:13 -0800
Message-Id: <611d92448a015fa54dbd839147ef696ab1f28328.1644025661.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1644025661.git.iourit@linux.microsoft.com>
References: <cover.1644025661.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

LX_DXGETDEVICESTATE(D3DKMTGetDeviceState)
The IOCTL is used to query the state of the given dxgdevice object (active,
error, etc.). A call to the dxgdevice execution state could be high
frequency. The followin method is used to avoid sending a synchronous VM
bus message to the host for every call:
- When a dxgdevice is created, a pointer to dxgglobal->device_state_counter
  is sent to the host
- Every time the device state on the host is changed, the host will send
  an asynchronous message to the guest (DXGK_VMBCOMMAND_SETGUESTDATA) and
  the guest will increment the device_state_counter counter.
- the dxgdevice object has execution_state_counter counter, which is equal
  to dxgglobal->device_state_counte at the time when LX_DXGETDEVICESTATE
  was last called.
- if execution_state_counter is different from evice_state_counter, the
  dxgk_vmbcommand_getdevicestate VM bus message is sent to the host.
  Otherwise, the cached value is returned.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  | 11 ++++++
 drivers/hv/dxgkrnl/dxgvmbus.c | 66 +++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 66 +++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index e1c718e7b8eb..892c95a11368 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -249,12 +249,18 @@ void dxgsyncobject_destroy(struct dxgprocess *process,
 void dxgsyncobject_stop(struct dxgsyncobject *syncobj);
 void dxgsyncobject_release(struct kref *refcount);
 
+/*
+ * device_state_counter - incremented every time the execition state of
+ *	a DXGDEVICE is changed in the host. Used to optimize access to the
+ *	device execution state.
+ */
 struct dxgglobal {
 	struct dxgvmbuschannel	channel;
 	struct delayed_work	dwork;
 	struct hv_device	*hdev;
 	u32			num_adapters;
 	u32			vmbus_ver;	/* Interface version */
+	atomic_t		device_state_counter;
 	struct resource		*mem;
 	u64			mmiospace_base;
 	u64			mmiospace_size;
@@ -495,6 +501,7 @@ struct dxgdevice {
 	struct list_head	syncobj_list_head;
 	struct d3dkmthandle	handle;
 	enum d3dkmt_deviceexecution_state execution_state;
+	int			execution_state_counter;
 	u32			handle_valid;
 };
 
@@ -823,6 +830,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct d3dkmt_opensyncobjectfromnthandle2
 				    *args,
 				    struct dxgsyncobject *syncobj);
+int dxgvmb_send_get_device_state(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_getdevicestate *args,
+				 struct d3dkmt_getdevicestate *__user inargs);
 int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 					struct d3dkmthandle object,
 					struct d3dkmthandle *shared_handle);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 8ad290b2b482..b5225756ee6e 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -275,6 +275,23 @@ static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
 	command->channel_type = DXGKVMB_VM_TO_HOST;
 }
 
+static void set_guest_data(struct dxgkvmb_command_host_to_vm *packet,
+			   u32 packet_length)
+{
+	struct dxgkvmb_command_setguestdata *command = (void *)packet;
+
+	pr_debug("%s: %d %d %p %p", __func__,
+		command->data_type,
+		command->data32,
+		command->guest_pointer,
+		&dxgglobal->device_state_counter);
+	if (command->data_type == SETGUESTDATA_DATATYPE_DWORD &&
+	    command->guest_pointer == &dxgglobal->device_state_counter &&
+	    command->data32 != 0) {
+		atomic_inc(&dxgglobal->device_state_counter);
+	}
+}
+
 static void signal_guest_event(struct dxgkvmb_command_host_to_vm *packet,
 			       u32 packet_length)
 {
@@ -305,6 +322,9 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 			pr_debug("global packet %d",
 				    packet->command_type);
 			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SETGUESTDATA:
+				set_guest_data(packet, packet_length);
+				break;
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
 				signal_guest_event(packet, packet_length);
@@ -1017,6 +1037,7 @@ struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
 	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_CREATEDEVICE,
 				   process->host_handle);
 	command->flags = args->flags;
+	command->error_code = &dxgglobal->device_state_counter;
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
 				   &result, sizeof(result));
@@ -1753,6 +1774,51 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_get_device_state(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_getdevicestate *args,
+				 struct d3dkmt_getdevicestate *__user output)
+{
+	int ret;
+	struct dxgkvmb_command_getdevicestate *command;
+	struct dxgkvmb_command_getdevicestate_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETDEVICESTATE,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result.status);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(output, &result.args, sizeof(result.args));
+	if (ret) {
+		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+	}
+
+	if (args->state_type == _D3DKMT_DEVICESTATE_EXECUTION)
+		args->execution_state = result.args.execution_state;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_open_resource(struct dxgprocess *process,
 			      struct dxgadapter *adapter,
 			      struct d3dkmthandle device,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 71ba7b75c60f..bb6eab08898f 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3180,6 +3180,70 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_get_device_state(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_getdevicestate args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int global_device_state_counter = 0;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	if (args.state_type == _D3DKMT_DEVICESTATE_EXECUTION) {
+		global_device_state_counter =
+			atomic_read(&dxgglobal->device_state_counter);
+		if (device->execution_state_counter ==
+		    global_device_state_counter) {
+			args.execution_state = device->execution_state;
+			ret = copy_to_user(inargs, &args, sizeof(args));
+			if (ret) {
+				pr_err("%s failed to copy args to user",
+					__func__);
+				ret = -EINVAL;
+			}
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_get_device_state(process, adapter, &args, inargs);
+
+	if (ret == 0 && args.state_type == _D3DKMT_DEVICESTATE_EXECUTION) {
+		device->execution_state = args.execution_state;
+		device->execution_state_counter = global_device_state_counter;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (ret < 0)
+		pr_err("%s failed %x", __func__, ret);
+
+	return ret;
+}
+
 static int
 dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
 				    struct dxgprocess *process,
@@ -3921,6 +3985,8 @@ void init_ioctls(void)
 		  LX_DXCREATEPAGINGQUEUE);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xe */ dxgk_get_device_state,
+		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
 		  LX_DXSUBMITCOMMAND);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
-- 
2.35.1

