Return-Path: <linux-hyperv+bounces-9617-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YClGElpfvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9617-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:58 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6DB2D24EB
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0E3432CC938
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABD43FFADE;
	Thu, 19 Mar 2026 20:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1omyZ3+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDA3FF897
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951968; cv=none; b=TV568RTaXLzow9xOr8TS+Zleye/bKdt8Bx2MZBePvZPualx61zljBnY1s5HAcmQt1olpxlYJUdiyLAEcO/y6Z1NAJQpAo2DwPtjC0jMZyXZjh8n118QtDzWLw9MMNTgWPrR9P1mrmJ5WCZP/T794beFpxKb15lqrLlV9bSUhEjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951968; c=relaxed/simple;
	bh=5GYgyHAPPb/c4TuOt/FovFbs4KdkJcctdoNSZgSBCI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZW0x5JezjA/X3MvHpwQ5QwCZW3i7T/t4lwJIMHG5dCbQ7KISsy8hg2GjBaXoVOlkLjEMqTibwOjOU5rCmFkQG5QforBpwfpNiErtnbNALFsBbiP4Msc98ry5l15YE0Y0fFiqpF1NL4TslVmDDNcuvkAVOK/lw6QV5XHDC2sEuX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1omyZ3+; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4327790c4e9so776664f8f.2
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951960; x=1774556760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxByceTa1YltExdfah9Lq3qXbpogAji5TptAgxuELUc=;
        b=Z1omyZ3+dWSDCnB+sTdM6BZTxwibX42H8JzDqMs7LXfbqsp0B2Wu4w96T8E86UbxYN
         CzNEjbfUykgrrf7Uk//pw1pY6bG+m0KgBbXHCeNcsGu0RwsAtYfI+V1YVQtN4gRIB3U/
         ymNWouJlWSAqsYYU3ThkecLlhZI2dI2iR94eeLpayt5U3b3d7uCf98y7wLOSbcGRRY3s
         SXpnt398S1qyU1WKcWGDJLMzdhm0i/hwfFgGyLJh4D2aXa21brzrIH2dTfJpYiqg8A+P
         SPEORwPG4/970YzcPgMpynSMAJ5bNiJ0WcMvl+N46iqHTyi59TpCg11IiJDq17QXOVt4
         CCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951960; x=1774556760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GxByceTa1YltExdfah9Lq3qXbpogAji5TptAgxuELUc=;
        b=nDJRzhh3kYvtdrvubo1qvWnykHfEBFtjXAsvyeMxSG0VnXHz6TzeCmXHpQvf/In1t/
         S2aiMdw1bt49v0/aunRVqIwAICL8GV2Jcq3aES/obhNMpHv6IhL+eA0YVYt6CDVcEZmV
         8a3DcfNpJjPtD523/vE9WNPr6rELvKUoh+cN3KcWaWqn88AzfHRvpJ3r69GJe25Nu55y
         3q3XS0/ATpxq3Xg4MRwIxqNWNI8rvYNLBCu9R0082ocG5eOnl0B1CxnzJFefOvQNW25/
         lVHV4AY++oblY1gROsYr/GGAP54MPBw+0VcBpGHIwGxb1SHvhXorsdQXulpqM13Ml8Se
         kkEw==
X-Gm-Message-State: AOJu0YzRjkJqbMBmydLBH1fNSaXKOan/2we191KW1n3icT74mkHYfhL4
	5dT/h3cGGvmy9Trvei+1p9ACz0BggPEsB83y8l+xH2GltlHzsrYhH1/eLO6wklLiJzE=
X-Gm-Gg: ATEYQzy3SVps/kkj1/mSqZzTDxCzADY4ABhFDrj9nakeWhnYTblmeUNxxrRsx3dlaxV
	woRoOsf9qTWalZJ2Vjn02vmcGDb8ODgWd3ZgWT92dlh9zEyjiL3yF5TIWHt+27ha0du8fbLVjtP
	/AhWvZJsJb8lhYNJc48j/9zkUYdzN9RyM2n4V2Ic/LBEz1WAVglggsXFMql+Zv5eHxyjVB/CcKS
	NkhwKSt6RmkCtoRX5YmvgD7eTislUcmmoZe2QiJx/th7vBRwoDsGU4++0olpaI5kLmXRpE0xAOt
	/LQ1bzzpBoMnNyz2+Ot91aHKrS8n5Ba6IyBgIQ4V7vk6gLn8vrAHLqV7yyeoeunQeyRQ9Gbmh+V
	FZrenxzbM6DpIcRCzXs1IeT6/UnoiWoRRdlS2UwvIpbEbJ5ipqzfGlOKDeqddrZTBAVbpMd8IJb
	wx3+pZq7f1SCxI4ITMcY9Ui8e/wk0xTm43U4zZ3LGCxS9q5DxX
