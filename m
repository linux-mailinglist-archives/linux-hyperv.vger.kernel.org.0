Return-Path: <linux-hyperv+bounces-9596-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGfeEFNcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9596-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4BB2D21B1
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 740D2303DF75
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C703FB7FF;
	Thu, 19 Mar 2026 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZkqHL2B"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B763FAE11
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951947; cv=none; b=rlHf2ZE7UiX41NxjMW2YLa/zuNT0U2j+W37MJw+GYW+cKbe4ITG1M1joBsYcQw8L9677pmBtboWQqLFvSQ4eTOjploMbuuznEzF967A3WwZZImKoENHVslktdNtPonhRNyfWGUgBg0RYrwP0Pgx7Bvk5SXmDQ83sf/YV2sgUYSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951947; c=relaxed/simple;
	bh=fEmYhkE9WL70ZTMxqR85nM8bi6WT0ZLiYvejlpetuSE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBpBFN2DpWUOwBIBTxzXwZXHw19xaR12w9ctDghLp2htItCmKUlMeNQH33+xUV0SePTRz5hsHhxAV36YPtWNkHhsGO6X5swjO4XKDihb/JKhI01X8m/Q8jEt3RLWtFwebzENDRorJuQ4gGSyEnkY4f6Zfl43M9HjjIvbsaudxUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZkqHL2B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4d73463dso946336f8f.3
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951941; x=1774556741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKsBdugocoQmJoY++9YCzacKrwO/Pe+LkVEnylf4tv8=;
        b=FZkqHL2Bymvztggk2Nk5qJfDw7HW8Mvtj2nnQ5rQPj8bTkGdTCU2FTEGG/U9tSGGQY
         20U/xFuLRTd5Qw8FkSHPYJNz2tcYk87lvuFrmkEhQSeGZW8y8+tobKCcGfOaEbxb2cwQ
         36cc7gjXpyoduDAKF8GeWg5NmkDMhemoGwt5hH1ESbbNE+8mBneUCh6kyxQkLN5JKqJv
         qaF91dfA5SSUNwqnmFXT/VGz9Pgn4sHMw9rynScLMl2Lfp3cJH/NIpi/y5CKWFaVZ1B1
         hwbqh3zFj9dTU9+e/jqZK9yAJEDyhfhEmMoNxJD24oeTX1rlcFjyC9j6WQYMFcTQBXvi
         8QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951941; x=1774556741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XKsBdugocoQmJoY++9YCzacKrwO/Pe+LkVEnylf4tv8=;
        b=EfASlfw0uqicBs3C5dd3K8hx7Vh3qMHZgeMTEcfS9Aq7TWXXM4H3h5ZsbSf9lw2qwC
         bCEWjQ3eyRCNFpTfxk6jObFjYNtN92Tipw17SCvuff3MK58YGcHVrUZZc2mWZNjaqdR4
         kxQs+3wnbeQmU3ry6a3gPBpG35UZLDVcqTzOdSxksMaglLSs3iWOn+p429e+pJ2bJtp3
         PICw6WTHecAHqxu1Lx7UaVrNXHR8+7pcVpMouq312km5k41etMA4ERt2TEDOcd6TaULW
         kFQQpz2SVxuboQQqjxDn9FyA6YhmMIPiiYamhH/Iv4tBWOJGx8m8cXHlm3TeF7kEbNxC
         XKAg==
X-Gm-Message-State: AOJu0YyDqgS2jc4+FW3u4JbbA5PsgM4/cBh35CQLQYWM/yK7p4MZvOQ9
	giImIiRb9WgPwzE718HEQlA7dV/pvsyBqyhFKFklqWjNOgM7bQOlCFhVfd3OH+ulmUA=
