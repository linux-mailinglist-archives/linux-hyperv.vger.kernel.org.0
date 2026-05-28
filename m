Return-Path: <linux-hyperv+bounces-11309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLpYON1KGGqjiggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11309-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:02:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4E55F3459
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 16:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AEDA305A782
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF5B28488D;
	Thu, 28 May 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="Y6QhSjix"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E9273D9F;
	Thu, 28 May 2026 13:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976301; cv=pass; b=U21b8qYa4Sri7mjwb1kZ3tpNla4FsMIyzi3+FXTgQf07af938N3iSOtH+NcqAyuZE5oZ0NtPfMyarJzBhWwEJA5/RztuNjcTdJcuZycNlPRmYFo+y/nTu4yFTV5JwlhbteanTHjCv99QODQAzn2XK4DaIA2y8b2GCuNfEtmS13Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976301; c=relaxed/simple;
	bh=gQJRRiv58lcd5AY83A8svvNHbifizkkTGgi0jKfqDFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0vYu9auPVd95SZrwp9xmJaQgB9iLxbjjvbj4F517UkRUJZJy2GPewx9Q6IBfdB2pKOhIdpqrqN3oSX/DTdD7YRYVpqoh+pl2suv+TqK5xPB4PPPGObWDlHekKlYzv+i3QO62oMo7rs0aJkGeqEw52606oS3lu1s4IM3GroBllk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=Y6QhSjix; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1779976280; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QA6wXhnTVvh42+lSTt9aHJkimpCuNmyBkaLp+TlGQO//T8DdLkgIx7IrpLw0q2jbSw+vY17cv+JhuTcpJNuU5pyxyZUTWGTVWBZ/U/tTaOd3im48B9eyuToCo9rpWJTpW9byyx4ojTq4Ak+QUIwO1B19GdT0EEsFOuJusKONa9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779976280; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=Js2plujde2d6iaFMl3CyeW6CZo8Jb4lvi/huLgUkzbQ=; 
	b=Cf5K3vqqGc7W4IzqYkw5PBPmJCZu8+KBNAunVpqw4bgBMcW6vAN/T1N7j7ms/wTtPASyl8l4s/9PGzDAEL4ndyko2c//dn/stjGuCRiGwiRFjqvUH3OQ0igjJbGfKzaMuuHCbVwpV/iy95cFUCw1nV4kksTJf+6dvaN/X/w2GEE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779976280;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=Js2plujde2d6iaFMl3CyeW6CZo8Jb4lvi/huLgUkzbQ=;
	b=Y6QhSjixQlrRKIah134nkZSuD7BANWXPC78k5of6F1Dr38ITUdwEyBMFTX2c+neX
	/yfGh0jQkycAZPbcP69ZtbdrCjFCrFvSuK3zLiUMOKkSyVyTABn66G1nilJQ4mrmKpz
	GvjoHSlYXtA3TxLOAe7jzPpLPoPuoqIZES/rtWlw=
Received: by mx.zohomail.com with SMTPS id 177997627840267.35295935386557;
	Thu, 28 May 2026 06:51:18 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	decui@microsoft.com,
	longli@microsoft.com,
	ssengar@linux.microsoft.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v2 1/1] drm/hyperv: Replace "hyperv_" with "hv_drm_" as symbol name prefix
Date: Thu, 28 May 2026 06:51:08 -0700
Message-Id: <20260528135108.1787-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227c9aa6929a90de2ee3e1b705300003dd4395110fca7b4c088a02bccba142e8ca1df0c7bd0d4725d:ZohoMail
X-Zoho-CM-AccountID: 0c88436b239415d28725328898ceccb9ce2ba3b61598c1c37bcb2109e0248174
X-ZohoMailClient: External
X-Spamd-Result: default: False [6.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:dkim];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[zohomail.com:s=zm2022];
	TAGGED_FROM(0.00)[bounces-11309-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	GREYLIST(0.00)[pass,body];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[zohomail.com:+];
	DMARC_POLICY_ALLOW(0.00)[zohomail.com,reject];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.904];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:replyto,outlook.com:email,zohomail.com:mid,zohomail.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ptr_shape.data:url,hv_drm_driver.name:url,hyperv_driver.name:url]
X-Rspamd-Queue-Id: 9E4E55F3459
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

From: Michael Kelley <mhklinux@outlook.com>