X-Received: by 2002:a05:6000:40c7:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43b6424f867mr1134796f8f.23.1773951959951;
        Thu, 19 Mar 2026 13:25:59 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:59 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 41/55] drivers: hv: dxgkrnl: Handle process ID in D3DKMTQueryStatistics
Date: Thu, 19 Mar 2026 20:24:55 +0000
Message-ID: <20260319202509.63802-42-eric.curtin@docker.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9617-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.981];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB6DB2D24EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

When D3DKMTQueryStatistics specifies a non-zero process ID, it needs to be
translated to the host process handle before sending a message to the host.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h    |   3 +-
 drivers/hv/dxgkrnl/dxgprocess.c |   2 +
 drivers/hv/dxgkrnl/dxgvmbus.c   | 140 ++++++++++++++++----------------
 drivers/hv/dxgkrnl/ioctl.c      |  39 ++++++++-
 4 files changed, 111 insertions(+), 73 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index e7d8919b3c01..6af1e59b0a31 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -386,6 +386,7 @@ struct dxgprocess {
 	struct list_head	plistentry;
 	pid_t			pid;
 	pid_t			tgid;
+	pid_t			vpid; /* pdi from the current namespace */
 	/* how many time the process was opened */
 	struct kref		process_kref;
 	/* protects the object memory */
@@ -981,7 +982,7 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 				  void *prive_alloc_data,
 				  u32 *res_priv_data_size,
 				  void *priv_res_data);
