Return-Path: <linux-hyperv+bounces-10630-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDg3AF7z+WmcFQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10630-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:40:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55D4CEAF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D419304DA14
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 13:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408447DD71;
	Tue,  5 May 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJkdMEcM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45053F1668;
	Tue,  5 May 2026 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988396; cv=none; b=gLBi3xxSWwb3EDksgXPpHbfdvr1o+GMfHJti28TGif/5rY+4McauxG7Kg3VcQcinkUaRF0VEFfCf2q4r7yTTDYzelJJYLPushuhUU9gyPt4rAWz+Z02aRJacTQ7H50Baryg20yDbP52cIYmF8eKrp3bsjcJtVJ1SKKVelmpDILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988396; c=relaxed/simple;
	bh=kcjC/HW2HNG3Ncw9EG7raccDRsFJ6UdMh53CNSoiCUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6gE7z0a5WRBSvcAoPpeU8JbdX3mgNNIslhxDGGBnTgA9vpABMOgTO1IO8BOYI0ikBKuitFQXEZKMiANfbNS57NwnsDJEU0X6CwLiEPMuVEhDUfsdytrsSEG1iZvJoNNIMyqUAhzX5FoEWZvwvAR3a4x8DVcU8btD5pFuIOAyEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJkdMEcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D77C2BCC7;
	Tue,  5 May 2026 13:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988396;
	bh=kcjC/HW2HNG3Ncw9EG7raccDRsFJ6UdMh53CNSoiCUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJkdMEcMbB0ZInoqZtF8Lz16OhqvF0tVkjjLp70E0yP+jbd1xYCvyLq0vNC85+sGx
	 EEKdlKd1uuQn6NF4G4GmK9A0EjwVnPGT+EKB7OZ2hVzxPFA+dh7gcwoTDnVPiZQpQ1
	 BhlviWzgsRGVtUfZvusHJB/I34Q9I1Vpysg+Dai8M/DVFRQy+jRwUEeutXfceg7bZS
	 MCZvPxESr8RIBlxfMC0HnuFvaauOHgLpHA8+TDjVBbSdOnY6ivDWMSx1Z8VOAHzX8K
	 sa8Je8oz2wn0rR4L3D7CgGAm4Bj449I44squSv43DQcrcuV8P7b5/SknzxD0hca3Fr
	 Fp8pqGOEea5KA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	linux@armlinux.org.uk,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andersson@kernel.org,
	mathieu.poirier@linaro.org
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH v2 2/5] cdx: use generic driver_override infrastructure
Date: Tue,  5 May 2026 15:37:22 +0200
Message-ID: <20260505133935.3772495-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505133935.3772495-1-dakr@kernel.org>
References: <20260505133935.3772495-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6F55D4CEAF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10630-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

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
Fixes: 2959ab247061 ("cdx: add the cdx bus driver")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/cdx/cdx.c           | 40 +++++--------------------------------
 include/linux/cdx/cdx_bus.h |  4 ----
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/cdx/cdx.c b/drivers/cdx/cdx.c
index 9196dc50a48d..d3d230247262 100644
--- a/drivers/cdx/cdx.c
+++ b/drivers/cdx/cdx.c
@@ -156,8 +156,6 @@ static int cdx_unregister_device(struct device *dev,
 	} else {
 		cdx_destroy_res_attr(cdx_dev, MAX_CDX_DEV_RESOURCES);
 		debugfs_remove_recursive(cdx_dev->debugfs_dir);
-		kfree(cdx_dev->driver_override);
-		cdx_dev->driver_override = NULL;
 	}
 
 	/*
@@ -268,6 +266,7 @@ static int cdx_bus_match(struct device *dev, const struct device_driver *drv)
 	const struct cdx_driver *cdx_drv = to_cdx_driver(drv);
 	const struct cdx_device_id *found_id = NULL;
 	const struct cdx_device_id *ids;
+	int ret;
 
 	if (cdx_dev->is_bus)
 		return false;
@@ -275,7 +274,8 @@ static int cdx_bus_match(struct device *dev, const struct device_driver *drv)
 	ids = cdx_drv->match_id_table;
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (cdx_dev->driver_override && strcmp(cdx_dev->driver_override, drv->name))
+	ret = device_match_driver_override(dev, drv);
+	if (ret == 0)
 		return false;
 
 	found_id = cdx_match_id(ids, cdx_dev);
@@ -289,7 +289,7 @@ static int cdx_bus_match(struct device *dev, const struct device_driver *drv)
 		 */
 		if (!found_id->override_only)
 			return true;
-		if (cdx_dev->driver_override)
+		if (ret > 0)
 			return true;
 
 		ids = found_id + 1;
@@ -453,36 +453,6 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(modalias);
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct cdx_device *cdx_dev = to_cdx_device(dev);
-	int ret;
-
-	if (WARN_ON(dev->bus != &cdx_bus_type))
-		return -EINVAL;
-
-	ret = driver_set_override(dev, &cdx_dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct cdx_device *cdx_dev = to_cdx_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", cdx_dev->driver_override);
-	device_unlock(dev);
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
@@ -552,7 +522,6 @@ static struct attribute *cdx_dev_attrs[] = {
 	&dev_attr_class.attr,
 	&dev_attr_revision.attr,
 	&dev_attr_modalias.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -646,6 +615,7 @@ ATTRIBUTE_GROUPS(cdx_bus);
 
 const struct bus_type cdx_bus_type = {
 	.name		= "cdx",
+	.driver_override = true,
 	.match		= cdx_bus_match,
 	.probe		= cdx_probe,
 	.remove		= cdx_remove,
diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
index b1ba97f6c9ad..f54770f110bc 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -137,9 +137,6 @@ struct cdx_controller {
  * @enabled: is this bus enabled
  * @msi_dev_id: MSI Device ID associated with CDX device
  * @num_msi: Number of MSI's supported by the device
- * @driver_override: driver name to force a match; do not set directly,
- *                   because core frees it; use driver_set_override() to
- *                   set or clear it.
  * @irqchip_lock: lock to synchronize irq/msi configuration
  * @msi_write_pending: MSI write pending for this device
  */
@@ -165,7 +162,6 @@ struct cdx_device {
 	bool enabled;
 	u32 msi_dev_id;
 	u32 num_msi;
-	const char *driver_override;
 	struct mutex irqchip_lock;
 	bool msi_write_pending;
 };
-- 
2.54.0


