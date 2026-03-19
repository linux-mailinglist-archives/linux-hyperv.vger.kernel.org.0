Return-Path: <linux-hyperv+bounces-9612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP8ML4tdvGlxxQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9612-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:15 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5E62D233F
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 21:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41A3730AE7BD
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Mar 2026 20:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4F6401496;
	Thu, 19 Mar 2026 20:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtVFUJo4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E94B3FD15F
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951966; cv=none; b=scm76ciTuOAB8fzbMHm4mM7fwWNwSMvxiAoLUH877v5GlRUppYLJhz9Ms5QPl4GxGMHUFKU0BIospGKw9DmxWdi9OZv6kR8wjIPS89mnc6TWRnifTN2ZTb1oXDcm+Npw7PGT/jCpfbapC1ABW3taLh2iqjVIAaanoTzz8fbTTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951966; c=relaxed/simple;
	bh=wQnn+i7HDDPXuej5K3rlTfB9nYZEhWTHsN8WCvRd9cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZD4r5+Lp+RG83W6JYd6Q7ryAUhAL1OI1WxEASaM9T9AS88X3cI2qFDa16iusj2aZyZHyRD8WYE7UBufJQktmssr2laIKY/phhgZXYF+wJ1BmHAbu1bb8CcKZulFLyFmvq73lydFZe/5DHrEzTbMmdvn26vm4XfBQquAU647YRRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtVFUJo4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b5bded412so661347f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951953; x=1774556753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4d2q8ALa933Eh/PiXW6PrWUfVVovOz9gsGmUizF5y3c=;
        b=OtVFUJo4ZCnG31ffUpffYpbBnd/19H8Ezkr9XeqC3ejvzBvygYeDI9Xs7zeZEFXiY+
         m84TZCx/Yd2REN6Vg2O6M/s7fQEYErfZGzc8JieuFrR6arG61lKT8qlb/hgXh3+3pNsl
         Vny+a/FQBgMEqsMOcBTc+E0f2aC7tIz0++iM5PjNYw8fSJoIHo3CJK1kx9JBNX+4cnM8
         lJ4I8qALtR348ob3Vdz52r1LFzfc9NQSta52y0idHajPw9GY/oHZCfFLabMRUmPDprhH
         CJNB0GaC4NDUL+5Sj9ufmFMFS9zW5l60Mk7MRdPWi0KPcL1gRzb/JD4S8W8OO+tBX23W
         jLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951953; x=1774556753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4d2q8ALa933Eh/PiXW6PrWUfVVovOz9gsGmUizF5y3c=;
        b=UN8R1Yt0TPxMOuYTzw3Bcl3/BkyTk7TQ1Q248Bsh++5l2VIhsP9awyrCUwxQXEOmh/
         U9heYhDapUCKT8JMZYunRovui0fd81y/CBQfebuSX21LEF/SqjXAPDHKxauyKhBUMLBx
         5fRR9WfWyyFNgW0XeQvbPQSVnk6oQTDo16DTpf2LbNmYmhi4uxD7VXGJPhrnBPsbRcvc
         rGkdKotQLB/JCgtWPaZVBQ/xGumJalP1NeTeg5f07lpB4B6NUPjY/vzG/gLeD5chOgBF
         Y8D3qKuM8wGk8x6nq8xfLcnsHvYXu2qaH06ybptYtcUCY+a7By5C0pxj71n7kRzIaZfZ
         vBRQ==
X-Gm-Message-State: AOJu0YzUfHcVLQvGIYjgc4Pl7zqQUCWSYSqeRZJx5LD5fX2VNDs0Lwet
	XnNg1auTiB1qB41T5Nmyrq+j6bPf+BwGGheMxJGIfQJRnUkwihrNbrcpBkEt+MvgI6w=
X-Gm-Gg: ATEYQzzWTSRTcCa5cXh+Ohe+L2D4bIZzhgukVBHB0wj51EVGcE+QIYw95s0FW2v2zfS
	ONXGGVi7WofAMQuIoEBzKS5pH1GeL6fQJLPNT1X4Jk8vgSk+1vqpIdcffmMOFzZPyg0fEjCLH9s
	Zh1QWzOOygBDkmHIGR/1r5tBAfekU9jR0XWrt1vYjY0ecy0/h50o2BIyPpOty/wGrdlhPd/rKUW
	fpzmIveVnWx5VbJ3FFWyeHU3/Jvme1K6Y43ZlDbS25+nLTmQQ4fHYFRY4QWxZOJbDtjTvn7w+NC
	MHjq4hdNYsGQsPDnTgTIbE7HPjh45TJ0ZTuE8p3oB1yPamFX3+8GP8AgUUcmlsj1SAhkbiDYdco
	3M5GdEfnuN1ZkhE68h0tTWjWmxJKqqkWqluWZtOcquHSqWtRxE1ESsCWtXu0gw3dFKEvKlQmeI8
	4k1RN6iA0e2RTd7Fd8CmaNaAXStD8o1J2xhTZcr1gpMYQ4fd7W
