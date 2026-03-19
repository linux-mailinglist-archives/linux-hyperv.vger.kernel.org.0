Return-Path: <linux-hyperv+bounces-9594-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA4VAEFcvGmCxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9594-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:45 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 680AC2D218A
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 215843054CB5
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483033FB7D4;
	Thu, 19 Mar 2026 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBhpYbMt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DB3FADF9
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951945; cv=none; b=PNwaEmQROjvbgtYDtdtNEZFbbLEfMKSwPffUvQ8atNCzCnDVm6o06bovIVT0uXhhfcGFDNFGL0G93PqoWSU7xDpjxrbSMrBluDw9UC6CYVdMmm4Ri2LYf2Y3eFnou1FAejfYtrDkROt7DONyeA+AWhTEedSD/D3XfRF/Wx+YhVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951945; c=relaxed/simple;
	bh=cTHMrhLFBJpZSrHBJN9rBbXEZ9RqxyfSw9KSRCI/12c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHE2jyS4JbRII42FGn9DflybAxF/kIkWJ65/TPuuvm2cYmuBZR5d/AV9IXbdQaspz7XiXSZca34YSUnHsXn/VASjtiYCJuECkIiz/SS/bcttADubjxZX7qcJr05PTFYrqPnLjpe2SJQthUno6iMszl3MG1SqAyAbX+KxcQ/Zvsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBhpYbMt; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b41b545d9so1477756f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951940; x=1774556740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItlcFlAFNUK9iEL+O6oBAG3ZQTT/S5ep55yAMkx91hI=;
        b=eBhpYbMt77jPeDCqLa/DYL/PjikezLVRpAf8ERX6k1bbmw51OCPJka+lNXxkk4623U
         1gem5Dm2fG5//4x5gNuq/E2Xpcw9+epflfHW4mY7vLuM7ah221yfU4lfv2qQd2rILqSe
         Bht5BU49yfZLGMvhczUdv6N7zNU8jOwBMxmxaz5TBfnvDNiXcg9GRA+oar0DnGVmbN+4
         Jrz+1o4YrimhE5V0WJ0TF4qbYTC75tOhKHC8T1apMYRHIVSBwoyKgWJD0eS07U1Fbo8O
         /634Icoe58yap9kfgwl0G61n+n/xZ6w8+ZtNddOtD9/jifINsHSTRWJv5sSwKjH/Q+Qp
         +KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951940; x=1774556740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ItlcFlAFNUK9iEL+O6oBAG3ZQTT/S5ep55yAMkx91hI=;
        b=C9toYWil51o7HqEbsikdu13zoQDM3GmfZEXTWrCReZv7gLKH/TJZGSH8+leHRKKsut
         HY9YmaV0KhRYm5uVj98Lj0aGR9f7Li0g0NwqMWWEduCzAL78VPxiSrTmLqayBIGh2KHY
         MF9Kp8d6BqfXRu9Vzv2YzekfKpzYEAi2IfgfuODfEaLjwB8Gca+/FlW75RifQG+gMFfe
         CTVM4vwKrfP5sVp5ZxFqHScTJKorCtyt6PzJAXH8KwwapeUPW6p+uvMyvdnI+qbYJbu7
         BcZExPvHQFGktHNqZ5bFNCvkrXKCyFTvWjA6KaSus5kabFaI5T34erURdDhj1RzBr1EG
         e4Uw==
X-Gm-Message-State: AOJu0YzQZLOKgfQ89gKe/X9zzFuBkHM7gAn3uPwKcpAx9cn35RV1d6dL
	eFD03i1beZxCa2yxNnr2lCmliVD2l86Xm8AVUZjezacWa+dZOvFcbl38/n0LSKBaVxY=
X-Gm-Gg: ATEYQzyWMsbZftRm93L4fwxx5b5cUm0Hhdn1/aFN39EiPwv9TdtSedIdHjjmd9vH1Wo
	B1dTG3aCvT1FBUExFFueGj2u0nYJHdtOUDRDc4a8VLAdv41W7o2K0sSq9qoBJW5xQNgbc0camqg
	5Fm0yf6khgfsP1g3TjJmsXjj8Admg562JBdTy5SbbCosHR/kw+UZZ0OnHGZdYC/LKwu4wYatM5H
	UtrLpqh1sLe1W5NyjdvEh9PpVVpdqBui/1u2rSyJnyqeioGovPgoSQagm+sGQ64MX6nfLJ/y6ib
	TA4EbJQizyitz4QL1FRJiJSeLsvqrEmdo5k9z4YbI9Bu4XZh/V/hknig3Wxxy0Sd7NZdhW6ZUsQ
	Hkpsgx/YbxhW4Dqh8/kYCHfSM2q2N+GyBX6bR1kz5k3Mb78TmgrktwNUWO6cg9Ml/wf54zeRC6t
	HIwyvvHJ4m3r3Pbd2FdObBYzZkhZMydUkbvGxcQ4bXawobEnUPAJeNlNPl/1Y=
X-Received: by 2002:a05:6000:26c3:b0:43b:45d1:f438 with SMTP id ffacd0b85a97d-43b64234722mr1193145f8f.3.1773951940150;
        Thu, 19 Mar 2026 13:25:40 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:39 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 23/55] drivers: hv: dxgkrnl: Ioctls to query statistics and clock calibration
Date: Thu, 19 Mar 2026 20:24:37 +0000
Message-ID: <20260319202509.63802-24-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9594-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.979];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,docker.com:mid]
X-Rspamd-Queue-Id: 680AC2D218A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement ioctls to query statistics from the VGPU device
(LX_DXQUERYSTATISTICS) and to query clock calibration
(LX_DXQUERYCLOCKCALIBRATION).

