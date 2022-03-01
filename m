Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39B4C94F2
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 20:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiCATre (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 14:47:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiCATr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 14:47:27 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F31636D4EA;
        Tue,  1 Mar 2022 11:46:36 -0800 (PST)
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id AA68620B4781;
        Tue,  1 Mar 2022 11:46:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AA68620B4781
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646163994;
        bh=vSdilctjvzMP2UO0svH8FWS2bPgNvVPAHXXm5dst5Mo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r4LXw/Z+qRBNJYkVjrl8WRPBTBoi23GDer5kp9ie/vZ5zbRoGdmelu+fe4gsBbILc
         8NvSSIAOS0P9PV8G8bHZXqne1hlDhRqmTQpZFcvnfL0p+C5Hugw6M/gE6d3OB/BOzx
         KDgJ4EVK8FvqkXnXgIR+CjYp00jVJQme6gRA9zwA=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: [PATCH v3 25/30] drivers: hv: dxgkrnl: Ioctls to query statistics and clock calibration
Date:   Tue,  1 Mar 2022 11:46:12 -0800
Message-Id: <c4ab564c260dc6ed73b89ae2981ff27a70c09556.1646163379.git.iourit@linux.microsoft.com>
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

Implement ioctls to query statistics from the VGPU device
(LX_DXQUERYSTATISTICS) and to query clock calibration
(LX_DXQUERYCLOCKCALIBRATION).

The LX_DXQUERYSTATISTICS ioctl is used to query various statistics from
the compute device on the host.

The LX_DXQUERYCLOCKCALIBRATION ioctl queries the compute device clock
and is used for performance monitoring.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 +++
 drivers/hv/dxgkrnl/dxgvmbus.c |  77 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  21 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 112 ++++++++++++++++++++++++++++++++++
 include/uapi/misc/d3dkmthk.h  |  62 +++++++++++++++++++
 5 files changed, 280 insertions(+)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 03acf8ce3baa..f1b3fa3214dc 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -865,6 +865,11 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_submitcommandtohwqueue *a);
+int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_queryclockcalibration *a,
+					struct d3dkmt_queryclockcalibration
+					*__user inargs);
 int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_flushheaptransitions *arg);
@@ -909,6 +914,9 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  void *prive_alloc_data,
 				  u32 *res_priv_data_size,
 				  void *priv_res_data);
+int dxgvmb_send_query_statistics(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_querystatistics *args);
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
 			  void *command,
 			  u32 cmd_size);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index bf65599635c6..04173dfe26a3 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1812,6 +1812,48 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_queryclockcalibration
