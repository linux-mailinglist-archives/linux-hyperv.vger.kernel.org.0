Return-Path: <linux-hyperv+bounces-9598-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AP31IHhcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9598-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4992D21F4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 148343065862
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB41F3FCB00;
	Thu, 19 Mar 2026 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0kT3v+7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446143FB067
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951949; cv=none; b=E3xUeNXUq/PfQfJm/tqCnc5tXbYJjW6o56XhQP/z1adK6lxaybk7LQRPs9nM81g2Ap3whjx+FwANXDHXhHzQXd12VUSzHI/YLrGOCC0OhydpDRpghvMwmBo5s7JBFVStQCYSA8uC9HLXFMUCBZshprrW+aKblUL7W3+yGAVhJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951949; c=relaxed/simple;
	bh=PrVjDos1wa71PrV7Y/ZBU6TbhGZpn+nSvhkDy9ptgyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUgTDlvn5FbmYN1psfyyH/d3sXZwXwOcnCKjXFpkCKlhzCj0CoxVJot8B4BhdIlidmNkmvULGpAwx4piO+/jHoLRxXS/+Rj6yvjzDBFgtRsElwR0wjfHv9qYQedO3ckyB11E9/q2+4nvP3dFUv5QkatDjlxYNjDOilcrUSByfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0kT3v+7; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1477831f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951943; x=1774556743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VRkcrNVWoDrrgx573fUCy9gOqPQFhMLeiPub9tIbpRM=;
        b=K0kT3v+7/AbKjrFzw65r9vHJ1GO/YJ+mPGurrUqgk/MN5iGHfHJTJ/+daXi50RIJ1H
         iOpYOclJ5+Bc1m4c1RaIHjZawWKz80aVGl8q2o7UNcubJa/UPegHs0xVG2rWCFFIhpPD
         iX5h4e5uMTzSMw0RQX2LT6MZgzz0tkeIqdre87vt9nfKvAsI/1LpvYRLfnuEqTxFHEU8
         0IpSmpUaotchqBqJFlhXBJJUCdOW5sDijud3F1yruF+mfhUgEDKg8fkLQ9lT95bh9QQT
         7nvGZQp3kZwihs4/Bv9G1y0cul0wiui72GFXPXPUGB5aQin8d+RfeSBeHh6oNHUqZczX
         ml+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951943; x=1774556743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VRkcrNVWoDrrgx573fUCy9gOqPQFhMLeiPub9tIbpRM=;
        b=ImEBlJQ4N6zwzWVgu9JC/TQjr4+I8goXXx8ubA39G4QCnC8rWt2LCoTfPoH4ENNFon
         CoIqa6BkvpySQwwfQcw5iPij/D4tA0Gg3qVb5Dz1JsZJQkf/KAl6YIerS7v7nMXLdZP+
         aLOonb/mWEqv/3ozqyVpfPvfm/RJgmtyQ4q/FsFH53GJHBk6iZwc20rMAmsOkqvvgfE/
         zgkuGWpFlJ3pBXnQdN+1Te3VJUL1BuC/OwyfB5MkGJlIXY30R0TjhVFKELPx8OZrCuza
         c1Dv+8lcg+d2lLGC0PK11MP6+Kf7lBILy7iEthyivPQvfvivUiua+In9x8Mgdfzpx4oM
         QBgA==
X-Gm-Message-State: AOJu0YwqGpe1wIuu642LQ7YLotj8LV01MjLCJQfZ1wxbTw1WmCoDJs7Z
	vBALl+jZRW/6CBHuiJW0LutBj+aUKE2bL7KgsEqdhfp6I4FLG9mrN6KiwBfemn/97R0=
X-Gm-Gg: ATEYQzwb9PeEd1mUFfiOVU1j088xMhOkqYIT8bjrzSgv6NeY9Rt502KVbOVY2JNoDoP
	Wf58l9WLZHrepqZq/zbjLki0zSTyZynQY2LVMufFvVSqca4LfLRcUcu4IP8eBykQI9JBck+HmJC
	C7J7sZjRJnmIKZdCK6Qbz5rvrNLziqGc/Gr20oSrRaQkezGVOTUSYtbw1WdZ/aliMKpMMNgUncE
	Q5+OZNARAZZ+rF0h2diauCDP+Kfg01JAMx2khEYHL4XbSrS9mVrQC0DLYBL9d77KhR9etvUOdiA
	MPgxdpU0ljWZugKjZtJujDRZK0aha41B/HmzKvYaYiJoJRTGRfqvd9kkdD7rSft8bNL+uzZoSK2
	70ezYWKvj+klpssMCCpj8oA+B6FDT3hOl6pYItioDX/hWldgPD+gaAKd4gUlgtvJ5urMZ8L1bpZ
	KZqjcEcQnMRuFusZdBhCAYKRkXxK+drfwT74/i2Y1R+z4QhIHe
