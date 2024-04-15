Return-Path: <linux-hyperv+bounces-1966-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C08A4BF1
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 11:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F68A1F22ED7
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 09:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6F47F5C;
	Mon, 15 Apr 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HREzJFRF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C10347A7F;
	Mon, 15 Apr 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713174592; cv=none; b=LZXxHBbzjeg1rHAwALvatUC69mJYY2GxxPYP+rdijfhiHcAT+WYqoXQJWZkYI1EIZlwfNz0AbshG80csgXrvTffVZ5FjFrRV1PKre54asIR7heEM8L7eZe8W8nvSdCbt5wU5ykhs2a7gBwrnAziabgL9Cupq4W3+wmpqo4L2mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713174592; c=relaxed/simple;
	bh=HPqIfe8N0h1aRaKL1e6qWNji6hvbGbimqY4dEkNUOi4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NFAcTYJOcd/XtkPFUKntyvXzTG0WTcbP4cNwdr2i1oiBRThs1B7VFzwrgbJ/AWPzz3AlG1HqcacY2Pp4cXMbooyac6VOB78Ivv1Nmt/mDOnuGCHV5+5rcOIqa5g6QpZDrzWVGduvkfEiMSqORrTVWQ0L6hj7NcvrgyncMD6M/CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HREzJFRF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9AC8420FC60E; Mon, 15 Apr 2024 02:49:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AC8420FC60E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713174590;
	bh=I0/lrKTOZRAEKlw4IxM0UxHLji3Bd4EZwvEMBRN/Fps=;
	h=From:To:Cc:Subject:Date:From;
	b=HREzJFRFIojtvhKFj4dl+RnRoAPWmBOCXhHvKF0V3TI3hbC/3bErU8JTUi7F/hjMV
	 9CvIYHwhL4pT6vwbC6627dcePGt8GB6kJGcIeu1tgnw1CSeGg8xMHf+0IpLU3Q69GT
	 WcigWcty1iqnWg4s2SJYN+I9Eh3+bA57QQnEPdow=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Subject: [PATCH net-next] net: mana: Add new device attributes for mana
Date: Mon, 15 Apr 2024 02:49:49 -0700
Message-Id: <1713174589-29243-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add new device attributes to view multiport, msix, and adapter MTU
setting for MANA device.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 74 +++++++++++++++++++
 include/net/mana/gdma.h                       |  9 +++
 2 files changed, 83 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb..6674a02cff06 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1471,6 +1471,65 @@ static bool mana_is_pf(unsigned short dev_id)
 	return dev_id == MANA_PF_DEVICE_ID;
 }
 
+static ssize_t mana_attr_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct mana_context *ac = gc->mana.driver_data;
+
+	if (strcmp(attr->attr.name, "mport") == 0)
+		return snprintf(buf, PAGE_SIZE, "%d\n", ac->num_ports);
+	else if (strcmp(attr->attr.name, "adapter_mtu") == 0)
+		return snprintf(buf, PAGE_SIZE, "%d\n", gc->adapter_mtu);
+	else if (strcmp(attr->attr.name, "msix") == 0)
+		return snprintf(buf, PAGE_SIZE, "%d\n", gc->max_num_msix);
+	else
+		return -EINVAL;
+}
+
+static int mana_gd_setup_sysfs(struct pci_dev *pdev)
+{
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	int retval = 0;
+
+	gc->mana_attributes.mana_mport_attr.attr.name = "mport";
+	gc->mana_attributes.mana_mport_attr.attr.mode = 0444;
+	gc->mana_attributes.mana_mport_attr.show = mana_attr_show;
+	sysfs_attr_init(&gc->mana_attributes.mana_mport_attr);
+	retval = device_create_file(&pdev->dev,
+				    &gc->mana_attributes.mana_mport_attr);
+	if (retval < 0)
+		return retval;
+
+	gc->mana_attributes.mana_adapter_mtu_attr.attr.name = "adapter_mtu";
+	gc->mana_attributes.mana_adapter_mtu_attr.attr.mode = 0444;
+	gc->mana_attributes.mana_adapter_mtu_attr.show = mana_attr_show;
+	sysfs_attr_init(&gc->mana_attributes.mana_adapter_mtu_attr);
+	retval = device_create_file(&pdev->dev,
+				    &gc->mana_attributes.mana_adapter_mtu_attr);
+	if (retval < 0)
+		goto mtu_attr_error;
+
+	gc->mana_attributes.mana_msix_attr.attr.name = "msix";
+	gc->mana_attributes.mana_msix_attr.attr.mode = 0444;
+	gc->mana_attributes.mana_msix_attr.show = mana_attr_show;
+	sysfs_attr_init(&gc->mana_attributes.mana_msix_attr);
+	retval = device_create_file(&pdev->dev,
+				    &gc->mana_attributes.mana_msix_attr);
+	if (retval < 0)
+		goto msix_attr_error;
+
+	return retval;
+msix_attr_error:
+	device_remove_file(&pdev->dev,
+			   &gc->mana_attributes.mana_adapter_mtu_attr);
+mtu_attr_error:
+	device_remove_file(&pdev->dev,
+			   &gc->mana_attributes.mana_mport_attr);
+	return retval;
+}
+
 static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct gdma_context *gc;
@@ -1519,6 +1578,10 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	gc->bar0_va = bar0_va;
 	gc->dev = &pdev->dev;
 
+	err = mana_gd_setup_sysfs(pdev);
+	if (err < 0)
+		goto free_gc;
+
 	err = mana_gd_setup(pdev);
 	if (err)
 		goto unmap_bar;
@@ -1544,6 +1607,15 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return err;
 }
 
+static void mana_cleanup_sysfs_files(struct pci_dev *pdev,
+				     struct gdma_context *gc)
+{
+	device_remove_file(&pdev->dev, &gc->mana_attributes.mana_msix_attr);
+	device_remove_file(&pdev->dev,
+			   &gc->mana_attributes.mana_adapter_mtu_attr);
+	device_remove_file(&pdev->dev, &gc->mana_attributes.mana_mport_attr);
+}
+
 static void mana_gd_remove(struct pci_dev *pdev)
 {
 	struct gdma_context *gc = pci_get_drvdata(pdev);
@@ -1552,6 +1624,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
 
 	mana_gd_cleanup(pdev);
 
+	mana_cleanup_sysfs_files(pdev, gc);
+
 	pci_iounmap(pdev, gc->bar0_va);
 
 	vfree(gc);
diff --git a/include/net/mana/gdma.h b/include/net/mana/gdma.h
index 27684135bb4d..ea636959164c 100644
--- a/include/net/mana/gdma.h
+++ b/include/net/mana/gdma.h
@@ -354,6 +354,12 @@ struct gdma_irq_context {
 	char name[MANA_IRQ_NAME_SZ];
 };
 
+struct mana_device_attributes {
+	struct device_attribute mana_mport_attr;
+	struct device_attribute mana_adapter_mtu_attr;
+	struct device_attribute mana_msix_attr;
+};
+
 struct gdma_context {
 	struct device		*dev;
 
@@ -395,6 +401,9 @@ struct gdma_context {
 
 	/* Azure RDMA adapter */
 	struct gdma_dev		mana_ib;
+
+	/* device attributes */
+	struct mana_device_attributes mana_attributes;
 };
 
 #define MAX_NUM_GDMA_DEVICES	4
-- 
2.34.1


