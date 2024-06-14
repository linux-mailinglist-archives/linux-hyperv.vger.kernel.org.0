Return-Path: <linux-hyperv+bounces-2413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B95D490844E
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 09:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4181F2495E
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69728148848;
	Fri, 14 Jun 2024 07:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j9MmVXl3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F8A20317;
	Fri, 14 Jun 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349551; cv=none; b=K0DI1n+yYiDeqwy4SGft2wQDPaXYVT6OOxu7HND5319SS6UttDZc6TXOaEpX+5ngfZYFzGC6LGWEEfp01aMTO5ywqhEOQizcEMLY6YyAAj2SwazbnQD2yifygd1Ha1AmecCGbcU7Xlh0CEQB+rYOgX6CGKeBJubXu99ZdmdvMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349551; c=relaxed/simple;
	bh=EgomXBteig4lz1gdQuwgDEdrsNpZ0S8xQyF6J4Omw00=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NgJtVLO1uL6uFeAeeIoLBcRcbYU4ltTD9R+8V6JkJ/7P4L3nqTUmEzfNEHEoi9F0i4jH0ufPzeCpVfLVMv5aaAl6yD+obBqkmnYZjVc3GylQc159W/jHWs4qmg9d5WkJwLfVkhYjDlRw7ofawi35xtOYrs66fO6c7s99tkhAlTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j9MmVXl3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 89B5820B7001; Fri, 14 Jun 2024 00:19:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89B5820B7001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1718349549;
	bh=8vK8fmbd5M6jG/NONoxloyUoUGqGh+n0nc/HIFecwzY=;
	h=From:To:Cc:Subject:Date:From;
	b=j9MmVXl3l4HDKbN+mnpMpdWeQiVemskLuOUmGgZGcXJ6Yvj6i88MW5FVm0cCjvvJ1
	 5SHZUfx14om0GJYirtcf1ty40RGqB0Ge/5k1gpiXHZGrgFnjD4Xmh92Y9tQ7m9gDou
	 ZD0icGxNzmakH8xVd5JDfeh2Z+hT+z6JC4GQ8jHo=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next] net: mana: Use mana_cleanup_port_context() for rxq cleanup
Date: Fri, 14 Jun 2024 00:19:08 -0700
Message-Id: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>


To cleanup rxqs in port context structures, instead of duplicating the
code, use existing function mana_cleanup_port_context() which does
the exact cleanup that's needed.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index b89ad4afd66e..93e526e5dd16 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2529,8 +2529,7 @@ static int mana_init_port(struct net_device *ndev)
 	return 0;
 
 reset_apc:
-	kfree(apc->rxqs);
-	apc->rxqs = NULL;
+	mana_cleanup_port_context(apc);
 	return err;
 }
 
@@ -2787,8 +2786,7 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 free_indir:
 	mana_cleanup_indir_table(apc);
 reset_apc:
-	kfree(apc->rxqs);
-	apc->rxqs = NULL;
+	mana_cleanup_port_context(apc);
 free_net:
 	*ndev_storage = NULL;
 	netdev_err(ndev, "Failed to probe vPort %d: %d\n", port_idx, err);
-- 
2.34.1


