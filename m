Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B522648CC9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jan 2022 20:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350448AbiALT4k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 14:56:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33340 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357567AbiALTzU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 14:55:20 -0500
Received: from IOURIT-Z4.ntdev.corp.microsoft.com (unknown [192.182.150.27])
        by linux.microsoft.com (Postfix) with ESMTPSA id BED3B20B718B;
        Wed, 12 Jan 2022 11:55:16 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BED3B20B718B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642017316;
        bh=KwLE7Ublq6vQf5eD1ZjTIbFY3Vk2pNh1xhrsbHAk9wU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yoyej0gTuAuapXQhSgdM2km2IVoFYX1efXxE+BNmC4PDjUDXbiQJ/JbgppdghFmSg
         BGsItE/QemXW5RAQnmjhzJctnnmsoFdC0sNlBaAHz2vVhUcfzgG5jA3sJG5xNrAvIv
         ErDphDaxCX6jie7SsxROiyao77eIyqmn0MnDfY1Y=
From:   Iouri Tarassov <iourit@linux.microsoft.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: [PATCH v1 8/9] drivers: hv: dxgkrnl: Implement various WDDM ioctls
Date:   Wed, 12 Jan 2022 11:55:13 -0800
Message-Id: <b3abd5afcf0f46b261064fd0aa4c33a708fbb66b.1641937420.git.iourit@linux.microsoft.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641937419.git.iourit@linux.microsoft.com>
References: <cover.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Implement various WDDM IOCTLs.

- IOCTLs to handle GPU virtual addressing (VA):
   LX_DXRESERVEGPUVIRTUALADDRESS (D3DKMTReserveGpuVertualAddress)
   LX_DXFREEGPUVIRTUALADDRESS (D3DKMTFreeGpuVertualAddress)
   LX_DXMAPGPUVIRTUALADDRESS (D3DKMTMapGpuVertualAddress)
   LX_DXUPDATEGPUVIRTUALADDRESS (D3DKMTUpdateGpuVertualAddress)

   WDDM supports a compute device to use GPU virtual addresses when
   accessing allocation memory. A GPU VA could be reserved or mapped
   to a GPU allocation. The video memory manager on the host updates
   GPU page tables for the virtual addresses.

- IOCTLs to manage residency of GPU accessing allocations:
   LX_DXMAKERESIDENT (D3DKMTMakeResident)
   LX_DXEVICT (D3DKMTEvict)

   An allocation is resident when GPU is setup to access it. The
   current WDDM design does not support on demand GPU page faulting.
   An allocation must be resident (be in the local device memory or
   in non-pageable system memory) before GPU is allowed to access it.

- IOCTLs to offer/reclaim alloctions:
   LX_DXOFFERALLOCATIONS {D3DKMTOfferAllocations)
   LX_DXRECLAIMALLOCATIONS2 (D3DKMTReclaimAllocations)

   When a user mode driver does not need an allocation, it can
   "offer" it. This means that the allocation is not in use and it
   local device memory could be reclaimed and given to another allocation.
   When the allocation is again needed, the caller can "reclaim" the
   allocations. If the allocation is still in the device local memory,
   the reclaim operation succeeds. If not the called must restore the
   content of the allocation before it can be used by the device.

- LX_DXESCAPE (D3DKMTEscape)
  This IOCTL is used to send/receive private data between user mode
  driver and kernel mode driver. This is an extension of the WDDM APIs.

- LX_DXGETDEVICESTATE (D3DKMTGetDeviceState)
  The IOCTL is used to get the current execution state of the dxgdevice
  object.

- LX_DXMARKDEVICEASERROR (D3DKMTMarkDeviceAsError)
  The IOCTL is used to bring the dxgdevice object to the error state.
  Subsequent calls to use the device object will fail.

- LX_DXQUERYSTATISTICS (D3DKMTQuerystatistics)
  The IOCTL is used to query various statistics from the compute device
  on the host.

- IOCTLs to deal with execution context priorities
  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY
  LX_DXGETCONTEXTSCHEDULINGPRIORITY
  LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY
  LX_DXSETCONTEXTSCHEDULINGPRIORITY

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |    2 +
 drivers/hv/dxgkrnl/dxgvmbus.c | 1466 ++++++++++++++++++++++++++++---
 drivers/hv/dxgkrnl/dxgvmbus.h |   15 +
 drivers/hv/dxgkrnl/ioctl.c    | 1524 ++++++++++++++++++++++++++++++++-
 4 files changed, 2831 insertions(+), 176 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 9d2d55d9b509..73d917cb11d5 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -945,5 +945,7 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 int dxgvmb_send_query_statistics(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_querystatistics *args);
+int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
+				struct d3dkmt_shareobjectwithhost *args);
 
 #endif
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 67ff8bcbfb9a..773d8f364b34 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -859,6 +859,50 @@ int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
+				struct d3dkmt_shareobjectwithhost *args)
+{
+	struct dxgkvmb_command_shareobjectwithhost *command;
+	struct dxgkvmb_command_shareobjectwithhost_return result = {};
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, NULL, process, sizeof(*command));
+	if (ret)
+		return ret;
+	command = (void *)msg.msg;
+
+	ret = dxgglobal_acquire_channel_lock();
+	if (ret < 0)
+		goto cleanup;
+
+	command_vm_to_host_init2(&command->hdr,
+				 DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST,
+				 process->host_handle);
+	command->device_handle = args->device_handle;
+	command->object_handle = args->object_handle;
+
+	ret = dxgvmb_send_sync_msg(dxgglobal_get_dxgvmbuschannel(),
+				   msg.hdr, msg.size, &result, sizeof(result));
+
+	dxgglobal_release_channel_lock();
+
+	if (ret || !NT_SUCCESS(result.status)) {
+		if (ret == 0)
+			ret = ntstatus2int(result.status);
+		pr_err("DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST failed: %d %x",
+			ret, result.status.v);
+		goto cleanup;
+	}
+	args->object_vail_nt_handle = result.vail_nt_handle;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 /*
  * Virtual GPU messages to the host
  */
