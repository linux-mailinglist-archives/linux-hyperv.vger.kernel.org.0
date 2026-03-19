Return-Path: <linux-hyperv+bounces-9601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOQRIqlcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9601-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 067712D222A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 717B930488F8
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52453FBEA0;
	Thu, 19 Mar 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6f8tUbR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889273FB7E6
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951952; cv=none; b=O1U3AXnry0KciuwwSiqScdWMCBeAHYkBJidHWjNVX1UkE09N454NUwyL2c0sFqG6t5Dv4WxcwMvhP7Z+HnjdiEXVapFcL2ypVh7KYsRjCxuVF3FNqodGLLv0v5ilwiCgIqNGGjRgchMHD4XmRgAAsx2IIhumfjLtjm3zCWPhqo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951952; c=relaxed/simple;
	bh=L4ollWAJ/W7Q1vX0Fn+b8oAXLwAJ9050OT+TDiUSc9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljk9m8WnrD330x2dJvm+mLpveMAvcSve5fKgCYf4elLbaC9uNjgNgjI7sVL3T7nb9M8KIcqLOXnktZ7PaEYPUBsBfSusbDGVc8jMkWYQhS5gVVoHq1jOHBzDq90iAsSWC65Ql8RkdSCH9HVW7ovytCnYScMlk97qIGurkKUQ9Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6f8tUbR; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b190easo978755f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951945; x=1774556745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwngdvO9y1yS2wABD/u0qPlNd/XIEvwIA6MgEWtPNo4=;
        b=M6f8tUbRbuTjdaeX0ptWZ3wenXIAvCWcXlnwDiNmktB8yhC/j7xMcL168a6b8harsw
         KeTu+K6OktQstQcokcxv1nmKim0dQqmohfR96KUZTVc3HzbNwGEEEAcu04pLYo5FpwJO
         r9tDaIV/NYI+9wTKrZpLlZCJmt6zW/MdplG13m4gUrB3hPDasLEkbqJ1E3EcGMgrGRE4
         J7s1llddoTwejCa5XvKVf56/1fqqgseRlEkLGx2BK3AW9ct/AV4Dlvm3ivm5zMrlpEqm
         nC0pDNTnA6o2b+zom20HTemxdaRoLZeBLESglMgrRJyyrxhbE/r8sStkMDUA+j3Di2my
         h0uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951945; x=1774556745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GwngdvO9y1yS2wABD/u0qPlNd/XIEvwIA6MgEWtPNo4=;
        b=etk6XzmiosV76xzYFOWt+Rm3MvlIGcCkLQsil0SbFtk75lN/8hzfQTQ6BHzadRilXu
         7soyMYBwaTKqDYibFBKL7JqsiyHLpVTsNJiQFLJb2KOQhKsnw9dcouJiH9TzR2UYL8ik
         orMcKDvf9DaUBgt2mk3XR+y7xk0nWudXFM5noU6uTQpZ8xi0S8Osyq4TS0NZG1tHUqyy
         Cx0vFAgVP1wHQX8toULNUwdNSBijuvOtxC5yU6xBEucjoBKVUZAM+UIJydVW/tlWeE5N
         RL32O/9tMrcVZsunqlVTSJTaxEfm6jjOVc3FQr8ndsaX1hOneT/SkXcIY+bfl4OHM3Yy
         /v1A==
X-Gm-Message-State: AOJu0Yx6V/6jw0jLqrn4eMDnll4Z3SYlCYQIOclsbOVDMpFWQtq/bO69
	y8fiYwMmgavaOsGSYh4oC7BhZb3l3mZgdXhyWwvqySiq1zxMQywHWEF+3ZaBPT+pzdU=