The LX_DXQUERYSTATISTICS ioctl is used to query various statistics from
the compute device on the host.

The LX_DXQUERYCLOCKCALIBRATION ioctl queries the compute device clock
and is used for performance monitoring.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   8 +++
 drivers/hv/dxgkrnl/dxgvmbus.c |  77 +++++++++++++++++++++++
 drivers/hv/dxgkrnl/dxgvmbus.h |  21 +++++++
 drivers/hv/dxgkrnl/ioctl.c    | 111 +++++++++++++++++++++++++++++++++-
 include/uapi/misc/d3dkmthk.h  |  62 +++++++++++++++++++
 5 files changed, 277 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index b454c7430f06..a55873bdd9a6 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -885,6 +885,11 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
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
@@ -929,6 +934,9 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
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
index f7264b12a477..9a1864bb4e14 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1829,6 +1829,48 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
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
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
+
 int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				       struct dxgadapter *adapter,
 				       struct d3dkmt_flushheaptransitions *args)
@@ -3242,3 +3284,38 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
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
+		DXG_TRACE("err: %d", ret);
+	return ret;
+}
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.h b/drivers/hv/dxgkrnl/dxgvmbus.h
index a66e11097bb2..17768ed0e68d 100644
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
index ce4af610ada7..4babb21f38a9 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -149,6 +149,65 @@ static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
 	return ret;
 }
 
+static int dxgkio_query_statistics(struct dxgprocess *process,
+				void __user *inargs)
+{
+	struct d3dkmt_querystatistics *args;
+	int ret;
+	struct dxgadapter *entry;
+	struct dxgadapter *adapter = NULL;
+	struct winluid tmp;
+	struct dxgglobal *dxgglobal = dxggbl();
+
+	args = vzalloc(sizeof(struct d3dkmt_querystatistics));
+	if (args == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+
+	ret = copy_from_user(args, inargs, sizeof(*args));
+	if (ret) {
+		DXG_ERR("failed to copy input args");
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
+				DXG_ERR("failed to copy args");
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
+	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	return ret;
+}
+
 static int
 dxgkp_enum_adapters(struct dxgprocess *process,
 		    union d3dkmt_enumadapters_filter filter,
@@ -3536,6 +3595,54 @@ dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs
 	return ret;
 }
 
+static int
+dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
+{
+	struct d3dkmt_queryclockcalibration args;
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
+		DXG_ERR("failed to copy output args");
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
 dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 {
@@ -4470,14 +4577,14 @@ static struct ioctl_desc ioctls[] = {
 /* 0x3b */	{dxgkio_wait_sync_object_gpu,
 		 LX_DXWAITFORSYNCHRONIZATIONOBJECTFROMGPU},
 /* 0x3c */	{dxgkio_get_allocation_priority, LX_DXGETALLOCATIONPRIORITY},
-/* 0x3d */	{},
+/* 0x3d */	{dxgkio_query_clock_calibration, LX_DXQUERYCLOCKCALIBRATION},
 /* 0x3e */	{dxgkio_enum_adapters3, LX_DXENUMADAPTERS3},
 /* 0x3f */	{dxgkio_share_objects, LX_DXSHAREOBJECTS},
 /* 0x40 */	{dxgkio_open_sync_object_nt, LX_DXOPENSYNCOBJECTFROMNTHANDLE2},
 /* 0x41 */	{dxgkio_query_resource_info_nt,
 		 LX_DXQUERYRESOURCEINFOFROMNTHANDLE},
 /* 0x42 */	{dxgkio_open_resource_nt, LX_DXOPENRESOURCEFROMNTHANDLE},
-/* 0x43 */	{},
+/* 0x43 */	{dxgkio_query_statistics, LX_DXQUERYSTATISTICS},
 /* 0x44 */	{dxgkio_share_object_with_host, LX_DXSHAREOBJECTWITHHOST},
 /* 0x45 */	{},
 };
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index ce5a638a886d..ea18242ceb83 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -996,6 +996,34 @@ struct d3dkmt_queryadapterinfo {
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
@@ -1238,6 +1266,36 @@ struct d3dkmt_enumadapters3 {
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
@@ -1328,6 +1386,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x3b, struct d3dkmt_waitforsynchronizationobjectfromgpu)
 #define LX_DXGETALLOCATIONPRIORITY	\
 	_IOWR(0x47, 0x3c, struct d3dkmt_getallocationpriority)
+#define LX_DXQUERYCLOCKCALIBRATION	\
+	_IOWR(0x47, 0x3d, struct d3dkmt_queryclockcalibration)
 #define LX_DXENUMADAPTERS3		\
 	_IOWR(0x47, 0x3e, struct d3dkmt_enumadapters3)
 #define LX_DXSHAREOBJECTS		\
@@ -1338,6 +1398,8 @@ struct d3dkmt_shareobjectwithhost {
 	_IOWR(0x47, 0x41, struct d3dkmt_queryresourceinfofromnthandle)
 #define LX_DXOPENRESOURCEFROMNTHANDLE	\
 	_IOWR(0x47, 0x42, struct d3dkmt_openresourcefromnthandle)
+#define LX_DXQUERYSTATISTICS	\
+	_IOWR(0x47, 0x43, struct d3dkmt_querystatistics)
 #define LX_DXSHAREOBJECTWITHHOST	\
 	_IOWR(0x47, 0x44, struct d3dkmt_shareobjectwithhost)
 

