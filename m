Return-Path: <linux-hyperv+bounces-9615-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQiL1RfvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9615-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C622D24E4
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D294832C78FE
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96854401A38;
	Thu, 19 Mar 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2fJl+nH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A93FFAA7
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951968; cv=none; b=OeWAavnxQhc5azFWYKH4ooPlR4eJh1eEvSezoXdVq4cJh6KhubzF/4YgBpJynb9OuMttFDPqxMcjnVI4i8WUFRFTKz83zdBUAy3R5eiIfSlrAAPSgA3iRvebu355i0VGtjV6A2w+bI6uOCr1yXtVfHlwRyrDf5JQst/ez3APaOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951968; c=relaxed/simple;
	bh=VR58u3V3i58J8N6ZNFVtkIjqDKPXetLd0h+s5znAmcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0qLxgZleyPGenchVqY1NUjE8B6lNRaByiFGS0YLleXx2gHBCVSniV11FWt7QSHqiLLr772/RCLIGf6rkoNUyUtaVFdHeTKDcOZa0r8mA8XctDbbjolySQVVSKYIrE6YNdW9VJi3lh5vfR926HXm+zxOUkHNgQIEU910JBhkQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2fJl+nH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-486fda2a389so4684725e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951963; x=1774556763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDHDicT0bUGDGWHfwGKo943zbmk1k4eN+/Sr+skSI6Y=;
        b=V2fJl+nHWAeNcjSxnuPqlE3ublca6IzhVBTM7dMRwfv7/BlY2AloK/bgJZe4xl3Zag
         lPYe8Xit+jgAZtbTeOa+RXph1/JCmtBambJtzIRHnpukdTe7+ADZX5dainwMy2+qHN/5
         Itr2IvWLxV5vAWdWMhBsUlSed7jlZisSvewG3tPIkfJu8+Gxuwchg/jsNHC0MicmVXRv
         QyD4DTmJmyisJWeKDFj80HwtGNWI103kkBgkuJyw98RMuUOwTsj1TwAkJhTZJWgtrxFR
         xIIjGCte1kefmwrAJu5BU1yBCUJxfUBij9U0pZItRbCRUOhzXdvR81zz+PRCJkA/I0/Q
         tpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951963; x=1774556763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DDHDicT0bUGDGWHfwGKo943zbmk1k4eN+/Sr+skSI6Y=;
        b=sW5/D/gGBJTt32iw+8SIxq14ReGZYI5YBrPDHRLCQ/sceaD4S4ZsxktE5LfVYvDhq/
         vCh7CrJUSwQPA2Mn40EowJdZZ+XgDhoB3ZARo7/MDVAnpwxKBUC0cpmgHbgs1GFoB19K
         tMBDTSjC2x5IxjAGwUI2AdfxnsNTRXdVYsY/6KrtL7MGrgFHDBvPctcjaCJLg1ZyalNM
         C9zwbWTFG8We2nEzBqDoyt+mm+T5EXDJ/9feYvA0QKI4CDlpR0a4CJ9Ej1nbPXF9eV1L
         YnzduKTKFbkY6Z8ZqI1+NHG1X1uvD3/4ttdxiU37sQ4y347SnTBpmjIdFC9ppzB659KB
         ezwQ==
X-Gm-Message-State: AOJu0YwvVextEGl6CH0ct3+jMKt+zPv46UyzFnicmh802TUPrHaC5s/o
	IqMyBALrDyeU8WYcOmppWmReU9qxtblLhEzvssF19S944dH2ZJe+iSECcfS4g/1dOEU=
X-Gm-Gg: ATEYQzzWg/Bvggf5qNd60EzHNXMzuCcbaufrqtwpHZIXiwJc5eJ1TlSeHJzVf+wsyo0
	HpEC+I/KNg9T/tq2BEDncNXDHW/SPPb0KqFky3oL5nTgGrc0nKQfyrLI2L8tD1ZxV2oExBQTlbS
	lUAhtbWIsx8j2kn9hnRdIDyBKBEvWywrbroGASMfEi50l5ZLxhsY08P20sgx5NgJBI/niCNQ9oI
	YTUTPnb4ypQ1BuZ0oFKCYcwWucNA+NtACyggxtpqCsRcpgbhs+tx6SabcM7+nQmZyJFMDUQJjY4
	N1UsbvTAOH8/wbYcU6vpCHrroRi+gy05Cey0E4+sLrjTKh/UyY6unM3gu9ybA/GbfoHz5slqpRO
	CblhIEAnmsrSOWulDFNzUcKi59qKln9vtgPGUKhSQP/+K+XM9T3ShDgaiTO7CJ7tZ9sCtWclefX
	W3GjMwkxqSuxCfo+hiSX6HeWcnTwdD9XKbcMXsGqXRg+Avnpzo
