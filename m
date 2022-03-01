Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA9A4C94CC
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237330AbiCATrZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiCATrT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9957F6D394;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 614B420B4910;
        Tue,  1 Mar 2022 11:46:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 614B420B4910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163993;
        bh=qWJmAEe14QVU7vMyCAQ7crMZ6RXWOiAbX0rRzpp6jJ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d5X7UCydPIy5//5SVR5YVBoemK9M9MAqCTn9dUi11fYL6LaYDHHrjXn+nctHYp9e6
         8XKzPVnv6abD1n6c/u3S1QHVS3JSxn7DcSSeLLMGHaA96QiLGB6WJgQnAVN6a9+H+s
         MzX2Ox7vpuHBlWlOV01J5OidRzndJwQAepTxQdPc=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 18/30] drivers: hv: dxgkrnl: Query the dxgdevice state
Date:   Tue,  1 Mar 2022 11:46:05 -0800
Message-Id: <9195c446e5ed62cce7ea26ab2a457c8be8a7e207.1646163378.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement the ioctl to query the dxgdevice state - LX_DXGETDEVICESTATE.
The IOCTL is used to query the state of the given dxgdevice object (active,
error, etc.).

A call to the dxgdevice execution state could be high frequency.
The following method is used to avoid sending a synchronous VM
bus message to the host for every call:
- When a dxgdevice is created, a pointer to dxgglobal->device_state_counter
  is sent to the host
- Every time the device state on the host is changed, the host will send
  an asynchronous message to the guest (DXGK_VMBCOMMAND_SETGUESTDATA) and
  the guest will increment the device_state_counter value.
- the dxgdevice object has execution_state_counter member, which is equal
  to dxgglobal->device_state_counter value at the time when
  LX_DXGETDEVICESTATE was last processed..
