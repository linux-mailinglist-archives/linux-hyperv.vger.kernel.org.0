Return-Path: <linux-hyperv+bounces-11473-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +pf4Fdb3IGoJ+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11473-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:58:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A475E63CC05
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=E3XCGpLT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11473-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11473-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 624A7300FEDA
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 03:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D993F3AF665;
	Thu,  4 Jun 2026 03:58:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA4F2701CB;
	Thu,  4 Jun 2026 03:58:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545491; cv=none; b=tOwGGTq/BnDPsJFN5Cg0AETifcBwD2idW4EVUSEEXsmcb/H4jjvLJRQ7w7s/uJ2W8OfjEkTIkX2dvHwp/PX0min8oIvcorbT+00BJ3+d2INcFBupHDIFlf99GfpoqGL2u+rjuShekpawXWOITjEuTjNH209tDYLE8MiTBEDR4DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545491; c=relaxed/simple;
	bh=mNZ1GDdeH4uwSNEskQtaK3mU/n0GrVC7IQtyPX4yIfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XKQLnmn92S+6t3DB088jS1RFR/zi49JGSgNnigO0h/KQUqd64PogSujA0b0BovlqKjGuQ6FYkFL4V70hgCZvxn2Bbx9LCjMJzYaheZED5nkPeoTmmotnxCPPYqwHdWGMT9HS+VzkvGvh1HrPzQmGTY1YNVcKrGGtPnj86RdmSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=E3XCGpLT; arc=none smtp.client-ip=101.71.155.101
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4103cca51;
	Thu, 4 Jun 2026 11:52:48 +0800 (GMT+08:00)
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
Subject: [PATCH v2 1/4] amba: use generic driver_override infrastructure
Date: Thu,  4 Jun 2026 11:52:36 +0800
Message-Id: <20260604035239.1711889-2-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9e90c3249303a1kunm0f81216d28d05
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTR9KVkgfSx0fGBpOSR8ZH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=E3XCGpLTScDDYzL6qRyozB8RVSYopFL74DFF4A8qmLU8AT2aFZ0QQtwuqqUsUnKUrtK7ggMN8APCsPqelSqB1EAVZoVmsNtP4rPdhNBYe/ewdu5R7xg3ZovAebsyAYkIgcK07+DYVskkLNQCz+T+jUS/2jj0iDGp2jzb28jFW3M=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=KafM4DmA77CwDJeuq1wWiXL3B4CRMhrjGZoxZOBTnXQ=;
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
	TAGGED_FROM(0.00)[bounces-11473-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,seu.edu.cn:mid,seu.edu.cn:dkim,seu.edu.cn:from_mime,seu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A475E63CC05

AMBA devices still keep driver_override in bus-private storage.

The sysfs write side updates that string through driver_set_override(),
which replaces the pointer and frees the old value. However,
driver_match_device() can call amba_match() from __driver_attach()
without holding the device lock, and amba_match() still dereferences
that private pointer directly.

That means a bind/unbind or reprobe path can race with a concurrent
driver_override update and make amba_match() compare against freed
memory.

Fix this by switching AMBA to the driver-core driver_override
infrastructure. This lets the core own the sysfs attribute and storage,
and uses device_match_driver_override() for the locked read in the match
path.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
Fixes: 3cf385713460 ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
drivers/amba/bus.c       | 35 +++++------------------------------
include/linux/amba/bus.h |  5 -----
 2 files changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6d479caf89cb..df8333f90906 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -82,33 +82,6 @@ static void amba_put_disable_pclk(struct amba_device *pcdev)
 }
 
 
-static ssize_t driver_override_show(struct device *_dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct amba_device *dev = to_amba_device(_dev);
-	ssize_t len;
-
-	device_lock(_dev);
-	len = sprintf(buf, "%s\n", dev->driver_override);
-	device_unlock(_dev);
-	return len;
-}
-
-static ssize_t driver_override_store(struct device *_dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct amba_device *dev = to_amba_device(_dev);
-	int ret;
-
-	ret = driver_set_override(_dev, &dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 #define amba_attr_func(name,fmt,arg...)					\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
@@ -126,7 +99,6 @@ amba_attr_func(resource, "\t%016llx\t%016llx\t%016lx\n",
 static struct attribute *amba_dev_attrs[] = {
 	&dev_attr_id.attr,
 	&dev_attr_resource.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(amba_dev);
@@ -209,6 +181,7 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	const struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
 	mutex_lock(&pcdev->periphid_lock);
 	if (!pcdev->periphid) {
@@ -230,8 +203,9 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 	mutex_unlock(&pcdev->periphid_lock);
 
 	/* When driver_override is set, only bind to the matching driver */
-	if (pcdev->driver_override)
-		return !strcmp(pcdev->driver_override, drv->name);
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	return amba_lookup(pcdrv->id_table, pcdev) != NULL;
 }
@@ -435,6 +409,7 @@ static const struct dev_pm_ops amba_pm = {
  */
 const struct bus_type amba_bustype = {
 	.name		= "amba",
+	.driver_override = true,
 	.dev_groups	= amba_dev_groups,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 9946276aff73..6c54d5c0d21f 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -71,11 +71,6 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.34.1

