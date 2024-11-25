Return-Path: <linux-hyperv+bounces-3349-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504FE9D85A0
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 13:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4FBB168EC2
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Nov 2024 12:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401718893C;
	Mon, 25 Nov 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Iqb+Vz6M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D10721106;
	Mon, 25 Nov 2024 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732539032; cv=none; b=H/rYS9QZWToYl6NEd8rBlJ0P6C1JFh1ZpexHGHX5qMMPWgxhAj/LRZK2wnddYjlFpPrtNcNIw3nkRpTfsaPIjbpnIi6JkX7TwypEWbotaz9Z52uOSw/XD0qfAIEdq3/JcjsqUO2DXlAetXmadKVjssEBMQB7T5PgZP3tSPWwbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732539032; c=relaxed/simple;
	bh=S5FTnpP+FqILvJpRb622TxXQgbgieT4Yr6ds/1L3ywI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DHpNJ+iU4uYdwKGdhT9OxwvLXZJSPIXjX8zWhJeeMu0eCAF33fYkE/RNZIpCB5Z/BTtGbm5rC1QJYcNh3BskG/sMS4hEq/l+Z44xlyIHg9K1ksopL2D6/C0eUTtr9R5hKSdezLdZ9qGEo3Xfsf/crwC4y3vM+yAYg/v+rw2Af20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Iqb+Vz6M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namj-hibernation.da14kui0fsbu3e3s21k5a4scgb.phxx.internal.cloudapp.net (unknown [4.242.218.60])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9394A205458F;
	Mon, 25 Nov 2024 04:50:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9394A205458F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1732539024;
	bh=AYXhvM8YIt9m9AlywKf5yDgpKjnVhtgDhqt+uzF/yl4=;
	h=From:To:Cc:Subject:Date:From;
	b=Iqb+Vz6M7f+PCmTElUxlJi+NbwLG493w7+amks8h1v7EtIFr0llv6CvPZNsn11OnK
	 t9ercDBJ3OC7JQTmwVa/5Lx3lCZ4RRJJYBKiJ7YFxBqAU8IAU4G6x3PbL/6G+ljrw3
	 F5+H3TwrNSQuqL6iVqciEscTpCuH1X5V+SeP4avk=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH] uio_hv_generic: Add a check for HV_NIC for send, receive buffers setup
Date: Mon, 25 Nov 2024 12:50:15 +0000
Message-Id: <20241125125015.1500-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support for send and receive buffers was added for networking usecases
in UIO devices. There is no known usecase of these buffers for devices
other than HV_NIC. Add a check for HV_NIC in probe function to avoid
memory allocation and GPADL setup which would save 47 MB memory per
device type.

While at it, fix some of the syntax related issues in the touched code
which are reported by "--strict" option of checkpatch.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
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
 

base-commit: 85a2dd7d7c8152cb125712a1ecae1d0a6ccac250
-- 
2.25.1


