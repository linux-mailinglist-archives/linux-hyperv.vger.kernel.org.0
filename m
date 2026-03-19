Return-Path: <linux-hyperv+bounces-9591-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MXqLvBcvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9591-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5105F2D2275
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1801B325762F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520BF3FAE12;
	Thu, 19 Mar 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQO0p6hQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924DD3F9F56
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951943; cv=none; b=LQJSKnkRRe8JQXHSVyvjT3ha2Z3z2zKgrUsndvSqfSKhvJXXR1I9GXxMEpYrIvVTqPRs+QXfu3W3oE02RQa+3yUMvx0BugLCWKqx2BhIc+op882M7VmB96wj5qJcRu0uxo+LxWlC+siutRyLeNh/tsibPqkakuqzQqaBBXOlFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951943; c=relaxed/simple;
	bh=3j1wDPqQSZdr8k5MF2F6ulqP/7AQz9mW4yJoIeHwvak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1aJ4tKLoyws21IsHZiBrmLTMT9kBdtmHXYx9ybIW5+2CUF5r5uWEj+hhWXevy3e4LL3svGNOFl0q+pNOn4aCqtCiDCHyyhe9aQ6VY9p5+VorJqF6j3CyvEAzyp4F26oiyiYi2cpvC3FZRBMww+43+0iiaqRABb79+3TtmghTXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQO0p6hQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so12259985e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951935; x=1774556735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZXgxsCauWvKSz1NA+qHkAzZKiqBTe7iEdmrrC0fzSs=;
        b=fQO0p6hQ5wPIe4cnsobl2IPAVkwgAX7lXtRU3KB2m9FtPqRn7jFOF1De0S4eU9zFeu
         NJ4bCzwTFeHPxDmqgF6p2/f5Hwz/5VawxP2Zz/T4PVZTBghTUhMv4a4pZvssgE6m/aRD
         hfsx0Rgb3BFSvo0ziv897cDV+HE49QU4iRCwoa1wKdXY46BYc5MUtVDEAD10T14OKKtr
         G8L936j2XL1c1ukMKUXcJlYloTSjZcB1fDNscpx0p79uVxkbW2BLa8zlk6ORYR23aLBt
         nteJ2ItzqDJPyrg1z4kaBOl0lg8I5kQ2CviRb3bdPgfpgrcmlXvQQb4q0KMM+n3sEAIw
         oumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951935; x=1774556735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+ZXgxsCauWvKSz1NA+qHkAzZKiqBTe7iEdmrrC0fzSs=;
        b=HVPvkIPee4P5v5baV7pqT3cyxaerMZyHZRPsgtziKO5H8aigVMDj1YXsASGHehWy3k
         OvzcFLbPVZSiVNoeosWXXecOodMco0ETveUV7FAtpCp8aRypmvv0jwiWfKZgz1fEcJ7I
         Ai1tnKq2G3qUnL1UUQqihhLlb3kU1GUOm4atmL2kCcyu43ylB7E7fFfMhJs5LZtr0Vf3
         XWtvuNU//yQuc0cNNmQqUWp2NTWU9bdDxNJnxCud+qU/98oWR59hsSmo+mrdg8bbM+p+
         LuNnaMdHf7VVQh3i+Sn3M7YsO0ITJD1YA3FIAdoQmTN3BH1iRnmsFhTGgUcAebdpw3jM
         /2+w==
X-Gm-Message-State: AOJu0YxoRfFkX3IpwawiEsUYlBdckpfeCPvo1t11AH3Nx8gmoqzyop8I
	gMTbqleEp2kTP7zWH/qXCbZjAXEBKK1+oLijsTNuNYnWSjdpvqH3dQnC3ZU7ahxUfE4=
X-Gm-Gg: ATEYQzxVoOcmw/lfWROwbAGaIch/Eej9LVqYfOwAN+7OFd59tpjXJ6ZH+WJvDBDpPT/
	TWuAw3hgEi6MNsOpaFDe7oaf349s7U0k/8nkpHoxfSOryzbZl1lvKhv7SNHrngBqkYV/G+vlIRQ
	iYMIQOMgqzI5H6/Xtfvmb34qQEsmnjLg7ghWdzlWTl3sVLepqgSJlosbuHPRVRnKijXEHg/c0NY
	QA9YtlKMPvanG36VmdJohP2aFjI7UQ+16VR2LoAFPCGzdG2T/xE+WiUcmxzE4seoY92HDCQQ7yt
	Ql7/ja2qk3UAI8T4xL7VgzTxR6jv/5mdKdMSPmtBNQDmLqLdHW0JOLGN4GSdUBHr7CBfIy5t864
	fjVxhMiZsFiSvIzARpm82/Wg0+f7xi8e7TmucDWcNDDIHCrKfRT5/oGLhY7WmawUHnsloFxcit7
	oQ2Xt+AZTzIa3LcOTE1gR3EMOdlTi7KLkCKCoKWGPhDYqowMY7