X-Received: by 2002:a05:6000:310e:b0:43b:564d:c11d with SMTP id ffacd0b85a97d-43b64234717mr1296643f8f.11.1773951952430;
        Thu, 19 Mar 2026 13:25:52 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:51 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 34/55] drivers: hv: dxgkrnl: Improve tracing and return values from copy from user
Date: Thu, 19 Mar 2026 20:24:48 +0000
Message-ID: <20260319202509.63802-35-eric.curtin@docker.com>
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
	TAGGED_FROM(0.00)[bounces-9612-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericcurtin17@gmail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.982];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[docker.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1C5E62D233F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgkrnl.h     |  17 +-
 drivers/hv/dxgkrnl/dxgmodule.c   |   1 +
 drivers/hv/dxgkrnl/dxgsyncfile.c |  13 +-
 drivers/hv/dxgkrnl/dxgvmbus.c    |  98 ++++-----
 drivers/hv/dxgkrnl/ioctl.c       | 327 +++++++++++++++----------------
 5 files changed, 225 insertions(+), 231 deletions(-)

diff --git a/drivers/hv/dxgkrnl/dxgkrnl.h b/drivers/hv/dxgkrnl/dxgkrnl.h
index d92e1348ccfb..f63aa6f7a9dc 100644
--- a/drivers/hv/dxgkrnl/dxgkrnl.h
+++ b/drivers/hv/dxgkrnl/dxgkrnl.h
@@ -999,18 +999,25 @@ void dxgk_validate_ioctls(void);
 	trace_printk(dev_fmt(fmt) "\n", ##__VA_ARGS__);	\
 }  while (0)
 
-#define DXG_ERR(fmt, ...) do {				\
-	dev_err(DXGDEV, fmt, ##__VA_ARGS__);		\
-	trace_printk("*** dxgkerror *** " dev_fmt(fmt) "\n", ##__VA_ARGS__);	\
+#define DXG_ERR(fmt, ...) do {					\
+	dev_err(DXGDEV, "%s: " fmt, __func__, ##__VA_ARGS__);	\
+	trace_printk("*** dxgkerror *** " dev_fmt(fmt) "\n", ##__VA_ARGS__); \
 } while (0)
 
 #else
 
 #define DXG_TRACE(...)
-#define DXG_ERR(fmt, ...) do {			\
-	dev_err(DXGDEV, fmt, ##__VA_ARGS__);	\
+#define DXG_ERR(fmt, ...) do {					\
+	dev_err(DXGDEV, "%s: " fmt, __func__, ##__VA_ARGS__);	\
 } while (0)
 
 #endif /* DEBUG */
 
+#define DXG_TRACE_IOCTL_END(ret)  do {			\
+	if (ret < 0)					\
+		DXG_ERR("Ioctl failed: %d", ret);	\
+	else						\
+		DXG_TRACE("Ioctl returned: %d", ret);	\
+} while (0)
+
 #endif
diff --git a/drivers/hv/dxgkrnl/dxgmodule.c b/drivers/hv/dxgkrnl/dxgmodule.c
index 5570f35954d4..aa27931a3447 100644
--- a/drivers/hv/dxgkrnl/dxgmodule.c
+++ b/drivers/hv/dxgkrnl/dxgmodule.c
@@ -961,3 +961,4 @@ module_exit(dxg_drv_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual compute device Driver");
+MODULE_VERSION("2.0.0");
diff --git a/drivers/hv/dxgkrnl/dxgsyncfile.c b/drivers/hv/dxgkrnl/dxgsyncfile.c
index 9d5832c90ad7..f3b3e8dd4568 100644
--- a/drivers/hv/dxgkrnl/dxgsyncfile.c
+++ b/drivers/hv/dxgkrnl/dxgsyncfile.c
@@ -38,13 +38,6 @@
 #undef dev_fmt
 #define dev_fmt(fmt)	"dxgk: " fmt
 
-#ifdef DEBUG
-static char *errorstr(int ret)
-{
-	return ret < 0 ? "err" : "";
-}
-#endif
-
 static const struct dma_fence_ops dxgdmafence_ops;
 
 static struct dxgsyncpoint *to_syncpoint(struct dma_fence *fence)
@@ -193,7 +186,7 @@ int dxgkio_create_sync_file(struct dxgprocess *process, void *__user inargs)
 		if (fd >= 0)
 			put_unused_fd(fd);
 	}
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -317,7 +310,7 @@ int dxgkio_open_syncobj_from_syncfile(struct dxgprocess *process,
 		kref_put(&device->device_kref, dxgdevice_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -415,7 +408,7 @@ int dxgkio_wait_sync_file(struct dxgprocess *process, void *__user inargs)
 	if (dmafence)
 		dma_fence_put(dmafence);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
diff --git a/drivers/hv/dxgkrnl/dxgvmbus.c b/drivers/hv/dxgkrnl/dxgvmbus.c
index 36f4d4e84d3e..566ccb6d01c9 100644
--- a/drivers/hv/dxgkrnl/dxgvmbus.c
+++ b/drivers/hv/dxgkrnl/dxgvmbus.c
@@ -1212,7 +1212,7 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 				     args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("Faled to copy private data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -1230,7 +1230,7 @@ dxgvmb_send_create_context(struct dxgadapter *adapter,
 			if (ret) {
 				DXG_ERR(
 					"Faled to copy private data to user");
-				ret = -EINVAL;
+				ret = -EFAULT;
 				dxgvmb_send_destroy_context(adapter, process,
 							    context);
 				context.v = 0;
@@ -1365,7 +1365,7 @@ copy_private_data(struct d3dkmt_createallocation *args,
 				     args->private_runtime_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy runtime data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 		private_data_dest += args->private_runtime_data_size;
@@ -1385,7 +1385,7 @@ copy_private_data(struct d3dkmt_createallocation *args,
 				     args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy private data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 		private_data_dest += args->priv_drv_data_size;
@@ -1406,7 +1406,7 @@ copy_private_data(struct d3dkmt_createallocation *args,
 					     input_alloc->priv_drv_data_size);
 			if (ret) {
 				DXG_ERR("failed to copy alloc data");
-				ret = -EINVAL;
+				ret = -EFAULT;
 				goto cleanup;
 			}
 			private_data_dest += input_alloc->priv_drv_data_size;
@@ -1658,7 +1658,7 @@ create_local_allocations(struct dxgprocess *process,
 				   sizeof(struct d3dkmthandle));
 		if (ret) {
 			DXG_ERR("failed to copy resource handle");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -1690,7 +1690,7 @@ create_local_allocations(struct dxgprocess *process,
 					   host_alloc->priv_drv_data_size);
 			if (ret) {
 				DXG_ERR("failed to copy private data");
-				ret = -EINVAL;
+				ret = -EFAULT;
 				goto cleanup;
 			}
 			alloc_private_data += host_alloc->priv_drv_data_size;
@@ -1700,7 +1700,7 @@ create_local_allocations(struct dxgprocess *process,
 				   sizeof(struct d3dkmthandle));
 		if (ret) {
 			DXG_ERR("failed to copy alloc handle");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -1714,7 +1714,7 @@ create_local_allocations(struct dxgprocess *process,
 			   sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy global share");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -1961,7 +1961,7 @@ int dxgvmb_send_query_clock_calibration(struct dxgprocess *process,
 			   sizeof(result.clock_data));
 	if (ret) {
 		DXG_ERR("failed to copy clock data");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = ntstatus2int(result.status);
@@ -2041,7 +2041,7 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 				     alloc_size);
 		if (ret) {
 			DXG_ERR("failed to copy alloc handles");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -2059,7 +2059,7 @@ int dxgvmb_send_query_alloc_residency(struct dxgprocess *process,
 			   result_allocation_size);
 	if (ret) {
 		DXG_ERR("failed to copy residency status");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -2105,7 +2105,7 @@ int dxgvmb_send_escape(struct dxgprocess *process,
 				     args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy priv data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -2164,14 +2164,14 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 			   sizeof(output->budget));
 	if (ret) {
 		DXG_ERR("failed to copy budget");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&output->current_usage, &result.current_usage,
 			   sizeof(output->current_usage));
 	if (ret) {
 		DXG_ERR("failed to copy current usage");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&output->current_reservation,
@@ -2179,7 +2179,7 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 			   sizeof(output->current_reservation));
 	if (ret) {
 		DXG_ERR("failed to copy reservation");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&output->available_for_reservation,
@@ -2187,7 +2187,7 @@ int dxgvmb_send_query_vidmem_info(struct dxgprocess *process,
 			   sizeof(output->available_for_reservation));
 	if (ret) {
 		DXG_ERR("failed to copy avail reservation");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -2229,7 +2229,7 @@ int dxgvmb_send_get_device_state(struct dxgprocess *process,
 	ret = copy_to_user(output, &result.args, sizeof(result.args));
 	if (ret) {
 		DXG_ERR("failed to copy output args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 	if (args->state_type == _D3DKMT_DEVICESTATE_EXECUTION)
@@ -2404,7 +2404,7 @@ int dxgvmb_send_make_resident(struct dxgprocess *process,
 			     sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy alloc handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	command_vgpu_to_host_init2(&command->hdr,
@@ -2454,7 +2454,7 @@ int dxgvmb_send_evict(struct dxgprocess *process,
 			     sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy alloc handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	command_vgpu_to_host_init2(&command->hdr,
@@ -2502,14 +2502,14 @@ int dxgvmb_send_submit_command(struct dxgprocess *process,
 			     hbufsize);
 	if (ret) {
 		DXG_ERR(" failed to copy history buffer");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_from_user((u8 *) &command[1] + hbufsize,
 			     args->priv_drv_data, args->priv_drv_data_size);
 	if (ret) {
 		DXG_ERR("failed to copy history priv data");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2671,7 +2671,7 @@ int dxgvmb_send_update_gpu_va(struct dxgprocess *process,
 			     op_size);
 	if (ret) {
 		DXG_ERR("failed to copy operations");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2751,7 +2751,7 @@ dxgvmb_send_create_sync_object(struct dxgprocess *process,
 						     sizeof(u64));
 				if (ret) {
 					DXG_ERR("failed to read fence");
-					ret = -EINVAL;
+					ret = -EFAULT;
 				} else {
 					DXG_TRACE("fence value:%lx",
 						value);
@@ -2820,7 +2820,7 @@ int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
 	if (ret) {
 		DXG_ERR("Failed to read objects %p %d",
 			objects, object_size);
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	current_pos += object_size;
@@ -2834,7 +2834,7 @@ int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
 		if (ret) {
 			DXG_ERR("Failed to read contexts %p %d",
 				contexts, context_size);
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 		current_pos += context_size;
@@ -2844,7 +2844,7 @@ int dxgvmb_send_signal_sync_object(struct dxgprocess *process,
 		if (ret) {
 			DXG_ERR("Failed to read fences %p %d",
 				fences, fence_size);
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -2898,7 +2898,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 		ret = copy_from_user(current_pos, args->objects, object_size);
 		if (ret) {
 			DXG_ERR("failed to copy objects");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 		current_pos += object_size;
@@ -2906,7 +2906,7 @@ int dxgvmb_send_wait_sync_object_cpu(struct dxgprocess *process,
 					fence_size);
 		if (ret) {
 			DXG_ERR("failed to copy fences");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	} else {
@@ -3037,7 +3037,7 @@ int dxgvmb_send_lock2(struct dxgprocess *process,
 					   sizeof(args->data));
 			if (ret) {
 				DXG_ERR("failed to copy data");
-				ret = -EINVAL;
+				ret = -EFAULT;
 				alloc->cpu_address_refcount--;
 				if (alloc->cpu_address_refcount == 0) {
 					dxg_unmap_iospace(alloc->cpu_address,
@@ -3119,7 +3119,7 @@ int dxgvmb_send_update_alloc_property(struct dxgprocess *process,
 				    sizeof(u64));
 		if (ret1) {
 			DXG_ERR("failed to copy paging fence");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 	}
 cleanup:
@@ -3204,14 +3204,14 @@ int dxgvmb_send_set_allocation_priority(struct dxgprocess *process,
 			     alloc_size);
 	if (ret) {
 		DXG_ERR("failed to copy alloc handle");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_from_user((u8 *) allocations + alloc_size,
 				args->priorities, priority_size);
 	if (ret) {
 		DXG_ERR("failed to copy alloc priority");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3277,7 +3277,7 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 			     alloc_size);
 	if (ret) {
 		DXG_ERR("failed to copy alloc handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3296,7 +3296,7 @@ int dxgvmb_send_get_allocation_priority(struct dxgprocess *process,
 			   priority_size);
 	if (ret) {
 		DXG_ERR("failed to copy priorities");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -3402,7 +3402,7 @@ int dxgvmb_send_offer_allocations(struct dxgprocess *process,
 	}
 	if (ret) {
 		DXG_ERR("failed to copy input handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3457,7 +3457,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 	}
 	if (ret) {
 		DXG_ERR("failed to copy input handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3469,7 +3469,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 			   &result->paging_fence_value, sizeof(u64));
 	if (ret) {
 		DXG_ERR("failed to copy paging fence");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3480,7 +3480,7 @@ int dxgvmb_send_reclaim_allocations(struct dxgprocess *process,
 				   args->allocation_count);
 		if (ret) {
 			DXG_ERR("failed to copy results");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 	}
 
@@ -3559,7 +3559,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 				     args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy private data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -3604,7 +3604,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			   sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy hwqueue handle");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence,
@@ -3612,7 +3612,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			   sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to progress fence");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_cpu_va,
@@ -3620,7 +3620,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			   sizeof(inargs->queue_progress_fence_cpu_va));
 	if (ret) {
 		DXG_ERR("failed to copy fence cpu va");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(&inargs->queue_progress_fence_gpu_va,
@@ -3628,7 +3628,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 			   sizeof(u64));
 	if (ret) {
 		DXG_ERR("failed to copy fence gpu va");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	if (args->priv_drv_data_size) {
@@ -3637,7 +3637,7 @@ int dxgvmb_send_create_hwqueue(struct dxgprocess *process,
 				   args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy private data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 	}
 
@@ -3706,7 +3706,7 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 			     args->private_data, args->private_data_size);
 	if (ret) {
 		DXG_ERR("Faled to copy private data");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3758,7 +3758,7 @@ int dxgvmb_send_query_adapter_info(struct dxgprocess *process,
 			   args->private_data_size);
 	if (ret) {
 		DXG_ERR("Faled to copy private data to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -3791,7 +3791,7 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 					 primaries_size);
 		if (ret) {
 			DXG_ERR("failed to copy primaries handles");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -3801,7 +3801,7 @@ int dxgvmb_send_submit_command_hwqueue(struct dxgprocess *process,
 				      args->priv_drv_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy primaries data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
diff --git a/drivers/hv/dxgkrnl/ioctl.c b/drivers/hv/dxgkrnl/ioctl.c
index 622904d5c3a9..3dc9e76f4f3d 100644
--- a/drivers/hv/dxgkrnl/ioctl.c
+++ b/drivers/hv/dxgkrnl/ioctl.c
@@ -29,13 +29,6 @@ struct ioctl_desc {
 	u32 ioctl;
 };
 
-#ifdef DEBUG
-static char *errorstr(int ret)
-{
-	return ret < 0 ? "err" : "";
-}
-#endif
-
 void dxgsharedsyncobj_put(struct dxgsharedsyncobject *syncobj)
 {
 	DXG_TRACE("Release syncobj: %p", syncobj);
@@ -108,7 +101,7 @@ static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("Faled to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -129,7 +122,7 @@ static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
 						&args.adapter_handle,
 						sizeof(struct d3dkmthandle));
 					if (ret)
-						ret = -EINVAL;
+						ret = -EFAULT;
 				}
 				adapter = entry;
 			}
@@ -150,7 +143,7 @@ static int dxgkio_open_adapter_from_luid(struct dxgprocess *process,
 	if (ret < 0)
 		dxgprocess_close_adapter(process, args.adapter_handle);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -173,7 +166,7 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 	ret = copy_from_user(args, inargs, sizeof(*args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -199,7 +192,7 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 			ret = copy_to_user(inargs, args, sizeof(*args));
 			if (ret) {
 				DXG_ERR("failed to copy args");
-				ret = -EINVAL;
+				ret = -EFAULT;
 			}
 		}
 		dxgadapter_release_lock_shared(adapter);
@@ -209,7 +202,7 @@ static int dxgkio_query_statistics(struct dxgprocess *process,
 	if (args)
 		vfree(args);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -233,7 +226,7 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 				   &dxgglobal->num_adapters, sizeof(u32));
 		if (ret) {
 			DXG_ERR("copy_to_user faled");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 		goto cleanup;
 	}
@@ -291,7 +284,7 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 				   &dxgglobal->num_adapters, sizeof(u32));
 		if (ret) {
 			DXG_ERR("copy_to_user failed");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 		goto cleanup;
 	}
@@ -300,13 +293,13 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 			   sizeof(adapter_count));
 	if (ret) {
 		DXG_ERR("failed to copy adapter_count");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(info_out, info, sizeof(info[0]) * adapter_count);
 	if (ret) {
 		DXG_ERR("failed to copy adapter info");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -326,7 +319,7 @@ dxgkp_enum_adapters(struct dxgprocess *process,
 	if (adapters)
 		vfree(adapters);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -437,7 +430,7 @@ dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -447,7 +440,7 @@ dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 		ret = copy_to_user(inargs, &args, sizeof(args));
 		if (ret) {
 			DXG_ERR("failed to copy args to user");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 		goto cleanup;
 	}
@@ -508,14 +501,14 @@ dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy args to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	ret = copy_to_user(args.adapters, info,
 			   sizeof(info[0]) * args.num_adapters);
 	if (ret) {
 		DXG_ERR("failed to copy adapter info to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -536,7 +529,7 @@ dxgkio_enum_adapters(struct dxgprocess *process, void *__user inargs)
 	if (adapters)
 		vfree(adapters);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -549,7 +542,7 @@ dxgkio_enum_adapters3(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -561,7 +554,7 @@ dxgkio_enum_adapters3(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -574,7 +567,7 @@ dxgkio_close_adapter(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -584,7 +577,7 @@ dxgkio_close_adapter(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl: %s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -598,7 +591,7 @@ dxgkio_query_adapter_info(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -630,7 +623,7 @@ dxgkio_query_adapter_info(struct dxgprocess *process, void *__user inargs)
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -647,7 +640,7 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -677,7 +670,7 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 				   sizeof(struct d3dkmthandle));
 		if (ret) {
 			DXG_ERR("failed to copy device handle");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 
@@ -709,7 +702,7 @@ dxgkio_create_device(struct dxgprocess *process, void *__user inargs)
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -724,7 +717,7 @@ dxgkio_destroy_device(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -756,7 +749,7 @@ dxgkio_destroy_device(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -774,7 +767,7 @@ dxgkio_create_context_virtual(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -824,7 +817,7 @@ dxgkio_create_context_virtual(struct dxgprocess *process, void *__user inargs)
 				   sizeof(struct d3dkmthandle));
 		if (ret) {
 			DXG_ERR("failed to copy context handle");
-			ret = -EINVAL;
+			ret = -EFAULT;
 		}
 	} else {
 		DXG_ERR("invalid host handle");
@@ -851,7 +844,7 @@ dxgkio_create_context_virtual(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -868,7 +861,7 @@ dxgkio_destroy_context(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -920,7 +913,7 @@ dxgkio_destroy_context(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %s %d", errorstr(ret), __func__, ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -938,7 +931,7 @@ dxgkio_create_hwqueue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1002,7 +995,7 @@ dxgkio_create_hwqueue(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1019,7 +1012,7 @@ static int dxgkio_destroy_hwqueue(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1070,7 +1063,7 @@ static int dxgkio_destroy_hwqueue(struct dxgprocess *process,
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1088,7 +1081,7 @@ dxgkio_create_paging_queue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1128,7 +1121,7 @@ dxgkio_create_paging_queue(struct dxgprocess *process, void *__user inargs)
 		ret = copy_to_user(inargs, &args, sizeof(args));
 		if (ret) {
 			DXG_ERR("failed to copy input args");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 
@@ -1169,7 +1162,7 @@ dxgkio_create_paging_queue(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1186,7 +1179,7 @@ dxgkio_destroy_paging_queue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1247,7 +1240,7 @@ dxgkio_destroy_paging_queue(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1351,7 +1344,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1373,7 +1366,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				 alloc_info_size);
 	if (ret) {
 		DXG_ERR("failed to copy alloc info");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1412,7 +1405,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				     sizeof(standard_alloc));
 		if (ret) {
 			DXG_ERR("failed to copy std alloc data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 		if (standard_alloc.type ==
@@ -1556,7 +1549,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				if (ret) {
 					DXG_ERR(
 						"failed to copy runtime data");
-					ret = -EINVAL;
+					ret = -EFAULT;
 					goto cleanup;
 				}
 			}
@@ -1576,7 +1569,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 				if (ret) {
 					DXG_ERR(
 						"failed to copy res data");
-					ret = -EINVAL;
+					ret = -EFAULT;
 					goto cleanup;
 				}
 			}
@@ -1733,7 +1726,7 @@ dxgkio_create_allocation(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1793,7 +1786,7 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -1823,7 +1816,7 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 					 handle_size);
 		if (ret) {
 			DXG_ERR("failed to copy alloc handles");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -1962,7 +1955,7 @@ dxgkio_destroy_allocation(struct dxgprocess *process, void *__user inargs)
 	if (allocs)
 		vfree(allocs);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -1978,7 +1971,7 @@ dxgkio_make_resident(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2022,7 +2015,7 @@ dxgkio_make_resident(struct dxgprocess *process, void *__user inargs)
 			    &args.paging_fence_value, sizeof(u64));
 	if (ret2) {
 		DXG_ERR("failed to copy paging fence");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2030,7 +2023,7 @@ dxgkio_make_resident(struct dxgprocess *process, void *__user inargs)
 			    &args.num_bytes_to_trim, sizeof(u64));
 	if (ret2) {
 		DXG_ERR("failed to copy bytes to trim");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2041,7 +2034,7 @@ dxgkio_make_resident(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 
 	return ret;
 }
@@ -2058,7 +2051,7 @@ dxgkio_evict(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2090,7 +2083,7 @@ dxgkio_evict(struct dxgprocess *process, void *__user inargs)
 			   &args.num_bytes_to_trim, sizeof(u64));
 	if (ret) {
 		DXG_ERR("failed to copy bytes to trim to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 cleanup:
 
@@ -2099,7 +2092,7 @@ dxgkio_evict(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2114,7 +2107,7 @@ dxgkio_offer_allocations(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2153,7 +2146,7 @@ dxgkio_offer_allocations(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2169,7 +2162,7 @@ dxgkio_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2212,7 +2205,7 @@ dxgkio_reclaim_allocations(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2227,7 +2220,7 @@ dxgkio_submit_command(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2280,7 +2273,7 @@ dxgkio_submit_command(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2296,7 +2289,7 @@ dxgkio_submit_command_to_hwqueue(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2336,7 +2329,7 @@ dxgkio_submit_command_to_hwqueue(struct dxgprocess *process,
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2352,7 +2345,7 @@ dxgkio_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2376,7 +2369,7 @@ dxgkio_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 			     sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy hwqueue handle");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2410,7 +2403,7 @@ dxgkio_submit_signal_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2428,7 +2421,7 @@ dxgkio_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2447,7 +2440,7 @@ dxgkio_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(objects, args.objects, object_size);
 	if (ret) {
 		DXG_ERR("failed to copy objects");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2460,7 +2453,7 @@ dxgkio_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(fences, args.fence_values, object_size);
 	if (ret) {
 		DXG_ERR("failed to copy fence values");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2494,7 +2487,7 @@ dxgkio_submit_wait_to_hwqueue(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2510,7 +2503,7 @@ dxgkio_map_gpu_va(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2542,7 +2535,7 @@ dxgkio_map_gpu_va(struct dxgprocess *process, void *__user inargs)
 			    &args.paging_fence_value, sizeof(u64));
 	if (ret2) {
 		DXG_ERR("failed to copy paging fence to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2550,7 +2543,7 @@ dxgkio_map_gpu_va(struct dxgprocess *process, void *__user inargs)
 				sizeof(args.virtual_address));
 	if (ret2) {
 		DXG_ERR("failed to copy va to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2561,7 +2554,7 @@ dxgkio_map_gpu_va(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2577,7 +2570,7 @@ dxgkio_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2614,7 +2607,7 @@ dxgkio_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
 			   sizeof(args.virtual_address));
 	if (ret) {
 		DXG_ERR("failed to copy VA to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -2624,7 +2617,7 @@ dxgkio_reserve_gpu_va(struct dxgprocess *process, void *__user inargs)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2638,7 +2631,7 @@ dxgkio_free_gpu_va(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2680,7 +2673,7 @@ dxgkio_update_gpu_va(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2705,7 +2698,7 @@ dxgkio_update_gpu_va(struct dxgprocess *process, void *__user inargs)
 			   sizeof(args.fence_value));
 	if (ret) {
 		DXG_ERR("failed to copy fence value to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -2734,7 +2727,7 @@ dxgkio_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2808,7 +2801,7 @@ dxgkio_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy output args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2842,7 +2835,7 @@ dxgkio_create_sync_object(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2856,7 +2849,7 @@ dxgkio_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2885,7 +2878,7 @@ dxgkio_destroy_sync_object(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -2906,7 +2899,7 @@ dxgkio_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -2995,7 +2988,7 @@ dxgkio_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 	if (ret == 0)
 		goto success;
 	DXG_ERR("failed to copy output args");
-	ret = -EINVAL;
+	ret = -EFAULT;
 
 cleanup:
 
@@ -3020,7 +3013,7 @@ dxgkio_open_sync_object_nt(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3041,7 +3034,7 @@ dxgkio_signal_sync_object(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3129,7 +3122,7 @@ dxgkio_signal_sync_object(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3144,7 +3137,7 @@ dxgkio_signal_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	if (args.object_count == 0 ||
@@ -3181,7 +3174,7 @@ dxgkio_signal_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3199,7 +3192,7 @@ dxgkio_signal_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3240,7 +3233,7 @@ dxgkio_signal_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3262,7 +3255,7 @@ dxgkio_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3287,7 +3280,7 @@ dxgkio_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
 			     sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy context handle");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3365,7 +3358,7 @@ dxgkio_signal_sync_object_gpu2(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3380,7 +3373,7 @@ dxgkio_wait_sync_object(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3418,7 +3411,7 @@ dxgkio_wait_sync_object(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3439,7 +3432,7 @@ dxgkio_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3540,7 +3533,7 @@ dxgkio_wait_sync_object_cpu(struct dxgprocess *process, void *__user inargs)
 			kfree(async_host_event);
 	}
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3563,7 +3556,7 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3583,7 +3576,7 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(objects, args.objects, object_size);
 	if (ret) {
 		DXG_ERR("failed to copy objects");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3637,7 +3630,7 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 				     object_size);
 		if (ret) {
 			DXG_ERR("failed to copy fences");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	} else {
@@ -3673,7 +3666,7 @@ dxgkio_wait_sync_object_gpu(struct dxgprocess *process, void *__user inargs)
 	if (fences && fences != &args.fence_value)
 		vfree(fences);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3690,7 +3683,7 @@ dxgkio_lock2(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3712,7 +3705,7 @@ dxgkio_lock2(struct dxgprocess *process, void *__user inargs)
 					alloc->cpu_address_refcount++;
 			} else {
 				DXG_ERR("Failed to copy cpu address");
-				ret = -EINVAL;
+				ret = -EFAULT;
 			}
 		}
 	}
@@ -3749,7 +3742,7 @@ dxgkio_lock2(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 
 success:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3766,7 +3759,7 @@ dxgkio_unlock2(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3829,7 +3822,7 @@ dxgkio_unlock2(struct dxgprocess *process, void *__user inargs)
 		kref_put(&device->device_kref, dxgdevice_release);
 
 success:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3844,7 +3837,7 @@ dxgkio_update_alloc_property(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3872,7 +3865,7 @@ dxgkio_update_alloc_property(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3887,7 +3880,7 @@ dxgkio_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	device = dxgprocess_device_by_handle(process, args.device);
@@ -3908,7 +3901,7 @@ dxgkio_mark_device_as_error(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3923,7 +3916,7 @@ dxgkio_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -3949,7 +3942,7 @@ dxgkio_query_alloc_residency(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3964,7 +3957,7 @@ dxgkio_set_allocation_priority(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	device = dxgprocess_device_by_handle(process, args.device);
@@ -3984,7 +3977,7 @@ dxgkio_set_allocation_priority(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -3999,7 +3992,7 @@ dxgkio_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 	device = dxgprocess_device_by_handle(process, args.device);
@@ -4019,7 +4012,7 @@ dxgkio_get_allocation_priority(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4069,14 +4062,14 @@ dxgkio_set_context_scheduling_priority(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
 	ret = set_context_scheduling_priority(process, args.context,
 					      args.priority, false);
 cleanup:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4111,7 +4104,7 @@ get_context_scheduling_priority(struct dxgprocess *process,
 	ret = copy_to_user(priority, &pri, sizeof(pri));
 	if (ret) {
 		DXG_ERR("failed to copy priority to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -4134,14 +4127,14 @@ dxgkio_get_context_scheduling_priority(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
 	ret = get_context_scheduling_priority(process, args.context,
 					      &input->priority, false);
 cleanup:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4155,14 +4148,14 @@ dxgkio_set_context_process_scheduling_priority(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
 	ret = set_context_scheduling_priority(process, args.context,
 					      args.priority, true);
 cleanup:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4176,7 +4169,7 @@ dxgkio_get_context_process_scheduling_priority(struct dxgprocess *process,
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4184,7 +4177,7 @@ dxgkio_get_context_process_scheduling_priority(struct dxgprocess *process,
 		&((struct d3dkmt_getcontextinprocessschedulingpriority *)
 		inargs)->priority, true);
 cleanup:
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4199,7 +4192,7 @@ dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4232,7 +4225,7 @@ dxgkio_change_vidmem_reservation(struct dxgprocess *process, void *__user inargs
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4247,7 +4240,7 @@ dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4272,7 +4265,7 @@ dxgkio_query_clock_calibration(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy output args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -4295,7 +4288,7 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4319,7 +4312,7 @@ dxgkio_flush_heap_transitions(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy output args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -4341,7 +4334,7 @@ dxgkio_escape(struct dxgprocess *process, void *__user inargs)
 
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4367,7 +4360,7 @@ dxgkio_escape(struct dxgprocess *process, void *__user inargs)
 		dxgadapter_release_lock_shared(adapter);
 	if (adapter)
 		kref_put(&adapter->adapter_kref, dxgadapter_release);
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4382,7 +4375,7 @@ dxgkio_query_vidmem_info(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4432,7 +4425,7 @@ dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4458,7 +4451,7 @@ dxgkio_get_device_state(struct dxgprocess *process, void *__user inargs)
 			ret = copy_to_user(inargs, &args, sizeof(args));
 			if (ret) {
 				DXG_ERR("failed to copy args to user");
-				ret = -EINVAL;
+				ret = -EFAULT;
 			}
 			goto cleanup;
 		}
@@ -4590,7 +4583,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4610,7 +4603,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(handles, args.objects, handle_size);
 	if (ret) {
 		DXG_ERR("failed to copy object handles");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4708,7 +4701,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(args.shared_handle, &tmp, sizeof(u64));
 	if (ret) {
 		DXG_ERR("failed to copy shared handle");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -4726,7 +4719,7 @@ dxgkio_share_objects(struct dxgprocess *process, void *__user inargs)
 	if (resource)
 		kref_put(&resource->resource_kref, dxgresource_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4742,7 +4735,7 @@ dxgkio_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -4795,7 +4788,7 @@ dxgkio_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy output args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -4807,7 +4800,7 @@ dxgkio_query_resource_info_nt(struct dxgprocess *process, void *__user inargs)
 	if (device)
 		kref_put(&device->device_kref, dxgdevice_release);
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -4859,7 +4852,7 @@ assign_resource_handles(struct dxgprocess *process,
 				   sizeof(open_alloc_info));
 		if (ret) {
 			DXG_ERR("failed to copy alloc info");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -5009,7 +5002,7 @@ open_resource(struct dxgprocess *process,
 				shared_resource->runtime_private_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy runtime data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -5020,7 +5013,7 @@ open_resource(struct dxgprocess *process,
 				shared_resource->resource_private_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy resource data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -5031,7 +5024,7 @@ open_resource(struct dxgprocess *process,
 				shared_resource->alloc_private_data_size);
 		if (ret) {
 			DXG_ERR("failed to copy alloc data");
-			ret = -EINVAL;
+			ret = -EFAULT;
 			goto cleanup;
 		}
 	}
@@ -5046,7 +5039,7 @@ open_resource(struct dxgprocess *process,
 			   sizeof(struct d3dkmthandle));
 	if (ret) {
 		DXG_ERR("failed to copy resource handle to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -5054,7 +5047,7 @@ open_resource(struct dxgprocess *process,
 			   &args->total_priv_drv_data_size, sizeof(u32));
 	if (ret) {
 		DXG_ERR("failed to copy total driver data size");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
@@ -5102,7 +5095,7 @@ dxgkio_open_resource_nt(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -5112,7 +5105,7 @@ dxgkio_open_resource_nt(struct dxgprocess *process, void *__user inargs)
 
 cleanup:
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 
@@ -5125,7 +5118,7 @@ dxgkio_share_object_with_host(struct dxgprocess *process, void *__user inargs)
 	ret = copy_from_user(&args, inargs, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy input args");
-		ret = -EINVAL;
+		ret = -EFAULT;
 		goto cleanup;
 	}
 
@@ -5138,12 +5131,12 @@ dxgkio_share_object_with_host(struct dxgprocess *process, void *__user inargs)
 	ret = copy_to_user(inargs, &args, sizeof(args));
 	if (ret) {
 		DXG_ERR("failed to copy data to user");
-		ret = -EINVAL;
+		ret = -EFAULT;
 	}
 
 cleanup:
 
-	DXG_TRACE("ioctl:%s %d", errorstr(ret), ret);
+	DXG_TRACE_IOCTL_END(ret);
 	return ret;
 }
 