@@ -1705,6 +1749,317 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
+				       struct dxgadapter *adapter,
+				       struct d3dkmt_flushheaptransitions *args)
+{
+	struct dxgkvmb_command_flushheaptransitions *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_FLUSHHEAPTRANSITIONS,
+				   process->host_handle);
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dkmt_queryallocationresidency
+				      *args)
+{
+	int ret = -EINVAL;
+	struct dxgkvmb_command_queryallocationresidency *command = NULL;
+	u32 cmd_size = sizeof(*command);
+	u32 alloc_size = 0;
+	u32 result_allocation_size = 0;
+	struct dxgkvmb_command_queryallocationresidency_return *result = NULL;
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args->allocation_count) {
+		alloc_size = args->allocation_count *
+			     sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		result_allocation_size = args->allocation_count *
+		    sizeof(args->residency_status[0]);
+	} else {
+		result_allocation_size = sizeof(args->residency_status[0]);
+	}
+	result_size += result_allocation_size;
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_QUERYALLOCATIONRESIDENCY,
+				   process->host_handle);
+	command->args = *args;
+	if (alloc_size) {
+		ret = copy_from_user(&command[1], args->allocations,
+				     alloc_size);
+		if (ret) {
+			pr_err("%s failed to copy alloc handles", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(args->residency_status, &result[1],
+			   result_allocation_size);
+	if (ret) {
+		pr_err("%s failed to copy residency status", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_escape(struct dxgprocess *process,
+		       struct dxgadapter *adapter,
+		       struct d3dkmt_escape *args)
+{
+	int ret;
+	struct dxgkvmb_command_escape *command = NULL;
+	u32 cmd_size = sizeof(*command);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->priv_drv_data_size > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	cmd_size = cmd_size - sizeof(args->priv_drv_data[0]) +
+	    args->priv_drv_data_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_ESCAPE,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->device = args->device;
+	command->type = args->type;
+	command->flags = args->flags;
+	command->priv_drv_data_size = args->priv_drv_data_size;
+	command->context = args->context;
+	if (args->priv_drv_data_size) {
+		ret = copy_from_user(command->priv_drv_data,
+				     args->priv_drv_data,
+				     args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+	if (ret < 0)
+		goto cleanup;
+
+	if (args->priv_drv_data_size) {
+		ret = copy_to_user(args->priv_drv_data,
+				   command->priv_drv_data,
+				   args->priv_drv_data_size);
+		if (ret) {
+			pr_err("%s failed to copy priv data", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_queryvideomemoryinfo *args,
+				  struct d3dkmt_queryvideomemoryinfo *__user
+				  output)
+{
+	int ret;
+	struct dxgkvmb_command_queryvideomemoryinfo *command;
+	struct dxgkvmb_command_queryvideomemoryinfo_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	command_vgpu_to_host_init2(&command->hdr,
+				   dxgk_vmbcommand_queryvideomemoryinfo,
+				   process->host_handle);
+	command->adapter = args->adapter;
+	command->memory_segment_group = args->memory_segment_group;
+	command->physical_adapter_index = args->physical_adapter_index;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&output->budget, &result.budget,
+			   sizeof(output->budget));
+	if (ret) {
+		pr_err("%s failed to copy budget", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_usage, &result.current_usage,
+			   sizeof(output->current_usage));
+	if (ret) {
+		pr_err("%s failed to copy current usage", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->current_reservation,
+			   &result.current_reservation,
+			   sizeof(output->current_reservation));
+	if (ret) {
+		pr_err("%s failed to copy reservation", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_to_user(&output->available_for_reservation,
+			   &result.available_for_reservation,
+			   sizeof(output->available_for_reservation));
+	if (ret) {
+		pr_err("%s failed to copy avail reservation", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
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
+				   dxgk_vmbcommand_getdevicestate,
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_open_resource(struct dxgprocess *process,
 			      struct dxgadapter *adapter,
 			      struct d3dkmthandle device,
@@ -1844,14 +2199,112 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
-int dxgvmb_send_submit_command(struct dxgprocess *process,
-			       struct dxgadapter *adapter,
-			       struct d3dkmt_submitcommand *args)
+int dxgvmb_send_make_resident(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args)
 {
 	int ret;
 	u32 cmd_size;
-	struct dxgkvmb_command_submitcommand *command;
-	u32 hbufsize = args->num_history_buffers * sizeof(struct d3dkmthandle);
+	struct dxgkvmb_command_makeresident_return result = { };
+	struct dxgkvmb_command_makeresident *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+		   sizeof(struct dxgkvmb_command_makeresident);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	ret = copy_from_user(command->allocations, args->allocation_list,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MAKERESIDENT,
+				   process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->paging_queue = args->paging_queue;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_make_resident failed %x", ret);
+		goto cleanup;
+	}
+
+	args->paging_fence_value = result.paging_fence_value;
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+	ret = ntstatus2int(result.status);
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_evict(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_evict_return result = { };
+	struct dxgkvmb_command_evict *command = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	cmd_size = (args->alloc_count - 1) * sizeof(struct d3dkmthandle) +
+	    sizeof(struct dxgkvmb_command_evict);
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	ret = copy_from_user(command->allocations, args->allocations,
+			     args->alloc_count *
+			     sizeof(struct d3dkmthandle));
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_EVICT, process->host_handle);
+	command->alloc_count = args->alloc_count;
+	command->device = args->device;
+	command->flags = args->flags;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret < 0) {
+		pr_err("send_evict failed %x", ret);
+		goto cleanup;
+	}
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_submit_command(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dkmt_submitcommand *args)
+{
+	int ret;
+	u32 cmd_size;
+	struct dxgkvmb_command_submitcommand *command;
+	u32 hbufsize = args->num_history_buffers * sizeof(struct d3dkmthandle);
 	struct dxgvmbusmsg msg = {.hdr = NULL};
 
 	cmd_size = sizeof(struct dxgkvmb_command_submitcommand) +
@@ -1898,6 +2351,156 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_map_gpu_va(struct dxgprocess *process,
+			   struct d3dkmthandle device,
+			   struct dxgadapter *adapter,
+			   struct d3dddi_mapgpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_mapgpuvirtualaddress *command;
+	struct dxgkvmb_command_mapgpuvirtualaddress_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MAPGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->args = *args;
+	command->device = device;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	if (ret < 0)
+		goto cleanup;
+	args->virtual_address = result.virtual_address;
+	args->paging_fence_value = result.paging_fence_value;
+	ret = ntstatus2int(result.status);
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_reserve_gpu_va(struct dxgprocess *process,
+			       struct dxgadapter *adapter,
+			       struct d3dddi_reservegpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_reservegpuvirtualaddress *command;
+	struct dxgkvmb_command_reservegpuvirtualaddress_return result;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_RESERVEGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, &result,
+				   sizeof(result));
+	args->virtual_address = result.virtual_address;
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_free_gpu_va(struct dxgprocess *process,
+			    struct dxgadapter *adapter,
+			    struct d3dkmt_freegpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_freegpuvirtualaddress *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_FREEGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_update_gpu_va(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dkmt_updategpuvirtualaddress *args)
+{
+	struct dxgkvmb_command_updategpuvirtualaddress *command;
+	u32 cmd_size;
+	u32 op_size;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->num_operations == 0 ||
+	    (DXG_MAX_VM_BUS_PACKET_SIZE /
+	     sizeof(struct d3dddi_updategpuvirtualaddress_operation)) <
+	    args->num_operations) {
+		ret = -EINVAL;
+		pr_err("Invalid number of operations: %d",
+			   args->num_operations);
+		goto cleanup;
+	}
+
+	op_size = args->num_operations *
+	    sizeof(struct d3dddi_updategpuvirtualaddress_operation);
+	cmd_size = sizeof(struct dxgkvmb_command_updategpuvirtualaddress) +
+	    op_size - sizeof(args->operations[0]);
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UPDATEGPUVIRTUALADDRESS,
+				   process->host_handle);
+	command->fence_value = args->fence_value;
+	command->device = args->device;
+	command->context = args->context;
+	command->fence_object = args->fence_object;
+	command->num_operations = args->num_operations;
+	command->flags = args->flags.value;
+	ret = copy_from_user(command->operations, args->operations,
+			     op_size);
+	if (ret) {
+		pr_err("%s failed to copy operations", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
@@ -1978,98 +2581,593 @@ dxgvmb_send_create_sync_object(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_lock2(struct dxgprocess *process,
+		      struct dxgadapter *adapter,
+		      struct d3dkmt_lock2 *args,
+		      struct d3dkmt_lock2 *__user outargs)
+{
+	int ret;
+	struct dxgkvmb_command_lock2 *command;
+	struct dxgkvmb_command_lock2_return result = { };
+	struct dxgallocation *alloc = NULL;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_LOCK2, process->host_handle);
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
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args->allocation);
+	if (alloc == NULL) {
+		pr_err("%s invalid alloc", __func__);
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			args->data = alloc->cpu_address;
+			if (alloc->cpu_address_mapped)
+				alloc->cpu_address_refcount++;
+		} else {
+			u64 offset = (u64)result.cpu_visible_buffer_offset;
+
+			args->data = dxg_map_iospace(offset,
+					alloc->num_pages << PAGE_SHIFT,
+					PROT_READ | PROT_WRITE, alloc->cached);
+			if (args->data) {
+				alloc->cpu_address_refcount = 1;
+				alloc->cpu_address_mapped = true;
+				alloc->cpu_address = args->data;
+			}
+		}
+		if (args->data == NULL) {
+			ret = -ENOMEM;
+		} else {
+			ret = copy_to_user(&outargs->data, &args->data,
+					   sizeof(args->data));
+			if (ret) {
+				pr_err("%s failed to copy data", __func__);
+				ret = -EINVAL;
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount == 0) {
+					dxg_unmap_iospace(alloc->cpu_address,
+					   alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_unlock2(struct dxgprocess *process,
+			struct dxgadapter *adapter,
+			struct d3dkmt_unlock2 *args)
+{
+	int ret;
+	struct dxgkvmb_command_unlock2 *command;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UNLOCK2,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dddi_updateallocproperty *args,
+				      struct d3dddi_updateallocproperty *__user
+				      inargs)
+{
+	int ret;
+	int ret1;
+	struct dxgkvmb_command_updateallocationproperty *command;
+	struct dxgkvmb_command_updateallocationproperty_return result = { };
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_UPDATEALLOCATIONPROPERTY,
+				   process->host_handle);
+	command->args = *args;
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+
+	if (ret < 0)
+		goto cleanup;
+	ret = ntstatus2int(result.status);
+	/* STATUS_PENING is a success code > 0 */
+	if (ret == STATUS_PENDING) {
+		ret1 = copy_to_user(&inargs->paging_fence_value,
+				    &result.paging_fence_value,
+				    sizeof(u64));
+		if (ret1) {
+			pr_err("%s failed to copy paging fence", __func__);
+			ret = -EINVAL;
+		}
+	}
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
+				     struct dxgadapter *adapter,
+				     struct d3dkmt_markdeviceaserror *args)
+{
+	struct dxgkvmb_command_markdeviceaserror *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_MARKDEVICEASERROR,
+				   process->host_handle);
+	command->args = *args;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_setallocationpriority *args)
+{
+	u32 cmd_size = sizeof(struct dxgkvmb_command_setallocationpriority);
+	u32 alloc_size = 0;
+	u32 priority_size = 0;
+	struct dxgkvmb_command_setallocationpriority *command;
+	int ret;
+	struct d3dkmthandle *allocations;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args->resource.v) {
+		priority_size = sizeof(u32);
+		if (args->allocation_count != 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		if (args->allocation_count == 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		alloc_size = args->allocation_count *
+			     sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		priority_size = sizeof(u32) * args->allocation_count;
+	}
+	cmd_size += priority_size;
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_SETALLOCATIONPRIORITY,
+				   process->host_handle);
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	command->resource = args->resource;
+	allocations = (struct d3dkmthandle *) &command[1];
+	ret = copy_from_user(allocations, args->allocation_list,
+			     alloc_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc handle", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) allocations + alloc_size,
+				args->priorities, priority_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc priority", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
+				struct dxgadapter *adapter,
+				struct d3dkmt_getallocationpriority *args)
+{
+	u32 cmd_size = sizeof(struct dxgkvmb_command_getallocationpriority);
+	u32 result_size;
+	u32 alloc_size = 0;
+	u32 priority_size = 0;
+	struct dxgkvmb_command_getallocationpriority *command;
+	struct dxgkvmb_command_getallocationpriority_return *result;
+	int ret;
+	struct d3dkmthandle *allocations;
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
+	if (args->allocation_count > DXG_MAX_VM_BUS_PACKET_SIZE) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args->resource.v) {
+		priority_size = sizeof(u32);
+		if (args->allocation_count != 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	} else {
+		if (args->allocation_count == 0) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		alloc_size = args->allocation_count *
+			sizeof(struct d3dkmthandle);
+		cmd_size += alloc_size;
+		priority_size = sizeof(u32) * args->allocation_count;
+	}
+	result_size = sizeof(*result) + priority_size;
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETALLOCATIONPRIORITY,
+				   process->host_handle);
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	command->resource = args->resource;
+	allocations = (struct d3dkmthandle *) &command[1];
+	ret = copy_from_user(allocations, args->allocation_list,
+			     alloc_size);
+	if (ret) {
+		pr_err("%s failed to copy alloc handles", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr,
+				   msg.size + msg.res_size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = ntstatus2int(result->status);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(args->priorities,
+			   (u8 *) result + sizeof(*result),
+			   priority_size);
+	if (ret) {
+		pr_err("%s failed to copy priorities", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
 	if (ret)
 		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
 	return ret;
 }
 
-int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
-				   struct dxgadapter *adapter,
-				   struct d3dddicb_signalflags flags,
-				   u64 legacy_fence_value,
-				   struct d3dkmthandle context,
-				   u32 object_count,
-				   struct d3dkmthandle __user *objects,
-				   u32 context_count,
-				   struct d3dkmthandle __user *contexts,
-				   u32 fence_count,
-				   u64 __user *fences,
-				   struct eventfd_ctx *cpu_event_handle,
-				   struct d3dkmthandle device)
+int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int priority,
+					 bool in_process)
 {
+	struct dxgkvmb_command_setcontextschedulingpriority2 *command;
 	int ret;
-	struct dxgkvmb_command_signalsyncobject *command;
-	u32 object_size = object_count * sizeof(struct d3dkmthandle);
-	u32 context_size = context_count * sizeof(struct d3dkmthandle);
-	u32 fence_size = fences ? fence_count * sizeof(u64) : 0;
-	u8 *current_pos;
-	u32 cmd_size = sizeof(struct dxgkvmb_command_signalsyncobject) +
-	    object_size + context_size + fence_size;
 	struct dxgvmbusmsg msg = {.hdr = NULL};
 
-	if (context.v)
-		cmd_size += sizeof(struct d3dkmthandle);
-
-	ret = init_message(&msg, adapter, process, cmd_size);
+	ret = init_message(&msg, adapter, process, sizeof(*command));
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
 
 	command_vgpu_to_host_init2(&command->hdr,
-				   DXGK_VMBCOMMAND_SIGNALSYNCOBJECT,
+				   DXGK_VMBCOMMAND_SETCONTEXTSCHEDULINGPRIORITY,
 				   process->host_handle);
+	command->context = context;
+	command->priority = priority;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
 
-	if (flags.enqueue_cpu_event)
-		command->cpu_event_handle = (u64) cpu_event_handle;
-	else
-		command->device = device;
-	command->flags = flags;
-	command->fence_value = legacy_fence_value;
-	command->object_count = object_count;
-	command->context_count = context_count;
-	current_pos = (u8 *) &command[1];
-	ret = copy_from_user(current_pos, objects, object_size);
-	if (ret) {
-		pr_err("Failed to read objects %p %d",
-			objects, object_size);
-		ret = -EINVAL;
+int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
+					 struct dxgadapter *adapter,
+					 struct d3dkmthandle context,
+					 int *priority,
+					 bool in_process)
+{
+	struct dxgkvmb_command_getcontextschedulingpriority *command;
+	struct dxgkvmb_command_getcontextschedulingpriority_return result = { };
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
+	if (ret)
 		goto cleanup;
-	}
-	current_pos += object_size;
-	if (context.v) {
-		command->context_count++;
-		*(struct d3dkmthandle *) current_pos = context;
-		current_pos += sizeof(struct d3dkmthandle);
-	}
-	if (context_size) {
-		ret = copy_from_user(current_pos, contexts, context_size);
-		if (ret) {
-			pr_err("Failed to read contexts %p %d",
-				contexts, context_size);
-			ret = -EINVAL;
-			goto cleanup;
-		}
-		current_pos += context_size;
-	}
-	if (fence_size) {
-		ret = copy_from_user(current_pos, fences, fence_size);
-		if (ret) {
-			pr_err("Failed to read fences %p %d",
-				fences, fence_size);
-			ret = -EINVAL;
-			goto cleanup;
-		}
-	}
+	command = (void *)msg.msg;
 
-	if (dxgglobal->async_msg_enabled) {
-		command->hdr.async_msg = 1;
-		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
-	} else {
-		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
-						    msg.size);
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_GETCONTEXTSCHEDULINGPRIORITY,
+				   process->host_handle);
+	command->context = context;
+	command->in_process = in_process;
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   &result, sizeof(result));
+	if (ret >= 0) {
+		ret = ntstatus2int(result.status);
+		*priority = result.priority;
 	}
-
 cleanup:
 	free_message(&msg, process);
 	if (ret)
@@ -2077,19 +3175,15 @@ int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
 	return ret;
 }
 
-int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
-				     struct dxgadapter *adapter,
-				     struct
-				     d3dkmt_waitforsynchronizationobjectfromcpu
-				     *args,
-				     u64 cpu_event)
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args)
 {
+	struct dxgkvmb_command_offerallocations *command;
 	int ret = -EINVAL;
-	struct dxgkvmb_command_waitforsyncobjectfromcpu *command;
-	u32 object_size = args->object_count * sizeof(struct d3dkmthandle);
-	u32 fence_size = args->object_count * sizeof(u64);
-	u8 *current_pos;
-	u32 cmd_size = sizeof(*command) + object_size + fence_size;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_offerallocations) +
+			alloc_size - sizeof(struct d3dkmthandle);
 	struct dxgvmbusmsg msg = {.hdr = NULL};
 
 	ret = init_message(&msg, adapter, process, cmd_size);
@@ -2098,23 +3192,22 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 	command = (void *)msg.msg;
 
 	command_vgpu_to_host_init2(&command->hdr,
-				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMCPU,
+				   DXGK_VMBCOMMAND_OFFERALLOCATIONS,
 				   process->host_handle);
-	command->device = args->device;
 	command->flags = args->flags;
-	command->object_count = args->object_count;
-	command->guest_event_pointer = (u64) cpu_event;
-	current_pos = (u8 *) &command[1];
-	ret = copy_from_user(current_pos, args->objects, object_size);
-	if (ret) {
-		pr_err("%s failed to copy objects", __func__);
-		ret = -EINVAL;
-		goto cleanup;
+	command->priority = args->priority;
+	command->device = args->device;
+	command->allocation_count = args->allocation_count;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+				     alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+				     args->allocations, alloc_size);
 	}
-	current_pos += object_size;
-	ret = copy_from_user(current_pos, args->fence_values, fence_size);
 	if (ret) {
-		pr_err("%s failed to copy fences", __func__);
+		pr_err("%s failed to copy input handles", __func__);
 		ret = -EINVAL;
 		goto cleanup;
 	}
@@ -2128,51 +3221,105 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 	return ret;
 }
 
-int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
-				     struct dxgadapter *adapter,
-				     struct d3dkmthandle context,
-				     u32 object_count,
-				     struct d3dkmthandle *objects,
-				     u64 *fences,
-				     bool legacy_fence)
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64  __user *paging_fence_value)
 {
+	struct dxgkvmb_command_reclaimallocations *command;
+	struct dxgkvmb_command_reclaimallocations_return *result;
 	int ret;
-	struct dxgkvmb_command_waitforsyncobjectfromgpu *command;
-	u32 fence_size = object_count * sizeof(u64);
-	u32 object_size = object_count * sizeof(struct d3dkmthandle);
-	u8 *current_pos;
-	u32 cmd_size = object_size + fence_size - sizeof(u64) +
-	    sizeof(struct dxgkvmb_command_waitforsyncobjectfromgpu);
-	struct dxgvmbusmsg msg = {.hdr = NULL};
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_reclaimallocations) +
+	    alloc_size - sizeof(struct d3dkmthandle);
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
 
-	if (object_count == 0 || object_count > D3DDDI_MAX_OBJECT_WAITED_ON) {
+	if (args->results)
+		result_size += (args->allocation_count - 1) *
+				sizeof(enum d3dddi_reclaim_result);
+
+	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+	result = msg.res;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_RECLAIMALLOCATIONS,
+				   process->host_handle);
+	command->device = device;
+	command->paging_queue = args->paging_queue;
+	command->allocation_count = args->allocation_count;
+	command->write_results = args->results != NULL;
+	if (args->resources) {
+		command->resources = true;
+		ret = copy_from_user(command->allocations, args->resources,
+					 alloc_size);
+	} else {
+		ret = copy_from_user(command->allocations,
+					 args->allocations, alloc_size);
+	}
+	if (ret) {
+		pr_err("%s failed to copy input handles", __func__);
 		ret = -EINVAL;
 		goto cleanup;
 	}
-	ret = init_message(&msg, adapter, process, cmd_size);
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(paging_fence_value,
+			   &result->paging_fence_value, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = ntstatus2int(result->status);
+	if (NT_SUCCESS(result->status) && args->results) {
+		ret = copy_to_user(args->results, result->discarded,
+				   sizeof(result->discarded[0]) *
+				   args->allocation_count);
+		if (ret) {
+			pr_err("%s failed to copy results", __func__);
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
+
+int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
+					  struct dxgadapter *adapter,
+					  struct d3dkmthandle other_process,
+					  struct
+					  d3dkmt_changevideomemoryreservation
+					  *args)
+{
+	struct dxgkvmb_command_changevideomemoryreservation *command;
+	int ret;
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, sizeof(*command));
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
 
 	command_vgpu_to_host_init2(&command->hdr,
-				   DXGK_VMBCOMMAND_WAITFORSYNCOBJECTFROMGPU,
+				   DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION,
 				   process->host_handle);
-	command->context = context;
-	command->object_count = object_count;
-	command->legacy_fence_object = legacy_fence;
-	current_pos = (u8 *) command->fence_values;
-	memcpy(current_pos, fences, fence_size);
-	current_pos += fence_size;
-	memcpy(current_pos, objects, object_size);
-
-	if (dxgglobal->async_msg_enabled) {
-		command->hdr.async_msg = 1;
-		ret = dxgvmb_send_async_msg(msg.channel, msg.hdr, msg.size);
-	} else {
-		ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr,
-						    msg.size);
-	}
+	command->args = *args;
+	command->args.process = other_process.v;
 
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
 	free_message(&msg, process);
 	if (ret)
@@ -2259,37 +3406,43 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 
 	ret = copy_to_user(&inargs->queue, &command->hwqueue,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy hwqueue handle", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence,
 			   &command->hwqueue_progress_fence,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to progress fence", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_cpu_va,
 			   &hwqueue->progress_fence_mapped_address,
 			   sizeof(inargs->queue_progress_fence_cpu_va));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy fence cpu va", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_gpu_va,
 			   &command->hwqueue_progress_fence_gpuva,
 			   sizeof(u64));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy fence gpu va", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 	if (args->priv_drv_data_size) {
 		ret = copy_to_user(args->priv_drv_data,
 				   command->priv_drv_data,
 				   args->priv_drv_data_size);
-		if (ret < 0)
+		if (ret) {
 			pr_err("%s failed to copy private data", __func__);
+			ret = -EINVAL;
+		}
 	}
 
 cleanup:
@@ -2474,3 +3627,38 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
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
+		dev_dbg(dxgglobaldev, "err: %s %d", __func__, ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index c166a2820052..a19ac804a320 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -63,6 +63,7 @@ enum dxgkvmb_commandtype_global {
 	DXGK_VMBCOMMAND_QUERYETWSESSION		= 1009,
 	DXGK_VMBCOMMAND_SETIOSPACEREGION	= 1010,
 	DXGK_VMBCOMMAND_COMPLETETRANSACTION	= 1011,
+	DXGK_VMBCOMMAND_SHAREOBJECTWITHHOST	= 1021,
 	DXGK_VMBCOMMAND_INVALID_VM_TO_HOST
 };
 
@@ -520,6 +521,7 @@ struct dxgkvmb_command_querystatistics {
 
 struct dxgkvmb_command_querystatistics_return {
 	struct ntstatus				status;
+	u32					reserved;
 	struct d3dkmt_querystatistics_result	result;
 };
 
@@ -847,6 +849,19 @@ struct dxgkvmb_command_getdevicestate_return {
 	struct ntstatus			status;
 };
 
+struct dxgkvmb_command_shareobjectwithhost {
+	struct dxgkvmb_command_vm_to_host hdr;
+	struct d3dkmthandle	device_handle;
+	struct d3dkmthandle	object_handle;
+	u64			reserved;
+};
+
+struct dxgkvmb_command_shareobjectwithhost_return {
+	struct ntstatus	status;
+	u32		alignment;
+	u64		vail_nt_handle;
+};
+
 /*
  * Helper functions
  */
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 6e18002c9d25..9770fabf163e 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -156,6 +156,66 @@ static int dxgk_open_adapter_from_luid(struct dxgprocess *process,
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
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
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
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgkp_enum_adapters(struct dxgprocess *process,
 		    union d3dkmt_enumadapters_filter filter,
@@ -1105,8 +1165,9 @@ dxgk_create_paging_queue(struct dxgprocess *process, void *__user inargs)
 		host_handle = args.paging_queue;
 
 		ret = copy_to_user(inargs, &args, sizeof(args));
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy input args", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 
@@ -1953,6 +2014,261 @@ dxgk_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_make_resident(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_makeresident args;
+	struct d3dddi_makeresident *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.paging_queue.v == 0) {
+		pr_err("paging queue is missing");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
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
+	ret = dxgvmb_send_make_resident(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+	/* STATUS_PENING is a success code > 0. It is returned to user mode */
+	if (!(ret == STATUS_PENDING || ret == 0)) {
+		pr_err("%s Unexpected error %x", __func__, ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy paging fence", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->num_bytes_to_trim,
+			    &args.num_bytes_to_trim, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy bytes to trim", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+
+	return ret;
+}
+
+static int
+dxgk_evict(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_evict args;
+	struct d3dkmt_evict *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		pr_err("invalid number of allocations");
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
+	ret = dxgvmb_send_evict(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->num_bytes_to_trim,
+			   &args.num_bytes_to_trim, sizeof(u64));
+	if (ret) {
+		pr_err("%s failed to copy bytes to trim to user", __func__);
+		ret = -EINVAL;
+	}
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_offer_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_offerallocations args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
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
+	ret = dxgvmb_send_offer_allocations(process, adapter, &args);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_reclaimallocations2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_reclaimallocations2 * __user in_args = inargs;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		pr_err("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		pr_err("invalid pointer to resources/allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
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
+	ret = dxgvmb_send_reclaim_allocations(process, adapter,
+					      device->handle, &args,
+					      &in_args->paging_fence_value);
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_submit_command(struct dxgprocess *process, void *__user inargs)
 {
@@ -2237,6 +2553,228 @@ dxgk_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_map_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dddi_mapgpuvirtualaddress *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+					HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+					args.paging_queue);
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
+	ret = dxgvmb_send_map_gpu_va(process, zerohandle, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+	/* STATUS_PENING is a success code > 0. It is returned to user mode */
+	if (!(ret == STATUS_PENDING || ret == 0)) {
+		pr_err("%s Unexpected error %x", __func__, ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		pr_err("%s failed to copy paging fence to user", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->virtual_address, &args.virtual_address,
+				sizeof(args.virtual_address));
+	if (ret2) {
+		pr_err("%s failed to copy va to user", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dddi_reservegpuvirtualaddress args;
+	struct d3dddi_reservegpuvirtualaddress *input = inargs;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.adapter);
+		if (device == NULL) {
+			pr_err("invalid adapter or paging queue: 0x%x",
+				   args.adapter.v);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		adapter = device->adapter;
+		kref_get(&adapter->adapter_kref);
+		kref_put(&device->device_kref, dxgdevice_release);
+	} else {
+		args.adapter = adapter->host_handle;
+	}
+
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_reserve_gpu_va(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->virtual_address, &args.virtual_address,
+			   sizeof(args.virtual_address));
+	if (ret) {
+		pr_err("%s failed to copy VA to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter) {
+		dxgadapter_release_lock_shared(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	}
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_free_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_freegpuvirtualaddress args;
+	struct dxgadapter *adapter = NULL;
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
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	args.adapter = adapter->host_handle;
+	ret = dxgvmb_send_free_gpu_va(process, adapter, &args);
+
+cleanup:
+
+	if (adapter) {
+		dxgadapter_release_lock_shared(adapter);
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	}
+
+	return ret;
+}
+
+static int
+dxgk_update_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_updategpuvirtualaddress args;
+	struct d3dkmt_updategpuvirtualaddress *input = inargs;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
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
+	ret = dxgvmb_send_update_gpu_va(process, adapter, &args);
+	if (ret < 0)
+		goto cleanup;
+
+	ret = copy_to_user(&input->fence_value, &args.fence_value,
+			   sizeof(args.fence_value));
+	if (ret) {
+		pr_err("%s failed to copy fence value to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
 static int
 dxgk_create_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -2512,8 +3050,9 @@ dxgk_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 
 	ret = copy_to_user(inargs, &args, sizeof(args));
-	if (ret >= 0)
+	if (ret == 0)
 		goto success;
+	ret = -EINVAL;
 	pr_err("%s failed to copy output args", __func__);
 
 cleanup:
@@ -3205,41 +3744,849 @@ dxgk_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 }
 
 static int
-dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
-				    struct dxgprocess *process,
-				    struct d3dkmthandle objecthandle)
+dxgk_lock2(struct dxgprocess *process, void *__user inargs)
 {
-	int ret = 0;
+	struct d3dkmt_lock2 args;
+	struct d3dkmt_lock2 *__user result = inargs;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
 
-	mutex_lock(&syncobj->fd_mutex);
-	if (syncobj->host_shared_handle_nt_reference == 0) {
-		ret = dxgvmb_send_create_nt_shared_object(process,
-			objecthandle,
-			&syncobj->host_shared_handle_nt);
-		if (ret < 0)
-			goto cleanup;
-		dev_dbg(dxgglobaldev, "Host_shared_handle_ht: %x",
-			    syncobj->host_shared_handle_nt.v);
-		kref_get(&syncobj->ssyncobj_kref);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
 	}
-	syncobj->host_shared_handle_nt_reference++;
+
+	args.data = NULL;
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address) {
+			ret = copy_to_user(&result->data,
+					   &alloc->cpu_address,
+					   sizeof(args.data));
+			if (ret == 0) {
+				args.data = alloc->cpu_address;
+				if (alloc->cpu_address_mapped)
+					alloc->cpu_address_refcount++;
+			} else {
+				pr_err("%s Failed to copy cpu address",
+					__func__);
+				ret = -EINVAL;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (ret < 0)
+		goto cleanup;
+	if (args.data)
+		goto success;
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_lock2(process, adapter, &args, result);
+
 cleanup:
-	mutex_unlock(&syncobj->fd_mutex);
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
 	return ret;
 }
 
 static int
-dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
-				     struct dxgprocess *process,
-				     struct d3dkmthandle objecthandle)
+dxgk_unlock2(struct dxgprocess *process, void *__user inargs)
 {
-	int ret = 0;
+	struct d3dkmt_unlock2 args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	struct dxgallocation *alloc = NULL;
+	bool done = false;
 
-	mutex_lock(&resource->fd_mutex);
-	if (resource->host_shared_handle_nt_reference == 0) {
-		ret = dxgvmb_send_create_nt_shared_object(process,
-					objecthandle,
-					&resource->host_shared_handle_nt);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	hmgrtable_lock(&process->handle_table, DXGLOCK_EXCL);
+	alloc = hmgrtable_get_object_by_type(&process->handle_table,
+					     HMGRENTRY_TYPE_DXGALLOCATION,
+					     args.allocation);
+	if (alloc == NULL) {
+		ret = -EINVAL;
+	} else {
+		if (alloc->cpu_address == NULL) {
+			pr_err("Allocation is not locked: %p", alloc);
+			ret = -EINVAL;
+		} else if (alloc->cpu_address_mapped) {
+			if (alloc->cpu_address_refcount > 0) {
+				alloc->cpu_address_refcount--;
+				if (alloc->cpu_address_refcount != 0) {
+					done = true;
+				} else {
+					dxg_unmap_iospace(alloc->cpu_address,
+						alloc->num_pages << PAGE_SHIFT);
+					alloc->cpu_address_mapped = false;
+					alloc->cpu_address = NULL;
+				}
+			} else {
+				pr_err("Invalid cpu access refcount");
+				done = true;
+			}
+		}
+	}
+	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
+	if (done)
+		goto success;
+	if (ret < 0)
+		goto cleanup;
+
+	/*
+	 * The call acquires reference on the device. It is safe to access the
+	 * adapter, because the device holds reference on it.
+	 */
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_unlock2(process, adapter, &args);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+success:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_update_alloc_property(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dddi_updateallocproperty args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.paging_queue);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_update_alloc_property(process, adapter,
+						&args, inargs);
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_markdeviceaserror args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	device->execution_state = _D3DKMT_DEVICEEXECUTION_RESET;
+	ret = dxgvmb_send_mark_device_as_error(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryallocationresidency args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.allocation_count == 0) == (args.resource.v == 0)) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_query_alloc_residency(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_set_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_setallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_set_allocation_priority(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_getallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	device = dxgprocess_device_by_handle(process, args.device);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_get_allocation_priority(process, adapter, &args);
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+set_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int priority, bool in_process)
+{
+	int ret = 0;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_set_context_sch_priority(process, adapter,
+						   hcontext, priority,
+						   in_process);
+	if (ret < 0)
+		pr_err("send_set_context_scheduling_priority failed");
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_set_context_scheduling_priority(struct dxgprocess *process,
+				     void *__user inargs)
+{
+	struct d3dkmt_setcontextschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, false);
+cleanup:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+get_context_scheduling_priority(struct dxgprocess *process,
+				struct d3dkmthandle hcontext,
+				int __user *priority,
+				bool in_process)
+{
+	int ret;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	int pri = 0;
+
+	device = dxgprocess_device_by_object_handle(process,
+						    HMGRENTRY_TYPE_DXGCONTEXT,
+						    hcontext);
+	if (device == NULL) {
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	adapter = device->adapter;
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0) {
+		adapter = NULL;
+		goto cleanup;
+	}
+	ret = dxgvmb_send_get_context_sch_priority(process, adapter,
+						   hcontext, &pri, in_process);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(priority, &pri, sizeof(pri));
+	if (ret) {
+		pr_err("%s failed to copy priority to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	return ret;
+}
+
+static int
+dxgk_get_context_scheduling_priority(struct dxgprocess *process,
+				     void *__user inargs)
+{
+	struct d3dkmt_getcontextschedulingpriority args;
+	struct d3dkmt_getcontextschedulingpriority __user *input = inargs;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+					      &input->priority, false);
+cleanup:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_set_context_process_scheduling_priority(struct dxgprocess *process,
+					     void *__user inargs)
+{
+	struct d3dkmt_setcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = set_context_scheduling_priority(process, args.context,
+					      args.priority, true);
+cleanup:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_get_context_process_scheduling_priority(struct dxgprocess *process,
+					     void __user *inargs)
+{
+	struct d3dkmt_getcontextinprocessschedulingpriority args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = get_context_scheduling_priority(process, args.context,
+		&((struct d3dkmt_getcontextinprocessschedulingpriority *)
+		inargs)->priority, true);
+cleanup:
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_changevideomemoryreservation args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.process != 0) {
+		pr_err("setting memory reservation for other process");
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
+	args.adapter.v = 0;
+	ret = dxgvmb_send_change_vidmem_reservation(process, adapter,
+						    zerohandle, &args);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
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
+static int
+dxgk_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_flushheaptransitions args;
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
+	ret = dxgvmb_send_flush_heap_transitions(process, adapter, &args);
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
+static int
+dxgk_escape(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_escape args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
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
+	ret = dxgvmb_send_escape(process, adapter, &args);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
+static int
+dxgk_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryvideomemoryinfo args;
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
+	if (args.process != 0) {
+		pr_err("query vidmem info from another process ");
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
+	ret = dxgvmb_send_query_vidmem_info(process, adapter, &args, inargs);
+
+cleanup:
+
+	if (adapter_locked)
+		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
+		kref_put(&adapter->adapter_kref, dxgadapter_release);
+	if (ret < 0)
+		pr_err("%s failed: %x", __func__, ret);
+	return ret;
+}
+
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
+static int
+dxgsharedsyncobj_get_host_nt_handle(struct dxgsharedsyncobject *syncobj,
+				    struct dxgprocess *process,
+				    struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&syncobj->fd_mutex);
+	if (syncobj->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+			objecthandle,
+			&syncobj->host_shared_handle_nt);
+		if (ret < 0)
+			goto cleanup;
+		dev_dbg(dxgglobaldev, "Host_shared_handle_ht: %x",
+			    syncobj->host_shared_handle_nt.v);
+		kref_get(&syncobj->ssyncobj_kref);
+	}
+	syncobj->host_shared_handle_nt_reference++;
+cleanup:
+	mutex_unlock(&syncobj->fd_mutex);
+	return ret;
+}
+
+static int
+dxgsharedresource_get_host_nt_handle(struct dxgsharedresource *resource,
+				     struct dxgprocess *process,
+				     struct d3dkmthandle objecthandle)
+{
+	int ret = 0;
+
+	mutex_lock(&resource->fd_mutex);
+	if (resource->host_shared_handle_nt_reference == 0) {
+		ret = dxgvmb_send_create_nt_shared_object(process,
+					objecthandle,
+					&resource->host_shared_handle_nt);
 		if (ret < 0)
 			goto cleanup;
 		dev_dbg(dxgglobaldev, "Resource host_shared_handle_ht: %x",
@@ -3431,8 +4778,10 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	tmp = (u64) object_fd;
 
 	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy shared handle", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 	if (ret < 0) {
@@ -3453,6 +4802,13 @@ dxgk_share_objects(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgk_invalidate_cache(struct dxgprocess *process, void *__user inargs)
+{
+	pr_err("%s is not implemented", __func__);
+	return -ENOTTY;
+}
+
 static int
 dxgk_query_resource_info(struct dxgprocess *process, void *__user inargs)
 {
@@ -3469,8 +4825,6 @@ dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	struct dxgsharedresource *shared_resource = NULL;
 	struct file *file = NULL;
 
-	dev_dbg(dxgglobaldev, "ioctl: %s", __func__);
-
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		pr_err("%s failed to copy input args", __func__);
@@ -3525,8 +4879,10 @@ dxgk_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	    shared_resource->alloc_private_data_size;
 
 	ret = copy_to_user(inargs, &args, sizeof(args));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy output args", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 
@@ -3587,8 +4943,9 @@ assign_resource_handles(struct dxgprocess *process,
 		ret = copy_to_user(&args->open_alloc_info[i],
 				   &open_alloc_info,
 				   sizeof(open_alloc_info));
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy alloc info", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3738,8 +5095,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->private_runtime_data,
 				shared_resource->runtime_private_data,
 				shared_resource->runtime_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy runtime data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3748,8 +5106,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->resource_priv_drv_data,
 				shared_resource->resource_private_data,
 				shared_resource->resource_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy resource data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3758,8 +5117,9 @@ open_resource(struct dxgprocess *process,
 		ret = copy_to_user(args->total_priv_drv_data,
 				shared_resource->alloc_private_data,
 				shared_resource->alloc_private_data_size);
-		if (ret < 0) {
+		if (ret) {
 			pr_err("%s failed to copy alloc data", __func__);
+			ret = -EINVAL;
 			goto cleanup;
 		}
 	}
@@ -3772,15 +5132,18 @@ open_resource(struct dxgprocess *process,
 
 	ret = copy_to_user(res_out, &resource_handle,
 			   sizeof(struct d3dkmthandle));
-	if (ret < 0) {
+	if (ret) {
 		pr_err("%s failed to copy resource handle to user", __func__);
+		ret = -EINVAL;
 		goto cleanup;
 	}
 
 	ret = copy_to_user(total_driver_data_size_out,
 			   &args->total_priv_drv_data_size, sizeof(u32));
-	if (ret < 0)
+	if (ret) {
 		pr_err("%s failed to copy total driver data size", __func__);
+		ret = -EINVAL;
+	}
 
 cleanup:
 
@@ -3849,6 +5212,37 @@ dxgk_open_resource_nt(struct dxgprocess *process,
 	return ret;
 }
 
+static int
+dxgk_share_object_with_host(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_shareobjectwithhost args;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy input args", __func__);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_share_object_with_host(process, &args);
+	if (ret) {
+		pr_err("dxgvmb_send_share_object_with_host dailed");
+		goto cleanup;
+	}
+
+	ret = copy_to_user(inargs, &args, sizeof(args));
+	if (ret) {
+		pr_err("%s failed to copy data to user", __func__);
+		ret = -EINVAL;
+	}
+
+cleanup:
+
+	dev_dbg(dxgglobaldev, "ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	return ret;
+}
+
 static int
 dxgk_render(struct dxgprocess *process, void *__user inargs)
 {
@@ -3941,8 +5335,20 @@ void init_ioctls(void)
 		  LX_DXCREATEALLOCATION);
 	SET_IOCTL(/*0x7 */ dxgk_create_paging_queue,
 		  LX_DXCREATEPAGINGQUEUE);
+	SET_IOCTL(/*0x8 */ dxgk_reserve_gpu_va,
+		  LX_DXRESERVEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x9 */ dxgk_query_adapter_info,
 		  LX_DXQUERYADAPTERINFO);
+	SET_IOCTL(/*0xa */ dxgk_query_vidmem_info,
+		  LX_DXQUERYVIDEOMEMORYINFO);
+	SET_IOCTL(/*0xb */ dxgk_make_resident,
+		  LX_DXMAKERESIDENT);
+	SET_IOCTL(/*0xc */ dxgk_map_gpu_va,
+		  LX_DXMAPGPUVIRTUALADDRESS);
+	SET_IOCTL(/*0xd */ dxgk_escape,
+		  LX_DXESCAPE);
+	SET_IOCTL(/*0xe */ dxgk_get_device_state,
+		  LX_DXGETDEVICESTATE);
 	SET_IOCTL(/*0xf */ dxgk_submit_command,
 		  LX_DXSUBMITCOMMAND);
 	SET_IOCTL(/*0x10 */ dxgk_create_sync_object,
@@ -3957,6 +5363,8 @@ void init_ioctls(void)
 		  LX_DXENUMADAPTERS2);
 	SET_IOCTL(/*0x15 */ dxgk_close_adapter,
 		  LX_DXCLOSEADAPTER);
+	SET_IOCTL(/*0x16 */ dxgk_change_vidmem_reservation,
+		  LX_DXCHANGEVIDEOMEMORYRESERVATION);
 	SET_IOCTL(/*0x17 */ dxgk_create_hwcontext,
 		  LX_DXCREATEHWCONTEXT);
 	SET_IOCTL(/*0x18 */ dxgk_create_hwqueue,
@@ -3971,16 +5379,44 @@ void init_ioctls(void)
 		  LX_DXDESTROYPAGINGQUEUE);
 	SET_IOCTL(/*0x1d */ dxgk_destroy_sync_object,
 		  LX_DXDESTROYSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x1e */ dxgk_evict,
+		  LX_DXEVICT);
+	SET_IOCTL(/*0x1f */ dxgk_flush_heap_transitions,
+		  LX_DXFLUSHHEAPTRANSITIONS);
+	SET_IOCTL(/*0x20 */ dxgk_free_gpu_va,
+		  LX_DXFREEGPUVIRTUALADDRESS);
+	SET_IOCTL(/*0x21 */ dxgk_get_context_process_scheduling_priority,
+		  LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x22 */ dxgk_get_context_scheduling_priority,
+		  LX_DXGETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x23 */ dxgk_get_shared_resource_adapter_luid,
 		  LX_DXGETSHAREDRESOURCEADAPTERLUID);
+	SET_IOCTL(/*0x24 */ dxgk_invalidate_cache,
+		  LX_DXINVALIDATECACHE);
+	SET_IOCTL(/*0x25 */ dxgk_lock2,
+		  LX_DXLOCK2);
+	SET_IOCTL(/*0x26 */ dxgk_mark_device_as_error,
+		  LX_DXMARKDEVICEASERROR);
+	SET_IOCTL(/*0x27 */ dxgk_offer_allocations,
+		  LX_DXOFFERALLOCATIONS);
 	SET_IOCTL(/*0x28 */ dxgk_open_resource,
 		  LX_DXOPENRESOURCE);
 	SET_IOCTL(/*0x29 */ dxgk_open_sync_object,
 		  LX_DXOPENSYNCHRONIZATIONOBJECT);
+	SET_IOCTL(/*0x2a */ dxgk_query_alloc_residency,
+		  LX_DXQUERYALLOCATIONRESIDENCY);
 	SET_IOCTL(/*0x2b */ dxgk_query_resource_info,
 		  LX_DXQUERYRESOURCEINFO);
+	SET_IOCTL(/*0x2c */ dxgk_reclaim_allocations,
+		  LX_DXRECLAIMALLOCATIONS2);
 	SET_IOCTL(/*0x2d */ dxgk_render,
 		  LX_DXRENDER);
+	SET_IOCTL(/*0x2e */ dxgk_set_allocation_priority,
+		  LX_DXSETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x2f */ dxgk_set_context_process_scheduling_priority,
+		  LX_DXSETCONTEXTINPROCESSSCHEDULINGPRIORITY);
+	SET_IOCTL(/*0x30 */ dxgk_set_context_scheduling_priority,
+		  LX_DXSETCONTEXTSCHEDULINGPRIORITY);
 	SET_IOCTL(/*0x31 */ dxgk_signal_sync_object_cpu,
 		  LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x32 */ dxgk_signal_sync_object_gpu,
@@ -3993,10 +5429,20 @@ void init_ioctls(void)
 		  LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE);
 	SET_IOCTL(/*0x36 */ dxgk_submit_signal_to_hwqueue,
 		  LX_DXSUBMITSIGNALSYNCOBJECTSTOHWQUEUE);
+	SET_IOCTL(/*0x37 */ dxgk_unlock2,
+		  LX_DXUNLOCK2);
+	SET_IOCTL(/*0x38 */ dxgk_update_alloc_property,
+		  LX_DXUPDATEALLOCPROPERTY);
+	SET_IOCTL(/*0x39 */ dxgk_update_gpu_va,
+		  LX_DXUPDATEGPUVIRTUALADDRESS);
 	SET_IOCTL(/*0x3a */ dxgk_wait_sync_object_cpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU);
 	SET_IOCTL(/*0x3b */ dxgk_wait_sync_object_gpu,
 		  LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU);
+	SET_IOCTL(/*0x3c */ dxgk_get_allocation_priority,
+		  LX_DXGETALLOCATIONPRIORITY);
+	SET_IOCTL(/*0x3d */ dxgk_query_clock_calibration,
+		  LX_DXQUERYCLOCKCALIBRATION);
 	SET_IOCTL(/*0x3e */ dxgk_enum_adapters3,
 		  LX_DXENUMADAPTERS3);
 	SET_IOCTL(/*0x3f */ dxgk_share_objects,
@@ -4007,4 +5453,8 @@ void init_ioctls(void)
 		  LX_DXQUERYRESOURCEINFOFROMNTHANDLE);
 	SET_IOCTL(/*0x42 */ dxgk_open_resource_nt,
 		  LX_DXOPENRESOURCEFROMNTHANDLE);
+	SET_IOCTL(/*0x43 */ dxgk_query_statistics,
+		  LX_DXQUERYSTATISTICS);
+	SET_IOCTL(/*0x44 */ dxgk_share_object_with_host,
+		  LX_DXSHAREOBJECTWITHHOST);
 }
-- 
2.32.0

