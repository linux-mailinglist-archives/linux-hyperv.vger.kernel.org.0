Return-Path: <linux-hyperv+bounces-2728-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C694891D
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 07:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7B11F236B9
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 05:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FFC1BBBFE;
	Tue,  6 Aug 2024 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ckw7La4J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16121BB6AF;
	Tue,  6 Aug 2024 05:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722923848; cv=none; b=aUS1K6QJyWI//yqn8BFHEcJUty4hZK/cB2WX/afB8iwYbbbXeOgMimmyfyjEOO+CaMpdV7hCCo2/2HWo7y8X81edHbanwqqnLQvFyHb84dWjwiVv9MsCDqpgP7ZxkwGiFGZ8w/KNksix/4l3K64hrKosiTiWd4wvYfCqZuVFO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722923848; c=relaxed/simple;
	bh=0wZtuVZPMcZA7UKz7pKLrTrF+35AezUPd4OIl2OBUMg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a/7L+x9I1F+0MK6nL0MPgcE4+ICxdBaxifcEvfORVS9CL0elruRQxBFcrOnbrAAXbnsMGLoTBSJNKxLn4FrNBfpINjhBfXUNEY5P8GMRNvKAGjYcwJJyJ7pnKVzyNv0NztUghwHkO84e6dTOsGcRTTnBTMXvd21razgNteSIaSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ckw7La4J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D21BD20B7165; Mon,  5 Aug 2024 22:57:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D21BD20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722923839;
	bh=eMfVj45J1JOd8v9wZjGiHLnozHQjKcpMREluYB8DYXI=;
	h=From:To:Cc:Subject:Date:From;
	b=Ckw7La4Ja90xRgXDwRgipLvDZ4hdrQ/Tb+5pxe28hGWWw3RJy1u+XozMmBHsvI8ia
	 ZvHIuF9pX9Zm/L31wDROCeWOlkWcsFn2pDMTNCog4qqpfGCoEtjPDAfEjeIqBcQW6z
	 THXLTmjJTM3kvj9uo/0Vb2YRJLgQ5HvcINlZrsYI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ernis@microsoft.com,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH] net: netvsc: Increase default VMBus channel from 8 to 16
Date: Mon,  5 Aug 2024 22:55:51 -0700
Message-Id: <1722923751-27296-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Increase default VMBus channels in Linux netvsc from 8 to 16
to align with Azure Windows VM and improve networking throughput.

Set channels to 16 for VMs with more than 16 vCPUs;
otherwise, channels depend on VM's vCPU count.

Performance tests showed significant improvement in throughput:
- 0.54% for 16 vCPUs
- 1.51% for 32 vCPUs
- 0.72% for 48 vCPUs
- 5.57% for 64 vCPUs
- 9.14% for 96 vCPUs

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index 810977952f95..e690b95b1bbb 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -882,7 +882,7 @@ struct nvsp_message {
 
 #define VRSS_SEND_TAB_SIZE 16  /* must be power of 2 */
 #define VRSS_CHANNEL_MAX 64
-#define VRSS_CHANNEL_DEFAULT 8
+#define VRSS_CHANNEL_DEFAULT 16
 
 #define RNDIS_MAX_PKT_DEFAULT 8
 #define RNDIS_PKT_ALIGN_DEFAULT 8
-- 
2.25.1


