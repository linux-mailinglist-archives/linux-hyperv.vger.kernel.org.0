Return-Path: <linux-hyperv+bounces-9930-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GmdFjy1zmlVpgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9930-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:28:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F238D17D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DDF853037416
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F9A3E5EF2;
	Thu,  2 Apr 2026 18:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G5ljUs6X"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E537C900;
	Thu,  2 Apr 2026 18:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154431; cv=none; b=hi5s0GyGX4A8VXiEQpEkbBTIpDfs41xKN3Mdl0czDKIH/8WWdm9SpJmRoLhv/45qmMYBIs2VaE1oUKYLJ9dU5pKiP3xQdCC+d6ZaRhL18OftXXzWAom54rcdfvJCbSMUJmL2AkuYThNuSg4drJ/yZgS5f1zLllPpTY/NaJntAnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154431; c=relaxed/simple;
	bh=N4eNRpQCrw7NZoaNxW3YoRSNiVllJamZZ8wWuACCQLs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcEawqfyPqdxwh0KlSF4ClwopmwLkiwGgO6cXyXSObQdlqUMr5r2k3VU890FYK84MyJFj3mWIZF7FUP0AUAh5td2KRVG3O+Sg/pdRHtgbLL88/JvzGnplmolJ7Etg7gfm1jqfnxATiYe+WT/XCBY8hGzMFUlh63YfHE4DLIAOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G5ljUs6X; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id C4A8320B712B; Thu,  2 Apr 2026 11:27:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4A8320B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775154429;
	bh=RonUNZbWYP9sU9PMYjhdAeqR0g5714VVqoRILfMXZOA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=G5ljUs6X5udD30pkeT0ZQs8GeAAhs3JU4WIa5a1wHDeqOO1mBi4MDDXHonTaQVrkb
	 c1kw5s/JQqdHBDOwjj5tG+2D2MbPaMPB6ftpkiyfYOKenQHuc+GhOz2jycRYbd58mJ
	 YSW6dNa+im1mF5ics1wOXlghHcoacpjwGtEAnn+c=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kotaranov@microsoft.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	shirazsaleem@microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 2/3] net: mana: Move current_speed debugfs file to mana_init_port()
Date: Thu,  2 Apr 2026 11:26:56 -0700
Message-ID: <20260402182704.2474739-3-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260402182704.2474739-1-ernis@linux.microsoft.com>
References: <20260402182704.2474739-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9930-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AC8F238D17D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Move the current_speed debugfs file creation from mana_probe_port() to
mana_init_port(). The file was previously created only during initial
probe, but mana_cleanup_port_context() removes the entire vPort debugfs
directory during detach/attach cycles. Since mana_init_port() recreates
the directory on re-attach, moving current_speed here ensures it survives
these cycles.

Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v5:
* New to the patchset.
Changes in v4, v3, v2:
* Not created.
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 565375cc20d3..78522205c5d0 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3147,6 +3147,8 @@ static int mana_init_port(struct net_device *ndev)
 	eth_hw_addr_set(ndev, apc->mac_addr);
 	sprintf(vport, "vport%d", port_idx);
 	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
+	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,
+			   &apc->speed);
 	return 0;
 
 reset_apc:
@@ -3425,8 +3427,6 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	netif_carrier_on(ndev);
 
-	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
-
 	return 0;
 
 free_indir:
-- 
2.34.1