X-Received: by 2002:a05:6000:2f84:b0:439:ac98:751f with SMTP id ffacd0b85a97d-43b642424d6mr1106631f8f.23.1773951943370;
        Thu, 19 Mar 2026 13:25:43 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:42 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 26/55] drivers: hv: dxgkrnl: Manage residency of allocations
Date: Thu, 19 Mar 2026 20:24:40 +0000
Message-ID: <20260319202509.63802-27-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9598-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 3A4992D21F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to manage residency of compute device allocations:
  - LX_DXMAKERESIDENT,
  - LX_DXEVICT.

An allocation is "resident" when the compute devoce is setup to
access it. It means that the allocation is in the local device
memory or in non-pageable system memory.

The current design does not support on demand compute device page
faulting. An allocation must be resident before the compute device
is allowed to access it.

The LX_DXMAKERESIDENT ioctl instructs the video memory manager to
make the given allocations resident. The operation is submitted to
a paging queue (dxgpagingqueue). When the ioctl returns a "pending"
status, a monitored fence sync object can be used to synchronize
with the completion of the operation.

The LX_DXEVICT ioctl istructs the video memory manager to evict
the given allocations from device accessible memory.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   4 +
 drivers/hv/dxgkrnl/dxgvmbus.c |  98 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  27 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 141 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  |  54 +++++++++++++
 5 files changed, 322 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 02d10bdcc820..93c3ceb23865 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -810,6 +810,10 @@ int dxgvmb_send_create_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 int dxgvmb_send_destroy_allocation(struct dxgprocess *pr, struct dxgdevice *dev,
 				   struct d3dkmt_destroyallocation2 *args,
 				   struct d3dkmthandle *alloc_handles);
+int dxgvmb_send_make_resident(struct dxgprocess *pr, struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args);
+int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
+		      struct d3dkmt_evict *args);
 int dxgvmb_send_submit_command(struct dxgprocess *pr,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args);
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 9a610d48bed7..f4c4a7e7ad8b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2279,6 +2279,104 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 	return ret;
 }
 
+int dxgvmb_send_make_resident(struct dxgprocess *process,
+			      struct dxgadapter *adapter,
+			      struct d3dddi_makeresident *args)
+{
+	int ret;
+	u32 cmd_size;
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
+		DXG_ERR("failed to copy alloc handles");
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
+		DXG_ERR("send_make_resident failed %x", ret);
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
+		DXG_TRACE("err: %d", ret);
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
+		DXG_ERR("failed to copy alloc handles");
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
+		DXG_ERR("send_evict failed %x", ret);
+		goto cleanup;
+	}
+	args->num_bytes_to_trim = result.num_bytes_to_trim;
+
+cleanup:
+
+	free_message(&msg, process);
+	if (ret)
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_submit_command(struct dxgprocess *process,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args)
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 509482e1f870..23f92ab9f8ad 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -372,6 +372,33 @@ struct dxgkvmb_command_flushdevice {
 	enum dxgdevice_flushschedulerreason	reason;
 };
 
