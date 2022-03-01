Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592B4C94BF
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiCATrV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiCATrS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346236D1AE;
        Tue,  1 Mar 2022 11:46:33 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B6F620B57C9;
        Tue,  1 Mar 2022 11:46:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B6F620B57C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163992;
        bh=NJ3VofQtiUZhOulGmP4IYBTjJKHu/tYmFgaUEE62hkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cbUPJA0i4oW6y4khIbPza569g6z80n6NvT0Ev/l+bFxs5JCi69JbX5mBvxOaW4Bhh
         HqRl32ZjJzJab+ikY3aDAR/zjh2DBuTMVK0ui0kiK9ZaHC9YhZAVgRUmAEuTmYIQOb
         hInEKTHiw3I7A+IeROw5HIhggBp2fjg6hNmTXCfE=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 11/30] drivers: hv: dxgkrnl: Operations using sync objects
Date:   Tue,  1 Mar 2022 11:45:58 -0800
Message-Id: <70adb776be6864e8c64c86c4198170a55847138a.1646163378.git.iourit@linux.microsoft.com>
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

Implement ioctls to submit operations with compute device
sync objects:
  - the LX_DXSIGNALSYNCHRONIZATIONOBJECT ioctl.
    The ioctl is used to submit a signal to a sync object.
  - the LX_DXWAITFORSYNCHRONIZATIONOBJECT ioctl.
    The ioctl is used to submit a wait for a sync object
  - the LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU ioctl
    The ioctl is used to signal to a monitored fence sync object
    from a CPU thread.
  - the LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU ioctl.
    The ioctl is used to submit a signal to a monitored fence
    sync object..
  - the LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 ioctl.
    The ioctl is used to submit a signal to a monitored fence
    sync object.
  - the LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU ioctl.
    The ioctl is used to submit a wait for a monitored fence
    sync object.

Compute device synchronization objects are used to synchronize
execution of DMA buffers between different execution contexts.
Operations with sync objects include "signal" and "wait". A wait
for a sync object is satisfied when the sync object is signaled.

A signal operation could be submitted to a compute device context or
the sync object could be signaled by a CPU thread.

To improve performance, submitting operations to the host is done
asynchronously when the host supports it.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c |  21 +
 drivers/hv/dxgkrnl/dxgkrnl.h    |  62 +++
 drivers/hv/dxgkrnl/dxgmodule.c  |  97 +++++
 drivers/hv/dxgkrnl/dxgvmbus.c   | 213 ++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h   |  48 +++
 drivers/hv/dxgkrnl/ioctl.c      | 693 ++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/misc.h       |   1 +
 include/uapi/misc/d3dkmthk.h    | 159 ++++++++
 8 files changed, 1294 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 71e3e1ce5c2b..c001f58a30db 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -897,6 +897,12 @@ struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 	case _D3DDDI_PERIODIC_MONITORED_FENCE:
 		syncobj->monitored_fence = 1;
 		break;
+	case _D3DDDI_CPU_NOTIFICATION:
+		syncobj->cpu_event = 1;
+		syncobj->host_event = vzalloc(sizeof(struct dxghostevent));
+		if (syncobj->host_event == NULL)
+			goto cleanup;
+		break;
 	default:
 		break;
 	}
@@ -924,6 +930,8 @@ struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 	pr_debug("%s 0x%p\n", __func__, syncobj);
 	return syncobj;
 cleanup:
+	if (syncobj->host_event)
+		vfree(syncobj->host_event);
 	if (syncobj)
 		vfree(syncobj);
 	return NULL;
@@ -933,6 +941,7 @@ void dxgsyncobject_destroy(struct dxgprocess *process,
 			   struct dxgsyncobject *syncobj)
 {
 	int destroyed;
+	struct dxghosteventcpu *host_event;
 
 	pr_debug("%s 0x%p", __func__, syncobj);
 
@@ -951,6 +960,16 @@ void dxgsyncobject_destroy(struct dxgprocess *process,
 		}
 		hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
 
+		if (syncobj->cpu_event) {
+			host_event = syncobj->host_event;
+			if (host_event->cpu_event) {
+				eventfd_ctx_put(host_event->cpu_event);
+				if (host_event->hdr.event_id)
+					dxgglobal_remove_host_event(
+						&host_event->hdr);
+				host_event->cpu_event = NULL;
+			}
+		}
 		if (syncobj->monitored_fence)
 			dxgdevice_remove_syncobj(syncobj);
 		else
@@ -990,5 +1009,7 @@ void dxgsyncobject_release(struct kref *refcount)
 	struct dxgsyncobject *syncobj;
 
 	syncobj = container_of(refcount, struct dxgsyncobject, syncobj_kref);
+	if (syncobj->host_event)
+		vfree(syncobj->host_event);
 	vfree(syncobj);
 }
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index f0b0e1bdd897..cb9096bd7a12 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -86,6 +86,29 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev);
 void dxgvmbuschannel_destroy(struct dxgvmbuschannel *ch);
 void dxgvmbuschannel_receive(void *ctx);
 
