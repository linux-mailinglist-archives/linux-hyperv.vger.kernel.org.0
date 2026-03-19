Return-Path: <linux-hyperv+bounces-9616-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGJ6J79dvGnLxgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9616-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:07 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8D62D236B
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2F4E432096DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0483F880D;
	Thu, 19 Mar 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcX6HoIm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31D03FFADE
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951968; cv=none; b=BS33FcH3eOiMPcMfsD30p09weDjKJPpw81YKo3Xb9c1J1+cloGFOXlb1HLiBt3h+JlwL/6EBR1dzPsoGHbXe1sk3P2Jpwg8xHdmFt6nkY3+69xrtHIbjhurnAbZYdUIh2jtlm8qVvfjYLrLnq/gJgbZWcNy5cdLBjjXpOXmK1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951968; c=relaxed/simple;
	bh=zMPjUJp3qaN20qEcVMXOtJ/uhNBq3nlGbiLzRom/6l0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=exjFleaUf4LB0fsSH9soGtDWUnVbMquw4EX84ikns0/NAbgDqaxkJonavUab4YGDx701zlSsqOPvHK/JwDvNyY7rs9hT9PSJYgKUodp9yjBnnnBMMwWKJavqWBz20BJYSKv/5JGOIEPz7LL7/6qI7Zqv/sHhxh/s7Gyb7t3pjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcX6HoIm; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-486fb439299so9165795e9.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951964; x=1774556764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2tY7so1VAcy4ANuQwbb9ijas9+JYVH0PRQMX4x27sM=;
        b=RcX6HoIm/KKfcn4Aj2y6zGN2IPhvby3WSMnnqYpWa9gTKG8gP+9Zcg2WkS0E0c6jaJ
         XcEa2sOVnOL7PceVt4SjO208ZEtLQdvJY+D3oyZ5fFwRhxLkIOtyhtgTKLHfBXbizpQ4
         YRh/GG5STsBCOGfVGeguDbvlm8VQJ4KRFsl34hM7Uhk/4QvnnxjjB3MAV2Oc4nQgMcpU
         kBNAg4br7NZfLlbj4GXWhZ2eiCn9cn62gJXteQHNONSj0tybumgX2gVa8n6XIffsdkCZ
         FHpl+vDVz+HLCXyn+ddTQl5aU4iaHqSlhnucRKy2x/vJEmCiwpzeZTd5BKWD7y8xfmxy
         ocCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951964; x=1774556764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O2tY7so1VAcy4ANuQwbb9ijas9+JYVH0PRQMX4x27sM=;
        b=EETwLCLu925WVet+xbykeS0pbM2jSgu7G3gX0zPZL5Mf+CZ8Rb1oILrysnktQyVLyP
         bqLGbAS59TzPIv+6wwbMhp9yOq/4wYwFZW5YwKG8WncQDKViKPSyTsxYF5S0A5lT/rvu
         1XwbaRMzt918i70zpW1bJk+OaqTqDFcDGRSUQv4Mz7xmSTEARgL1lIUZwk0LptXUjEAp
         zfdXQ+6UnLs9uZStjWiKT685Czj5oHSY4vkBxzI96oKoDKROWKnrwAkoyut3dLnV6Dae
         sxdmdG28wQwQRzacs4hvGU+HzPaX5QzNX1SGl3gjsgKDctYJ1JUc212sflmKVmcGoaa6
         0dow==
X-Gm-Message-State: AOJu0YwpQUeCHTedYGiqeDDSzptbvr83FiSjnFAJdH2W9PtlTHypkhLh
	vqqtZIDKSblsxL/X5kK3QdJZr4Fk1Fc6e8rv9A7gGNdNoIWzP2u1J3qSAKh59BiCQac=
X-Gm-Gg: ATEYQzwwnyRK1G8Ql85XjDA/ZWU5CMyVhXtiO2xO5iXjdjm0/2TnfWZmb3pcZErJZcu
	cEK82zQl4s/RUtD+4DQrYrK3DHnIQ9cHR6rpJQG3CgB94CEsYTGtiKT2OL54kBWeeEG9VZn9q2M
	UaIA5VX8bl1gEGQLTwu3mjtEnmtDOleKvotVoCKPlyD65zENUff6irYC2i8qw9aGGBHxn1j2cAD
	5O1ZqxncMoPpy1QhE1XgqdYsd/INw5wZfWapWDGHXPAgJtaPuRFH8snAsZ29RUi3vyJxmS+HpLu
	mjYpQC9DBjgC2wOH/JrBdgdP5fSrAOg4MMWFKj0POusM9jXJF0gTOhFwjxkhxsYaEtjbTOk0dkJ
	f4BQu1gh+EeiJJ9xwfW9SS7YYC/kGgAlL2Zoxq1PMiH2zEyUhF8ncmIMmAzFW3+2Ymv63vluyHr
	KOK9Pw4gabDSYN3rF89NhixWqCTB2tSpk+/qlBVrojMq4Nq+8cb2G74/mFGRY=
X-Received: by 2002:a05:600c:4705:b0:486:f9aa:2b57 with SMTP id 5b1f17b1804b1-486fee0d6d4mr6935405e9.16.1773951963960;
        Thu, 19 Mar 2026 13:26:03 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:03 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 45/55] drivers: hv: dxgkrnl: Fixed coding style issues
