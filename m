Return-Path: <linux-hyperv+bounces-2041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA5D8B076A
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 12:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE023283E01
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Apr 2024 10:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57900158DDF;
	Wed, 24 Apr 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GlM+J1m4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA8B142621;
	Wed, 24 Apr 2024 10:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713954851; cv=none; b=molL5rueBkWpLEYqSQKMnAJ91PQN2pTfhaWTtp+bWja3NmxcUZb8ag1domkcKxO/vBh42ELktoNox2EDJE7XvEmrGlO2130uCWkCsucTYXBfNB/QW2RIPVTBN8MRiK9gGju+MVlJLCd7KRBWM8mbIec4+EqCaG0JfLTQMHoX7pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713954851; c=relaxed/simple;
	bh=pBpwupSigKleZZTb+2kGSlklScf7AqbywhAP8CWXs1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j5wAvqrxyTTwS3iye9QyekWxGvHzVEbsBzg1XvvGWajqBYiYfDuwuO233aOrn5ngXUW4phzgOmEOqt5YK7KRW1M+zv4V03O+2kKk6+R3BfyWUaCPlPFS9O81LePq6JMhyqmMRWbECkVLCxoddvfFq1giuCuMrlgRxbJ8JIzg5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GlM+J1m4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id B3906208591D; Wed, 24 Apr 2024 03:34:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3906208591D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713954849;
	bh=fmV2dEL2yO9DxzlpnlosDU08cXJN2Bc3pZpwWQ9nU5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlM+J1m4MN+NBqgAk6ui0SjVDAU87Ui6H78VbQ6O0ZFDGJ8hSHxYlZ28HX9DaNVlA
	 i/rPA9pTXl7J4XLOTElJUGZU6fvsYMB28q1FxnkgJRWe0EKkquBlCZD+6tZjAviJsC
	 qhzt/CtHlrb6osxvWM//xRbF9c71mqb4irSDoKk8=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	shradhagupta@microsoft.com
Subject: [PATCH net-next v2 2/2] net: mana: Add new device attributes for mana
Date: Wed, 24 Apr 2024 03:34:08 -0700
Message-Id: <1713954848-30299-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1713954774-29953-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add new device attributes to read num_ports and max_num_msix setting for
MANA device.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 Changes in v2
 * Used the suggested method(v1 dicsussion) to implement sysfs device parameters
   for MANA device
 * Implemented attributes max_mtu and min_mtu generically for all device
   drivers
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 1332db9a08eb..e35f984e34ce 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1471,6 +1471,37 @@ static bool mana_is_pf(unsigned short dev_id)
 	return dev_id == MANA_PF_DEVICE_ID;
 }
 
+static ssize_t num_ports_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+	struct mana_context *ac = gc->mana.driver_data;
+
+	return sysfs_emit(buf, "%d\n", ac->num_ports);
+}
+
+static DEVICE_ATTR_RO(num_ports);
+
+static ssize_t max_num_msix_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct gdma_context *gc = pci_get_drvdata(pdev);
+
+	return sysfs_emit(buf, "%d\n", gc->max_num_msix);
+}
+
+static DEVICE_ATTR_RO(max_num_msix);
+
+static struct attribute *mana_gd_device_attrs[] = {
+	&dev_attr_num_ports.attr,
+	&dev_attr_max_num_msix.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(mana_gd_device);
+
 static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct gdma_context *gc;
@@ -1613,6 +1644,7 @@ static const struct pci_device_id mana_id_table[] = {
 };
 
 static struct pci_driver mana_driver = {
+	.dev_groups	= mana_gd_device_groups,
 	.name		= "mana",
 	.id_table	= mana_id_table,
 	.probe		= mana_gd_probe,
-- 
2.34.1