Function and structure names in the Hyper-V DRM driver currently
use "hyperv_" as the prefix. This conflicts with usage in core Hyper-V
and VMBus code, and incorrectly implies that functions and structures
in this driver apply generically to Hyper-V. A specific conflict arises
for "hyperv_init", which is an initcall for generic Hyper-V
initialization on arm64. The conflict prevents the use of
initcall_blacklist on the kernel boot line to skip loading this driver.

Fix this by substituting "hv_drm_" as the prefix for all functions and
structures in this driver. In most places, this is replacing "hyperv_"
with "hv_drm_". In a few places, the substitution results in
"hv_drm_drm_", which has been collapsed to just "hv_drm_". In one
place, the existing prefix is a bare "hv_", which has been replaced
with "hv_drm_" for consistency.

The changes are all mechanical text substitution in symbol names.
There are no other code or functional changes.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This patch is built against linux-next20260526.

Changes in v2:
* Use "hv_drm_" as the new prefix instead of "hvdrm_". [Hamza Mahfooz]
* After the new prefix is applied, collapse occurrences of "hv_drm_drm_"
  to just "hv_drm_", such as with hv_drm_device. [Hamza Mahfooz]
* Don't change comments referring to source code filenames. [Dexuan Cui]
* Change hv_fops to hv_drm_fops for consistency.

 drivers/gpu/drm/hyperv/hyperv_drm.h         |  16 +--
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  92 ++++++++--------
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 110 ++++++++++----------
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c   |  70 ++++++-------
 4 files changed, 144 insertions(+), 144 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index 9e776112c03e..fe0bf5d40e48 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -8,7 +8,7 @@
 
 #define VMBUS_MAX_PACKET_SIZE 0x4000
 
-struct hyperv_drm_device {
+struct hv_drm_device {
 	/* drm */
 	struct drm_device dev;
 	struct drm_plane plane;
@@ -39,17 +39,17 @@ struct hyperv_drm_device {
 	struct hv_device *hdev;
 };
 
-#define to_hv(_dev) container_of(_dev, struct hyperv_drm_device, dev)
+#define to_hv(_dev) container_of(_dev, struct hv_drm_device, dev)
 
 /* hyperv_drm_modeset */
-int hyperv_mode_config_init(struct hyperv_drm_device *hv);
+int hv_drm_mode_config_init(struct hv_drm_device *hv);
 
 /* hyperv_drm_proto */
-int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
-int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
+int hv_drm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp);
+int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
 			    u32 w, u32 h, u32 pitch);
-int hyperv_hide_hw_ptr(struct hv_device *hdev);
-int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
-int hyperv_connect_vsp(struct hv_device *hdev);
+int hv_drm_hide_hw_ptr(struct hv_device *hdev);
+int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect);
+int hv_drm_connect_vsp(struct hv_device *hdev);
 
 #endif
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index b6bf6412ae34..b9661f946b7f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -24,9 +24,9 @@
 #define DRIVER_MAJOR 1
 #define DRIVER_MINOR 0
 
-DEFINE_DRM_GEM_FOPS(hv_fops);
+DEFINE_DRM_GEM_FOPS(hv_drm_fops);
 
