Return-Path: <linux-hyperv+bounces-9929-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKdQDx61zmlVpgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9929-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:27:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD63F38D14E
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 20:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D52F030293C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA4A3D75DA;
	Thu,  2 Apr 2026 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ihQCsPjT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA814373BEB;
	Thu,  2 Apr 2026 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775154430; cv=none; b=d4uurLMw8qNEbIlV+jMsZ+X++BUXUq8qcxzaeG9CVvorudcqKHqxzm8AOxiLdvx/XDFuo/Qa1HPxyL7aRm8EekphCa6TnNV3950S+zPS2UTP30mlsVVlrIILWK8dUbreM8nxNcXm0HExA2W0Tq3RQEwsaAEAMsN6cPHg1p2IvC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775154430; c=relaxed/simple;
	bh=fSsf6YcB7e6GhxRhhUZLjb1tw7iGg3byv5rSHDsUr8c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZt2VS4q8TUTM03noDNhwafmw4w0DfMUyNY8zfAU4O8oPVyrevz9N0QIQKC6oKX0WIJsbdb9HOfM2hKz9TpfFunNR6HkARB6mH0T8taXtlBp2DjcYvtDH+jG73Tf9Eqx+Ud6kdKhStBkJl9Q4CVCrkAIrxWIriGBHOMoymOYfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ihQCsPjT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B828920B7136; Thu,  2 Apr 2026 11:27:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B828920B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775154428;
	bh=0AvdIAIcrnuYLaP5WWfHLp/4nBpChaHQuE+QzTbHK+E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ihQCsPjT0SRJSv0kUVo1BImmOQKKitXPk30s32k5j/6lH0+M5uh+4iVaEUKxN8LMb
	 wITt1knjMFHTSHhq/DiR+XVq9KLXJ+iDUv+LkzY9rhLSC59BT7Uyef3Nxury8xjY7k
	 KagWrrKHuRpSHiO9DHXTrISHtBmmJSR9wqH8g1r4=
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
Subject: [PATCH net-next v5 1/3] net: mana: Use pci_name() for debugfs directory naming
Date: Thu,  2 Apr 2026 11:26:55 -0700
Message-ID: <20260402182704.2474739-2-ernis@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9929-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD63F38D14E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use pci_name(pdev) for the per-device debugfs directory instead of
hardcoded "0" for PFs and pci_slot_name(pdev->slot) for VFs. The
previous approach had two issues:

1. pci_slot_name() dereferences pdev->slot, which can be NULL for VFs
   in environments like generic VFIO passthrough or nested KVM,
   causing a NULL pointer dereference.

2. Multiple PFs would all use "0", and VFs across different PCI
   domains or buses could share the same slot name, leading to
   -EEXIST errors from debugfs_create_dir().

pci_name(pdev) returns the unique BDF address, is always valid, and
is unique across the system.

Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v5:
* New to patchset.
Changes in v4, v3, v2:
* Not created
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 43741cd35af8..098fbda0d128 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2065,11 +2065,8 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->dev = &pdev->dev;
 	xa_init(&gc->irq_contexts);
 
-	if (gc->is_pf)
-		gc->mana_pci_debugfs = debugfs_create_dir("0", mana_debugfs_root);
-	else
-		gc->mana_pci_debugfs = debugfs_create_dir(pci_slot_name(pdev->slot),
-							  mana_debugfs_root);
+	gc->mana_pci_debugfs = debugfs_create_dir(pci_name(pdev),
+						  mana_debugfs_root);
 
 	err = mana_gd_setup(pdev);
 	if (err)
-- 
2.34.1