X-Gm-Gg: ATEYQzz5BaoZZzpFrEedEdRXaGlej5015K6nS8iSqDXB8IncOTzODPGXnmuRB9+VKup
	IF+pJaerAp0m6+8np62AfWHO50xA3NFahfLICZlgC7lDezm5CJDVxLFn4SWM3zKbznhXgn+x8Hj
	3u3w8ABPoCRxm3TeV5emaVdB27x+kh0+a7y02MHw9hwbfdZjDgRAGYzL48oZ14SZcMTSW4ho3M5
	fEoJcp8Q28uqNW3lV75GidgzLeZey9hahtSCFvIsIlkOH4i161h7rVloSkgLF5JW3Uvsg7ihErt
	yhgtbf9YmhiD1XPNzg66KvLZ0WqF3ofy/oO1bRRpqiHn75zt1n9/AeOGaDShA35s5ZEHsc1Ykf3
	Z5SEVJhio02NR81IoQUmx0iyCVyXhlJMDReBzkxCmvksr+1OVFJhqyALOq5J/JLj5sYhVRUCnsG
	DKltTDpRuk6I4D39Nrqn48EJg3EI6K6yB81KwFi2QRQ50sxJxg
X-Received: by 2002:a5d:588f:0:b0:439:b3a3:7239 with SMTP id ffacd0b85a97d-43b6423fb3dmr1306490f8f.5.1773951941251;
        Thu, 19 Mar 2026 13:25:41 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:40 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 24/55] drivers: hv: dxgkrnl: Offer and reclaim allocations
Date: Thu, 19 Mar 2026 20:24:38 +0000
Message-ID: <20260319202509.63802-25-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9596-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AF4BB2D21B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to offer and reclaim compute device allocations:
  - LX_DXOFFERALLOCATIONS,
  - LX_DXRECLAIMALLOCATIONS2

When a user mode driver (UMD) does not need to access an allocation,
it can "offer" it by issuing the LX_DXOFFERALLOCATIONS ioctl.  This
means that the allocation is not in use and its local device memory
could be evicted. The freed space could be given to another allocation.
When the allocation is again needed, the UMD can attempt to"reclaim"
the allocation by issuing the LX_DXRECLAIMALLOCATIONS2 ioctl. If the
allocation is still not evicted, the reclaim operation succeeds and no
other action is required. If the reclaim operation fails, the caller
must restore the content of the allocation before it can be used by
the device.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 +++
 drivers/hv/dxgkrnl/dxgvmbus.c | 124 +++++++++++++++++++++++++++++++++-
 drivers/hv/dxgkrnl/dxgvmbus.h |  27 ++++++++
 drivers/hv/dxgkrnl/ioctl.c    | 117 +++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  |  67 ++++++++++++++++++
 5 files changed, 340 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index a55873bdd9a6..494ea8fb0bb3 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -865,6 +865,14 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 					struct dxgadapter *adapter,
 					struct d3dkmt_getallocationpriority *a);
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args);
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64 __user *paging_fence_value);
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 9a1864bb4e14..8448fd78975b 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1858,7 +1858,7 @@ int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
 	ret = copy_to_user(&inargs->clock_data, &result.clock_data,
 			   sizeof(result.clock_data));
 	if (ret) {
-		pr_err("%s failed to copy clock data", __func__);
+		DXG_ERR("failed to copy clock data");
 		ret = -EINVAL;
 		goto cleanup;
 	}
@@ -2949,6 +2949,128 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	return ret;
 }
 