+/*
+ * The structure describes an event, which will be signaled by
+ * a message from host.
+ */
+enum dxghosteventtype {
+	dxghostevent_cpu_event = 1,
+};
+
+struct dxghostevent {
+	struct list_head	host_event_list_entry;
+	u64			event_id;
+	enum dxghosteventtype	event_type;
+};
+
+struct dxghosteventcpu {
+	struct dxghostevent	hdr;
+	struct dxgprocess	*process;
+	struct eventfd_ctx	*cpu_event;
+	struct completion	*completion_event;
+	bool			destroy_after_signal;
+	bool			remove_from_list;
+};
+
 /*
  * This is GPU synchronization object, which is used to synchronize execution
  * between GPU contextx/hardware queues or for tracking GPU execution progress.
@@ -115,6 +138,8 @@ struct dxgsyncobject {
 	 */
 	struct dxgdevice		*device;
 	struct dxgprocess		*process;
+	/* Used by D3DDDI_CPU_NOTIFICATION objects */
+	struct dxghosteventcpu		*host_event;
 	/* CPU virtual address of the fence value for "device" syncobjects */
 	void				*mapped_address;
 	/* Handle in the process handle table */
@@ -129,6 +154,7 @@ struct dxgsyncobject {
 			u32		stopped:1;
 			/* device syncobject */
 			u32		monitored_fence:1;
+			u32		cpu_event:1;
 			u32		shared:1;
 			u32		reserved:27;
 		};
@@ -195,6 +221,11 @@ struct dxgglobal {
 	/* protects the dxgprocess_adapter lists */
 	struct mutex		process_adapter_mutex;
 
+	/*  list of events, waiting to be signaled by the host */
+	struct list_head	host_event_list_head;
+	spinlock_t		host_event_list_mutex;
+	atomic64_t		host_event_id;
+
 	bool			dxg_dev_initialized;
 	bool			vmbus_registered;
 	bool			pci_registered;
@@ -214,6 +245,11 @@ struct vmbus_channel *dxgglobal_get_vmbus(void);
 struct dxgvmbuschannel *dxgglobal_get_dxgvmbuschannel(void);
 void dxgglobal_acquire_process_adapter_lock(void);
 void dxgglobal_release_process_adapter_lock(void);
+void dxgglobal_add_host_event(struct dxghostevent *hostevent);
+void dxgglobal_remove_host_event(struct dxghostevent *hostevent);
+u64 dxgglobal_new_host_event_id(void);
+void dxgglobal_signal_host_event(u64 event_id);
+struct dxghostevent *dxgglobal_get_host_event(u64 event_id);
 int dxgglobal_acquire_channel_lock(void);
 void dxgglobal_release_channel_lock(void);
 
@@ -574,6 +610,31 @@ int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   *args, struct dxgsyncobject *so);
 int dxgvmb_send_destroy_sync_object(struct dxgprocess *pr,
 				    struct d3dkmthandle h);
+int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
+				   struct dxgadapter *adapter,
+				   struct d3dddicb_signalflags flags,
+				   u64 legacy_fence_value,
+				   struct d3dkmthandle context,
+				   u32 object_count,
+				   struct d3dkmthandle *object,
+				   u32 context_count,
+				   struct d3dkmthandle *contexts,
+				   u32 fence_count, u64 *fences,
+				   struct eventfd_ctx *cpu_event,
+				   struct d3dkmthandle device);
+int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle context,
+				     u32 object_count,
+				     struct d3dkmthandle *objects,
+				     u64 *fences,
+				     bool legacy_fence);
+int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct
+				     d3dkmt_waitforsynchronizationobjectfromcpu
+				     *args,
+				     u64 cpu_event);
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args);
@@ -589,6 +650,7 @@ int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
 
+void signal_host_cpu_event(struct dxghostevent *eventhdr);
 int ntstatus2int(struct ntstatus status);
 
 #endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index d64504a1cff0..80af0de4aa37 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -124,6 +124,98 @@ static struct dxgadapter *find_adapter(struct winluid *luid)
 	return adapter;
 }
 