+					*args,
+					struct d3dkmt_queryclockcalibration
+					*__user inargs)
+{
+	struct dxgkvmb_command_queryclockcalibration *command;
+	struct dxgkvmb_command_queryclockcalibration_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYCLOCKCALIBRATION,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(&inargs->clock_data, &result.clock_data,
+			   sizeof(result.clock_data));
+	if (ret) {
+		pr_err("%s failed to copy clock data", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = ntstatus2int(result.status);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_flushheaptransitions *args)
@@ -3215,3 +3257,38 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_query_statistics(struct dxgprocess *process,
+				 struct dxgadapter *adapter,
+				 struct d3dkmt_querystatistics *args)
+{
+	struct dxgkvmb_command_querystatistics *command;
+	struct dxgkvmb_command_querystatistics_return *result;
+	int ret;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+			       sizeof(*result));
+	if (ret)
+		goto cleanup;
+	command = msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYSTATISTICS,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	args->result = result->result;
+	ret = ntstatus2int(result->status);
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 615a163f836e..6c8ed5d547a5 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -372,6 +372,16 @@ struct dxgkvmb_command_flushheaptransitions {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 };
 
+struct dxgkvmb_command_queryclockcalibration {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_queryclockcalibration args;
+};
+
+struct dxgkvmb_command_queryclockcalibration_return {
+	struct ntstatus			status;
+	struct dxgk_gpuclockdata	clock_data;
+};
+
 struct dxgkvmb_command_createallocation_allocinfo {
 	u32				flags;
 	u32				priv_drv_data_size;
@@ -408,6 +418,17 @@ struct dxgkvmb_command_openresource_return {
 /* struct d3dkmthandle   allocation[allocation_count]; */
 };
 
+struct dxgkvmb_command_querystatistics {
+	struct dxgkvmb_command_vgpu_to_host	hdr;
+	struct d3dkmt_querystatistics		args;
+};
+
+struct dxgkvmb_command_querystatistics_return {
+	struct ntstatus				status;
+	u32					reserved;
+	struct d3dkmt_querystatistics_result	result;
+};
+
 struct dxgkvmb_command_getstandardallocprivdata {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	enum d3dkmdt_standardallocationtype alloc_type;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index b2cc2c6fc725..4bff78c7b1d3 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -153,6 +153,66 @@ static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgk_query_statistics(struct dxgprocess *process,
+				 void __user *inargs)
+{
+	struct d3dkmt_querystatistics *args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct winluid tmp;
+
+	pr_debug("ioctl: %s", __func__);
+
+	args = vzalloc(sizeof(struct d3dkmt_querystatistics));
+	if (args == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(args, inargs, sizeof(*args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
+	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
+			    adapter_list_entry) {
+		if (dxgadapter_acquire_lock_shared(entry) == 0) {
+			if (*(u64 *) &entry->luid ==
+			    *(u64 *) &args->adapter_luid) {
+				adapter = entry;
+				break;
+			}
+			dxgadapter_release_lock_shared(entry);
+		}
+	}
+	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
+	if (adapter) {
+		tmp = args->adapter_luid;
+		args->adapter_luid = adapter->host_adapter_luid;
+		ret = dxgvmb_send_query_statistics(process, adapter, args);
+		if (ret >= 0) {
+			args->adapter_luid = tmp;
+			ret = copy_to_user(inargs, args, sizeof(*args));
+			if (ret) {
+				pr_err("%s failed to copy args", __func__);
+				ret = -EINVAL;
+			}
+		}
+		dxgadapter_release_lock_shared(adapter);
+	}
+
+cleanup:
+	if (args)
+		vfree(args);
+
+	pr_debug("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgkp_enum_adapters(struct dxgprocess *process,
 		    union d3dkmt_enumadapters_filter filter,
@@ -3576,6 +3636,54 @@ dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryclockcalibration args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	adapter_locked = true;
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_query_clock_calibration(process, adapter,
+						  &args, inargs);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	return ret;
+}
+
 static int
 dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 {
@@ -4580,6 +4688,8 @@ void init_ioctls(void)
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
 	SET_IOCTL(/*0x3c */ dxgk_get_allocation_priority,
 		  LX_DXGETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x3d */ dxgk_query_clock_calibration,
+		  LX_DXQUERYCLOCKCALIBRATION);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 	SET_IOCTL(/*0x3f */ dxgk_share_objects,
@@ -4590,6 +4700,8 @@ void init_ioctls(void)
 		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
 	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
 		  LX_DXOPENRESOURCEFROMNTHANDLE);
+	SET_IOCTL(/*0x43 */ dxgk_query_statistics,
+		  LX_DXQUERYSTATISTICS);
 	SET_IOCTL(/*0x44 */ dxgk_share_object_with_host,
 		  LX_DXSHAREOBJECTWITHHOST);
 }
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index fb4ff4b905c4..2cd88a9320d1 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -992,6 +992,34 @@ struct d3dkmt_queryadapterinfo {
 	__u32				private_data_size;
 };
 
+#pragma pack(push, 1)
+
+struct dxgk_gpuclockdata_flags {
+	union {
+		struct {
+			__u32	context_management_processor:1;
+			__u32	reserved:31;
+		};
+		__u32		value;
+	};
+};
+
+struct dxgk_gpuclockdata {
+	__u64				gpu_frequency;
+	__u64				gpu_clock_counter;
+	__u64				cpu_clock_counter;
+	struct dxgk_gpuclockdata_flags	flags;
+} __packed;
+
+struct d3dkmt_queryclockcalibration {
+	struct d3dkmthandle	adapter;
+	__u32			node_ordinal;
+	__u32			physical_adapter_index;
+	struct dxgk_gpuclockdata clock_data;
+};
+
+#pragma pack(pop)
+
 struct d3dkmt_flushheaptransitions {
 	struct d3dkmthandle	adapter;
 };
@@ -1234,6 +1262,36 @@ struct d3dkmt_enumadapters3 {
 #endif
 };
 
+enum d3dkmt_querystatistics_type {
+	_D3DKMT_QUERYSTATISTICS_ADAPTER                = 0,
+	_D3DKMT_QUERYSTATISTICS_PROCESS                = 1,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_ADAPTER        = 2,
+	_D3DKMT_QUERYSTATISTICS_SEGMENT                = 3,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_SEGMENT        = 4,
+	_D3DKMT_QUERYSTATISTICS_NODE                   = 5,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_NODE           = 6,
+	_D3DKMT_QUERYSTATISTICS_VIDPNSOURCE            = 7,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_VIDPNSOURCE    = 8,
+	_D3DKMT_QUERYSTATISTICS_PROCESS_SEGMENT_GROUP  = 9,
+	_D3DKMT_QUERYSTATISTICS_PHYSICAL_ADAPTER       = 10,
+};
+
+struct d3dkmt_querystatistics_result {
+	char size[0x308];
+};
+
+struct d3dkmt_querystatistics {
+	union {
+		struct {
+			enum d3dkmt_querystatistics_type	type;
+			struct winluid				adapter_luid;
+			__u64					process;
+			struct d3dkmt_querystatistics_result	result;
+		};
+		char size[0x328];
+	};
+};
+
 struct d3dkmt_shareobjectwithhost {
 	struct d3dkmthandle	device_handle;
 	struct d3dkmthandle	object_handle;
@@ -1324,6 +1382,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
 #define LX_DXGETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x3c, struct d3dkmt_getallocationpriority)
+#define LX_DXQUERYCLOCKCALIBRATION	\
+	_IOWR(0x47, 0x3d, struct d3dkmt_queryclockcalibration)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 #define LX_DXSHAREOBJECTS		\
@@ -1334,6 +1394,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x41, struct d3dkmt_queryresourceinfofromnthandle)
 #define LX_DXOPENRESOURCEFROMNTHANDLE	\
 	_IOWR(0x47, 0x42, struct d3dkmt_openresourcefromnthandle)
+#define LX_DXQUERYSTATISTICS	\
+	_IOWR(0x47, 0x43, struct d3dkmt_querystatistics)
 #define LX_DXSHAREOBJECTWITHHOST	\
 	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
 
-- 
2.35.1

