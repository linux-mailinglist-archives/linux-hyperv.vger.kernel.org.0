Return-Path: <linux-hyperv+bounces-11877-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id slJ+EZW7TmraTAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11877-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 23:05:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9202372A6A7
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 23:05:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b="SSLrwj/F";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11877-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11877-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B849B3009F96
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DE43A6B81;
	Wed,  8 Jul 2026 21:00:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A842FF164;
	Wed,  8 Jul 2026 21:00:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783544429; cv=none; b=S6XNoTx7QlSTDzOn0FeGroZuD7xIKLxnZL2GjwTwSeM7bF/qMWWet61WbkzsjsANF+IK4z5t2g/EHgrardJkaKvNCwlBf0p2INQxdk8DHfAOT4AT9WijRLz0gbQdS4y+SN7O5MKwOD/0gGjB2D6ajphL9+oOHlrFENiEh+XVEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783544429; c=relaxed/simple;
	bh=CGmhYeHo9ruvnlF2f/eZBt95w03O2Ro9NBdOGYXrf5c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNJ7GTOh0JWmKNgpglNuejXOprdPIx5oj//JrQ3HjOAVKwSFL8LkD3IyGf3kftqOX8+yCaWsCvdOf5+fQ0eTJHD1HTl4ibkVkgH7PD33UK74Ti1cQQeg+TAEgQ+lchxJ3u8r0jeKfUA3YUj7RG+LH0gfj+pbwgSMnxrDLKPts68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SSLrwj/F; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 5E46820B716B; Wed,  8 Jul 2026 14:00:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E46820B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783544423;
	bh=bdzu0Oi5yl8bAykCWi1Ow9jtLjVoEU97W+c58vtKvew=;
	h=From:To:Cc:Subject:Date:From;
	b=SSLrwj/Fzva25T3RpqLW0D+fHQS9I5Ur4PE6XYJbjOm4pJJka6feHB6AFoHBB9RVj
	 uDsW9+gD4QnA7zDtAASQdlbXIsqUM+MHgYkdkeMhjRueE118et/Qj09sO1gH29wKKU
	 WFW4hrLLYHkF3hiZwtBuxPBxYXUS8IQgDkIAGfls=
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
Subject: [PATCH net-next v3] net: mana: Add handler for sriov configure
Date: Wed,  8 Jul 2026 13:59:18 -0700
Message-ID: <20260708205924.2408673-1-haiyangz@linux.microsoft.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_FROM(0.00)[bounces-11877-lists,linux-hyperv=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9202372A6A7

From: Haiyang Zhang <haiyangz@microsoft.com>

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v3:
  Updated sriov disabling paths suggested by Paolo Abeni

v2:
  No longer change VF autoprobe as discussed with Leon Romanovsky and Bjorn Helgaas.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef3b77229c1..80a9118a90bc 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2456,6 +2456,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	pci_disable_sriov(pdev);
+
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, false);
 
@@ -2517,6 +2519,8 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 
 	dev_info(&pdev->dev, "Shutdown was called\n");
 
+	pci_disable_sriov(pdev);
+
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, true);
 
@@ -2525,6 +2529,27 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
+{
+	int err = 0;
+
+	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
+
+	if (numvfs > 0) {
+		err = pci_enable_sriov(pdev, numvfs);
+	} else {
+		if (pci_vfs_assigned(pdev)) {
+			dev_warn(&pdev->dev,
+				 "Cannot disable SR-IOV while VFs are assigned\n");
+			return -EPERM;
+		}
+
+		pci_disable_sriov(pdev);
+	}
+
+	return err ? err : numvfs;
+}
+
 static const struct pci_device_id mana_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF2_DEVICE_ID) },
@@ -2540,6 +2565,7 @@ static struct pci_driver mana_driver = {
 	.suspend	= mana_gd_suspend,
 	.resume		= mana_gd_resume,
 	.shutdown	= mana_gd_shutdown,
+	.sriov_configure = mana_sriov_configure,
 };
 
 static int __init mana_driver_init(void)
-- 
2.34.1