X-Received: by 2002:a05:6000:2007:b0:43b:41df:705e with SMTP id ffacd0b85a97d-43b6428aa4fmr1299751f8f.49.1773951934625;
        Thu, 19 Mar 2026 13:25:34 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:34 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 18/55] drivers: hv: dxgkrnl: Manage device allocation properties
Date: Thu, 19 Mar 2026 20:24:32 +0000
Message-ID: <20260319202509.63802-19-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9591-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5105F2D2275
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to manage properties of a compute device allocation:
  - LX_DXUPDATEALLOCPROPERTY,
  - LX_DXSETALLOCATIONPRIORITY,
  - LX_DXGETALLOCATIONPRIORITY,
  - LX_DXQUERYALLOCATIONRESIDENCY.
  - LX_DXCHANGEVIDEOMEMORYRESERVATION,

The LX_DXUPDATEALLOCPROPERTY ioctl requests the host to update
various properties of a compute devoce allocation.

The LX_DXSETALLOCATIONPRIORITY and LX_DXGETALLOCATIONPRIORITY ioctls
are used to set/get allocation priority, which defines the
importance of the allocation to be in the local device memory.

The LX_DXQUERYALLOCATIONRESIDENCY ioctl queries if the allocation
is located in the compute device accessible memory.

The LX_DXCHANGEVIDEOMEMORYRESERVATION ioctl changes compute device
memory reservation of an allocation.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  21 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 300 ++++++++++++++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  50 ++++++
 drivers/hv/dxgkrnl/ioctl.c    | 217 +++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  | 127 ++++++++++++++
 5 files changed, 708 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 1d6b552f1c1a..7fefe4617488 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -851,6 +851,23 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
 int dxgvmb_send_unlock2(struct dxgprocess *process,
 			struct dxgadapter *adapter,
 			struct d3dkmt_unlock2 *args);
+int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dddi_updateallocproperty *args,
+				      struct d3dddi_updateallocproperty *__user
+				      inargs);
+int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_setallocationpriority *a);
+int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
+					struct dxgadapter *adapter,
+					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
+					  struct dxgadapter *adapter,
+					  struct d3dkmthandle other_process,
+					  struct
+					  d3dkmt_changevideomemoryreservation
+					  *args);
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
@@ -870,6 +887,10 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 				    struct d3dkmt_opensyncobjectfromnthandle2
 				    *args,
 				    struct dxgsyncobject *syncobj);