Date: Thu, 19 Mar 2026 20:24:59 +0000
Message-ID: <20260319202509.63802-46-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9616-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.980];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D8D62D236B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 12 ++++--------
 drivers/hv/dxgkrnl/dxgkrnl.h    |  6 +++---
 drivers/hv/dxgkrnl/dxgvmbus.c   |  2 +-
 drivers/hv/dxgkrnl/ioctl.c      | 20 +++++++-------------
 4 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index bcd19b7267d1..b8ae8099847b 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -1017,8 +1017,7 @@ struct dxgprocess_adapter *dxgprocess_adapter_create(struct dxgprocess *process,
 	}
 	return adapter_info;
 cleanup:
-	if (adapter_info)
-		kfree(adapter_info);
+	kfree(adapter_info);
 	return NULL;
 }
 
@@ -1225,10 +1224,8 @@ struct dxgsyncobject *dxgsyncobject_create(struct dxgprocess *process,
 	DXG_TRACE("Syncobj created: %p", syncobj);
 	return syncobj;
 cleanup:
-	if (syncobj->host_event)
-		kfree(syncobj->host_event);
-	if (syncobj)
-		kfree(syncobj);
+	kfree(syncobj->host_event);
+	kfree(syncobj);
 	return NULL;
 }
 
@@ -1308,8 +1305,7 @@ void dxgsyncobject_release(struct kref *refcount)
 		kref_put(&syncobj->shared_owner->ssyncobj_kref,
 			 dxgsharedsyncobj_release);
 	}
-	if (syncobj->host_event)
-		kfree(syncobj->host_event);
+	kfree(syncobj->host_event);
 	kfree(syncobj);
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index 9599ec8e0f1d..a4d0c504668b 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -47,10 +47,10 @@ struct dxghwqueue;
  * Driver private data.
  * A single /dev/dxg device is created per virtual machine.
  */
-struct dxgdriver{
+struct dxgdriver {
 	struct dxgglobal	*dxgglobal;
-	struct device 		*dxgdev;
-	struct pci_driver 	pci_drv;
+	struct device		*dxgdev;
+	struct pci_driver	pci_drv;
 	struct hv_driver	vmbus_drv;
 };
 extern struct dxgdriver dxgdrv;
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index de28c6162a70..215e2f6648e2 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -246,7 +246,7 @@ int dxgvmbuschannel_init(struct dxgvmbuschannel *ch, struct hv_device *hdev)
 		goto cleanup;
 	}
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,15,0)
+#if KERNEL_VERSION(5, 15, 0) <= LINUX_VERSION_CODE
 	hdev->channel->max_pkt_size = DXG_MAX_VM_BUS_PACKET_SIZE;
 #endif
 	ret = vmbus_open(hdev->channel, RING_BUFSIZE, RING_BUFSIZE,
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index f8ca79d098f3..5ac6dd1f09b9 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -3162,8 +3162,7 @@ dxgkio_signal_sync_object(struct dxgprocess *process, void *__user inargs)
 		}
 		if (event)
 			eventfd_ctx_put(event);
-		if (host_event)
-			kfree(host_event);
+		kfree(host_event);
 	}
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
@@ -3398,8 +3397,7 @@ dxgkio_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
 		}
 		if (event)
 			eventfd_ctx_put(event);
-		if (host_event)
-			kfree(host_event);
+		kfree(host_event);
 	}
 	if (adapter)
 		dxgadapter_release_lock_shared(adapter);
@@ -3577,8 +3575,7 @@ dxgkio_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 		}
 		if (event)
 			eventfd_ctx_put(event);
-		if (async_host_event)
-			kfree(async_host_event);
+		kfree(async_host_event);
 	}
 
 	DXG_TRACE_IOCTL_END(ret);
@@ -4438,7 +4435,7 @@ build_test_command_buffer(struct dxgprocess *process,
 	if (cmd.dma_buffer_size < sizeof(u32) ||
 	    cmd.dma_buffer_size > D3DDDI_MAXTESTBUFFERSIZE ||
 	    cmd.dma_buffer_priv_data_size >
-	    	D3DDDI_MAXTESTBUFFERPRIVATEDRIVERDATASIZE) {
+		D3DDDI_MAXTESTBUFFERPRIVATEDRIVERDATASIZE) {
 		DXG_ERR("Invalid DMA buffer or private data size");
 		return -EINVAL;
 	}
@@ -4511,8 +4508,7 @@ driver_known_escape(struct dxgprocess *process,
 	enum d3dkmt_escapetype escape_type;
 	int ret = 0;
 
-	if (args->priv_drv_data_size < sizeof(enum d3dddi_knownescapetype))
-	{
+	if (args->priv_drv_data_size < sizeof(enum d3dddi_knownescapetype)) {
 		DXG_ERR("Invalid private data size");
 		return -EINVAL;
 	}
@@ -5631,10 +5627,8 @@ void dxgk_validate_ioctls(void)
 {
 	int i;
 
-	for (i=0; i < ARRAY_SIZE(ioctls); i++)
-	{
-		if (ioctls[i].ioctl && _IOC_NR(ioctls[i].ioctl) != i)
-		{
+	for (i = 0; i < ARRAY_SIZE(ioctls); i++) {
+		if (ioctls[i].ioctl && _IOC_NR(ioctls[i].ioctl) != i) {
 			DXG_ERR("Invalid ioctl");
 			DXGKRNL_ASSERT(0);
 		}