+int dxgvmb_send_offer_allocations(struct dxgprocess *process,
+				  struct dxgadapter *adapter,
+				  struct d3dkmt_offerallocations *args)
+{
+	struct dxgkvmb_command_offerallocations *command;
+	int ret = -EINVAL;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_offerallocations) +
+			alloc_size - sizeof(struct d3dkmthandle);
+	struct dxgvmbusmsg msg = {.hdr = NULL};
+
+	ret = init_message(&msg, adapter, process, cmd_size);
+	if (ret)
+		goto cleanup;
+	command = (void *)msg.msg;
+
+	command_vgpu_to_host_init2(&command->hdr,
+				   DXGK_VMBCOMMAND_OFFERALLOCATIONS,
+				   process->host_handle);
+	command->flags = args->flags;
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
+	}
+	if (ret) {
+		DXG_ERR("failed to copy input handles");
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
+int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
+				    struct dxgadapter *adapter,
+				    struct d3dkmthandle device,
+				    struct d3dkmt_reclaimallocations2 *args,
+				    u64  __user *paging_fence_value)
+{
+	struct dxgkvmb_command_reclaimallocations *command;
+	struct dxgkvmb_command_reclaimallocations_return *result;
+	int ret;
+	u32 alloc_size = sizeof(struct d3dkmthandle) * args->allocation_count;
+	u32 cmd_size = sizeof(struct dxgkvmb_command_reclaimallocations) +
+	    alloc_size - sizeof(struct d3dkmthandle);
+	u32 result_size = sizeof(*result);
+	struct dxgvmbusmsgres msg = {.hdr = NULL};
+
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
+		DXG_ERR("failed to copy input handles");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
+				   result, msg.res_size);
+	if (ret < 0)
+		goto cleanup;
+	ret = copy_to_user(paging_fence_value,
+			   &result->paging_fence_value, sizeof(u64));
+	if (ret) {
+		DXG_ERR("failed to copy paging fence");
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
+			DXG_ERR("failed to copy results");
+			ret = -EINVAL;
+		}
+	}
+
+cleanup:
+	free_message((struct dxgvmbusmsg *)&msg, process);
+	if (ret)
+		pr_debug("err: %s %d", __func__, ret);
+	return ret;
+}
+
 int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 					  struct dxgadapter *adapter,
 					  struct d3dkmthandle other_process,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 17768ed0e68d..558c6576a262 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -653,6 +653,33 @@ struct dxgkvmb_command_markdeviceaserror {
 	struct d3dkmt_markdeviceaserror args;
 };
 
