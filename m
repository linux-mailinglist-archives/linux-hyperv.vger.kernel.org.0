Return-Path: <linux-hyperv+bounces-7412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B60AC376C5
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 20:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC56B3BAEC0
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 19:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F262EDD7C;
	Wed,  5 Nov 2025 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SSiqPsXP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB4299AB5;
	Wed,  5 Nov 2025 19:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762369471; cv=none; b=s0GoO1Y6MCE0iqVrTzM4sgc1fqF/Bfkrsl/yyb9gy0Q565HIK4ANnRunuKi+ZUBf3uYGZlWMftsRecYprVHeCwZSpqq2yYBXj1sVT45Jm6aUUP4JIBkI5V+HggDTS1gR9ckWDklrAMEXygquhWCtFEygUrvNqmDBdELZIh+j/RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762369471; c=relaxed/simple;
	bh=RZ9HGuKLUFkmQgMJugWxZNIxILZWaInhLoFzpg9EyaA=;
	h=From:To:Subject:Date:Message-Id; b=P1GtjUbHmVNu0eyVTu4Aa2x4pU91DLvqTceJIIbyY10PBc9E9zdZpp8cR7fat+M6OkCyyCKyY6UIGRVVpZEkY4tfx3jRAXZKzFUIYVYNyEU9SQOTl4at7bnY34y0NZiNT8OLXo4+7YFpT5hjw83tVk7HLwhgxkf5zsftZ7qKrp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SSiqPsXP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 179CD20120AA; Wed,  5 Nov 2025 11:04:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 179CD20120AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762369470;
	bh=gJLOitnzxxUpLudr21FKrp1Qu36nwEjF5k1Lhwin6lQ=;
	h=From:To:Subject:Date:From;
	b=SSiqPsXPSx8IpkFJfI1QcYbQ3o39SqjGLjweOUcgFKE4YsCDyvE7OskcNIbOpRddz
	 76W5SySqfGV34S1pZNcWMSD+umXhgc9aWSkKPlKrCC73O9F15+g4dfIU/3RlfkHThe
	 0yIOwirwFxE00at6fCRzVvhSKADNfvuFkyS5j0g4=
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
Subject: [PATCH net-next v3] net: mana: Fix incorrect speed reported by debugfs
Date: Wed,  5 Nov 2025 11:04:28 -0800
Message-Id: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
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

Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Remove Fixes tag.
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