X-Gm-Gg: ATEYQzwa2Keor/P/JL1V6e4BkOnn9Sbs1/UrU1opvTCjNA2Nn+FhCXr44gIvAGh8XEu
	iN4iKnNQBnQqgyddMqDdWFLCWyXKunKq/WZkA5i7AG7I9eU086EluqD3tf6Zwf0C30iEn2N+52J
	m6lCdfC4L27Ilc7x6jYO+nKczI5j+80iCZDoWiptL0E/cIiUMUKBrty7a9gp9LVOFNlltVFBnog
	2ZErESix/ZNuluW1B3quDCblhxgDX/S+ICaHvFZ9QEJqgqcdHRI1es+dSAE4CqSkvc8viM/DAkA
	bHdbV64SIWO1U9Qs5e+OlyQyZkOFp+4t9isWMSO8VDkN8FxTBL7mr34lzLkMXH7zJy0zzY8GTB0
	/x5btF7EZ3ho8adpnbmxiczfSHUPMF5eihydKxVvMqdvmffMQvJD8BLfxQn5uH7WkQVNyflNs4V
	Wnpot8bVE27i33jyHUAPABATo8EszCdHu+4MGPP7Mi9XdHfAeJ
X-Received: by 2002:a5d:5f87:0:b0:43b:4f86:e996 with SMTP id ffacd0b85a97d-43b6427ea9bmr1145983f8f.29.1773951944616;
        Thu, 19 Mar 2026 13:25:44 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:44 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 27/55] drivers: hv: dxgkrnl: Manage compute device virtual addresses
Date: Thu, 19 Mar 2026 20:24:41 +0000
Message-ID: <20260319202509.63802-28-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9601-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 067712D222A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to manage compute device virtual addresses (VA):
  - LX_DXRESERVEGPUVIRTUALADDRESS,
  - LX_DXFREEGPUVIRTUALADDRESS,
  - LX_DXMAPGPUVIRTUALADDRESS,
  - LX_DXUPDATEGPUVIRTUALADDRESS.

Compute devices access memory by using virtual addressses.
Each process has a dedicated VA space. The video memory manager
on the host is responsible with updating device page tables
before submitting a DMA buffer for execution.

The LX_DXRESERVEGPUVIRTUALADDRESS ioctl reserves a portion of the
process compute device VA space.

The LX_DXMAPGPUVIRTUALADDRESS ioctl reserves a portion of the process
compute device VA space and maps it to the given compute device
allocation.

The LX_DXFREEGPUVIRTUALADDRESS frees the previously reserved portion
of the compute device VA space.

