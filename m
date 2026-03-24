Return-Path: <linux-hyperv+bounces-9720-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGwONv7kwWnLXgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9720-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:12:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F8E30059C
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A1E830344A1
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 01:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB43374185;
	Tue, 24 Mar 2026 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urbkSyPC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197C1373BF8;
	Tue, 24 Mar 2026 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314050; cv=none; b=tEvHq1M4zapJbmdsBPLyNQKBV46y6MeVg4IH1og9fPlM3hOXXEdKH+8uTvnQtM/4/M1OPjuT8Prb9sTJv23MraheIMLWSbqOOpg5b5gh8TKzJjS2aJs8a932KiCuewB/NCMWcdBQBKVXl4+MdYQYs+aEGwnoKEE1b2/2yZTV5DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314050; c=relaxed/simple;
	bh=2lHhdrgE9qzH1ZdWMWGXkZLiIUExSh17kxoWzoBpEYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tn4r10MH46SBtv2c/Ly9ouNQ+DCFU5PLIbMOO+I/8Cy9zHin/0o5gt2VN9u+gLdJoPovI8eN/pSCeFd5TuV98w4uTLqcL/1tODJp5XE5nWdI7Nuz/99vIo+8inwxCVIHWPycS0rJK2M8giSLlHDK4v63QKa7vtW5G/TwOYvUgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urbkSyPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600FAC2BCB3;
	Tue, 24 Mar 2026 01:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314049;
	bh=2lHhdrgE9qzH1ZdWMWGXkZLiIUExSh17kxoWzoBpEYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=urbkSyPC//Mc+7xDMT60BWD1PM5iJno/Pv3C12Ww9BFBlm+Txslon6hgVop799Zux
	 g+Sv+q81mxYoKpArwgNlL1ZLxKeJEZHi/lM3U9lsj91wt+dVuwPQVluFb1QQ+HQlCj
	 sv5wTpgn5xlflwnnmanQE9E5F/Pn2wr+wAILRhGodQgtrhj4oxFDHJG9NtY75ERcHC
	 m7A8DB8J2Ne77LkVgV0/eIo9dU9uCfUYKNhjjLT4Tt3E8Clc0+8oqnyAcHS/Bg4R5L
	 D1zJWmU8m174lSqL3A0Ubvc3fqLrq3bwEdahRa42TfG/CVeZDK4Hwt1j/T6kr4aNVX
	 9oiBCcvJ5IK1g==
From: Danilo Krummrich <dakr@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Armin Wolf <W_Armin@gmx.de>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Holger Dengler <dengler@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Alex Williamson <alex@shazbot.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-spi@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arm-kernel@lists.infradead.org,
	Danilo Krummrich <dakr@kernel.org>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 08/12] vdpa: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:12 +0100
Message-ID: <20260324005919.2408620-9-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324005919.2408620-1-dakr@kernel.org>
References: <20260324005919.2408620-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9720-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_GT_50(0.00)[50];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E1F8E30059C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: 539fec78edb4 ("vdpa: add driver_override support")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/vdpa/vdpa.c  | 48 +++++---------------------------------------
 include/linux/vdpa.h |  4 ----
 2 files changed, 5 insertions(+), 47 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 34874beb0152..caf0ee5d6856 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -67,57 +67,20 @@ static void vdpa_dev_remove(struct device *d)
 
 static int vdpa_dev_match(struct device *dev, const struct device_driver *drv)
 {
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
+	int ret;
 
 	/* Check override first, and if set, only use the named driver */
-	if (vdev->driver_override)
-		return strcmp(vdev->driver_override, drv->name) == 0;
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	/* Currently devices must be supported by all vDPA bus drivers */
 	return 1;
 }
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &vdev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", vdev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
-static struct attribute *vdpa_dev_attrs[] = {
-	&dev_attr_driver_override.attr,
-	NULL,
-};
-
-static const struct attribute_group vdpa_dev_group = {
-	.attrs  = vdpa_dev_attrs,
-};
-__ATTRIBUTE_GROUPS(vdpa_dev);
-
 static const struct bus_type vdpa_bus = {
 	.name  = "vdpa",
-	.dev_groups = vdpa_dev_groups,
+	.driver_override = true,
 	.match = vdpa_dev_match,
 	.probe = vdpa_dev_probe,
 	.remove = vdpa_dev_remove,
@@ -132,7 +95,6 @@ static void vdpa_release_dev(struct device *d)
 		ops->free(vdev);
 
 	ida_free(&vdpa_index_ida, vdev->index);
-	kfree(vdev->driver_override);
 	kfree(vdev);
 }
 
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 2bfe3baa63f4..782c42d25db1 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -72,9 +72,6 @@ struct vdpa_mgmt_dev;
  * struct vdpa_device - representation of a vDPA device
  * @dev: underlying device
  * @vmap: the metadata passed to upper layer to be used for mapping
- * @driver_override: driver name to force a match; do not set directly,
- *                   because core frees it; use driver_set_override() to
- *                   set or clear it.
  * @config: the configuration ops for this device.
  * @map: the map ops for this device
  * @cf_lock: Protects get and set access to configuration layout.
@@ -90,7 +87,6 @@ struct vdpa_mgmt_dev;
 struct vdpa_device {
 	struct device dev;
 	union virtio_map vmap;
-	const char *driver_override;
 	const struct vdpa_config_ops *config;
 	const struct virtio_map_ops *map;
 	struct rw_semaphore cf_lock; /* Protects get/set config */
-- 
2.53.0