-static struct drm_driver hyperv_driver = {
+static struct drm_driver hv_drm_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
 
 	.name		 = DRIVER_NAME,
@@ -34,22 +34,22 @@ static struct drm_driver hyperv_driver = {
 	.major		 = DRIVER_MAJOR,
 	.minor		 = DRIVER_MINOR,
 
-	.fops		 = &hv_fops,
+	.fops		 = &hv_drm_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
 	DRM_FBDEV_SHMEM_DRIVER_OPS,
 };
 
-static int hyperv_pci_probe(struct pci_dev *pdev,
+static int hv_drm_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
 	return 0;
 }
 
-static void hyperv_pci_remove(struct pci_dev *pdev)
+static void hv_drm_pci_remove(struct pci_dev *pdev)
 {
 }
 
-static const struct pci_device_id hyperv_pci_tbl[] = {
+static const struct pci_device_id hv_drm_pci_tbl[] = {
 	{
 		.vendor = PCI_VENDOR_ID_MICROSOFT,
 		.device = PCI_DEVICE_ID_HYPERV_VIDEO,
@@ -60,14 +60,14 @@ static const struct pci_device_id hyperv_pci_tbl[] = {
 /*
  * PCI stub to support gen1 VM.
  */
-static struct pci_driver hyperv_pci_driver = {
+static struct pci_driver hv_drm_pci_driver = {
 	.name =		KBUILD_MODNAME,
-	.id_table =	hyperv_pci_tbl,
-	.probe =	hyperv_pci_probe,
-	.remove =	hyperv_pci_remove,
+	.id_table =	hv_drm_pci_tbl,
+	.probe =	hv_drm_pci_probe,
+	.remove =	hv_drm_pci_remove,
 };
 
-static int hyperv_setup_vram(struct hyperv_drm_device *hv,
+static int hv_drm_setup_vram(struct hv_drm_device *hv,
 			     struct hv_device *hdev)
 {
 	struct drm_device *dev = &hv->dev;
@@ -102,15 +102,15 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
 	return ret;
 }
 
-static int hyperv_vmbus_probe(struct hv_device *hdev,
+static int hv_drm_vmbus_probe(struct hv_device *hdev,
 			      const struct hv_vmbus_device_id *dev_id)
 {
-	struct hyperv_drm_device *hv;
+	struct hv_drm_device *hv;
 	struct drm_device *dev;
 	int ret;
 
-	hv = devm_drm_dev_alloc(&hdev->device, &hyperv_driver,
-				struct hyperv_drm_device, dev);
+	hv = devm_drm_dev_alloc(&hdev->device, &hv_drm_driver,
+				struct hv_drm_device, dev);
 	if (IS_ERR(hv))
 		return PTR_ERR(hv);
 
@@ -119,15 +119,15 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	hv_set_drvdata(hdev, hv);
 	hv->hdev = hdev;
 
-	ret = hyperv_connect_vsp(hdev);
+	ret = hv_drm_connect_vsp(hdev);
 	if (ret) {
 		drm_err(dev, "Failed to connect to vmbus.\n");
 		goto err_hv_set_drv_data;
 	}
 
-	aperture_remove_all_conflicting_devices(hyperv_driver.name);
+	aperture_remove_all_conflicting_devices(hv_drm_driver.name);
 
-	ret = hyperv_setup_vram(hv, hdev);
+	ret = hv_drm_setup_vram(hv, hdev);
 	if (ret)
 		goto err_vmbus_close;
 
@@ -136,11 +136,11 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	 * vram location is not fatal. Device will update dirty area till
 	 * preferred resolution only.
 	 */
-	ret = hyperv_update_vram_location(hdev, hv->fb_base);
+	ret = hv_drm_update_vram_location(hdev, hv->fb_base);
 	if (ret)
 		drm_warn(dev, "Failed to update vram location.\n");
 
-	ret = hyperv_mode_config_init(hv);
+	ret = hv_drm_mode_config_init(hv);
 	if (ret)
 		goto err_free_mmio;
 
@@ -168,10 +168,10 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	return ret;
 }
 
-static void hyperv_vmbus_remove(struct hv_device *hdev)
+static void hv_drm_vmbus_remove(struct hv_device *hdev)
 {
 	struct drm_device *dev = hv_get_drvdata(hdev);
-	struct hyperv_drm_device *hv = to_hv(dev);
+	struct hv_drm_device *hv = to_hv(dev);
 
 	vmbus_set_skip_unload(false);
 	drm_dev_unplug(dev);
@@ -183,12 +183,12 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
 	vmbus_free_mmio(hv->mem->start, hv->fb_size);
 }
 
-static void hyperv_vmbus_shutdown(struct hv_device *hdev)
+static void hv_drm_vmbus_shutdown(struct hv_device *hdev)
 {
 	drm_atomic_helper_shutdown(hv_get_drvdata(hdev));
 }
 
-static int hyperv_vmbus_suspend(struct hv_device *hdev)
+static int hv_drm_vmbus_suspend(struct hv_device *hdev)
 {
 	struct drm_device *dev = hv_get_drvdata(hdev);
 	int ret;
@@ -202,67 +202,67 @@ static int hyperv_vmbus_suspend(struct hv_device *hdev)
 	return 0;
 }
 
-static int hyperv_vmbus_resume(struct hv_device *hdev)
+static int hv_drm_vmbus_resume(struct hv_device *hdev)
 {
 	struct drm_device *dev = hv_get_drvdata(hdev);
-	struct hyperv_drm_device *hv = to_hv(dev);
+	struct hv_drm_device *hv = to_hv(dev);
 	int ret;
 
-	ret = hyperv_connect_vsp(hdev);
+	ret = hv_drm_connect_vsp(hdev);
 	if (ret)
 		return ret;
 
-	ret = hyperv_update_vram_location(hdev, hv->fb_base);
+	ret = hv_drm_update_vram_location(hdev, hv->fb_base);
 	if (ret)
 		return ret;
 
 	return drm_mode_config_helper_resume(dev);
 }
 
-static const struct hv_vmbus_device_id hyperv_vmbus_tbl[] = {
+static const struct hv_vmbus_device_id hv_drm_vmbus_tbl[] = {
 	/* Synthetic Video Device GUID */
 	{HV_SYNTHVID_GUID},
 	{}
 };
 
-static struct hv_driver hyperv_hv_driver = {
+static struct hv_driver hv_drm_hv_driver = {
 	.name = KBUILD_MODNAME,
-	.id_table = hyperv_vmbus_tbl,
-	.probe = hyperv_vmbus_probe,
-	.remove = hyperv_vmbus_remove,
-	.shutdown = hyperv_vmbus_shutdown,
-	.suspend = hyperv_vmbus_suspend,
-	.resume = hyperv_vmbus_resume,
+	.id_table = hv_drm_vmbus_tbl,
+	.probe = hv_drm_vmbus_probe,
+	.remove = hv_drm_vmbus_remove,
+	.shutdown = hv_drm_vmbus_shutdown,
+	.suspend = hv_drm_vmbus_suspend,
+	.resume = hv_drm_vmbus_resume,
 	.driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 
-static int __init hyperv_init(void)
+static int __init hv_drm_init(void)
 {
 	int ret;
 
 	if (drm_firmware_drivers_only())
 		return -ENODEV;
 
-	ret = pci_register_driver(&hyperv_pci_driver);
+	ret = pci_register_driver(&hv_drm_pci_driver);
 	if (ret != 0)
 		return ret;
 
-	return vmbus_driver_register(&hyperv_hv_driver);
+	return vmbus_driver_register(&hv_drm_hv_driver);
 }
 
-static void __exit hyperv_exit(void)
+static void __exit hv_drm_exit(void)
 {
-	vmbus_driver_unregister(&hyperv_hv_driver);
-	pci_unregister_driver(&hyperv_pci_driver);
+	vmbus_driver_unregister(&hv_drm_hv_driver);
+	pci_unregister_driver(&hv_drm_pci_driver);
 }
 
-module_init(hyperv_init);
-module_exit(hyperv_exit);
+module_init(hv_drm_init);
+module_exit(hv_drm_exit);
 
-MODULE_DEVICE_TABLE(pci, hyperv_pci_tbl);
-MODULE_DEVICE_TABLE(vmbus, hyperv_vmbus_tbl);
+MODULE_DEVICE_TABLE(pci, hv_drm_pci_tbl);
+MODULE_DEVICE_TABLE(vmbus, hv_drm_vmbus_tbl);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Deepak Rawat <drawat.floss@gmail.com>");
 MODULE_DESCRIPTION("DRM driver for Hyper-V synthetic video device");
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 793dbbf61893..3f0ab5da0cd5 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -25,11 +25,11 @@
 
 #include "hyperv_drm.h"
 
-static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
+static int hv_drm_blit_to_vram_rect(struct drm_framebuffer *fb,
 				    const struct iosys_map *vmap,
 				    struct drm_rect *rect)
 {
-	struct hyperv_drm_device *hv = to_hv(fb->dev);
+	struct hv_drm_device *hv = to_hv(fb->dev);
 	struct iosys_map dst = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
 	int idx;
 
@@ -44,9 +44,9 @@ static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
 	return 0;
 }
 
-static int hyperv_connector_get_modes(struct drm_connector *connector)
+static int hv_drm_connector_get_modes(struct drm_connector *connector)
 {
-	struct hyperv_drm_device *hv = to_hv(connector->dev);
+	struct hv_drm_device *hv = to_hv(connector->dev);
 	int count;
 
 	count = drm_add_modes_noedid(connector,
@@ -58,11 +58,11 @@ static int hyperv_connector_get_modes(struct drm_connector *connector)
 	return count;
 }
 
-static const struct drm_connector_helper_funcs hyperv_connector_helper_funcs = {
-	.get_modes = hyperv_connector_get_modes,
+static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
+	.get_modes = hv_drm_connector_get_modes,
 };
 
-static const struct drm_connector_funcs hyperv_connector_funcs = {
+static const struct drm_connector_funcs hv_drm_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.destroy = drm_connector_cleanup,
 	.reset = drm_atomic_helper_connector_reset,
@@ -70,15 +70,15 @@ static const struct drm_connector_funcs hyperv_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static inline int hyperv_conn_init(struct hyperv_drm_device *hv)
+static inline int hv_drm_conn_init(struct hv_drm_device *hv)
 {
-	drm_connector_helper_add(&hv->connector, &hyperv_connector_helper_funcs);
+	drm_connector_helper_add(&hv->connector, &hv_drm_connector_helper_funcs);
 	return drm_connector_init(&hv->dev, &hv->connector,
-				  &hyperv_connector_funcs,
+				  &hv_drm_connector_funcs,
 				  DRM_MODE_CONNECTOR_VIRTUAL);
 }
 
-static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
+static int hv_drm_check_size(struct hv_drm_device *hv, int w, int h,
 			     struct drm_framebuffer *fb)
 {
 	u32 pitch = w * (hv->screen_depth / 8);
@@ -92,25 +92,25 @@ static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
 	return 0;
 }
 
-static const uint32_t hyperv_formats[] = {
+static const uint32_t hv_drm_formats[] = {
 	DRM_FORMAT_XRGB8888,
 };
 
-static const uint64_t hyperv_modifiers[] = {
+static const uint64_t hv_drm_modifiers[] = {
 	DRM_FORMAT_MOD_LINEAR,
 	DRM_FORMAT_MOD_INVALID
 };
 
-static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
+static void hv_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 					     struct drm_atomic_commit *state)
 {
-	struct hyperv_drm_device *hv = to_hv(crtc->dev);
+	struct hv_drm_device *hv = to_hv(crtc->dev);
 	struct drm_plane *plane = &hv->plane;
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_crtc_state *crtc_state = crtc->state;
 
-	hyperv_hide_hw_ptr(hv->hdev);
-	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
+	hv_drm_hide_hw_ptr(hv->hdev);
+	hv_drm_update_situation(hv->hdev, 1,  hv->screen_depth,
 				crtc_state->mode.hdisplay,
 				crtc_state->mode.vdisplay,
 				plane_state->fb->pitches[0]);
@@ -118,14 +118,14 @@ static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 	drm_crtc_vblank_on(crtc);
 }
 
-static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
+static const struct drm_crtc_helper_funcs hv_drm_crtc_helper_funcs = {
 	.atomic_check = drm_crtc_helper_atomic_check,
 	.atomic_flush = drm_crtc_vblank_atomic_flush,
-	.atomic_enable = hyperv_crtc_helper_atomic_enable,
+	.atomic_enable = hv_drm_crtc_helper_atomic_enable,
 	.atomic_disable = drm_crtc_vblank_atomic_disable,
 };
 
-static const struct drm_crtc_funcs hyperv_crtc_funcs = {
+static const struct drm_crtc_funcs hv_drm_crtc_funcs = {
 	.reset = drm_atomic_helper_crtc_reset,
 	.destroy = drm_crtc_cleanup,
 	.set_config = drm_atomic_helper_set_config,
@@ -135,11 +135,11 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
 	DRM_CRTC_VBLANK_TIMER_FUNCS,
 };
 
-static int hyperv_plane_atomic_check(struct drm_plane *plane,
+static int hv_drm_plane_atomic_check(struct drm_plane *plane,
 				     struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct hv_drm_device *hv = to_hv(plane->dev);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_crtc *crtc = plane_state->crtc;
 	struct drm_crtc_state *crtc_state = NULL;
@@ -167,10 +167,10 @@ static int hyperv_plane_atomic_check(struct drm_plane *plane,
 	return 0;
 }
 
-static void hyperv_plane_atomic_update(struct drm_plane *plane,
+static void hv_drm_plane_atomic_update(struct drm_plane *plane,
 				       struct drm_atomic_commit *state)
 {
-	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct hv_drm_device *hv = to_hv(plane->dev);
 	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
@@ -185,15 +185,15 @@ static void hyperv_plane_atomic_update(struct drm_plane *plane,
 		if (!drm_rect_intersect(&dst_clip, &damage))
 			continue;
 
-		hyperv_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
-		hyperv_update_dirt(hv->hdev, &damage);
+		hv_drm_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
+		hv_drm_update_dirt(hv->hdev, &damage);
 	}
 }
 
-static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
+static int hv_drm_plane_get_scanout_buffer(struct drm_plane *plane,
 					   struct drm_scanout_buffer *sb)
 {
-	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct hv_drm_device *hv = to_hv(plane->dev);
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
 
 	if (plane->state && plane->state->fb) {
@@ -207,9 +207,9 @@ static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
 	return -ENODEV;
 }
 
-static void hyperv_plane_panic_flush(struct drm_plane *plane)
+static void hv_drm_plane_panic_flush(struct drm_plane *plane)
 {
-	struct hyperv_drm_device *hv = to_hv(plane->dev);
+	struct hv_drm_device *hv = to_hv(plane->dev);
 	struct drm_rect rect;
 
 	if (plane->state && plane->state->fb) {
@@ -218,32 +218,32 @@ static void hyperv_plane_panic_flush(struct drm_plane *plane)
 		rect.x2 = plane->state->fb->width;
 		rect.y2 = plane->state->fb->height;
 
-		hyperv_update_dirt(hv->hdev, &rect);
+		hv_drm_update_dirt(hv->hdev, &rect);
 	}
 
 	vmbus_initiate_unload(true);
 }
 
-static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
+static const struct drm_plane_helper_funcs hv_drm_plane_helper_funcs = {
 	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
-	.atomic_check = hyperv_plane_atomic_check,
-	.atomic_update = hyperv_plane_atomic_update,
-	.get_scanout_buffer = hyperv_plane_get_scanout_buffer,
-	.panic_flush = hyperv_plane_panic_flush,
+	.atomic_check = hv_drm_plane_atomic_check,
+	.atomic_update = hv_drm_plane_atomic_update,
+	.get_scanout_buffer = hv_drm_plane_get_scanout_buffer,
+	.panic_flush = hv_drm_plane_panic_flush,
 };
 
-static const struct drm_plane_funcs hyperv_plane_funcs = {
+static const struct drm_plane_funcs hv_drm_plane_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 	.disable_plane		= drm_atomic_helper_disable_plane,
 	.destroy		= drm_plane_cleanup,
 	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
-static const struct drm_encoder_funcs hyperv_drm_simple_encoder_funcs_cleanup = {
+static const struct drm_encoder_funcs hv_drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
-static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
+static inline int hv_drm_pipe_init(struct hv_drm_device *hv)
 {
 	struct drm_device *dev = &hv->dev;
 	struct drm_encoder *encoder = &hv->encoder;
@@ -253,29 +253,29 @@ static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 	int ret;
 
 	ret = drm_universal_plane_init(dev, plane, 0,
-				       &hyperv_plane_funcs,
-				       hyperv_formats, ARRAY_SIZE(hyperv_formats),
-				       hyperv_modifiers,
+				       &hv_drm_plane_funcs,
+				       hv_drm_formats, ARRAY_SIZE(hv_drm_formats),
+				       hv_drm_modifiers,
 				       DRM_PLANE_TYPE_PRIMARY, NULL);
 	if (ret)
 		return ret;
-	drm_plane_helper_add(plane, &hyperv_plane_helper_funcs);
+	drm_plane_helper_add(plane, &hv_drm_plane_helper_funcs);
 	drm_plane_enable_fb_damage_clips(plane);
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					&hyperv_crtc_funcs, NULL);
+					&hv_drm_crtc_funcs, NULL);
 	if (ret)
 		return ret;
-	drm_crtc_helper_add(crtc, &hyperv_crtc_helper_funcs);
+	drm_crtc_helper_add(crtc, &hv_drm_crtc_helper_funcs);
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 	ret = drm_encoder_init(dev, encoder,
-			       &hyperv_drm_simple_encoder_funcs_cleanup,
+			       &hv_drm_simple_encoder_funcs_cleanup,
 			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret)
 		return ret;
 
-	ret = hyperv_conn_init(hv);
+	ret = hv_drm_conn_init(hv);
 	if (ret) {
 		drm_err(dev, "Failed to initialized connector.\n");
 		return ret;
@@ -285,25 +285,25 @@ static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
 }
 
 static enum drm_mode_status
-hyperv_mode_valid(struct drm_device *dev,
+hv_drm_mode_valid(struct drm_device *dev,
 		  const struct drm_display_mode *mode)
 {
-	struct hyperv_drm_device *hv = to_hv(dev);
+	struct hv_drm_device *hv = to_hv(dev);
 
-	if (hyperv_check_size(hv, mode->hdisplay, mode->vdisplay, NULL))
+	if (hv_drm_check_size(hv, mode->hdisplay, mode->vdisplay, NULL))
 		return MODE_BAD;
 
 	return MODE_OK;
 }
 
-static const struct drm_mode_config_funcs hyperv_mode_config_funcs = {
+static const struct drm_mode_config_funcs hv_drm_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
-	.mode_valid = hyperv_mode_valid,
+	.mode_valid = hv_drm_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
-int hyperv_mode_config_init(struct hyperv_drm_device *hv)
+int hv_drm_mode_config_init(struct hv_drm_device *hv)
 {
 	struct drm_device *dev = &hv->dev;
 	int ret;
@@ -322,9 +322,9 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
 	dev->mode_config.preferred_depth = hv->screen_depth;
 	dev->mode_config.prefer_shadow = 0;
 
-	dev->mode_config.funcs = &hyperv_mode_config_funcs;
+	dev->mode_config.funcs = &hv_drm_mode_config_funcs;
 
-	ret = hyperv_pipe_init(hv);
+	ret = hv_drm_pipe_init(hv);
 	if (ret) {
 		drm_err(dev, "Failed to initialized pipe.\n");
 		return ret;
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 6e09b0218df4..f0ef627b4898 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -181,7 +181,7 @@ struct synthvid_msg {
 	};
 } __packed;
 
-static inline bool hyperv_version_ge(u32 ver1, u32 ver2)
+static inline bool hv_drm_version_ge(u32 ver1, u32 ver2)
 {
 	if (SYNTHVID_VER_GET_MAJOR(ver1) > SYNTHVID_VER_GET_MAJOR(ver2) ||
 	    (SYNTHVID_VER_GET_MAJOR(ver1) == SYNTHVID_VER_GET_MAJOR(ver2) &&
@@ -191,10 +191,10 @@ static inline bool hyperv_version_ge(u32 ver1, u32 ver2)
 	return false;
 }
 
-static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg *msg)
+static inline int hv_drm_sendpacket(struct hv_device *hdev, struct synthvid_msg *msg)
 {
 	static atomic64_t request_id = ATOMIC64_INIT(0);
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	int ret;
 
 	msg->pipe_hdr.type = PIPE_MSG_DATA;
@@ -211,9 +211,9 @@ static inline int hyperv_sendpacket(struct hv_device *hdev, struct synthvid_msg
 	return ret;
 }
 
-static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
+static int hv_drm_negotiate_version(struct hv_device *hdev, u32 ver)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
 	struct drm_device *dev = &hv->dev;
 	unsigned long t;
@@ -223,7 +223,7 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
 	msg->vid_hdr.size = sizeof(struct synthvid_msg_hdr) +
 		sizeof(struct synthvid_version_req);
 	msg->ver_req.version = ver;
-	hyperv_sendpacket(hdev, msg);
+	hv_drm_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
 	if (!t) {
@@ -243,9 +243,9 @@ static int hyperv_negotiate_version(struct hv_device *hdev, u32 ver)
 	return 0;
 }
 
-int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
+int hv_drm_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
 	struct drm_device *dev = &hv->dev;
 	unsigned long t;
@@ -257,7 +257,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
 	msg->vram.user_ctx = vram_pp;
 	msg->vram.vram_gpa = vram_pp;
 	msg->vram.is_vram_gpa_specified = 1;
-	hyperv_sendpacket(hdev, msg);
+	hv_drm_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
 	if (!t) {
@@ -272,7 +272,7 @@ int hyperv_update_vram_location(struct hv_device *hdev, phys_addr_t vram_pp)
 	return 0;
 }
 
-int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
+int hv_drm_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
 			    u32 w, u32 h, u32 pitch)
 {
 	struct synthvid_msg msg;
@@ -292,7 +292,7 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
 	msg.situ.video_output[0].height_pixels = h;
 	msg.situ.video_output[0].pitch_bytes = pitch;
 
-	hyperv_sendpacket(hdev, &msg);
+	hv_drm_sendpacket(hdev, &msg);
 
 	return 0;
 }
@@ -306,11 +306,11 @@ int hyperv_update_situation(struct hv_device *hdev, u8 active, u32 bpp,
  * the msg.ptr_shape.data. Note: setting msg.ptr_pos.is_visible to 0 doesn't
  * work in tests.
  *
- * The hyperv_hide_hw_ptr() is also called in the handler of the
+ * The hv_drm_hide_hw_ptr() is also called in the handler of the
  * SYNTHVID_FEATURE_CHANGE event, otherwise the host still draws an extra
  * unwanted mouse pointer after the VM Connection window is closed and reopened.
  */
-int hyperv_hide_hw_ptr(struct hv_device *hdev)
+int hv_drm_hide_hw_ptr(struct hv_device *hdev)
 {
 	struct synthvid_msg msg;
 
@@ -322,7 +322,7 @@ int hyperv_hide_hw_ptr(struct hv_device *hdev)
 	msg.ptr_pos.video_output = 0;
 	msg.ptr_pos.image_x = 0;
 	msg.ptr_pos.image_y = 0;
-	hyperv_sendpacket(hdev, &msg);
+	hv_drm_sendpacket(hdev, &msg);
 
 	memset(&msg, 0, sizeof(struct synthvid_msg));
 	msg.vid_hdr.type = SYNTHVID_POINTER_SHAPE;
@@ -338,14 +338,14 @@ int hyperv_hide_hw_ptr(struct hv_device *hdev)
 	msg.ptr_shape.data[1] = 1;
 	msg.ptr_shape.data[2] = 1;
 	msg.ptr_shape.data[3] = 1;
-	hyperv_sendpacket(hdev, &msg);
+	hv_drm_sendpacket(hdev, &msg);
 
 	return 0;
 }
 
-int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
+int hv_drm_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg msg;
 
 	if (!hv->dirt_needed)
@@ -363,14 +363,14 @@ int hyperv_update_dirt(struct hv_device *hdev, struct drm_rect *rect)
 	msg.dirt.rect[0].x2 = rect->x2;
 	msg.dirt.rect[0].y2 = rect->y2;
 
-	hyperv_sendpacket(hdev, &msg);
+	hv_drm_sendpacket(hdev, &msg);
 
 	return 0;
 }
 
-static int hyperv_get_supported_resolution(struct hv_device *hdev)
+static int hv_drm_get_supported_resolution(struct hv_device *hdev)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg = (struct synthvid_msg *)hv->init_buf;
 	struct drm_device *dev = &hv->dev;
 	unsigned long t;
@@ -383,7 +383,7 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		sizeof(struct synthvid_supported_resolution_req);
 	msg->resolution_req.maximum_resolution_count =
 		SYNTHVID_MAX_RESOLUTION_COUNT;
-	hyperv_sendpacket(hdev, msg);
+	hv_drm_sendpacket(hdev, msg);
 
 	t = wait_for_completion_timeout(&hv->wait, VMBUS_VSP_TIMEOUT);
 	if (!t) {
@@ -420,9 +420,9 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
+static void hv_drm_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
 	size_t hdr_size;
 	size_t need;
@@ -486,7 +486,7 @@ static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 		}
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
-			hyperv_hide_hw_ptr(hv->hdev);
+			hv_drm_hide_hw_ptr(hv->hdev);
 		return;
 	default:
 		return;
@@ -508,10 +508,10 @@ static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 	complete(&hv->wait);
 }
 
-static void hyperv_receive(void *ctx)
+static void hv_drm_receive(void *ctx)
 {
 	struct hv_device *hdev = ctx;
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *recv_buf;
 	u32 bytes_recvd;
 	u64 req_id;
@@ -539,19 +539,19 @@ static void hyperv_receive(void *ctx)
 					    ret, bytes_recvd);
 		} else if (bytes_recvd > 0 &&
 			   recv_buf->pipe_hdr.type == PIPE_MSG_DATA) {
-			hyperv_receive_sub(hdev, bytes_recvd);
+			hv_drm_receive_sub(hdev, bytes_recvd);
 		}
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
-int hyperv_connect_vsp(struct hv_device *hdev)
+int hv_drm_connect_vsp(struct hv_device *hdev)
 {
-	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
+	struct hv_drm_device *hv = hv_get_drvdata(hdev);
 	struct drm_device *dev = &hv->dev;
 	int ret;
 
 	ret = vmbus_open(hdev->channel, VMBUS_RING_BUFSIZE, VMBUS_RING_BUFSIZE,
-			 NULL, 0, hyperv_receive, hdev);
+			 NULL, 0, hv_drm_receive, hdev);
 	if (ret) {
 		drm_err(dev, "Unable to open vmbus channel\n");
 		return ret;
@@ -561,16 +561,16 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 	switch (vmbus_proto_version) {
 	case VERSION_WIN10:
 	case VERSION_WIN10_V5:
-		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
+		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 		if (!ret)
 			break;
 		fallthrough;
 	case VERSION_WIN8:
 	case VERSION_WIN8_1:
-		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
+		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
 		break;
 	default:
-		ret = hyperv_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
+		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 		break;
 	}
 
@@ -581,8 +581,8 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 
 	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
-	if (hyperv_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
-		ret = hyperv_get_supported_resolution(hdev);
+	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
+		ret = hv_drm_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
 	}
-- 
2.25.1