+void dxgglobal_add_host_event(struct dxghostevent *event)
+{
+	spin_lock_irq(&dxgglobal->host_event_list_mutex);
+	list_add_tail(&event->host_event_list_entry,
+		      &dxgglobal->host_event_list_head);
+	spin_unlock_irq(&dxgglobal->host_event_list_mutex);
+}
+
+void dxgglobal_remove_host_event(struct dxghostevent *event)
+{
+	spin_lock_irq(&dxgglobal->host_event_list_mutex);
+	if (event->host_event_list_entry.next != NULL) {
+		list_del(&event->host_event_list_entry);
+		event->host_event_list_entry.next = NULL;
+	}
+	spin_unlock_irq(&dxgglobal->host_event_list_mutex);
+}
+
+void signal_host_cpu_event(struct dxghostevent *eventhdr)
+{
+	struct  dxghosteventcpu *event = (struct  dxghosteventcpu *)eventhdr;
+
+	if (event->remove_from_list ||
+		event->destroy_after_signal) {
+		list_del(&eventhdr->host_event_list_entry);
+		eventhdr->host_event_list_entry.next = NULL;
+	}
+	if (event->cpu_event) {
+		pr_debug("signal cpu event\n");
+		eventfd_signal(event->cpu_event, 1);
+		if (event->destroy_after_signal)
+			eventfd_ctx_put(event->cpu_event);
+	} else {
+		pr_debug("signal completion\n");
+		complete(event->completion_event);
+	}
+	if (event->destroy_after_signal) {
+		pr_debug("destroying event %p\n",
+			event);
+		vfree(event);
+	}
+}
+
+void dxgglobal_signal_host_event(u64 event_id)
+{
+	struct dxghostevent *event;
+	unsigned long flags;
+
+	pr_debug("%s %lld\n", __func__, event_id);
+
+	spin_lock_irqsave(&dxgglobal->host_event_list_mutex, flags);
+	list_for_each_entry(event, &dxgglobal->host_event_list_head,
+			    host_event_list_entry) {
+		if (event->event_id == event_id) {
+			pr_debug("found event to signal %lld\n",
+				    event_id);
+			if (event->event_type == dxghostevent_cpu_event)
+				signal_host_cpu_event(event);
+			else
+				pr_err("Unknown host event type");
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&dxgglobal->host_event_list_mutex, flags);
+	pr_debug("dxgglobal_signal_host_event_end %lld\n",
+		event_id);
+}
+
+struct dxghostevent *dxgglobal_get_host_event(u64 event_id)
+{
+	struct dxghostevent *entry;
+	struct dxghostevent *event = NULL;
+
+	spin_lock_irq(&dxgglobal->host_event_list_mutex);
+	list_for_each_entry(entry, &dxgglobal->host_event_list_head,
+			    host_event_list_entry) {
+		if (entry->event_id == event_id) {
+			list_del(&entry->host_event_list_entry);
+			entry->host_event_list_entry.next = NULL;
+			event = entry;
+			break;
+		}
+	}
+	spin_unlock_irq(&dxgglobal->host_event_list_mutex);
+	return event;
+}
+
+u64 dxgglobal_new_host_event_id(void)
+{
+	return atomic64_inc_return(&dxgglobal->host_event_id);
+}
+
 void dxgglobal_acquire_process_adapter_lock(void)
 {
 	mutex_lock(&dxgglobal->process_adapter_mutex);
@@ -745,6 +837,11 @@ static int dxgglobal_create(void)
 
 	init_rwsem(&dxgglobal->channel_lock);
 
+	INIT_LIST_HEAD(&dxgglobal->host_event_list_head);
+	spin_lock_init(&dxgglobal->host_event_list_mutex);
+	atomic64_set(&dxgglobal->host_event_id, 1);
+
+	pr_debug("dxgglobal_init end\n");
 	pr_debug("dxgglobal_init end\n");
 	return ret;
 }
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 067a60319a12..a6979b4ae955 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -276,6 +276,22 @@ static void command_vm_to_host_init1(struct dxgkvmb_command_vm_to_host *command,
 	command->channel_type = DXGKVMB_VM_TO_HOST;
 }
 
+static void signal_guest_event(struct dxgkvmb_command_host_to_vm *packet,
+			       u32 packet_length)
+{
+	struct dxgkvmb_command_signalguestevent *command = (void *)packet;
+
+	if (packet_length < sizeof(struct dxgkvmb_command_signalguestevent)) {
+		pr_err("invalid packet size");
+		return;
+	}
+	if (command->event == 0) {
+		pr_err("invalid event pointer");
+		return;
+	}
+	dxgglobal_signal_host_event(command->event);
+}
+
 static void process_inband_packet(struct dxgvmbuschannel *channel,
 				  struct vmpacket_descriptor *desc)
 {
@@ -292,6 +308,7 @@ static void process_inband_packet(struct dxgvmbuschannel *channel,
 			switch (packet->command_type) {
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENT:
 			case DXGK_VMBCOMMAND_SIGNALGUESTEVENTPASSIVE:
+				signal_guest_event(packet, packet_length);
 				break;
 			case DXGK_VMBCOMMAND_SENDWNFNOTIFICATION:
 				break;
@@ -1691,6 +1708,202 @@ dxgvmb_send_create_sync_object(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
+				   struct dxgadapter *adapter,
+				   struct d3dddicb_signalflags flags,
+				   u64 legacy_fence_value,
+				   struct d3dkmthandle context,
+				   u32 object_count,
+				   struct d3dkmthandle __user *objects,
+				   u32 context_count,
+				   struct d3dkmthandle __user *contexts,
+				   u32 fence_count,
+				   u64 __user *fences,
+				   struct eventfd_ctx *cpu_event_handle,
+				   struct d3dkmthandle device)
+{
+	int ret;
+	struct dxgkvmb_command_signalsyncobject *command;
+	u32 object_size = object_count * sizeof(struct d3dkmthandle);
+	u32 context_size = context_count * sizeof(struct d3dkmthandle);
+	u32 fence_size = fences ? fence_count * sizeof(u64) : 0;
+	u8 *current_pos;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_signalsyncobject) +
+	    object_size + context_size + fence_size;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (context.v)
+		cmd_size += sizeof(struct d3dkmthandle);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SIGNALSYNCOBJECT,
+				   process->host_handle);
+
+	if (flags.enqueue_cpu_event)
+		command->cpu_event_handle = (u64) cpu_event_handle;
+	else
+		command->device = device;
+	command->flags = flags;
+	command->fence_value = legacy_fence_value;
+	command->object_count = object_count;
+	command->context_count = context_count;
+	current_pos = (u8 *) &command[1];
+	ret = copy_from_user(current_pos, objects, object_size);
+	if (ret) {
+		pr_err("Failed to read objects %p %d",
+			objects, object_size);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	current_pos += object_size;
+	if (context.v) {
+		command->context_count++;
+		*(struct d3dkmthandle *) current_pos = context;
+		current_pos += sizeof(struct d3dkmthandle);
+	}
+	if (context_size) {
+		ret = copy_from_user(current_pos, contexts, context_size);
+		if (ret) {
+			pr_err("Failed to read contexts %p %d",
+				contexts, context_size);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		current_pos += context_size;
+	}
+	if (fence_size) {
+		ret = copy_from_user(current_pos, fences, fence_size);
+		if (ret) {
+			pr_err("Failed to read fences %p %d",
+				fences, fence_size);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct
+				     d3dkmt_waitforsynchronizationobjectfromcpu
+				     *args,
+				     u64 cpu_event)
+{
+	int ret = -EINVAL;
+	struct dxgkvmb_command_waitforsyncobjectfromcpu *command;
+	u32 object_size = args->object_count * sizeof(struct d3dkmthandle);
+	u32 fence_size = args->object_count * sizeof(u64);
+	u8 *current_pos;
+	u32 cmd_size = sizeof(*command) + object_size + fence_size;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU,
+				   process->host_handle);
+	command->device = args->device;
+	command->flags = args->flags;
+	command->object_count = args->object_count;
+	command->guest_event_pointer = (u64) cpu_event;
+	current_pos = (u8 *) &command[1];
+	ret = copy_from_user(current_pos, args->objects, object_size);
+	if (ret) {
+		pr_err("%s failed to copy objects", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	current_pos += object_size;
+	ret = copy_from_user(current_pos, args->fence_values, fence_size);
+	if (ret) {
+		pr_err("%s failed to copy fences", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmthandle context,
+				     u32 object_count,
+				     struct d3dkmthandle *objects,
+				     u64 *fences,
+				     bool legacy_fence)
+{
+	int ret;
+	struct dxgkvmb_command_waitforsyncobjectfromgpu *command;
+	u32 fence_size = object_count * sizeof(u64);
+	u32 object_size = object_count * sizeof(struct d3dkmthandle);
+	u8 *current_pos;
+	u32 cmd_size = object_size + fence_size - sizeof(u64) +
+	    sizeof(struct dxgkvmb_command_waitforsyncobjectfromgpu);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (object_count == 0 || object_count > D3DDDI_MAX_OBJECT_WAITED_ON) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU,
+				   process->host_handle);
+	command->context = context;
+	command->object_count = object_count;
+	command->legacy_fence_object = legacy_fence;
+	current_pos = (u8 *) command->fence_values;
+	memcpy(current_pos, fences, fence_size);
+	current_pos += fence_size;
+	memcpy(current_pos, objects, object_size);
+
+	if (dxgglobal->async_msg_enabled) {
+		command->hdr.async_msg = 1;
+		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
+	} else {
+		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
+						    msg.size);
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_queryadapterinfo *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a2cfdb832664..da63f89ad822 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -165,6 +165,13 @@ struct dxgkvmb_command_host_to_vm {
 	enum dxgkvmb_commandtype_host_to_vm	command_type;
 };
 
+struct dxgkvmb_command_signalguestevent {
+	struct dxgkvmb_command_host_to_vm hdr;
+	u64				event;
+	u64				process_id;
+	bool				dereference_event;
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_setiospaceregion {
 	struct dxgkvmb_command_vm_to_host hdr;
@@ -430,4 +437,45 @@ struct dxgkvmb_command_destroysyncobject {
 	struct d3dkmthandle	sync_object;
 };
 
+/* The command returns ntstatus */
+struct dxgkvmb_command_signalsyncobject {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u32				object_count;
+	struct d3dddicb_signalflags	flags;
+	u32				context_count;
+	u64				fence_value;
+	union {
+		/* Pointer to the guest event object */
+		u64			cpu_event_handle;
+		/* Non zero when signal from CPU is done */
+		struct d3dkmthandle		device;
+	};
+	/* struct d3dkmthandle ObjectHandleArray[object_count] */
+	/* struct d3dkmthandle ContextArray[context_count]     */
+	/* u64 MonitoredFenceValueArray[object_count] */
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_waitforsyncobjectfromcpu {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	u32				object_count;
+	struct d3dddi_waitforsynchronizationobjectfromcpu_flags flags;
+	u64				guest_event_pointer;
+	bool				dereference_event;
+	/* struct d3dkmthandle ObjectHandleArray[object_count] */
+	/* u64 FenceValueArray [object_count] */
+};
+
+/* The command returns ntstatus */
+struct dxgkvmb_command_waitforsyncobjectfromgpu {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		context;
+	/* Must be 1 when bLegacyFenceObject is TRUE */
+	u32				object_count;
+	bool				legacy_fence_object;
+	u64				fence_values[1];
+	/* struct d3dkmthandle ObjectHandles[object_count] */
+};
+
 #endif /* _DXGVMBUS_H */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index bc1ac2dd302f..b945da0da55a 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1375,8 +1375,10 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	struct d3dkmt_createsynchronizationobject2 args;
 	struct dxgdevice *device = NULL;
 	struct dxgadapter *adapter = NULL;
+	struct eventfd_ctx *event = NULL;
 	struct dxgsyncobject *syncobj = NULL;
 	bool device_lock_acquired = false;
+	struct dxghosteventcpu *host_event = NULL;
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
@@ -1411,6 +1413,27 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 	}
 
+	if (args.info.type == _D3DDDI_CPU_NOTIFICATION) {
+		event = eventfd_ctx_fdget((int)
+					  args.info.cpu_notification.event);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		host_event = syncobj->host_event;
+		host_event->hdr.event_id = dxgglobal_new_host_event_id();
+		host_event->cpu_event = event;
+		host_event->remove_from_list = false;
+		host_event->destroy_after_signal = false;
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&host_event->hdr);
+		args.info.cpu_notification.event = host_event->hdr.event_id;
+		pr_debug("creating CPU notification event: %lld",
+			args.info.cpu_notification.event);
+	}
+
 	ret = dxgvmb_send_create_sync_object(process, adapter, &args, syncobj);
 	if (ret < 0)
 		goto cleanup;
@@ -1438,7 +1461,10 @@ dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 			if (args.sync_object.v)
 				dxgvmb_send_destroy_sync_object(process,
 							args.sync_object);
+			event = NULL;
 		}
+		if (event)
+			eventfd_ctx_put(event);
 	}
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
@@ -1494,6 +1520,659 @@ dxgk_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_signal_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobject2 args;
+	struct d3dkmt_signalsynchronizationobject2 *__user in_args = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+	u32 fence_count = 1;
+	struct eventfd_ctx *event = NULL;
+	struct dxghosteventcpu *host_event = NULL;
+	bool host_event_added = false;
+	u64 host_event_id = 0;
+
+	pr_debug("ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.context_count >= D3DDDI_MAX_BROADCAST_CONTEXT ||
+	    args.object_count > D3DDDI_MAX_OBJECT_SIGNALED) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		host_event = vzalloc(sizeof(*host_event));
+		if (host_event == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.cpu_event_handle);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		fence_count = 0;
+		host_event->cpu_event = event;
+		host_event_id = dxgglobal_new_host_event_id();
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		host_event->hdr.event_id = host_event_id;
+		host_event->remove_from_list = true;
+		host_event->destroy_after_signal = true;
+		dxgglobal_add_host_event(&host_event->hdr);
+		host_event_added = true;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     args.flags, args.fence.fence_value,
+					     args.context, args.object_count,
+					     in_args->object_array,
+					     args.context_count,
+					     in_args->contexts, fence_count,
+					     NULL, (void *)host_event_id,
+					     zerohandle);
+
+	/*
+	 * When the send operation succeeds, the host event will be destroyed
+	 * after signal from the host
+	 */
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_event_added) {
+			/* The event might be signaled and destroyed by host */
+			host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(host_event_id);
+			if (host_event) {
+				eventfd_ctx_put(event);
+				event = NULL;
+				vfree(host_event);
+				host_event = NULL;
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (host_event)
+			vfree(host_event);
+	}
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_signal_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromcpu args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.object_count == 0 ||
+	    args.object_count > D3DDDI_MAX_OBJECT_SIGNALED) {
+		pr_debug("Too many objects: %d",
+			args.object_count);
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
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     args.flags, 0, zerohandle,
+					     args.object_count, args.objects, 0,
+					     NULL, args.object_count,
+					     args.fence_values, NULL,
+					     args.device);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_signal_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromgpu args;
+	struct d3dkmt_signalsynchronizationobjectfromgpu *__user user_args =
+	    inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dddicb_signalflags flags = { };
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count == 0 ||
+	    args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     flags, 0, zerohandle,
+					     args.object_count,
+					     args.objects, 1,
+					     &user_args->context,
+					     args.object_count,
+					     args.monitored_fence_values, NULL,
+					     zerohandle);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_signalsynchronizationobjectfromgpu2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmthandle context_handle;
+	struct eventfd_ctx *event = NULL;
+	u64 *fences = NULL;
+	u32 fence_count = 0;
+	int ret;
+	struct dxghosteventcpu *host_event = NULL;
+	bool host_event_added = false;
+	u64 host_event_id = 0;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		if (args.object_count != 0 || args.cpu_event_handle == 0) {
+			pr_err("Bad input for EnqueueCpuEvent: %d %lld",
+				   args.object_count, args.cpu_event_handle);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else if (args.object_count == 0 ||
+		   args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+		   args.context_count == 0 ||
+		   args.context_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		pr_err("Invalid input: %d %d",
+			   args.object_count, args.context_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(&context_handle, args.contexts,
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy context handle", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.flags.enqueue_cpu_event) {
+		host_event = vzalloc(sizeof(*host_event));
+		if (host_event == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.cpu_event_handle);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		fence_count = 0;
+		host_event->cpu_event = event;
+		host_event_id = dxgglobal_new_host_event_id();
+		host_event->hdr.event_id = host_event_id;
+		host_event->hdr.event_type = dxghostevent_cpu_event;
+		host_event->remove_from_list = true;
+		host_event->destroy_after_signal = true;
+		dxgglobal_add_host_event(&host_event->hdr);
+		host_event_added = true;
+	} else {
+		fences = args.monitored_fence_values;
+		fence_count = args.object_count;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    context_handle);
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
+	ret = dxgvmb_send_signal_sync_object(process, adapter,
+					     args.flags, 0, zerohandle,
+					     args.object_count, args.objects,
+					     args.context_count, args.contexts,
+					     fence_count, fences,
+					     (void *)host_event_id, zerohandle);
+
+cleanup:
+
+	if (ret < 0) {
+		if (host_event_added) {
+			/* The event might be signaled and destroyed by host */
+			host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(host_event_id);
+			if (host_event) {
+				eventfd_ctx_put(event);
+				event = NULL;
+				vfree(host_event);
+				host_event = NULL;
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (host_event)
+			vfree(host_event);
+	}
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_wait_sync_object(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobject2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > D3DDDI_MAX_OBJECT_WAITED_ON ||
+	    args.object_count == 0) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    args.context);
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
+	pr_debug("Fence value: %lld", args.fence.fence_value);
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.context, args.object_count,
+					       args.object_array,
+					       &args.fence.fence_value, true);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobjectfromcpu args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct eventfd_ctx *event = NULL;
+	struct dxghosteventcpu host_event = { };
+	struct dxghosteventcpu *async_host_event = NULL;
+	struct completion local_event = { };
+	u64 event_id = 0;
+	int ret;
+	bool host_event_added = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.object_count == 0) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.async_event) {
+		async_host_event = vzalloc(sizeof(*async_host_event));
+		if (async_host_event == NULL) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		async_host_event->process = process;
+		event = eventfd_ctx_fdget((int)args.async_event);
+		if (IS_ERR(event)) {
+			pr_err("failed to reference the event");
+			event = NULL;
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		async_host_event->cpu_event = event;
+		async_host_event->hdr.event_id = dxgglobal_new_host_event_id();
+		async_host_event->destroy_after_signal = true;
+		async_host_event->hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&async_host_event->hdr);
+		event_id = async_host_event->hdr.event_id;
+		host_event_added = true;
+	} else {
+		init_completion(&local_event);
+		host_event.completion_event = &local_event;
+		host_event.hdr.event_id = dxgglobal_new_host_event_id();
+		host_event.hdr.event_type = dxghostevent_cpu_event;
+		dxgglobal_add_host_event(&host_event.hdr);
+		event_id = host_event.hdr.event_id;
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
+	ret = dxgvmb_send_wait_sync_object_cpu(process, adapter,
+					       &args, event_id);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args.async_event == 0) {
+		dxgadapter_release_lock_shared(adapter);
+		adapter = NULL;
+		ret = wait_for_completion_interruptible(&local_event);
+		if (ret) {
+			pr_err("%s: wait_completion_interruptible failed: %d",
+			       __func__, ret);
+			ret = -ERESTARTSYS;
+		}
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (host_event.hdr.event_id)
+		dxgglobal_remove_host_event(&host_event.hdr);
+	if (ret < 0) {
+		if (host_event_added) {
+			async_host_event = (struct dxghosteventcpu *)
+				dxgglobal_get_host_event(event_id);
+			if (async_host_event) {
+				if (async_host_event->hdr.event_type ==
+				    dxghostevent_cpu_event) {
+					eventfd_ctx_put(event);
+					event = NULL;
+					vfree(async_host_event);
+					async_host_event = NULL;
+				} else {
+					pr_err("Invalid event type");
+					DXGKRNL_ASSERT(0);
+				}
+			}
+		}
+		if (event)
+			eventfd_ctx_put(event);
+		if (async_host_event)
+			vfree(async_host_event);
+	}
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_waitforsynchronizationobjectfromgpu args;
+	struct dxgcontext *context = NULL;
+	struct d3dkmthandle device_handle = {};
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct dxgsyncobject *syncobj = NULL;
+	struct d3dkmthandle *objects = NULL;
+	u32 object_size;
+	u64 *fences = NULL;
+	int ret;
+	enum hmgrentry_type syncobj_type = HMGRENTRY_TYPE_FREE;
+	bool monitored_fence = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.object_count > DXG_MAX_VM_BUS_PACKET_SIZE ||
+	    args.object_count == 0) {
+		pr_err("Invalid object count: %d", args.object_count);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	object_size = sizeof(struct d3dkmthandle) * args.object_count;
+	objects = vzalloc(object_size);
+	if (objects == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	ret = copy_from_user(objects, args.objects, object_size);
+	if (ret) {
+		pr_err("%s failed to copy objects", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_SHARED);
+	context = hmgrtable_get_object_by_type(&process->handle_table,
+					       HMGRENTRY_TYPE_DXGCONTEXT,
+					       args.context);
+	if (context) {
+		device_handle = context->device_handle;
+		syncobj_type =
+		    hmgrtable_get_object_type(&process->handle_table,
+					      objects[0]);
+	}
+	if (device_handle.v == 0) {
+		pr_err("Invalid context handle: %x", args.context.v);
+		ret = -EINVAL;
+	} else {
+		if (syncobj_type == HMGRENTRY_TYPE_MONITOREDFENCE) {
+			monitored_fence = true;
+		} else if (syncobj_type == HMGRENTRY_TYPE_DXGSYNCOBJECT) {
+			syncobj =
+			    hmgrtable_get_object_by_type(&process->handle_table,
+						HMGRENTRY_TYPE_DXGSYNCOBJECT,
+						objects[0]);
+			if (syncobj == NULL) {
+				pr_err("Invalid syncobj: %x", objects[0].v);
+				ret = -EINVAL;
+			} else {
+				monitored_fence = syncobj->monitored_fence;
+			}
+		} else {
+			pr_err("Invalid syncobj type: %x", objects[0].v);
+			ret = -EINVAL;
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_SHARED);
+
+	if (ret < 0)
+		goto cleanup;
+
+	if (monitored_fence) {
+		object_size = sizeof(u64) * args.object_count;
+		fences = vzalloc(object_size);
+		if (fences == NULL) {
+			ret = -ENOMEM;
+			goto cleanup;
+		}
+		ret = copy_from_user(fences, args.monitored_fence_values,
+				     object_size);
+		if (ret) {
+			pr_err("%s failed to copy fences", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		fences = &args.fence_value;
+	}
+
+	device = dxgprocess_device_by_handle(process, device_handle);
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
+	ret = dxgvmb_send_wait_sync_object_gpu(process, adapter,
+					       args.context, args.object_count,
+					       objects, fences,
+					       !monitored_fence);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	if (objects)
+		vfree(objects);
+	if (fences && fences != &args.fence_value)
+		vfree(fences);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 /*
  * IOCTL processing
  * The driver IOCTLs return
@@ -1564,6 +2243,10 @@ void init_ioctls(void)
 		  LX_DXQUERYADAPTERINFO);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
 		  LX_DXCREATESYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x11 */ dxgk_signal_sync_object,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x12 */ dxgk_wait_sync_object,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECT);
 	SET_IOCTL(/*0x13 */ dxgk_destroy_allocation,
 		  LX_DXDESTROYALLOCATION2);
 	SET_IOCTL(/*0x14 */ dxgk_enum_adapters,
@@ -1574,6 +2257,16 @@ void init_ioctls(void)
 		  LX_DXDESTROYDEVICE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
+	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU);
+	SET_IOCTL(/*0x33 */ dxgk_signal_sync_object_gpu2,
+		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2);
+	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
+	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
+		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 }
diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
index 41abdc504bc2..f56d21b48814 100644
--- a/drivers/hv/dxgkrnl/misc.h
+++ b/drivers/hv/dxgkrnl/misc.h
@@ -26,6 +26,7 @@ extern const struct d3dkmthandle zerohandle;
  * When a lower lock ois held, the higher lock should not be acquired.
  *
  * device_list_mutex
+ * host_event_list_mutex
  * channel_lock
  * fd_mutex
  * plistmutex
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 52d54aa9266e..13bc3adf0abb 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -56,6 +56,9 @@ struct winluid {
 
 #define D3DKMT_CREATEALLOCATION_MAX		1024
 #define D3DKMT_ADAPTERS_MAX			64
+#define D3DDDI_MAX_BROADCAST_CONTEXT		64
+#define D3DDDI_MAX_OBJECT_WAITED_ON		32
+#define D3DDDI_MAX_OBJECT_SIGNALED		32
 
 struct d3dkmt_adapterinfo {
 	struct d3dkmthandle		adapter_handle;
@@ -339,6 +342,148 @@ struct d3dkmt_createsynchronizationobject2 {
 	__u32						reserved1;
 };
 
+struct d3dkmt_waitforsynchronizationobject2 {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+	struct d3dkmthandle	object_array[D3DDDI_MAX_OBJECT_WAITED_ON];
+	union {
+		struct {
+			__u64	fence_value;
+		} fence;
+		__u64		reserved[8];
+	};
+};
+
+struct d3dddicb_signalflags {
+	union {
+		struct {
+			__u32	signal_at_submission:1;
+			__u32	enqueue_cpu_event:1;
+			__u32	allow_fence_rewind:1;
+			__u32	reserved:28;
+			__u32	DXGK_SIGNAL_FLAG_INTERNAL0:1;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_signalsynchronizationobject2 {
+	struct d3dkmthandle		context;
+	__u32				object_count;
+	struct d3dkmthandle	object_array[D3DDDI_MAX_OBJECT_SIGNALED];
+	struct d3dddicb_signalflags	flags;
+	__u32				context_count;
+	struct d3dkmthandle		contexts[D3DDDI_MAX_BROADCAST_CONTEXT];
+	union {
+		struct {
+			__u64		fence_value;
+		} fence;
+		__u64			cpu_event_handle;
+		__u64			reserved[8];
+	};
+};
+
+struct d3dddi_waitforsynchronizationobjectfromcpu_flags {
+	union {
+		struct {
+			__u32	wait_any:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_waitforsynchronizationobjectfromcpu {
+	struct d3dkmthandle	device;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+	__u64			async_event;
+	struct d3dddi_waitforsynchronizationobjectfromcpu_flags flags;
+};
+
+struct d3dkmt_signalsynchronizationobjectfromcpu {
+	struct d3dkmthandle	device;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+	__u64			*fence_values;
+#else
+	__u64			objects;
+	__u64			fence_values;
+#endif
+	struct d3dddicb_signalflags	flags;
+};
+
+struct d3dkmt_waitforsynchronizationobjectfromgpu {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+#else
+	__u64			objects;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u64		*monitored_fence_values;
+#else
+		__u64		monitored_fence_values;
+#endif
+		__u64		fence_value;
+		__u64		reserved[8];
+	};
+};
+
+struct d3dkmt_signalsynchronizationobjectfromgpu {
+	struct d3dkmthandle	context;
+	__u32			object_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*objects;
+#else
+	__u64			objects;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u64		*monitored_fence_values;
+#else
+		__u64		monitored_fence_values;
+#endif
+		__u64		reserved[8];
+	};
+};
+
+struct d3dkmt_signalsynchronizationobjectfromgpu2 {
+	__u32				object_count;
+	__u32				reserved1;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*objects;
+#else
+	__u64				objects;
+#endif
+	struct d3dddicb_signalflags	flags;
+	__u32				context_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*contexts;
+#else
+	__u64				contexts;
+#endif
+	union {
+		__u64			fence_value;
+		__u64			cpu_event_handle;
+#ifdef __KERNEL__
+		__u64			*monitored_fence_values;
+#else
+		__u64			monitored_fence_values;
+#endif
+		__u64			reserved[8];
+	};
+};
+
 struct d3dkmt_destroysynchronizationobject {
 	struct d3dkmthandle	sync_object;
 };
@@ -572,6 +717,10 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXCREATESYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x10, struct d3dkmt_createsynchronizationobject2)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x11, struct d3dkmt_signalsynchronizationobject2)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECT \
+	_IOWR(0x47, 0x12, struct d3dkmt_waitforsynchronizationobject2)
 #define LX_DXDESTROYALLOCATION2		\
 	_IOWR(0x47, 0x13, struct d3dkmt_destroyallocation2)
 #define LX_DXENUMADAPTERS2		\
@@ -582,6 +731,16 @@ struct d3dkmt_enumadapters3 {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
+	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
+	_IOWR(0x47, 0x32, struct d3dkmt_signalsynchronizationobjectfromgpu)
+#define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU2 \
+	_IOWR(0x47, 0x33, struct d3dkmt_signalsynchronizationobjectfromgpu2)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
+	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
+#define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
+	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 
-- 
2.35.1