+int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
+				      struct dxgadapter *adapter,
+				      struct d3dkmt_queryallocationresidency
+				      *args);
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index a80f84d9065a..dd2c97fee27b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1829,6 +1829,79 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 	return ret;
 }
 
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
+			DXG_ERR("failed to copy alloc handles");
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
+		DXG_ERR("failed to copy residency status");
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_get_device_state(struct dxgprocess *process,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_getdevicestate *args,
@@ -2461,6 +2534,233 @@ int dxgvmb_send_unlock2(struct dxgprocess *process,
 	return ret;
 }
 
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
+			DXG_ERR("failed to copy paging fence");
+			ret = -EINVAL;
+		}
+	}
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
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
+		DXG_ERR("failed to copy alloc handle");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	ret = copy_from_user((u8 *) allocations + alloc_size,
+				args->priorities, priority_size);
+	if (ret) {
+		DXG_ERR("failed to copy alloc priority");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
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
+		DXG_ERR("failed to copy alloc handles");
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
+		DXG_ERR("failed to copy priorities");
+		ret = -EINVAL;
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
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
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_CHANGEVIDEOMEMORYRESERVATION,
+				   process->host_handle);
+	command->args = *args;
+	command->args.process = other_process.v;
+
+	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
+cleanup:
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_createhwqueue *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 447bb1ba391b..dbb01b9ab066 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -308,6 +308,29 @@ struct dxgkvmb_command_queryadapterinfo_return {
 	u8				private_data[1];
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_setallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle    allocations[allocation_count or 0]; */
+	/* u32 priorities[allocation_count or 1]; */
+};
+
+struct dxgkvmb_command_getallocationpriority {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+	u32				allocation_count;
+	/* struct d3dkmthandle allocations[allocation_count or 0]; */
+};
+
+struct dxgkvmb_command_getallocationpriority_return {
+	struct ntstatus			status;
+	/* u32 priorities[allocation_count or 1]; */
+};
+
 struct dxgkvmb_command_createdevice {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_createdeviceflags	flags;
@@ -589,6 +612,22 @@ struct dxgkvmb_command_unlock2 {
 	bool				use_legacy_unlock;
 };
 
+struct dxgkvmb_command_updateallocationproperty {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_updateallocproperty args;
+};
+
+struct dxgkvmb_command_updateallocationproperty_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+};
+
+/* Returns ntstatus */
+struct dxgkvmb_command_changevideomemoryreservation {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_changevideomemoryreservation args;
+};
+
 /* Returns the same structure */
 struct dxgkvmb_command_createhwqueue {
 	struct dxgkvmb_command_vgpu_to_host hdr;
@@ -609,6 +648,17 @@ struct dxgkvmb_command_destroyhwqueue {
 	struct d3dkmthandle		hwqueue;
 };
 
+struct dxgkvmb_command_queryallocationresidency {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_queryallocationresidency args;
+	/* struct d3dkmthandle allocations[0 or number of allocations] */
+};
+
+struct dxgkvmb_command_queryallocationresidency_return {
+	struct ntstatus			status;
+	/* d3dkmt_allocationresidencystatus[NumAllocations] */
+};
+
 struct dxgkvmb_command_getdevicestate {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_getdevicestate	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 37e218443310..b626e2518ff2 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3214,7 +3214,7 @@ dxgkio_lock2(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 
 success:
-	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
 	return ret;
 }
 
@@ -3294,7 +3294,209 @@ dxgkio_unlock2(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 
 success:
-	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_update_alloc_property(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dddi_updateallocproperty args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryallocationresidency args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_set_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_setallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_getallocationpriority args;
+	struct dxgadapter *adapter = NULL;
+	struct dxgdevice *device = NULL;
+	int ret;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_changevideomemoryreservation args;
+	int ret;
+	struct dxgadapter *adapter = NULL;
+	bool adapter_locked = false;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.process != 0) {
+		DXG_ERR("setting memory reservation for other process");
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
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
 	return ret;
 }
 
@@ -4050,7 +4252,8 @@ static struct ioctl_desc ioctls[] = {
 /* 0x13 */	{dxgkio_destroy_allocation, LX_DXDESTROYALLOCATION2},
 /* 0x14 */	{dxgkio_enum_adapters, LX_DXENUMADAPTERS2},
 /* 0x15 */	{dxgkio_close_adapter, LX_DXCLOSEADAPTER},
-/* 0x16 */	{},
+/* 0x16 */	{dxgkio_change_vidmem_reservation,
+		  LX_DXCHANGEVIDEOMEMORYRESERVATION},
 /* 0x17 */	{},
 /* 0x18 */	{dxgkio_create_hwqueue, LX_DXCREATEHWQUEUE},
 /* 0x19 */	{dxgkio_destroy_device, LX_DXDESTROYDEVICE},
@@ -4070,11 +4273,11 @@ static struct ioctl_desc ioctls[] = {
 /* 0x27 */	{},
 /* 0x28 */	{},
 /* 0x29 */	{},
-/* 0x2a */	{},
+/* 0x2a */	{dxgkio_query_alloc_residency, LX_DXQUERYALLOCATIONRESIDENCY},
 /* 0x2b */	{},
 /* 0x2c */	{},
 /* 0x2d */	{},
-/* 0x2e */	{},
+/* 0x2e */	{dxgkio_set_allocation_priority, LX_DXSETALLOCATIONPRIORITY},
 /* 0x2f */	{},
 /* 0x30 */	{},
 /* 0x31 */	{dxgkio_signal_sync_object_cpu,
@@ -4089,13 +4292,13 @@ static struct ioctl_desc ioctls[] = {
 /* 0x36 */	{dxgkio_submit_wait_to_hwqueue,
 		 LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE},
 /* 0x37 */	{dxgkio_unlock2, LX_DXUNLOCK2},
-/* 0x38 */	{},
+/* 0x38 */	{dxgkio_update_alloc_property, LX_DXUPDATEALLOCPROPERTY},
 /* 0x39 */	{},
 /* 0x3a */	{dxgkio_wait_sync_object_cpu,
 		 LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU},
 /* 0x3b */	{dxgkio_wait_sync_object_gpu,
 		 LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU},
-/* 0x3c */	{},
+/* 0x3c */	{dxgkio_get_allocation_priority, LX_DXGETALLOCATIONPRIORITY},
 /* 0x3d */	{},
 /* 0x3e */	{dxgkio_enum_adapters3, LX_DXENUMADAPTERS3},
 /* 0x3f */	{dxgkio_share_objects, LX_DXSHAREOBJECTS},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index b498f09e694d..af381101fd90 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -668,6 +668,63 @@ struct d3dkmt_submitcommandtohwqueue {
 #endif
 };
 
+struct d3dkmt_setallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	const __u32			*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+struct d3dkmt_getallocationpriority {
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		resource;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+#else
+	__u64				allocation_list;
+#endif
+	__u32				allocation_count;
+	__u32				reserved;
+#ifdef __KERNEL__
+	__u32				*priorities;
+#else
+	__u64				priorities;
+#endif
+};
+
+enum d3dkmt_allocationresidencystatus {
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINGPUMEMORY		= 1,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_RESIDENTINSHAREDMEMORY	= 2,
+	_D3DKMT_ALLOCATIONRESIDENCYSTATUS_NOTRESIDENT			= 3,
+};
+
+struct d3dkmt_queryallocationresidency {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			resource;
+#ifdef __KERNEL__
+	struct d3dkmthandle			*allocations;
+#else
+	__u64					allocations;
+#endif
+	__u32					allocation_count;
+	__u32					reserved;
+#ifdef __KERNEL__
+	enum d3dkmt_allocationresidencystatus	*residency_status;
+#else
+	__u64					residency_status;
+#endif
+};
+
 struct d3dddicb_lock2flags {
 	union {
 		struct {
@@ -835,6 +892,11 @@ struct d3dkmt_destroyallocation2 {
 	struct d3dddicb_destroyallocation2flags flags;
 };
 
+enum d3dkmt_memory_segment_group {
+	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
+	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
+};
+
 struct d3dkmt_adaptertype {
 	union {
 		struct {
@@ -886,6 +948,61 @@ struct d3dddi_openallocationinfo2 {
 	__u64			reserved[6];
 };
 
+struct d3dddi_updateallocproperty_flags {
+	union {
+		struct {
+			__u32			accessed_physically:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_segmentpreference {
+	union {
+		struct {
+			__u32			segment_id0:5;
+			__u32			direction0:1;
+			__u32			segment_id1:5;
+			__u32			direction1:1;
+			__u32			segment_id2:5;
+			__u32			direction2:1;
+			__u32			segment_id3:5;
+			__u32			direction3:1;
+			__u32			segment_id4:5;
+			__u32			direction4:1;
+			__u32			reserved:2;
+		};
+		__u32				value;
+	};
+};
+
+struct d3dddi_updateallocproperty {
+	struct d3dkmthandle			paging_queue;
+	struct d3dkmthandle			allocation;
+	__u32					supported_segment_set;
+	struct d3dddi_segmentpreference		preferred_segment;
+	struct d3dddi_updateallocproperty_flags	flags;
+	__u64					paging_fence_value;
+	union {
+		struct {
+			__u32			set_accessed_physically:1;
+			__u32			set_supported_segmentSet:1;
+			__u32			set_preferred_segment:1;
+			__u32			reserved:29;
+		};
+		__u32				property_mask_value;
+	};
+};
+
+struct d3dkmt_changevideomemoryreservation {
+	__u64			process;
+	struct d3dkmthandle	adapter;
+	enum d3dkmt_memory_segment_group memory_segment_group;
+	__u64			reservation;
+	__u32			physical_adapter_index;
+};
+
 struct d3dkmt_createhwqueue {
 	struct d3dkmthandle	context;
 	struct d3dddi_createhwqueueflags flags;
@@ -1099,6 +1216,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x14, struct d3dkmt_enumadapters2)
 #define LX_DXCLOSEADAPTER		\
 	_IOWR(0x47, 0x15, struct d3dkmt_closeadapter)
+#define LX_DXCHANGEVIDEOMEMORYRESERVATION \
+	_IOWR(0x47, 0x16, struct d3dkmt_changevideomemoryreservation)
 #define LX_DXCREATEHWQUEUE		\
 	_IOWR(0x47, 0x18, struct d3dkmt_createhwqueue)
 #define LX_DXDESTROYHWQUEUE		\
@@ -1111,6 +1230,10 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
 #define LX_DXLOCK2			\
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
+#define LX_DXQUERYALLOCATIONRESIDENCY	\
+	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
+#define LX_DXSETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x31, struct d3dkmt_signalsynchronizationobjectfromcpu)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMGPU \
@@ -1125,10 +1248,14 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x36, struct d3dkmt_submitwaitforsyncobjectstohwqueue)
 #define LX_DXUNLOCK2			\
 	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
+#define LX_DXUPDATEALLOCPROPERTY	\
+	_IOWR(0x47, 0x38, struct d3dddi_updateallocproperty)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \
 	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
+#define LX_DXGETALLOCATIONPRIORITY	\
+	_IOWR(0x47, 0x3c, struct d3dkmt_getallocationpriority)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 #define LX_DXSHAREOBJECTS		\

