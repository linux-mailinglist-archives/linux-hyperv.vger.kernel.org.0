Return-Path: <linux-hyperv+bounces-2193-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B558C98E6
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 08:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FAE2815B5
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 06:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B5A14285;
	Mon, 20 May 2024 06:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TQck0Xur"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493505235;
	Mon, 20 May 2024 06:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716185122; cv=none; b=H9ZHbsd7dYIj/MXN/74yDv6mZjRMXFGZ9RnQZFA+DdWYlYZEyiRq35GqIKAOR0wngmwbgDS5beHWiV0dzC9dXxFmxqS0hq/wRmW6tmIEa29zpVaTNRaOr+LLzxdaJm/Ew2EMjjtStD2UpP/xFO2XjentqsCheylXnCPqPty/s6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716185122; c=relaxed/simple;
	bh=/8FGYyFajtYsUI/UY6TXkg1f+FUarY0aZMfBN4KAy7Q=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MubRjgwNXS8/N55pSNrYe71uACwYZX24wy9p6OWoJYtLtt0nm5kon4P5BJX1VtyBgapBh5MHxLcHKupvRBTYYekBohCmkKeeeKJoAd2F0c85Mn2hTq4lWy5hb/GoVOKUUYaJodQhYXXRQpVyUS4c/6hP0KQOc3gbPLID39hik+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TQck0Xur; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1099)
	id 6346D20678EE; Sun, 19 May 2024 23:05:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6346D20678EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1716185115;
	bh=OJF633DxKsVlsVlcJfKvP+Cgzrk0Y8wVfiiDT0ja/a4=;
	h=From:To:Cc:Subject:Date:From;
	b=TQck0Xur0JBqXWvjYHaETzxFDyt5n4j2V8vwBaY6jmPxxtNJpT+zbTbMq3IavI10B
	 iAkQCdmhBGiCtP+IS1ge8qvG/aUjgJhvJAwejpGsw4s0PbhG49QH54c6kXaRvGyvMR
	 pqffXZkktzBtTHIWXr+DBrXRPJWRInPoiBZkODv8=
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
Subject: [PATCH V2 net] net: mana: Fix the extra HZ in mana_hwc_send_request
Date: Sun, 19 May 2024 23:05:04 -0700
Message-Id: <1716185104-31658-1-git-send-email-schakrabarti@linux.microsoft.com>
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
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
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


