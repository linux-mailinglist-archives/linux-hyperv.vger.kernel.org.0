Return-Path: <linux-hyperv+bounces-3567-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A87B9FFA9A
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49AD8162AA8
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Jan 2025 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B579A1B0430;
	Thu,  2 Jan 2025 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kQy+qsm3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A91917D0;
	Thu,  2 Jan 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735829569; cv=none; b=jcIf8NealcUcXoJk0hRDJnp9BjH/iOGHcx9cIV3MXKaRAuGgRC0enfPg6UWeTS3DJWgvsnatF3Nbomsx0mxJUMt+n/z61zHMTaJY4uW6uEZWNDknAwGJCBDCRDS02BMjZBLsoCeDInUR/LXNlVB2Z0TrHVSYOWxv/in4lfp1o2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735829569; c=relaxed/simple;
	bh=hmSvYT4hNSwZCGDLOZZiz2C0ylP1YEA7B8i46Ol5DT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k6lFOwJ8Q8m5j3aiCjdb4wof2XIytnUmuu0omAX70r2gfroUKMZ23l48ElmIjxvh46LYm3rw7FTPGNI+MLaLQdXMvOGxrsrABcgdrEd1KOy42YvgFw0HMYpB3rcINz8sTV40RSwUE/Vel1JfiluZmSHurmAUcQqxvAvflJYFRbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kQy+qsm3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id D49422066C28;
	Thu,  2 Jan 2025 06:52:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D49422066C28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735829567;
	bh=mxoNnxjfOrAQrS0SDTM25QTJeAJbxT1VvWPNULCuRCM=;
	h=From:To:Cc:Subject:Date:From;
	b=kQy+qsm3eNa6kuuoE8nedatbAaERwFnVKNCgdT27E3VAdNdTXy8s0EfyVm/Oe9I+7
	 YgM8Ba4+5gsauF61Z6TTPHS0n6y59hmNlpB2muknQZUmtNRvzX1G0ZlHLIzUPmy8lU
	 cch1HrxDqjBiza7CbWw/FQrb/rOeqp2zxEGIe3gs=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2] uio_hv_generic: Add a check for HV_NIC for send, receive buffers setup
Date: Thu,  2 Jan 2025 14:52:43 +0000
Message-ID: <20250102145243.2088-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Receive and send buffer allocation was originally introduced to support
DPDK's networking use case. These buffer sizes were further increased to
meet DPDK performance requirements. However, these large buffers are
unnecessary for any other UIO use cases.
Restrict the allocation of receive and send buffers only for HV_NIC device
type, saving 47 MB of memory per device.

While at it, fix some of the syntax related issues in the touched code
which are reported by "--strict" option of checkpatch.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
Changes since v1:
https://lore.kernel.org/all/20241125125015.1500-1-namjain@linux.microsoft.com/
Rephrased commit msg as per Saurabh's suggestion.
---
 drivers/uio/uio_hv_generic.c | 86 ++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 43 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3976360d0096..1b19b5647495 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -296,51 +296,51 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->info.mem[MON_PAGE_MAP].size = PAGE_SIZE;
 	pdata->info.mem[MON_PAGE_MAP].memtype = UIO_MEM_LOGICAL;
 
-	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
-	if (pdata->recv_buf == NULL) {
-		ret = -ENOMEM;
-		goto fail_free_ring;
+	if (channel->device_id == HV_NIC) {
+		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
+		if (!pdata->recv_buf) {
+			ret = -ENOMEM;
+			goto fail_free_ring;
+		}
+
+		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
+					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
+		if (ret) {
+			if (!pdata->recv_gpadl.decrypted)
+				vfree(pdata->recv_buf);
+			goto fail_close;
+		}
+
+		/* put Global Physical Address Label in name */
+		snprintf(pdata->recv_name, sizeof(pdata->recv_name),
+			 "recv:%u", pdata->recv_gpadl.gpadl_handle);
+		pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
+		pdata->info.mem[RECV_BUF_MAP].addr = (uintptr_t)pdata->recv_buf;
+		pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
+		pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
+
+		pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
+		if (!pdata->send_buf) {
+			ret = -ENOMEM;
+			goto fail_close;
+		}
+
+		ret = vmbus_establish_gpadl(channel, pdata->send_buf,
+					    SEND_BUFFER_SIZE, &pdata->send_gpadl);
+		if (ret) {
+			if (!pdata->send_gpadl.decrypted)
+				vfree(pdata->send_buf);
+			goto fail_close;
+		}
+
+		snprintf(pdata->send_name, sizeof(pdata->send_name),
+			 "send:%u", pdata->send_gpadl.gpadl_handle);
+		pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
+		pdata->info.mem[SEND_BUF_MAP].addr = (uintptr_t)pdata->send_buf;
+		pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
+		pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
 	}
 
-	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
-				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
-	if (ret) {
-		if (!pdata->recv_gpadl.decrypted)
-			vfree(pdata->recv_buf);
-		goto fail_close;
-	}
-
-	/* put Global Physical Address Label in name */
-	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
-		 "recv:%u", pdata->recv_gpadl.gpadl_handle);
-	pdata->info.mem[RECV_BUF_MAP].name = pdata->recv_name;
-	pdata->info.mem[RECV_BUF_MAP].addr
-		= (uintptr_t)pdata->recv_buf;
-	pdata->info.mem[RECV_BUF_MAP].size = RECV_BUFFER_SIZE;
-	pdata->info.mem[RECV_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
-
-	pdata->send_buf = vzalloc(SEND_BUFFER_SIZE);
-	if (pdata->send_buf == NULL) {
-		ret = -ENOMEM;
-		goto fail_close;
-	}
-
-	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
-				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
-	if (ret) {
-		if (!pdata->send_gpadl.decrypted)
-			vfree(pdata->send_buf);
-		goto fail_close;
-	}
-
-	snprintf(pdata->send_name, sizeof(pdata->send_name),
-		 "send:%u", pdata->send_gpadl.gpadl_handle);
-	pdata->info.mem[SEND_BUF_MAP].name = pdata->send_name;
-	pdata->info.mem[SEND_BUF_MAP].addr
-		= (uintptr_t)pdata->send_buf;
-	pdata->info.mem[SEND_BUF_MAP].size = SEND_BUFFER_SIZE;
-	pdata->info.mem[SEND_BUF_MAP].memtype = UIO_MEM_VIRTUAL;
-
 	pdata->info.priv = pdata;
 	pdata->device = dev;
 

base-commit: 3d6fbc065983fabd3fcfef4d66c9cf8a587f9ddc
-- 
2.43.0


