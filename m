Return-Path: <linux-hyperv+bounces-7333-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68068C0CDEC
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 11:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C587D19A5E7B
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Oct 2025 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425F1DE4E1;
	Mon, 27 Oct 2025 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jnNW8aaQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9813B280;
	Mon, 27 Oct 2025 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761559417; cv=none; b=KpZZAnu9wVVQvhqghoUnA5AT1jYHEehwuuhVanSJPCs/bk/73ILSx7V5O+e8oIpF3YgLoPjRSypM/fo/RAwBDN2oBoxyl0c+sZqIm2b6sHvO974xg+o8leUM2Tupp3tz3phyIEsWBgN5agxZHjtfNYXmys5OzrhZp8eMnCgPlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761559417; c=relaxed/simple;
	bh=JHwarkqBPq72JFpOasQzHaDBamKHSrbmH4YRuweybHs=;
	h=From:To:Subject:Date:Message-Id; b=FrMYIu82mMCtITTv/3gFpqT58TdkqSxdPI1hQ4jTWo97EbNMzATxzbFXj1eE2ONYHhVIXk9EKMipaR9I8wDOsddcbBYempO90OlCdw5uLIt+0rSsiUiGxTd00lXoh8y7sPSn0s/PPTAtIQU3DmOr0btSJrutJ8rhPPAnpDX/9Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jnNW8aaQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id AD1F2211D8D8; Mon, 27 Oct 2025 03:03:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AD1F2211D8D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761559410;
	bh=EuEAS/gEv10XHC56mPN6AvDAFFpqsTPL7sGSBrWVkXg=;
	h=From:To:Subject:Date:From;
	b=jnNW8aaQWFLG60KQSHonqS8ElLyVj/5WkHt+1CWbbsffYBag6VmwPSBmVZvcwkOeq
	 O84blQ+3W9eSYscSv8nvc3x5es91LV38pa/R0F7MvwD0O7tNO22ogfzQfRXRdZ2Y9D
	 Jbn9tAum4UvzGvIs17nMZibO2ha7Pjed43XouiDs=
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
Subject: [PATCH] net: mana: Fix incorrect speed reported by debugfs
Date: Mon, 27 Oct 2025 03:03:28 -0700
Message-Id: <1761559408-22534-1-git-send-email-ernis@linux.microsoft.com>
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