The LX_DXUPDATEGPUVIRTUALADDRESS ioctl adds operations to modify the
compute device VA space to a compute device execution context. It
allows the operations to be queued and synchronized with execution
of other compute device DMA buffers..

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |  10 ++
 drivers/hv/dxgkrnl/dxgvmbus.c | 150 ++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  38 ++++++
 drivers/hv/dxgkrnl/ioctl.c    | 228 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  | 126 +++++++++++++++++++
 5 files changed, 548 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 93c3ceb23865..93bc9b41aa41 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -817,6 +817,16 @@ int dxgvmb_send_evict(struct dxgprocess *pr, struct dxgadapter *adapter,
 int dxgvmb_send_submit_command(struct dxgprocess *pr,
 			       struct dxgadapter *adapter,
 			       struct d3dkmt_submitcommand *args);
+int dxgvmb_send_map_gpu_va(struct dxgprocess *pr, struct d3dkmthandle h,
+			   struct dxgadapter *adapter,
+			   struct d3dddi_mapgpuvirtualaddress *args);
+int dxgvmb_send_reserve_gpu_va(struct dxgprocess *pr,
+			       struct dxgadapter *adapter,
+			       struct d3dddi_reservegpuvirtualaddress *args);
+int dxgvmb_send_free_gpu_va(struct dxgprocess *pr, struct dxgadapter *adapter,
+			    struct d3dkmt_freegpuvirtualaddress *args);
+int dxgvmb_send_update_gpu_va(struct dxgprocess *pr, struct dxgadapter *adapter,
+			      struct d3dkmt_updategpuvirtualaddress *args);
 int dxgvmb_send_create_sync_object(struct dxgprocess *pr,
 				   struct dxgadapter *adapter,
 				   struct d3dkmt_createsynchronizationobject2
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index f4c4a7e7ad8b..425a1ab87bd6 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2432,6 +2432,156 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
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
+		DXG_TRACE("err: %d", ret);
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
+		DXG_TRACE("err: %d", ret);
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
+		DXG_TRACE("err: %d", ret);
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
+		DXG_ERR("Invalid number of operations: %d",
+			args->num_operations);
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
+		DXG_ERR("failed to copy operations");
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
 static void set_result(struct d3dkmt_createsynchronizationobject2 *args,
 		       u64 fence_gpu_va, u8 *va)
 {
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index 23f92ab9f8ad..88967ff6a505 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.h
+++ b/drivers/hv/dxgkrnl/dxgvmbus.h
@@ -418,6 +418,44 @@ struct dxgkvmb_command_flushheaptransitions {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 };
 
+struct dxgkvmb_command_freegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dkmt_freegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dkmthandle		device;
+};
+
+struct dxgkvmb_command_mapgpuvirtualaddress_return {
+	u64		virtual_address;
+	u64		paging_fence_value;
+	struct ntstatus	status;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	struct d3dddi_reservegpuvirtualaddress args;
+};
+
+struct dxgkvmb_command_reservegpuvirtualaddress_return {
+	u64	virtual_address;
+	u64	paging_fence_value;
+};
+
+struct dxgkvmb_command_updategpuvirtualaddress {
+	struct dxgkvmb_command_vgpu_to_host hdr;
+	u64				fence_value;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		context;
+	struct d3dkmthandle		fence_object;
+	u32				num_operations;
+	u32				flags;
+	struct d3dddi_updategpuvirtualaddress_operation operations[1];
+};
+
 struct dxgkvmb_command_queryclockcalibration {
 	struct dxgkvmb_command_vgpu_to_host hdr;
 	struct d3dkmt_queryclockcalibration args;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 2700da51bc01..f6700e974f25 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -2492,6 +2492,226 @@ dxgkio_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+dxgkio_map_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret, ret2;
+	struct d3dddi_mapgpuvirtualaddress args;
+	struct d3dddi_mapgpuvirtualaddress *input = inargs;
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
+		DXG_ERR("Unexpected error %x", ret);
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->paging_fence_value,
+			    &args.paging_fence_value, sizeof(u64));
+	if (ret2) {
+		DXG_ERR("failed to copy paging fence to user");
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	ret2 = copy_to_user(&input->virtual_address, &args.virtual_address,
+				sizeof(args.virtual_address));
+	if (ret2) {
+		DXG_ERR("failed to copy va to user");
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
+	return ret;
+}
+
+static int
+dxgkio_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dddi_reservegpuvirtualaddress args;
+	struct d3dddi_reservegpuvirtualaddress *input = inargs;
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
+	adapter = dxgprocess_adapter_by_handle(process, args.adapter);
+	if (adapter == NULL) {
+		device = dxgprocess_device_by_object_handle(process,
+						HMGRENTRY_TYPE_DXGPAGINGQUEUE,
+						args.adapter);
+		if (device == NULL) {
+			DXG_ERR("invalid adapter or paging queue: 0x%x",
+				args.adapter.v);
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
+		DXG_ERR("failed to copy VA to user");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
+static int
+dxgkio_free_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_freegpuvirtualaddress args;
+	struct dxgadapter *adapter = NULL;
+
+	ret = copy_from_user(&args, inargs, sizeof(args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+dxgkio_update_gpu_va(struct dxgprocess *process, void *__user inargs)
+{
+	int ret;
+	struct d3dkmt_updategpuvirtualaddress args;
+	struct d3dkmt_updategpuvirtualaddress *input = inargs;
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
+		DXG_ERR("failed to copy fence value to user");
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
 dxgkio_create_sync_object(struct dxgprocess *process, void *__user inargs)
 {
@@ -4931,11 +5151,11 @@ static struct ioctl_desc ioctls[] = {
 /* 0x05 */	{dxgkio_destroy_context, LX_DXDESTROYCONTEXT},
 /* 0x06 */	{dxgkio_create_allocation, LX_DXCREATEALLOCATION},
 /* 0x07 */	{dxgkio_create_paging_queue, LX_DXCREATEPAGINGQUEUE},
-/* 0x08 */	{},
+/* 0x08 */	{dxgkio_reserve_gpu_va, LX_DXRESERVEGPUVIRTUALADDRESS},
 /* 0x09 */	{dxgkio_query_adapter_info, LX_DXQUERYADAPTERINFO},
 /* 0x0a */	{dxgkio_query_vidmem_info, LX_DXQUERYVIDEOMEMORYINFO},
 /* 0x0b */	{dxgkio_make_resident, LX_DXMAKERESIDENT},
-/* 0x0c */	{},
+/* 0x0c */	{dxgkio_map_gpu_va, LX_DXMAPGPUVIRTUALADDRESS},
 /* 0x0d */	{dxgkio_escape, LX_DXESCAPE},
 /* 0x0e */	{dxgkio_get_device_state, LX_DXGETDEVICESTATE},
 /* 0x0f */	{dxgkio_submit_command, LX_DXSUBMITCOMMAND},
@@ -4956,7 +5176,7 @@ static struct ioctl_desc ioctls[] = {
 /* 0x1d */	{dxgkio_destroy_sync_object, LX_DXDESTROYSYNCHRONIZATIONOBJECT},
 /* 0x1e */	{dxgkio_evict, LX_DXEVICT},
 /* 0x1f */	{dxgkio_flush_heap_transitions, LX_DXFLUSHHEAPTRANSITIONS},
-/* 0x20 */	{},
+/* 0x20 */	{dxgkio_free_gpu_va, LX_DXFREEGPUVIRTUALADDRESS},
 /* 0x21 */	{dxgkio_get_context_process_scheduling_priority,
 		 LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY},
 /* 0x22 */	{dxgkio_get_context_scheduling_priority,
@@ -4990,7 +5210,7 @@ static struct ioctl_desc ioctls[] = {
 		 LX_DXSUBMITWAITFORSYNCOBJECTSTOHWQUEUE},
 /* 0x37 */	{dxgkio_unlock2, LX_DXUNLOCK2},
 /* 0x38 */	{dxgkio_update_alloc_property, LX_DXUPDATEALLOCPROPERTY},
-/* 0x39 */	{},
+/* 0x39 */	{dxgkio_update_gpu_va, LX_DXUPDATEGPUVIRTUALADDRESS},
 /* 0x3a */	{dxgkio_wait_sync_object_cpu,
 		 LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU},
 /* 0x3b */	{dxgkio_wait_sync_object_gpu,
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 944f9d1e73d6..1f60f5120e1d 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -1012,6 +1012,124 @@ struct d3dkmt_evict {
 	__u64				num_bytes_to_trim;
 };
 
+struct d3dddigpuva_protection_type {
+	union {
+		struct {
+			__u64	write:1;
+			__u64	execute:1;
+			__u64	zero:1;
+			__u64	no_access:1;
+			__u64	system_use_only:1;
+			__u64	reserved:59;
+		};
+		__u64		value;
+	};
+};
+
+enum d3dddi_updategpuvirtualaddress_operation_type {
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP		= 0,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_UNMAP		= 1,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_COPY		= 2,
+	_D3DDDI_UPDATEGPUVIRTUALADDRESS_MAP_PROTECT	= 3,
+};
+
+struct d3dddi_updategpuvirtualaddress_operation {
+	enum d3dddi_updategpuvirtualaddress_operation_type operation;
+	union {
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+		} map;
+		struct {
+			__u64		base_address;
+			__u64		size;
+			struct d3dkmthandle allocation;
+			__u64		allocation_offset;
+			__u64		allocation_size;
+			struct d3dddigpuva_protection_type protection;
+			__u64		driver_protection;
+		} map_protect;
+		struct {
+			__u64	base_address;
+			__u64	size;
+			struct d3dddigpuva_protection_type protection;
+		} unmap;
+		struct {
+			__u64	source_address;
+			__u64	size;
+			__u64	dest_address;
+		} copy;
+	};
+};
+
+enum d3dddigpuva_reservation_type {
+	_D3DDDIGPUVA_RESERVE_NO_ACCESS		= 0,
+	_D3DDDIGPUVA_RESERVE_ZERO		= 1,
+	_D3DDDIGPUVA_RESERVE_NO_COMMIT		= 2
+};
+
+struct d3dkmt_updategpuvirtualaddress {
+	struct d3dkmthandle			device;
+	struct d3dkmthandle			context;
+	struct d3dkmthandle			fence_object;
+	__u32					num_operations;
+#ifdef __KERNEL__
+	struct d3dddi_updategpuvirtualaddress_operation *operations;
+#else
+	__u64					operations;
+#endif
+	__u32					reserved0;
+	__u32					reserved1;
+	__u64					reserved2;
+	__u64					fence_value;
+	union {
+		struct {
+			__u32			do_not_wait:1;
+			__u32			reserved:31;
+		};
+		__u32				value;
+	} flags;
+	__u32					reserved3;
+};
+
+struct d3dddi_mapgpuvirtualaddress {
+	struct d3dkmthandle			paging_queue;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	struct d3dkmthandle			allocation;
+	__u64					offset_in_pages;
+	__u64					size_in_pages;
+	struct d3dddigpuva_protection_type	protection;
+	__u64					driver_protection;
+	__u32					reserved0;
+	__u64					reserved1;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dddi_reservegpuvirtualaddress {
+	struct d3dkmthandle			adapter;
+	__u64					base_address;
+	__u64					minimum_address;
+	__u64					maximum_address;
+	__u64					size;
+	enum d3dddigpuva_reservation_type	reservation_type;
+	__u64					driver_protection;
+	__u64					virtual_address;
+	__u64					paging_fence_value;
+};
+
+struct d3dkmt_freegpuvirtualaddress {
+	struct d3dkmthandle	adapter;
+	__u32			reserved;
+	__u64			base_address;
+	__u64			size;
+};
+
 enum d3dkmt_memory_segment_group {
 	_D3DKMT_MEMORY_SEGMENT_GROUP_LOCAL	= 0,
 	_D3DKMT_MEMORY_SEGMENT_GROUP_NON_LOCAL	= 1
@@ -1453,12 +1571,16 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x06, struct d3dkmt_createallocation)
 #define LX_DXCREATEPAGINGQUEUE		\
 	_IOWR(0x47, 0x07, struct d3dkmt_createpagingqueue)
+#define LX_DXRESERVEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x08, struct d3dddi_reservegpuvirtualaddress)
 #define LX_DXQUERYADAPTERINFO		\
 	_IOWR(0x47, 0x09, struct d3dkmt_queryadapterinfo)
 #define LX_DXQUERYVIDEOMEMORYINFO	\
 	_IOWR(0x47, 0x0a, struct d3dkmt_queryvideomemoryinfo)
 #define LX_DXMAKERESIDENT		\
 	_IOWR(0x47, 0x0b, struct d3dddi_makeresident)
+#define LX_DXMAPGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x0c, struct d3dddi_mapgpuvirtualaddress)
 #define LX_DXESCAPE			\
 	_IOWR(0x47, 0x0d, struct d3dkmt_escape)
 #define LX_DXGETDEVICESTATE		\
@@ -1493,6 +1615,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x1e, struct d3dkmt_evict)
 #define LX_DXFLUSHHEAPTRANSITIONS	\
 	_IOWR(0x47, 0x1f, struct d3dkmt_flushheaptransitions)
+#define LX_DXFREEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x20, struct d3dkmt_freegpuvirtualaddress)
 #define LX_DXGETCONTEXTINPROCESSSCHEDULINGPRIORITY \
 	_IOWR(0x47, 0x21, struct d3dkmt_getcontextinprocessschedulingpriority)
 #define LX_DXGETCONTEXTSCHEDULINGPRIORITY \
@@ -1529,6 +1653,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x37, struct d3dkmt_unlock2)
 #define LX_DXUPDATEALLOCPROPERTY	\
 	_IOWR(0x47, 0x38, struct d3dddi_updateallocproperty)
+#define LX_DXUPDATEGPUVIRTUALADDRESS	\
+	_IOWR(0x47, 0x39, struct d3dkmt_updategpuvirtualaddress)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMCPU \
 	_IOWR(0x47, 0x3a, struct d3dkmt_waitforsynchronizationobjectfromcpu)
 #define LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU \

