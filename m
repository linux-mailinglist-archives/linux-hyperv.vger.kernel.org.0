Return-Path: <linux-hyperv+bounces-10722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPIZMfZd/mkWpgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10722-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:04:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D44FC23F
	for <lists+linux-hyperv@lfdr.de>; Sat, 09 May 2026 00:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 77331300B9CA
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 22:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BF733F580;
	Fri,  8 May 2026 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JzLPJfVf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8A33342C;
	Fri,  8 May 2026 22:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277872; cv=none; b=jADq8I0FJCJkUBH+moKFjI0FqZ2UDG1Rmi0m+4WqhCFlffD0T+Ob2LDIcmxdwpeSnWE4AnXZjmBE7+J+EHP8SD4hy8xwXeUMfD7oplMdqJ5CO23YBECRjVUjMoh4/RHSTEdy4VsS4LPHOQtEx+dY3PVoXQJ7jPHD0BFOF3Wiel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277872; c=relaxed/simple;
	bh=sVxh7KZEWfqvP0gD45P4kR5hPU+/5A7LrdRH+d7OyNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVm/Hy4HcI4qsxJz9kwJgw5RiSMZHMZf40vM+0lAtmCCBkiilNj9nL/FxqDhLoMBkA6/eSvNaHXRNLy64xDnxCjGipIxTNx6VWC4lpmNPzRp5dHZj3do27a6Wvx/7Dkbx4DJAdGejdlTSmTh4wnNTqBn4zEdn/CHIUvhDnDleM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JzLPJfVf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1006)
	id 1327020B7166; Fri,  8 May 2026 15:04:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1327020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778277870;
	bh=GUfY60yumu3zuHpreYxIjGZCb6P35LC9IeB0Uemy/2A=;
	h=From:To:Cc:Subject:Date:From;
	b=JzLPJfVflxJA7ipuxf2JNvCbJLurRH9WoGScaDYxFMBLOc/UixJ57F4mOvBcXPTHG
	 JdY9XclifvXj/UUQWuvuLCWtAErgI6o3vCneycCWmChuuqvVsG7Kaf+kKXTvIcBdZL
	 jbWNNmp8qihwpYjXomnRTujqXAE5eYd8hF8sGEOA=
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
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: paulros@microsoft.com
Subject: [PATCH net-next] net: mana: Add handler for sriov configure
Date: Fri,  8 May 2026 15:04:06 -0700
Message-ID: <20260508220412.15138-1-haiyangz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C93D44FC23F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-10722-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Haiyang Zhang <haiyangz@microsoft.com>

Add callback function for the pci_driver, sriov_configure.

Also disable VF autoprobe when it runs as PF driver on bare metal,
since the hardware side may not have the VF ready immediately.

Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
autoprobe flag.

Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 20 +++++++++++++++++++
 drivers/pci/iov.c                             |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 3bc3fff55999..767f11d5b351 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -2094,6 +2094,11 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	gc->numa_node = dev_to_node(&pdev->dev);
 	gc->is_pf = mana_is_pf(pdev->device);
+
+	/* Disable VF autoprobe on BM */
+	if (gc->is_pf)
+		pci_vf_drivers_autoprobe(pdev, false);
+
 	gc->bar0_va = bar0_va;
 	gc->dev = &pdev->dev;
 	xa_init(&gc->irq_contexts);
@@ -2262,6 +2267,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
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
 	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_VF_DEVICE_ID) },
@@ -2276,6 +2295,7 @@ static struct pci_driver mana_driver = {
 	.suspend	= mana_gd_suspend,
 	.resume		= mana_gd_resume,
 	.shutdown	= mana_gd_shutdown,
+	.sriov_configure = mana_sriov_configure,
 };
 
 static int __init mana_driver_init(void)
diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9..5a701f44b8fd 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1127,6 +1127,7 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
 	if (dev->is_physfn)
 		dev->sriov->drivers_autoprobe = auto_probe;
 }
+EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);
 
 /**
  * pci_iov_bus_range - find bus range used by Virtual Function
-- 
2.34.1


