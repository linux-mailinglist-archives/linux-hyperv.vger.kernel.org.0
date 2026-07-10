Return-Path: <linux-hyperv+bounces-11916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G7WLF2lIUWpVBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11916-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:30:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F273DC8E
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 21:30:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=VBl1erQH;
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11916-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11916-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B82813051D19
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Jul 2026 19:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BEC3839BE;
	Fri, 10 Jul 2026 19:27:54 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E25388374;
	Fri, 10 Jul 2026 19:27:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711674; cv=none; b=FgTZl09KPTLLM96q4aTd3MsqTlO4a0fN2HK1i3suOOFm5QPCOTHZ6iXPbqRpWFYNvggK4L2D/BMFR9pBoDhhD669nihJp3EdQODFJ9LRcW+3Kf0Qg7QlBnxQtAFrQIr+cHywdEm5oT5+ZoxV/vlPTDwcdT7cvKVdlmRmrr/RC/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711674; c=relaxed/simple;
	bh=UWj/0xJ3E/s9fNNFWLVQr/YscRyFgXX/OvTPMf1Fvbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HuzPd9fVFbr0ZBVxDFjQdTSJRquuOFcCCdy5xETLwAVVvRnggPpcRhAuismm14LKvouqYWXZKYBHgRPNCzrtY2LKtAx4k6D7umOQaiUXQmtwQCn9Gh42rwwMUizNeW9t8tk5WAWjlp+NQk0vY2luiXmxLS1iAUMOZ1L3H6oVIWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VBl1erQH; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 74B1720B7169; Fri, 10 Jul 2026 12:27:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 74B1720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783711665;
	bh=CIGcZUacPy7ZKSLfX1pZyU4Ol+FGeuAdAMX6DIN/vCs=;
	h=From:To:Cc:Subject:Date:From;
	b=VBl1erQHAaEaduadQeljAY3y0Qs58udnTl6bE2Rf79pvfmWf7HNX0zjcsbvJBn84U
	 NjvcI6UA0MLnuEeAHbrRWQjfpH9u4eCW2tJrrQ7vsC/vLXc8+w62YAmpcQJUJnE5s9
	 l6jBSjr/aOTQxJkY75WJrCzbgu8+tY/UrBhz5Sgw=
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
Subject: [PATCH net-next v4] net: mana: Add handler for sriov configure
Date: Fri, 10 Jul 2026 12:27:29 -0700
Message-ID: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-11916-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC7F273DC8E

From: Haiyang Zhang <haiyangz@microsoft.com>

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
v4:
  Removed unnecessary pci_disable_sriov() from mana_gd_shutdown() as
  suggested by AI review.

v3:
  Updated sriov disabling paths suggested by Paolo Abeni

v2:
  No longer change VF autoprobe as discussed with Leon Romanovsky and Bjorn Helgaas.

---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index aef3b77229c1..a38d4bb74621 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2456,6 +2456,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
+	pci_disable_sriov(pdev);
+
 	mana_rdma_remove(&gc->mana_ib);
 	mana_remove(&gc->mana, false);
 
@@ -2525,6 +2527,27 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
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
@@ -2540,6 +2563,7 @@ static struct pci_driver mana_driver = {
 	.suspend	= mana_gd_suspend,
 	.resume		= mana_gd_resume,
 	.shutdown	= mana_gd_shutdown,
+	.sriov_configure = mana_sriov_configure,
 };
 
 static int __init mana_driver_init(void)
-- 
2.34.1