+struct dxgkvmb_command_makeresident {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	struct d3dddi_makeresident_flags flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_makeresident_return {
+	u64			paging_fence_value;
+	u64			num_bytes_to_trim;
+	struct ntstatus		status;
+};
+
+struct dxgkvmb_command_evict {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dddi_evict_flags	flags;
+	u32				alloc_count;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_evict_return {
+	u64			num_bytes_to_trim;
+};
+
 struct dxgkvmb_command_submitcommand {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_submitcommand	args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index bc0adebe52ae..2700da51bc01 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1961,6 +1961,143 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_make_resident(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_makeresident args;
+	struct d3dddi_makeresident *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		DXG_ERR("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+	if (args.paging_queue.v == 0) {
+		DXG_ERR("paging queue is missing");
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
+		DXG_ERR("Unexpected error %x", ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		DXG_ERR("failed to copy paging fence");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->num_bytes_to_trim,
+			    &args.num_bytes_to_trim, sizeof(u64));
+	if (ret2) {
+		DXG_ERR("failed to copy bytes to trim");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+
+	return ret;
+}
+
+static int
+dxgkio_evict(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_evict args;
+	struct d3dkmt_evict *input = inargs;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.alloc_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.alloc_count == 0) {
+		DXG_ERR("invalid number of allocations");
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
+		DXG_ERR("failed to copy bytes to trim to user");
+		ret = -EINVAL;
+	}
+cleanup:
+
+	if (adapter)
+		dxgadapter_release_lock_shared(adapter);
+	if (device)
+		kref_put(&device->device_kref, dxgdevice_release);
+
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_offer_allocations(struct dxgprocess *process, void *__user inargs)
 {
@@ -4797,7 +4934,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x08 */	{},
 /* 0x09 */	{dxgkio_query_adapter_info, LX_DXQUERYADAPTERINFO},
 /* 0x0a */	{dxgkio_query_vidmem_info, LX_DXQUERYVIDEOMEMORYINFO},
-/* 0x0b */	{},
+/* 0x0b */	{dxgkio_make_resident, LX_DXMAKERESIDENT},
 /* 0x0c */	{},
 /* 0x0d */	{dxgkio_escape, LX_DXESCAPE},
 /* 0x0e */	{dxgkio_get_device_state, LX_DXGETDEVICESTATE},
@@ -4817,7 +4954,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x1b */	{dxgkio_destroy_hwqueue, LX_DXDESTROYHWQUEUE},
 /* 0x1c */	{dxgkio_destroy_paging_queue, LX_DXDESTROYPAGINGQUEUE},
 /* 0x1d */	{dxgkio_destroy_sync_object, LX_DXDESTROYSYNCHRONIZATIONOBJECT},
-/* 0x1e */	{},
+/* 0x1e */	{dxgkio_evict, LX_DXEVICT},
 /* 0x1f */	{dxgkio_flush_heap_transitions, LX_DXFLUSHHEAPTRANSITIONS},
 /* 0x20 */	{},
 /* 0x21 */	{dxgkio_get_context_process_scheduling_priority,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index a9bafab97c18..944f9d1e73d6 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -962,6 +962,56 @@ struct d3dkmt_destroyallocation2 {
 	struct d3dddicb_destroyallocation2flags flags;
 };
 
+struct d3dddi_makeresident_flags {
+	union {
+		struct {
+			__u32		cant_trim_further:1;
+			__u32		must_succeed:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dddi_makeresident {
+	struct d3dkmthandle		paging_queue;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocation_list;
+	const __u32			*priority_list;
+#else
+	__u64				allocation_list;
+	__u64				priority_list;
+#endif
+	struct d3dddi_makeresident_flags flags;
+	__u64				paging_fence_value;
+	__u64				num_bytes_to_trim;
+};
+
+struct d3dddi_evict_flags {
+	union {
+		struct {
+			__u32		evict_only_if_necessary:1;
+			__u32		not_written_to:1;
+			__u32		reserved:30;
+		};
+		__u32			value;
+	};
+};
+
+struct d3dkmt_evict {
+	struct d3dkmthandle		device;
+	__u32				alloc_count;
+#ifdef __KERNEL__
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				allocations;
+#endif
+	struct d3dddi_evict_flags	flags;
+	__u32				reserved;
+	__u64				num_bytes_to_trim;
+};
+
 enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
@@ -1407,6 +1457,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
+#define LX_DXMAKERESIDENT		\
+	_IOWR(0x47, 0x0b, struct d3dddi_makeresident)
 #define LX_DXESCAPE			\
 	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
@@ -1437,6 +1489,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x19, struct d3dkmt_destroydevice)
 #define LX_DXDESTROYSYNCHRONIZATIONOBJECT \
 	_IOWR(0x47, 0x1d, struct d3dkmt_destroysynchronizationobject)
+#define LX_DXEVICT			\
+	_IOWR(0x47, 0x1e, struct d3dkmt_evict)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
 #define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \

