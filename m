Return-Path: <linux-hyperv+bounces-6157-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FBCAFEA8B
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812CF1C83C08
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C052D8796;
	Wed,  9 Jul 2025 13:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mx2uOdn7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E3A2DCF5B;
	Wed,  9 Jul 2025 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068583; cv=none; b=ToMw47bVKDns7Aq+HnVCd6NyszTc7TdLnHjbArHWDkVgIzYLPIZ10QSdNpHWZu0+pBiTh/eWZ2c6YWwjifqD8LDsoPY+5P44OHVs54xiI0UUYBk6ilzs0rGgyEXmxSspxZAKfPIALnPjU+YQpBYPQKGcdvuo6RSBqp0o/d4WxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068583; c=relaxed/simple;
	bh=xww6hMBOjTVwiOv2DC1vpenT+J8Pu/zpCSWlyZFCzGU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=sE2TqtSrwnz2E8Ygd5qZkIKMHGOhO5E0DWsirPo+im7yjbo5SiScr7Xlz9tXMlBdsnpdeI2cEATIzEsTTXNU0SzKycXD7/eItVo1TnWhSPOi3c02nGHGJoH+PnDOoZXHlTWViY3bJksRTvVy5wZSXTtuVx2eZnjMPKj2MmzDN40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mx2uOdn7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id A69D4201656B; Wed,  9 Jul 2025 06:43:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A69D4201656B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1752068581;
	bh=zpmJrbND/1sgJVHdc73Wad6MQdTQuZiNnFvSeRoR2HE=;
	h=From:To:Cc:Subject:Date:From;
	b=mx2uOdn70UGsehG1znRqpXJo/VQuJtlRR5NmI+OVuS2bhQPpUVL4p5GPdytBaQiyv
	 Lf0mpsKO0dxEYOKUVvhI7xrf4xxZR5lFzbr/tthoo2UKQu2FrfUUwsLjeCpXBZJHG8
	 enXk/bQem1bHNrjuO5kLIyfVuAp8UmAyxrGNC+nI=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Long Li <longli@microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH] net: mana: fix spelling for mana_gd_deregiser_irq()
Date: Wed,  9 Jul 2025 06:43:00 -0700
Message-Id: <1752068580-27215-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Fix the typo in function name mana_gd_deregiser_irq()

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index a468cd8e5f36..d6c0699bc8cf 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -657,7 +657,7 @@ static int mana_gd_register_irq(struct gdma_queue *queue,
 	return 0;
 }
 
-static void mana_gd_deregiser_irq(struct gdma_queue *queue)
+static void mana_gd_deregister_irq(struct gdma_queue *queue)
 {
 	struct gdma_dev *gd = queue->gdma_dev;
 	struct gdma_irq_context *gic;
@@ -750,7 +750,7 @@ static void mana_gd_destroy_eq(struct gdma_context *gc, bool flush_evenets,
 			dev_warn(gc->dev, "Failed to flush EQ: %d\n", err);
 	}
 
-	mana_gd_deregiser_irq(queue);
+	mana_gd_deregister_irq(queue);
 
 	if (queue->eq.disable_needed)
 		mana_gd_disable_queue(queue);

base-commit: ea988b450690448d5b12ce743a598ade7a8c34b1
-- 
2.34.1


