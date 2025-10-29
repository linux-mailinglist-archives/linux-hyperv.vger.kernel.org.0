Return-Path: <linux-hyperv+bounces-7370-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8D9C19E3B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E094EDFDE
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120A7313E39;
	Wed, 29 Oct 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChMaEM25"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B93123D7D4;
	Wed, 29 Oct 2025 10:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761735161; cv=none; b=aNDmsii+rN9PmPofzUqQtukMSiwgKNiXJpsD351/B6az43XXozhMIeY+xPmSlBZxGO3QNHfPsI+UaBHDCKyz9+8ymMyQBhjAWfjV9i2HyfQIV2WgoHXOptuv/5xWo74STU6R33+/HoQ73BmaHI0QwTxuiF+u1XEzn6UJCLLozkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761735161; c=relaxed/simple;
	bh=IV3DppH+htGZzXML5gRdsjIjWXHR9k4skszsEzlmii0=;
	h=From:To:Subject:Date:Message-Id; b=GqFhfBWkXLnkQKeMNeUq3QvDqQl1f73mZs0gGhEQFegDX4A5KkUUNhBLAVZhDW23tNm+ZvW/+JZT+yFfVHLfrwu+E1dHSzFy/YruQ9J3RUR69Xas/yj1kLxQQ0gzThoVIIRkBjR1f6+4p3LzdKHLqk6sKd6Ejn9yUmrW9PApESs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ChMaEM25; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 47E67200FE76; Wed, 29 Oct 2025 03:52:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47E67200FE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761735159;
	bh=fcF0CHwRVjLbM926VagGV0r1O2kFFiYZ1FC5AhsGGfk=;
	h=From:To:Subject:Date:From;
	b=ChMaEM25F/L5zzQaRW/o5JkcGuFzcbYgKbtLRjFM7RRYdHsCBgpTQm08Zzjcp64sC
	 o3uFcQMY1w6aRmJDZfvrbfDVpQ3snUNgxXGYCd05FeW5EM3ylH7iMDMxkNoGKK05Bj
	 2ioGGPLqNSr8K4FqtEustG+ascktKJ02jLFPAjlk=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shradhagupta@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	kotaranov@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] net: mana: Fix incorrect speed reported by debugfs
Date: Wed, 29 Oct 2025 03:52:34 -0700
Message-Id: <1761735154-3593-1-git-send-email-ernis@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Once the netshaper is created for MANA, the current bandwidth
is reported in debugfs like this:

$ sudo ./tools/net/ynl/pyynl/cli.py \
  --spec Documentation/netlink/specs/net_shaper.yaml \
  --do set \
  --json '{"ifindex":'3',
           "handle":{ "scope": "netdev", "id":'1' },
           "bw-max": 200000000 }'
None

$ sudo cat /sys/kernel/debug/mana/1/vport0/current_speed
200

After the shaper  is deleted, it is expected to report
the maximum speed supported by the SKU. But currently it is
reporting 0, which is incorrect.

Fix this inconsistency, by resetting apc->speed to apc->max_speed
during deletion of the shaper object. This will improve
readability and debuggability.

Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops") 
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Add Fixes tag.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 0142fd98392c..9d56bfefd755 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -814,7 +814,7 @@ static int mana_shaper_del(struct net_shaper_binding *binding,
 		/* Reset mana port context parameters */
 		apc->handle.id = 0;
 		apc->handle.scope = NET_SHAPER_SCOPE_UNSPEC;
-		apc->speed = 0;
+		apc->speed = apc->max_speed;
 	}
 
 	return err;
-- 
2.43.0


