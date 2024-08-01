Return-Path: <linux-hyperv+bounces-2661-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC494540D
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 23:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9B21C22A68
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 21:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494C14883C;
	Thu,  1 Aug 2024 21:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CVSwPCG+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5586719478;
	Thu,  1 Aug 2024 21:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547356; cv=none; b=QhuOwfW4rQl5dyktazp0S7mTU8Ph0IQ+VyJ5ZNlTNvsjfH5UalqECz+91ZWkc6dDDRNw7owKZI3yy7WwyRYcW5qNL9BHwLExPXDB+f2quedvURBdSLGB2rSMm/bfO9HcDywLQR6a7VDcwFZFzTe4a+okKuO9DZJTf2LUaJxWAcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547356; c=relaxed/simple;
	bh=Fp8RbFPrYmsMxzhho+v2nx41q791mEWu9ZiAY9TT4m8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMQIrqoZ20oBzEnU5UXjy0AE8c/LGpfa2zd+qvTx04fOFDoVqh6sRmoKHskwRfeOr9npcJ4g38VEwM3AxPQKLXwe+ed8LYkytjiPZgf5gjN+ed9ct0Yo424rGfYeOpEEFe9TRo0WZoXo1JPYtIlUuu93c0/UgZICvs0l963y/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CVSwPCG+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.159.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id C46AB20B7165;
	Thu,  1 Aug 2024 14:22:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C46AB20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722547354;
	bh=GyphtkfSY2FEttHBLdf3oNH/TBYDZHQbpfGiwQZszUY=;
	h=From:To:Cc:Subject:Date:From;
	b=CVSwPCG+GqIeQ88nOaZAI9yksMwnOWj7LTPfJi47DplEv08eluZ10TtNtoDpf3qKq
	 qaPsRx3ZZJ2L8fqz9XtRNNR65J5I2IxyBXuboW5/RLfC/In8Dlh1tHl4VOgfWM0X5L
	 nq/3n2XtGI+xJoJ6Hk4QsdqYHvVkzZ4k8KwWXkQA=
From: Roman Kisel <romank@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	sashal@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH] Drivers: hv: vmbus: Fix the misplaced function description
Date: Thu,  1 Aug 2024 14:22:35 -0700
Message-Id: <20240801212235.352220-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When hv_synic_disable_regs was introduced, it received the description
of hv_synic_cleanup. Fix that.

Fixes: dba61cda3046 ("Drivers: hv: vmbus: Break out synic enable and disable operations")

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index e0d676c74f14..36d9ba097ff5 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -342,9 +342,6 @@ int hv_synic_init(unsigned int cpu)
 	return 0;
 }
 
-/*
- * hv_synic_cleanup - Cleanup routine for hv_synic_init().
- */
 void hv_synic_disable_regs(unsigned int cpu)
 {
 	struct hv_per_cpu_context *hv_cpu =
@@ -436,6 +433,9 @@ static bool hv_synic_event_pending(void)
 	return pending;
 }
 
+/*
+ * hv_synic_cleanup - Cleanup routine for hv_synic_init().
+ */
 int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;

base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
-- 
2.34.1