X-Received: by 2002:a05:600c:34d2:b0:485:1878:7b8c with SMTP id 5b1f17b1804b1-486ff029163mr6284935e9.18.1773951962928;
        Thu, 19 Mar 2026 13:26:02 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.26.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:26:02 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 44/55] drivers: hv: dxgkrnl: Implement known escapes
Date: Thu, 19 Mar 2026 20:24:58 +0000
Message-ID: <20260319202509.63802-45-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9615-lists,linux-hyperv=lfdr.de];
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
X-Rspamd-Queue-Id: 29C622D24E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Implement an escape to build test command buffer.
Implement other known escapes.

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h  |   3 +-
 drivers/hv/dxgkrnl/dxgvmbus.c |  40 +++++---
 drivers/hv/dxgkrnl/ioctl.c    | 170 +++++++++++++++++++++++++++++-----
 include/uapi/misc/d3dkmthk.h  |  31 +++++++
 4 files changed, 205 insertions(+), 39 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index ebf81cffa289..9599ec8e0f1d 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -953,7 +953,8 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				      *args);
 int dxgvmb_send_escape(struct dxgprocess *process,
 		       struct dxgadapter *adapter,
-		       struct d3dkmt_escape *args);
+		       struct d3dkmt_escape *args,
+		       bool user_mode);
 int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 				  struct dxgadapter *adapter,
 				  struct d3dkmt_queryvideomemoryinfo *args,
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 2436e1a7bc73..de28c6162a70 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -2174,7 +2174,8 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 
 int dxgvmb_send_escape(struct dxgprocess *process,
 		       struct dxgadapter *adapter,
-		       struct d3dkmt_escape *args)
+		       struct d3dkmt_escape *args,
+		       bool user_mode)
 {
 	int ret;
 	struct dxgkvmb_command_escape *command = NULL;
@@ -2203,13 +2204,18 @@ int dxgvmb_send_escape(struct dxgprocess *process,
 	command->priv_drv_data_size = args->priv_drv_data_size;
 	command->context = args->context;
 	if (args->priv_drv_data_size) {
-		ret = copy_from_user(command->priv_drv_data,
-				     args->priv_drv_data,
-				     args->priv_drv_data_size);
-		if (ret) {
-			DXG_ERR("failed to copy priv data");
-			ret = -EFAULT;
-			goto cleanup;
+		if (user_mode) {
+			ret = copy_from_user(command->priv_drv_data,
+					args->priv_drv_data,
+					args->priv_drv_data_size);
+			if (ret) {
+				DXG_ERR("failed to copy priv data");
+				ret = -EFAULT;
+				goto cleanup;
+			}
+		} else {
+			memcpy(command->priv_drv_data, args->priv_drv_data,
+				args->priv_drv_data_size);
 		}
 	}
 
@@ -2220,12 +2226,18 @@ int dxgvmb_send_escape(struct dxgprocess *process,
 		goto cleanup;
 
 	if (args->priv_drv_data_size) {
-		ret = copy_to_user(args->priv_drv_data,
-				   command->priv_drv_data,
-				   args->priv_drv_data_size);
-		if (ret) {
-			DXG_ERR("failed to copy priv data");
-			ret = -EINVAL;
+		if (user_mode) {
+			ret = copy_to_user(args->priv_drv_data,
+					command->priv_drv_data,
+					args->priv_drv_data_size);
+			if (ret) {
+				DXG_ERR("failed to copy priv data");
+				ret = -EINVAL;
+			}
+		} else {
+			memcpy(args->priv_drv_data,
+				command->priv_drv_data,
+				args->priv_drv_data_size);
 		}
 	}
 
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 5ff4b27af19d..f8ca79d098f3 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -4257,10 +4257,8 @@ dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs
 	}
 
 	ret = dxgadapter_acquire_lock_shared(adapter);
-	if (ret < 0) {
-		adapter = NULL;
+	if (ret < 0)
 		goto cleanup;
-	}
 	adapter_locked = true;
 	args.adapter.v = 0;
 	ret = dxgvmb_send_change_vidmem_reservation(process, adapter,
@@ -4299,10 +4297,8 @@ dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgadapter_acquire_lock_shared(adapter);
-	if (ret < 0) {
-		adapter = NULL;
+	if (ret < 0)
 		goto cleanup;
-	}
 	adapter_locked = true;
 
 	args.adapter = adapter->host_handle;
@@ -4349,10 +4345,8 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgadapter_acquire_lock_shared(adapter);
-	if (ret < 0) {
-		adapter = NULL;
+	if (ret < 0)
 		goto cleanup;
-	}
 	adapter_locked = true;
 
 	args.adapter = adapter->host_handle;
@@ -4417,6 +4411,134 @@ dxgkio_invalidate_cache(struct dxgprocess *process, void *__user inargs)
 	return ret;
 }
 
+static int
+build_test_command_buffer(struct dxgprocess *process,
+			  struct dxgadapter *adapter,
+			  struct d3dkmt_escape *args)
+{
+	int ret;
+	struct d3dddi_buildtestcommandbuffer cmd;
+	struct d3dkmt_escape newargs = *args;
+	u32 buf_size;
+	struct d3dddi_buildtestcommandbuffer *buf = NULL;
+	struct d3dddi_buildtestcommandbuffer *__user ucmd;
+
+	ucmd = args->priv_drv_data;
+	if (args->priv_drv_data_size <
+	    sizeof(struct d3dddi_buildtestcommandbuffer)) {
+		DXG_ERR("Invalid private data size");
+		return -EINVAL;
+	}
+	ret = copy_from_user(&cmd, ucmd, sizeof(cmd));
+	if (ret) {
+		DXG_ERR("Failed to copy private data");
+		return -EFAULT;
+	}
+
+	if (cmd.dma_buffer_size < sizeof(u32) ||
+	    cmd.dma_buffer_size > D3DDDI_MAXTESTBUFFERSIZE ||
+	    cmd.dma_buffer_priv_data_size >
+	    	D3DDDI_MAXTESTBUFFERPRIVATEDRIVERDATASIZE) {
+		DXG_ERR("Invalid DMA buffer or private data size");
+		return -EINVAL;
+	}
+	/* Allocate a new buffer for the escape call */
+	buf_size = sizeof(struct d3dddi_buildtestcommandbuffer) +
+		cmd.dma_buffer_size +
+		cmd.dma_buffer_priv_data_size;
+	buf = vzalloc(buf_size);
+	if (buf == NULL) {
+		ret = -ENOMEM;
+		goto cleanup;
+	}
+	*buf = cmd;
+	buf->dma_buffer = NULL;
+	buf->dma_buffer_priv_data = NULL;
+
+	/* Replace private data in the escape arguments and call the host */
+	newargs.priv_drv_data = buf;
+	newargs.priv_drv_data_size = buf_size;
+	ret = dxgvmb_send_escape(process, adapter, &newargs, false);
+	if (ret) {
+		DXG_ERR("Host failed escape");
+		goto cleanup;
+	}
+
+	ret = copy_to_user(&ucmd->dma_buffer_size, &buf->dma_buffer_size,
+			   sizeof(u32));
+	if (ret) {
+		DXG_ERR("Failed to dma size to user");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+	ret = copy_to_user(&ucmd->dma_buffer_priv_data_size,
+			   &buf->dma_buffer_priv_data_size,
+			   sizeof(u32));
+	if (ret) {
+		DXG_ERR("Failed to dma private data size to user");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+	ret = copy_to_user(cmd.dma_buffer, (char *)buf + sizeof(*buf),
+			   buf->dma_buffer_size);
+	if (ret) {
+		DXG_ERR("Failed to copy dma buffer to user");
+		ret = -EFAULT;
+		goto cleanup;
+	}
+	if (buf->dma_buffer_priv_data_size) {
+		ret = copy_to_user(cmd.dma_buffer_priv_data,
+			(char *)buf + sizeof(*buf) + cmd.dma_buffer_size,
+			buf->dma_buffer_priv_data_size);
+		if (ret) {
+			DXG_ERR("Failed to copy private data to user");
+			ret = -EFAULT;
+			goto cleanup;
+		}
+	}
+
+cleanup:
+	if (buf)
+		vfree(buf);
+	return ret;
+}
+
+static int
+driver_known_escape(struct dxgprocess *process,
+		    struct dxgadapter *adapter,
+		    struct d3dkmt_escape *args)
+{
+	enum d3dkmt_escapetype escape_type;
+	int ret = 0;
+
+	if (args->priv_drv_data_size < sizeof(enum d3dddi_knownescapetype))
+	{
+		DXG_ERR("Invalid private data size");
+		return -EINVAL;
+	}
+	ret = copy_from_user(&escape_type, args->priv_drv_data,
+			     sizeof(escape_type));
+	if (ret) {
+		DXG_ERR("Failed to read escape type");
+		return -EFAULT;
+	}
+	switch (escape_type) {
+	case _D3DDDI_DRIVERESCAPETYPE_TRANSLATEALLOCATIONHANDLE:
+	case _D3DDDI_DRIVERESCAPETYPE_TRANSLATERESOURCEHANDLE:
+		/*
+		 * The host and VM handles are the same
+		 */
+		break;
+	case _D3DDDI_DRIVERESCAPETYPE_BUILDTESTCOMMANDBUFFER:
+		ret = build_test_command_buffer(process, adapter, args);
+		break;
+	default:
+		ret = dxgvmb_send_escape(process, adapter, args, true);
+		break;
+	}
+	return ret;
+}
+
 static int
 dxgkio_escape(struct dxgprocess *process, void *__user inargs)
 {
@@ -4438,14 +4560,17 @@ dxgkio_escape(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgadapter_acquire_lock_shared(adapter);
-	if (ret < 0) {
-		adapter = NULL;
+	if (ret < 0)
 		goto cleanup;
-	}
 	adapter_locked = true;
 
 	args.adapter = adapter->host_handle;
-	ret = dxgvmb_send_escape(process, adapter, &args);
+
+	if (args.type == _D3DKMT_ESCAPE_DRIVERPRIVATE &&
+	    args.flags.driver_known_escape)
+		ret = driver_known_escape(process, adapter, &args);
+	else
+		ret = dxgvmb_send_escape(process, adapter, &args, true);
 
 cleanup:
 
@@ -4485,10 +4610,8 @@ dxgkio_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
 	}
 
 	ret = dxgadapter_acquire_lock_shared(adapter);
-	if (ret < 0) {
-		adapter = NULL;
+	if (ret < 0)
 		goto cleanup;
-	}
 	adapter_locked = true;
 
 	args.adapter = adapter->host_handle;
@@ -5323,9 +5446,9 @@ dxgkio_is_feature_enabled(struct dxgprocess *process, void *__user inargs)
 {
 	struct d3dkmt_isfeatureenabled args;
 	struct dxgadapter *adapter = NULL;
-	struct dxgglobal *dxgglobal = dxggbl();
 	struct d3dkmt_isfeatureenabled *__user uargs = inargs;
 	int ret;
+	bool adapter_locked = false;
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
@@ -5340,11 +5463,10 @@ dxgkio_is_feature_enabled(struct dxgprocess *process, void *__user inargs)
 		goto cleanup;
 	}
 
-	if (adapter) {
-		ret = dxgadapter_acquire_lock_shared(adapter);
-		if (ret < 0)
-			goto cleanup;
-	}
+	ret = dxgadapter_acquire_lock_shared(adapter);
+	if (ret < 0)
+		goto cleanup;
+	adapter_locked = true;
 
 	ret = dxgvmb_send_is_feature_enabled(adapter, &args);
 	if (ret)
@@ -5354,10 +5476,10 @@ dxgkio_is_feature_enabled(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	if (adapter) {
+	if (adapter_locked)
 		dxgadapter_release_lock_shared(adapter);
+	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
-	}
 
 	DXG_TRACE_IOCTL_END(ret);
 	return ret;
diff --git a/include/uapi/misc/d3dkmthk.h b/include/uapi/misc/d3dkmthk.h
index 5b345ddaf66e..db40e8ff40b0 100644
--- a/include/uapi/misc/d3dkmthk.h
+++ b/include/uapi/misc/d3dkmthk.h
@@ -237,6 +237,37 @@ struct d3dddi_destroypagingqueue {
 	struct d3dkmthandle		paging_queue;
 };
 
+enum d3dddi_knownescapetype {
+	_D3DDDI_DRIVERESCAPETYPE_TRANSLATEALLOCATIONHANDLE	= 0,
+	_D3DDDI_DRIVERESCAPETYPE_TRANSLATERESOURCEHANDLE	= 1,
+	_D3DDDI_DRIVERESCAPETYPE_CPUEVENTUSAGE			= 2,
+	_D3DDDI_DRIVERESCAPETYPE_BUILDTESTCOMMANDBUFFER		= 3,
+};
+
+struct d3dddi_translate_allocation_handle {
+	enum d3dddi_knownescapetype	escape_type;
+	struct d3dkmthandle		allocation;
+};
+
+struct d3dddi_testcommand {
+	char buffer[72];
+};
+
+#define D3DDDI_MAXTESTBUFFERSIZE 4096
+#define D3DDDI_MAXTESTBUFFERPRIVATEDRIVERDATASIZE 1024
+
+struct d3dddi_buildtestcommandbuffer {
+	enum d3dddi_knownescapetype	escape_type;
+	struct d3dkmthandle		device;
+	struct d3dkmthandle		context;
+	__u32				flags;
+	struct d3dddi_testcommand	command;
+	void				*dma_buffer;
+	void				*dma_buffer_priv_data;
+	__u32				dma_buffer_size;
+	__u32				dma_buffer_priv_data_size;
+};
+
 enum d3dkmt_escapetype {
 	_D3DKMT_ESCAPE_DRIVERPRIVATE	= 0,
 	_D3DKMT_ESCAPE_VIDMM		= 1,