+/* Returns ntstatus */
+struct dxgkvmb_command_offerallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	bool				resources;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		paging_queue;
+	u32				allocation_count;
+	bool				resources;
+	bool				write_results;
+	struct d3dkmthandle		allocations[1];
+};
+
+struct dxgkvmb_command_reclaimallocations_return {
+	u64				paging_fence_value;
+	struct ntstatus			status;
+	enum d3dddi_reclaim_result	discarded[1];
+};
+
 /* Returns ntstatus */
 struct dxgkvmb_command_changevideomemoryreservation {
 	struct dxgkvmb_command_vgpu_to_host hdr;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 4babb21f38a9..fa880aa0196a 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -1961,6 +1961,119 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_offer_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_offerallocations args;
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
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		DXG_ERR("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		DXG_ERR("invalid pointer to resources/allocations");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_reclaimallocations2 args;
+	struct dxgdevice *device = NULL;
+	struct dxgadapter *adapter = NULL;
+	struct d3dkmt_reclaimallocations2 * __user in_args = inargs;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if (args.allocation_count > D3DKMT_MAKERESIDENT_ALLOC_MAX ||
+	    args.allocation_count == 0) {
+		DXG_ERR("invalid number of allocations");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	if ((args.resources == NULL) == (args.allocations == NULL)) {
+		DXG_ERR("invalid pointer to resources/allocations");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkio_submit_command(struct dxgprocess *process, void *__user inargs)
 {
@@ -4548,12 +4661,12 @@ static struct ioctl_desc ioctls[] = {
 /* 0x24 */	{},
 /* 0x25 */	{dxgkio_lock2, LX_DXLOCK2},
 /* 0x26 */	{dxgkio_mark_device_as_error, LX_DXMARKDEVICEASERROR},
-/* 0x27 */	{},
+/* 0x27 */	{dxgkio_offer_allocations, LX_DXOFFERALLOCATIONS},
 /* 0x28 */	{},
 /* 0x29 */	{},
 /* 0x2a */	{dxgkio_query_alloc_residency, LX_DXQUERYALLOCATIONRESIDENCY},
 /* 0x2b */	{},
-/* 0x2c */	{},
+/* 0x2c */	{dxgkio_reclaim_allocations, LX_DXRECLAIMALLOCATIONS2},
 /* 0x2d */	{},
 /* 0x2e */	{dxgkio_set_allocation_priority, LX_DXSETALLOCATIONPRIORITY},
 /* 0x2f */	{},
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index ea18242ceb83..46b9f6d303bf 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -61,6 +61,7 @@ struct winluid {
 #define D3DDDI_MAX_WRITTEN_PRIMARIES		16
 
 #define D3DKMT_CREATEALLOCATION_MAX		1024
+#define D3DKMT_MAKERESIDENT_ALLOC_MAX		(1024 * 10)
 #define D3DKMT_ADAPTERS_MAX			64
 #define D3DDDI_MAX_BROADCAST_CONTEXT		64
 #define D3DDDI_MAX_OBJECT_WAITED_ON		32
@@ -1087,6 +1088,68 @@ struct d3dddi_updateallocproperty {
 	};
 };
 
+enum d3dkmt_offer_priority {
+	_D3DKMT_OFFER_PRIORITY_LOW	= 1,
+	_D3DKMT_OFFER_PRIORITY_NORMAL	= 2,
+	_D3DKMT_OFFER_PRIORITY_HIGH	= 3,
+	_D3DKMT_OFFER_PRIORITY_AUTO	= 4,
+};
+
+struct d3dkmt_offer_flags {
+	union {
+		struct {
+			__u32	offer_immediately:1;
+			__u32	allow_decommit:1;
+			__u32	reserved:30;
+		};
+		__u32		value;
+	};
+};
+
+struct d3dkmt_offerallocations {
+	struct d3dkmthandle		device;
+	__u32				reserved;
+#ifdef __KERNEL__
+	struct d3dkmthandle		*resources;
+	const struct d3dkmthandle	*allocations;
+#else
+	__u64				resources;
+	__u64				allocations;
+#endif
+	__u32				allocation_count;
+	enum d3dkmt_offer_priority	priority;
+	struct d3dkmt_offer_flags	flags;
+	__u32				reserved1;
+};
+
+enum d3dddi_reclaim_result {
+	_D3DDDI_RECLAIM_RESULT_OK		= 0,
+	_D3DDDI_RECLAIM_RESULT_DISCARDED	= 1,
+	_D3DDDI_RECLAIM_RESULT_NOT_COMMITTED	= 2,
+};
+
+struct d3dkmt_reclaimallocations2 {
+	struct d3dkmthandle	paging_queue;
+	__u32			allocation_count;
+#ifdef __KERNEL__
+	struct d3dkmthandle	*resources;
+	struct d3dkmthandle	*allocations;
+#else
+	__u64			resources;
+	__u64			allocations;
+#endif
+	union {
+#ifdef __KERNEL__
+		__u32				*discarded;
+		enum d3dddi_reclaim_result	*results;
+#else
+		__u64				discarded;
+		__u64				results;
+#endif
+	};
+	__u64			paging_fence_value;
+};
+
 struct d3dkmt_changevideomemoryreservation {
 	__u64			process;
 	struct d3dkmthandle	adapter;
@@ -1360,8 +1423,12 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x25, struct d3dkmt_lock2)
 #define LX_DXMARKDEVICEASERROR		\
 	_IOWR(0x47, 0x26, struct d3dkmt_markdeviceaserror)
+#define LX_DXOFFERALLOCATIONS		\
+	_IOWR(0x47, 0x27, struct d3dkmt_offerallocations)
 #define LX_DXQUERYALLOCATIONRESIDENCY	\
 	_IOWR(0x47, 0x2a, struct d3dkmt_queryallocationresidency)
+#define LX_DXRECLAIMALLOCATIONS2	\
+	_IOWR(0x47, 0x2c, struct d3dkmt_reclaimallocations2)
 #define LX_DXSETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x2e, struct d3dkmt_setallocationpriority)
 #define LX_DXSIGNALSYNCHRONIZATIONOBJECTFROMCPU \

