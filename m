Return-Path: <linux-hyperv+bounces-11475-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /doBARn4IGoi+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11475-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:59:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F98163CC32
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:59:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=L0ePJB2Z;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11475-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11475-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A9CC3040AAD
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AA3B0AEF;
	Thu,  4 Jun 2026 03:58:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17D72617;
	Thu,  4 Jun 2026 03:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545493; cv=none; b=AwbVnnLPQBLEFE2GxMAwt5L/1GUEbqxmmkjBPJb5LHT1VcAq7bIDksZmKomOyHZb3zzW761sbk95Re9QuPp/d2pXd9k1hK4kWa1xoS6wSLxvsP2aCEKcBdQ+x+mCZg+oUOwDLRYXpVHqDjJI/XHyi36nk+XLMkCtUrlFSLwjZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545493; c=relaxed/simple;
	bh=aZLwY/9EDQ02XdFP+3inxUVP43n/84nghC9Ko7Zn+tA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeSu9bc0rSifw5nEsUHK0C+WWICpEzIn2XHf4VBebIb18GLB4rkWgOISpjpR4xs78zsy3+hy6lAOV7EK+kloqtlJWLwJAnBltoxPqWjY/7WmoH9B279Uyt40BN3cSXGJsRsC++uDjOn38ySal6zyHoQI7Y8ev8Ch4O93IZQWB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=L0ePJB2Z; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4103cca57;
	Thu, 4 Jun 2026 11:52:56 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: dakr@kernel.org,
	driver-core@lists.linux.dev,
	linux@armlinux.org.uk,
	andersson@kernel.org,
	mathieu.poirier@linaro.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	nipun.gupta@amd.com,
	nikhil.agarwal@amd.com,
	linux-remoteproc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] cdx: use generic driver_override infrastructure
Date: Thu,  4 Jun 2026 11:52:39 +0800
Message-Id: <20260604035239.1711889-5-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
 <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e90c3458003a1kunm0f81216d28d1b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTEsdVkoYGh8eHkMaQ0NPSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=L0ePJB2Zgla5W6w8PmnPsi0MIHdQdH/3TgkcwGvhOJdJw8MD7UEzgg0Vyn3r8/0Rf97EMJrK8ONmOTIxiNTNsqcguPSKNzBsF/cbNK1YOc41xQsIelpXuxocnGbCywF7j3u4MNjSb1/THblDMq/4qp4AMtXXF6skWSjr6g9aQkQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=0XPOIhxg2F68hBRjE6rRRrqxSXoozAE1hg6WZ/Tun+U=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11475-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux@armlinux.org.uk,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:nipun.gupta@amd.com,m:nikhil.agarwal@amd.com,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,seu.edu.cn:mid,seu.edu.cn:dkim,seu.edu.cn:from_mime,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F98163CC32

CDX devices still keep driver_override in bus-private storage.

The sysfs write side updates that string through driver_set_override(),
which replaces the pointer and frees the old value. However,
driver_match_device() can call cdx_bus_match() from __driver_attach()
without holding the device lock, and cdx_bus_match() still dereferences
that private pointer directly.

That means the CDX match path can race with a concurrent
driver_override update and compare against freed memory.

Switch CDX to the driver-core driver_override infrastructure. This
removes the private driver_override storage, lets the core provide the
sysfs attribute, and uses device_match_driver_override() for the locked
read in cdx_bus_match().

Preserve the existing CDX override_only semantics: entries marked
override_only still require a matching driver_override, but ordinary ID
matches continue to work unchanged.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
Fixes: 48a6c7bced2a ("cdx: add device attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
drivers/cdx/cdx.c           | 40 +++++--------------------------------
include/linux/cdx/cdx_bus.h |  1 -
 2 files changed, 5 insertions(+), 36 deletions(-)

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
index b1ba97f6c9ad..f1a107b232da 100644
--- a/include/linux/cdx/cdx_bus.h
+++ b/include/linux/cdx/cdx_bus.h
@@ -165,7 +165,6 @@ struct cdx_device {
 	bool enabled;
 	u32 msi_dev_id;
 	u32 num_msi;
-	const char *driver_override;
 	struct mutex irqchip_lock;
 	bool msi_write_pending;
 };
-- 
2.34.1

