Return-Path: <linux-hyperv+bounces-6815-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA7FB52326
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 22:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A361891A29
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Sep 2025 20:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469882FF64A;
	Wed, 10 Sep 2025 20:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c+hm8Jcw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA9272E7B;
	Wed, 10 Sep 2025 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757537861; cv=none; b=QmvjFKoh3OVh/aHwhnQgJ5YYprnCdDW3ucP0i84TAG/i8Jh/MeCnE3RnQsLuQnE+oFYu5k+xXOEbuMgRObNkULLC7SGElEylhk+Oo3GbOCLqqX29GoaypX5sTUgrM2/MSFVS0S3tqwXag+K6uAO/B5HphSlzvNjI2EXnxGVQEko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757537861; c=relaxed/simple;
	bh=mgH+RApEREFbxuYp5FmMugM97WajwuPrp/KpthV4H70=;
	h=From:To:Cc:Subject:Date:Message-Id; b=RYtmEroO9idJeuhGhgPy/TPXs6BZ2swF1CT0KWFuel3asGM+u167AqGGaMjeisURr0JDwx8iHkiQIIZ8Laq1HfAYdhhhRn5YgmLnBlKbbdSWfVkuG3inr/opMCXRtXeYq+pzlNV/qlo4H6b1c2o0qLf6ntzujJb4YaZVOSTodVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=c+hm8Jcw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id B7D0D20171B8; Wed, 10 Sep 2025 13:57:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B7D0D20171B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1757537852;
	bh=N/iRK+5SlnN9/G2FPEN7vTk8IiFryrGhXVADYNhLhW4=;
	h=From:To:Cc:Subject:Date:From;
	b=c+hm8Jcw2pW+QahnVxFM3ACweqy/H9hMx2v/oqU2GYqqLI6j3Phzi+e9AHODwBr1k
	 ye7E/ErWx+MOyur4IFUUXRuEN9Rp1U1hMOUUZDOKS5wIHMcqrSsHKnw4zyk3ynNTUk
	 8+NuVoyjh4SIsq6DxVIq5wwQyPzXPOEFLvNJ+3rg=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Cc: haiyangz@microsoft.com,
	decui@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	kotaranov@microsoft.com,
	shirazsaleem@microsoft.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mana: Reduce waiting time if HWC not responding
Date: Wed, 10 Sep 2025 13:57:21 -0700
Message-Id: <1757537841-5063-1-git-send-email-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

If HW Channel (HWC) is not responding, reduce the waiting time, so further
steps will fail quickly.
This will prevent getting stuck for a long time (30 minutes or more), for
example, during unloading while HWC is not responding.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index ef072e24c46d..ada6c78a2bef 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -881,7 +881,12 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	if (!wait_for_completion_timeout(&ctx->comp_event,
 					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		if (hwc->hwc_timeout != 0)
-			dev_err(hwc->dev, "HWC: Request timed out!\n");
+			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
+				hwc->hwc_timeout);
+
+		/* Reduce further waiting if HWC no response */
+		if (hwc->hwc_timeout > 1)
+			hwc->hwc_timeout = 1;
 
 		err = -ETIMEDOUT;
 		goto out;
-- 
2.34.1