-int dxgvmb_send_query_statistics(struct dxgprocess *process,
+int dxgvmb_send_query_statistics(struct d3dkmthandle host_process_handle,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_querystatistics *args);
 int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
diff --git a/drivers/hv/dxgkrnl/dxgprocess.c b/drivers/hv/dxgkrnl/dxgprocess.c
index fd51fd968049..5a4c4cb0c2e8 100644
--- a/drivers/hv/dxgkrnl/dxgprocess.c
+++ b/drivers/hv/dxgkrnl/dxgprocess.c
@@ -12,6 +12,7 @@
  */
 
 #include "dxgkrnl.h"
+#include "linux/sched.h"
 
 #undef dev_fmt
 #define dev_fmt(fmt)	"dxgk: " fmt
@@ -31,6 +32,7 @@ struct dxgprocess *dxgprocess_create(void)
 		DXG_TRACE("new dxgprocess created");
 		process->pid = current->pid;
 		process->tgid = current->tgid;
+		process->vpid = task_pid_vnr(current);
 		ret = dxgvmb_send_create_process(process);
 		if (ret < 0) {
 			DXG_TRACE("send_create_process failed");
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 487804ca731a..916ed9071656 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -22,6 +22,8 @@
 #include "dxgkrnl.h"
 #include "dxgvmbus.h"
 
+#pragma GCC diagnostic ignored "-Warray-bounds"
+
 #undef dev_fmt
 #define dev_fmt(fmt)	"dxgk: " fmt
 
@@ -113,7 +115,6 @@ static int init_message(struct dxgvmbusmsg *msg, struct dxgadapter *adapter,
 
 static int init_message_res(struct dxgvmbusmsgres *msg,
 			    struct dxgadapter *adapter,
-			    struct dxgprocess *process,
 			    u32 size,
 			    u32 result_size)
 {
@@ -146,7 +147,7 @@ static int init_message_res(struct dxgvmbusmsgres *msg,
 	return 0;
 }
 
-static void free_message(struct dxgvmbusmsg *msg, struct dxgprocess *process)
+static void free_message(struct dxgvmbusmsg *msg)
 {
 	if (msg->hdr && (char *)msg->hdr != msg->msg_on_stack)
 		vfree(msg->hdr);
@@ -646,7 +647,7 @@ int dxgvmb_send_set_iospace_region(u64 start, u64 len)
 
 	dxgglobal_release_channel_lock();
 cleanup:
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("Error: %d", ret);
 	return ret;
@@ -699,7 +700,7 @@ int dxgvmb_send_create_process(struct dxgprocess *process)
 	dxgglobal_release_channel_lock();
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -727,7 +728,7 @@ int dxgvmb_send_destroy_process(struct d3dkmthandle process)
 	dxgglobal_release_channel_lock();
 
 cleanup:
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -790,7 +791,7 @@ int dxgvmb_send_open_sync_object_nt(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -839,7 +840,7 @@ int dxgvmb_send_open_sync_object(struct dxgprocess *process,
 	*syncobj = result.sync_object;
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -881,7 +882,7 @@ int dxgvmb_send_create_nt_shared_object(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -912,7 +913,7 @@ int dxgvmb_send_destroy_nt_shared_object(struct d3dkmthandle shared_handle)
 	dxgglobal_release_channel_lock();
 
 cleanup:
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -945,7 +946,7 @@ int dxgvmb_send_destroy_sync_object(struct dxgprocess *process,
 	dxgglobal_release_channel_lock();
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -989,7 +990,7 @@ int dxgvmb_send_share_object_with_host(struct dxgprocess *process,
 	args->object_vail_nt_handle = result.vail_nt_handle;
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_ERR("err: %d", ret);
 	return ret;
@@ -1026,7 +1027,7 @@ int dxgvmb_send_open_adapter(struct dxgadapter *adapter)
 	adapter->host_handle = result.host_adapter_handle;
 
 cleanup:
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_ERR("Failed to open adapter: %d", ret);
 	return ret;
@@ -1048,7 +1049,7 @@ int dxgvmb_send_close_adapter(struct dxgadapter *adapter)
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
 				   NULL, 0);
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_ERR("Failed to close adapter: %d", ret);
 	return ret;
@@ -1084,7 +1085,7 @@ int dxgvmb_send_get_internal_adapter_info(struct dxgadapter *adapter)
 			sizeof(adapter->device_instance_id) / sizeof(u16));
 		dxgglobal->async_msg_enabled = result.async_msg_enabled != 0;
 	}
-	free_message(&msg, NULL);
+	free_message(&msg);
 	if (ret)
 		DXG_ERR("Failed to get adapter info: %d", ret);
 	return ret;
@@ -1114,7 +1115,7 @@ struct d3dkmthandle dxgvmb_send_create_device(struct dxgadapter *adapter,
 				   &result, sizeof(result));
 	if (ret < 0)
 		result.device.v = 0;
-	free_message(&msg, process);
+	free_message(&msg);
 cleanup:
 	if (ret)
 		DXG_TRACE("err: %d", ret);
@@ -1140,7 +1141,7 @@ int dxgvmb_send_destroy_device(struct dxgadapter *adapter,
 
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1167,7 +1168,7 @@ int dxgvmb_send_flush_device(struct dxgdevice *device,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1239,7 +1240,7 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return context;
@@ -1265,7 +1266,7 @@ int dxgvmb_send_destroy_context(struct dxgadapter *adapter,
 
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1312,7 +1313,7 @@ int dxgvmb_send_create_paging_queue(struct dxgprocess *process,
 	pqueue->handle = args->paging_queue;
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1339,7 +1340,7 @@ int dxgvmb_send_destroy_paging_queue(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size, NULL, 0);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1550,7 +1551,7 @@ int create_existing_sysmem(struct dxgdevice *device,
 cleanup:
 	if (kmem)
 		vunmap(kmem);
-	free_message(&msg, device->process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1783,7 +1784,7 @@ create_local_allocations(struct dxgprocess *process,
 		dxgdevice_release_alloc_list_lock(device);
 	}
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1908,7 +1909,7 @@ int dxgvmb_send_create_allocation(struct dxgprocess *process,
 
 	if (result)
 		vfree(result);
-	free_message(&msg, process);
+	free_message(&msg);
 
 	if (ret)
 		DXG_TRACE("err: %d", ret);
@@ -1950,7 +1951,7 @@ int dxgvmb_send_destroy_allocation(struct dxgprocess *process,
 
 cleanup:
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -1992,7 +1993,7 @@ int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
 	ret = ntstatus2int(result.status);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2015,7 +2016,7 @@ int dxgvmb_send_flush_heap_transitions(struct dxgprocess *process,
 				   process->host_handle);
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2042,7 +2043,7 @@ int dxgvmb_send_invalidate_cache(struct dxgprocess *process,
 	command->length = args->length;
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2078,7 +2079,7 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	}
 	result_size += result_allocation_size;
 
-	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	ret = init_message_res(&msg, adapter, cmd_size, result_size);
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
@@ -2115,7 +2116,7 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message((struct dxgvmbusmsg *)&msg, process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2179,7 +2180,7 @@ int dxgvmb_send_escape(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2243,7 +2244,7 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2288,7 +2289,7 @@ int dxgvmb_send_get_device_state(struct dxgprocess *process,
 		args->execution_state = result.args.execution_state;
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2312,8 +2313,7 @@ int dxgvmb_send_open_resource(struct dxgprocess *process,
 			   sizeof(*result);
 	struct dxgvmbusmsgres msg = {.hdr = NULL};
 
-	ret = init_message_res(&msg, adapter, process, sizeof(*command),
-			       result_size);
+	ret = init_message_res(&msg, adapter,  sizeof(*command), result_size);
 	if (ret)
 		goto cleanup;
 	command = msg.msg;
@@ -2342,7 +2342,7 @@ int dxgvmb_send_open_resource(struct dxgprocess *process,
 		alloc_handles[i] = handles[i];
 
 cleanup:
-	free_message((struct dxgvmbusmsg *)&msg, process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2367,7 +2367,7 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 		result_size += *alloc_priv_driver_size;
 	if (priv_res_data)
 		result_size += *res_priv_data_size;
-	ret = init_message_res(&msg, device->adapter, device->process,
+	ret = init_message_res(&msg, device->adapter,
 			       sizeof(*command), result_size);
 	if (ret)
 		goto cleanup;
@@ -2427,7 +2427,7 @@ int dxgvmb_send_get_stdalloc_data(struct dxgdevice *device,
 
 cleanup:
 
-	free_message((struct dxgvmbusmsg *)&msg, device->process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2479,7 +2479,7 @@ int dxgvmb_send_make_resident(struct dxgprocess *process,
 
 cleanup:
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2525,7 +2525,7 @@ int dxgvmb_send_evict(struct dxgprocess *process,
 
 cleanup:
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2580,7 +2580,7 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
 
 cleanup:
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2617,7 +2617,7 @@ int dxgvmb_send_map_gpu_va(struct dxgprocess *process,
 
 cleanup:
 
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2647,7 +2647,7 @@ int dxgvmb_send_reserve_gpu_va(struct dxgprocess *process,
 	args->virtual_address = result.virtual_address;
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2674,7 +2674,7 @@ int dxgvmb_send_free_gpu_va(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2730,7 +2730,7 @@ int dxgvmb_send_update_gpu_va(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2816,7 +2816,7 @@ dxgvmb_send_create_sync_object(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2910,7 +2910,7 @@ int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -2970,7 +2970,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3023,7 +3023,7 @@ int dxgvmb_send_wait_sync_object_gpu(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3103,7 +3103,7 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
 	hmgrtable_unlock(&process->handle_table, DXGLOCK_EXCL);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3130,7 +3130,7 @@ int dxgvmb_send_unlock2(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3175,7 +3175,7 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 		}
 	}
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3200,7 +3200,7 @@ int dxgvmb_send_mark_device_as_error(struct dxgprocess *process,
 	command->args = *args;
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3270,7 +3270,7 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3312,7 +3312,7 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	}
 	result_size = sizeof(*result) + priority_size;
 
-	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	ret = init_message_res(&msg, adapter, cmd_size, result_size);
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
@@ -3352,7 +3352,7 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message((struct dxgvmbusmsg *)&msg, process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3381,7 +3381,7 @@ int dxgvmb_send_set_context_sch_priority(struct dxgprocess *process,
 	command->in_process = in_process;
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3415,7 +3415,7 @@ int dxgvmb_send_get_context_sch_priority(struct dxgprocess *process,
 		*priority = result.priority;
 	}
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3461,7 +3461,7 @@ int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3486,7 +3486,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 		result_size += (args->allocation_count - 1) *
 				sizeof(enum d3dddi_reclaim_result);
 
-	ret = init_message_res(&msg, adapter, process, cmd_size, result_size);
+	ret = init_message_res(&msg, adapter, cmd_size, result_size);
 	if (ret)
 		goto cleanup;
 	command = (void *)msg.msg;
@@ -3537,7 +3537,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message((struct dxgvmbusmsg *)&msg, process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3567,7 +3567,7 @@ int dxgvmb_send_change_vidmem_reservation(struct dxgprocess *process,
 
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3706,7 +3706,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			dxgvmb_send_destroy_hwqueue(process, adapter,
 						    command->hwqueue);
 	}
-	free_message(&msg, process);
+	free_message(&msg);
 	return ret;
 }
 
@@ -3731,7 +3731,7 @@ int dxgvmb_send_destroy_hwqueue(struct dxgprocess *process,
 	ret = dxgvmb_send_sync_msg_ntstatus(msg.channel, msg.hdr, msg.size);
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3815,7 +3815,7 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
@@ -3873,13 +3873,13 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 	}
 
 cleanup:
-	free_message(&msg, process);
+	free_message(&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
 }
 
-int dxgvmb_send_query_statistics(struct dxgprocess *process,
+int dxgvmb_send_query_statistics(struct d3dkmthandle host_process_handle,
 				 struct dxgadapter *adapter,
 				 struct d3dkmt_querystatistics *args)
 {
@@ -3888,7 +3888,7 @@ int dxgvmb_send_query_statistics(struct dxgprocess *process,
 	int ret;
 	struct dxgvmbusmsgres msg = {.hdr = NULL};
 
-	ret = init_message_res(&msg, adapter, process, sizeof(*command),
+	ret = init_message_res(&msg, adapter, sizeof(*command),
 			       sizeof(*result));
 	if (ret)
 		goto cleanup;
@@ -3897,7 +3897,7 @@ int dxgvmb_send_query_statistics(struct dxgprocess *process,
 
 	command_vgpu_to_host_init2(&command->hdr,
 				   DXGK_VMBCOMMAND_QUERYSTATISTICS,
-				   process->host_handle);
+				   host_process_handle);
 	command->args = *args;
 
 	ret = dxgvmb_send_sync_msg(msg.channel, msg.hdr, msg.size,
@@ -3909,7 +3909,7 @@ int dxgvmb_send_query_statistics(struct dxgprocess *process,
 	ret = ntstatus2int(result->status);
 
 cleanup:
-	free_message((struct dxgvmbusmsg *)&msg, process);
+	free_message((struct dxgvmbusmsg *)&msg);
 	if (ret)
 		DXG_TRACE("err: %d", ret);
 	return ret;
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 56b838a87f09..466bef6c14b3 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -147,6 +147,23 @@ static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
 	return ret;
 }
 
+static struct d3dkmthandle find_dxgprocess_handle(u64 pid)
+{
+	struct dxgglobal *dxgglobal = dxggbl();
+	struct dxgprocess *entry;
+	struct d3dkmthandle host_handle = {};
+
+	mutex_lock(&dxgglobal->plistmutex);
+	list_for_each_entry(entry, &dxgglobal->plisthead, plistentry) {
+		if (entry->vpid == pid) {
+			host_handle.v = entry->host_handle.v;
+			break;
+		}
+	}
+	mutex_unlock(&dxgglobal->plistmutex);
+	return host_handle;
+}
+
 static int dxgkio_query_statistics(struct dxgprocess *process,
 				void __user *inargs)
 {
@@ -156,6 +173,8 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 	struct dxgadapter *adapter = NULL;
 	struct winluid tmp;
 	struct dxgglobal *dxgglobal = dxggbl();
+	struct d3dkmthandle host_process_handle = process->host_handle;
+	u64 pid;
 
 	args = vzalloc(sizeof(struct d3dkmt_querystatistics));
 	if (args == NULL) {
@@ -170,6 +189,18 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 		goto cleanup;
 	}
 
+	/* Find the host process handle when needed */
+	pid = args->process;
+	if (pid) {
+		host_process_handle = find_dxgprocess_handle(pid);
+		if (host_process_handle.v == 0) {
+			DXG_ERR("Invalid process ID is specified: %lld", pid);
+			ret = -EINVAL;
+			goto cleanup;
+		}
+		args->process = 0;
+	}
+
 	dxgglobal_acquire_adapter_list_lock(DXGLOCK_SHARED);
 	list_for_each_entry(entry, &dxgglobal->adapter_list_head,
 			    adapter_list_entry) {
@@ -186,7 +217,8 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 	if (adapter) {
 		tmp = args->adapter_luid;
 		args->adapter_luid = adapter->host_adapter_luid;
-		ret = dxgvmb_send_query_statistics(process, adapter, args);
+		ret = dxgvmb_send_query_statistics(host_process_handle, adapter,
+						   args);
 		if (ret >= 0) {
 			args->adapter_luid = tmp;
 			ret = copy_to_user(inargs, args, sizeof(*args));
@@ -280,7 +312,10 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 	dxgglobal_release_adapter_list_lock(DXGLOCK_SHARED);
 
 	if (adapter_count > adapter_count_max) {
-		ret = STATUS_BUFFER_TOO_SMALL;
+		struct ntstatus status;
+
+		status.v = STATUS_BUFFER_TOO_SMALL;
+		ret = ntstatus2int(status);
 		DXG_TRACE("Too many adapters");
 		ret = copy_to_user(adapter_count_out,
 				   &dxgglobal->num_adapters, sizeof(u32));