- if execution_state_counter is different from device_state_counter, the
  dxgk_vmbcommand_getdevicestate VM bus message is sent to the host.
  Otherwise, the cached value is returned to the caller.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  11 ++++
 drivers/hv/dxgkrnl/dxgvmbus.c |  66 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  26 +++++++++
 drivers/hv/dxgkrnl/ioctl.c    |  66 ++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  | 101 ++++++++++++++++++++++++++++++----
 5 files changed, 260 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 96f04cdadeb5..4a2c8149dcc5 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -253,12 +253,18 @@ void dxgsyncobject_destroy(struct dxgprocess *process,
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
@@ -499,6 +505,7 @@ struct dxgdevice {
 	struct list_head	syncobj_list_head;
 	struct d3dkmthandle	handle;
 	enum d3dkmt_deviceexecution_state execution_state;
+	int			execution_state_counter;
 	u32			handle_valid;
 };
 
@@ -829,6 +836,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
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
index c1c24ea9c14b..44b95a63d7ce 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -276,6 +276,23 @@ static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
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
@@ -306,6 +323,9 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 			pr_debug("global packet %d",
 				    packet->command_type);
 			switch (packet->command_type) {
+			case DXGK_VMBCOMMAND_SETGUESTDATA:
+				set_guest_data(packet, packet_length);
+				break;
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
 				signal_guest_event(packet, packet_length);
@@ -1028,6 +1048,7 @@ struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
 	command_vgpu_to_host_init2(&command->hdr, DXGK_VMBCOMMAND_CREATEDEVICE,
 				   process->host_handle);
 	command->flags = args->flags;
+	command->error_code = &dxgglobal->device_state_counter;
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
 				   &result, sizeof(result));
@@ -1791,6 +1812,51 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 20e0659accf1..62e2fc3e5d14 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -172,6 +172,22 @@ struct dxgkvmb_command_signalguestevent {
 	bool				dereference_event;
 };
 
+enum set_guestdata_type {
+	SETGUESTDATA_DATATYPE_DWORD	= 0,
+	SETGUESTDATA_DATATYPE_UINT64	= 1
+};
+
+struct dxgkvmb_command_setguestdata {
+	struct dxgkvmb_command_host_to_vm hdr;
+	void *guest_pointer;
+	union {
+		u64	data64;
+		u32	data32;
+	};
+	u32	dereference	: 1;
+	u32	data_type	: 4;
+};
+
 struct dxgkvmb_command_opensyncobject {
 	struct dxgkvmb_command_vm_to_host hdr;
 	struct d3dkmthandle		device;
@@ -574,6 +590,16 @@ struct dxgkvmb_command_destroyhwqueue {
 	struct d3dkmthandle		hwqueue;
 };
 
+struct dxgkvmb_command_getdevicestate {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_getdevicestate	args;
+};
+
+struct dxgkvmb_command_getdevicestate_return {
+	struct d3dkmt_getdevicestate	args;
+	struct ntstatus			status;
+};
+
 struct dxgkvmb_command_shareobjectwithhost {
 	struct dxgkvmb_command_vm_to_host hdr;
 	struct d3dkmthandle	device_handle;
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
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index e3b39c1d2b30..a0af63f046c6 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -232,6 +232,95 @@ struct d3dddi_destroypagingqueue {
 	struct d3dkmthandle		paging_queue;
 };
 
+enum dxgk_render_pipeline_stage {
+	_DXGK_RENDER_PIPELINE_STAGE_UNKNOWN		= 0,
+	_DXGK_RENDER_PIPELINE_STAGE_INPUT_ASSEMBLER	= 1,
+	_DXGK_RENDER_PIPELINE_STAGE_VERTEX_SHADER	= 2,
+	_DXGK_RENDER_PIPELINE_STAGE_GEOMETRY_SHADER	= 3,
+	_DXGK_RENDER_PIPELINE_STAGE_STREAM_OUTPUT	= 4,
+	_DXGK_RENDER_PIPELINE_STAGE_RASTERIZER		= 5,
+	_DXGK_RENDER_PIPELINE_STAGE_PIXEL_SHADER	= 6,
+	_DXGK_RENDER_PIPELINE_STAGE_OUTPUT_MERGER	= 7,
+};
+
+enum dxgk_page_fault_flags {
+	_DXGK_PAGE_FAULT_WRITE			= 0x1,
+	_DXGK_PAGE_FAULT_FENCE_INVALID		= 0x2,
+	_DXGK_PAGE_FAULT_ADAPTER_RESET_REQUIRED	= 0x4,
+	_DXGK_PAGE_FAULT_ENGINE_RESET_REQUIRED	= 0x8,
+	_DXGK_PAGE_FAULT_FATAL_HARDWARE_ERROR	= 0x10,
+	_DXGK_PAGE_FAULT_IOMMU			= 0x20,
+	_DXGK_PAGE_FAULT_HW_CONTEXT_VALID	= 0x40,
+	_DXGK_PAGE_FAULT_PROCESS_HANDLE_VALID	= 0x80,
+};
+
+enum dxgk_general_error_code {
+	_DXGK_GENERAL_ERROR_PAGE_FAULT		= 0,
+	_DXGK_GENERAL_ERROR_INVALID_INSTRUCTION	= 1,
+};
+
+struct dxgk_fault_error_code {
+	union {
+		struct {
+			__u32	is_device_specific_code:1;
+			enum dxgk_general_error_code general_error_code:31;
+		};
+		struct {
+			__u32	is_device_specific_code_reserved_bit:1;
+			__u32	device_specific_code:31;
+		};
+	};
+};
+
+struct d3dkmt_devicereset_state {
+	union {
+		struct {
+			__u32	desktop_switched:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_devicepagefault_state {
+	__u64				faulted_primitive_api_sequence_number;
+	enum dxgk_render_pipeline_stage	faulted_pipeline_stage;
+	__u32				faulted_bind_table_entry;
+	enum dxgk_page_fault_flags	page_fault_flags;
+	struct dxgk_fault_error_code	fault_error_code;
+	__u64				faulted_virtual_address;
+};
+
+enum d3dkmt_deviceexecution_state {
+	_D3DKMT_DEVICEEXECUTION_ACTIVE			= 1,
+	_D3DKMT_DEVICEEXECUTION_RESET			= 2,
+	_D3DKMT_DEVICEEXECUTION_HUNG			= 3,
+	_D3DKMT_DEVICEEXECUTION_STOPPED			= 4,
+	_D3DKMT_DEVICEEXECUTION_ERROR_OUTOFMEMORY	= 5,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAFAULT		= 6,
+	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
+};
+
+enum d3dkmt_devicestate_type {
+	_D3DKMT_DEVICESTATE_EXECUTION		= 1,
+	_D3DKMT_DEVICESTATE_PRESENT		= 2,
+	_D3DKMT_DEVICESTATE_RESET		= 3,
+	_D3DKMT_DEVICESTATE_PRESENT_DWM		= 4,
+	_D3DKMT_DEVICESTATE_PAGE_FAULT		= 5,
+	_D3DKMT_DEVICESTATE_PRESENT_QUEUE	= 6,
+};
+
+struct d3dkmt_getdevicestate {
+	struct d3dkmthandle				device;
+	enum d3dkmt_devicestate_type			state_type;
+	union {
+		enum d3dkmt_deviceexecution_state	execution_state;
+		struct d3dkmt_devicereset_state		reset_state;
+		struct d3dkmt_devicepagefault_state	page_fault_state;
+		char alignment[48];
+	};
+};
+
 enum d3dkmdt_gdisurfacetype {
 	_D3DKMDT_GDISURFACE_INVALID				= 0,
 	_D3DKMDT_GDISURFACE_TEXTURE				= 1,
@@ -755,16 +844,6 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
-enum d3dkmt_deviceexecution_state {
-	_D3DKMT_DEVICEEXECUTION_ACTIVE			= 1,
-	_D3DKMT_DEVICEEXECUTION_RESET			= 2,
-	_D3DKMT_DEVICEEXECUTION_HUNG			= 3,
-	_D3DKMT_DEVICEEXECUTION_STOPPED			= 4,
-	_D3DKMT_DEVICEEXECUTION_ERROR_OUTOFMEMORY	= 5,
-	_D3DKMT_DEVICEEXECUTION_ERROR_DMAFAULT		= 6,
-	_D3DKMT_DEVICEEXECUTION_ERROR_DMAPAGEFAULT	= 7,
-};
-
 struct d3dddi_openallocationinfo2 {
 	struct d3dkmthandle	allocation;
 #ifdef __KERNEL__
@@ -974,6 +1053,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
+#define LX_DXGETDEVICESTATE		\
+	_IOWR(0x47, 0x0e, struct d3dkmt_getdevicestate)
 #define LX_DXSUBMITCOMMAND		\
 	_IOWR(0x47, 0x0f, struct d3dkmt_submitcommand)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
-- 
2.35.1

