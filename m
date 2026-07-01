Return-Path: <linux-hyperv+bounces-11727-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yQ8kLhtWRWqt+goAu9opvQ
	(envelope-from <linux-hyperv+bounces-11727-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 20:02:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D16F07C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Jul 2026 20:02:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=GJ01IfUn;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11727-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11727-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20071300D176
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Jul 2026 18:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56891372064;
	Wed,  1 Jul 2026 18:02:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27BFE23EA83;
	Wed,  1 Jul 2026 18:02:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782928921; cv=none; b=Swxo6C8ef24Kd0rJDDLYBD6enE1z7hLMLEV9F4KhxIk20GdsVZb2LgefSg9liKCv8Tk1uVS18Suo4Wp9GwOGtxVZ+d3WQwxL0KImZj7ZtXuzy4jiaNUcZXz8ogz3l0V9gGQB26VuOEW5WIF6AwVJp4Q37Xr0hIILhKoSTEW+awA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782928921; c=relaxed/simple;
	bh=C9C0ey+KBcaGrThFNVqe2/kSM+kUFfA/ngJvtaQ0tPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O2rtEeupuDjOS9a5ZZT+oPcLq8HHafj+9FfmGF3/pPZBbnTq4pCbe+eJNF0OFxufGOcBEfL4aHzGOREoIVkckGaTNtI252K69dxHhHa4i4uXRFA7sysqQxb9Hn8KEO6lmY8hCNRW7au5zQGwn9j7Qk65p1z5BrbckHHT8kAzt+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GJ01IfUn; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id AFE9120B7166; Wed,  1 Jul 2026 11:01:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AFE9120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782928918;
	bh=V7Xqk09lMVg9r2BuTyp9Jy+9Qj+FKgjsTH7SgjTZ0+o=;
	h=From:To:Cc:Subject:Date:From;
	b=GJ01IfUnf4SYLucS7EKDtBU+/eeKisPThbRwG9A9rEfkP+uMO9MtTk5cJMVDUDP0F
	 ZQZS16EgbJQEkgiI4uTZFl5aO67Iiij1K6bO6RKVvt2W+HMzcFYI8TFynHCal+Zjmm
	 krAttasFGrp5siydJKnJEOAtkm8T48qTXNm16Cg8=
From: Haiyang Zhang <haiyangz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-kernel@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next v2] net: mana: Add handler for sriov configure
Date: Wed,  1 Jul 2026 11:01:09 -0700
Message-ID: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11727-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A2D16F07C8

From: Haiyang Zhang <haiyangz@microsoft.com>

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v2:
  No longer change VF autoprobe as discussed with Leon Romanovsky and Bjorn Helgaas.

---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index a0fdd052d7f1..0b7380fd1da8 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2446,6 +2446,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int err = 0;
+
+	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
+
+	if (numvfs > 0)
+		err = pci_enable_sriov(pdev, numvfs);
+	else
+		pci_disable_sriov(pdev);
+
+	return err ? err : numvfs;
+}
+
 static const struct pci_device_id mana_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF2_DEVICE_ID) },
@@ -2461,6 +2475,7 @@ static struct pci_driver mana_driver = {
 	.suspend	= mana_gd_suspend,
 	.resume		= mana_gd_resume,
 	.shutdown	= mana_gd_shutdown,
+	.sriov_configure = mana_sriov_configure,
 };
 
 static int __init mana_driver_init(void)
-- 
2.34.1


