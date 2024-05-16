Return-Path: <linux-hyperv+bounces-2148-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 493B58C7A0F
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 18:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5CF1C20F96
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 May 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7162214D70C;
	Thu, 16 May 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D+vybkna"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A914B953;
	Thu, 16 May 2024 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715875621; cv=none; b=QdswXMcAxTf6ygHHrxIUbtzdyAcLgzuH5BA1LN8H5344SZ4QIM5fXufC/aVzJgXWIZbyNXwYc/DttpxIizeVGg32KPxlBdtJzOm4AaVBtsRyT6G3FtpuTyg290UipA92bo5zxOniJzgaGen/Dpp7gaddHg86iZB1b3If3o/WHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715875621; c=relaxed/simple;
	bh=NDl1/On8Xl0p+o2LhYUeEkJ4uggR90m3F+FyFOP1acI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CqsJQxS0B0s4RmwAbyYko2vuanq6rg0ncArbvBWBhQs6ZMiNLSOwdKVqJH2qVo7LzZye6C1osyOjy1qQ4RdxcBCRLUfoh+asIEdyq60xBdqTlSqFFKwrslUrxkslzzluENfjbtU5qPIwKZejREeDsKMTuec9p1sjHOjh/g2xR+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D+vybkna; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id A63DD20B915A; Thu, 16 May 2024 09:06:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A63DD20B915A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715875619;
	bh=H1h4r/pbYCGt93I7ZZhMxZkjxnhh2Z7CdrZM+aGCgc4=;
	h=From:To:Cc:Subject:Date:From;
	b=D+vybknaQfz6UUVxhmK+s6MkF/uqCV2n77dyEOSCZnAiG3zoC7TaFRLhckgd2UIJo
	 SQFBIEVDS6/eD/0GUj2t/W/x9U/R4krC42cgVzaaBuC5fSkyeEK7wyoUYHxInNXplO
	 pSEz0qef+V1q4z9SjL/tzUwUb4QZZMCVy89+Iuxw=
From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	longli@microsoft.com,
	yury.norov@gmail.com,
	leon@kernel.org,
	cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com,
	vkuznets@redhat.com,
	tglx@linutronix.de,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: schakrabarti@microsoft.com,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: mana: Fix the extra HZ in mana_hwc_send_request
Date: Thu, 16 May 2024 09:05:38 -0700
Message-Id: <1715875538-21499-1-git-send-email-schakrabarti@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Commit 62c1bff593b7 added an extra HZ along with msecs_to_jiffies.
This patch fixes that.

Cc: stable@vger.kernel.org
Fixes: 62c1bff593b7 ("net: mana: Configure hwc timeout from hardware")
Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 2729a2c5acf9..ca814fe8a775 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -848,7 +848,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
 	}
 
 	if (!wait_for_completion_timeout(&ctx->comp_event,
-					 (msecs_to_jiffies(hwc->hwc_timeout) * HZ))) {
+					 (msecs_to_jiffies(hwc->hwc_timeout)))) {
 		dev_err(hwc->dev, "HWC: Request timed out!\n");
 		err = -ETIMEDOUT;
 		goto out;
-- 
2.34.1


