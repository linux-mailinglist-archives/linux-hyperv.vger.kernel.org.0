Return-Path: <linux-hyperv+bounces-11474-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3QkhD+X3IGoY+AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11474-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:58:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B097463CC19
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 05:58:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=Z+ZpfeIl;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11474-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11474-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A4A3020A63
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 03:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AFB3B0AFE;
	Thu,  4 Jun 2026 03:58:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196A385D64;
	Thu,  4 Jun 2026 03:58:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780545492; cv=none; b=V7XTQ2m/K7X1M9boFJK1lmcn2C1ZijAO8LfdP3zDYiTO0iMSeDwq7DGbwcNo8X2VJoCVWCTRP4EHPwBe9ozlgLx2xSQsRsDrikVSBD8TnLu8b0/FPrz4DgoGJDcY+GDcn+cBiXiEn+P55PJsmQx4lda31L5AizEtVJ3KeShw4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780545492; c=relaxed/simple;
	bh=SMAFTtvZKj1tGxbRkVNkrcfNuKUXUgt/xlwD1tg2SEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggSZ2Vx1lWENjbMhAJuKQsxWbUTwQWhRoTBXvQ7uhd+KWFKodJQUofgXx/9KtgcfMzVEzyPlLcJeLpTFWSwraqp6bj/toVxNGaNXohYabfq/dyUjQ/7tPlCQAVtcqNzypviI2nSFd8TIc6ELmY3qvp2LH/D57MTxQDzaMJIlHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Z+ZpfeIl; arc=none smtp.client-ip=45.254.49.198
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4103cca53;
	Thu, 4 Jun 2026 11:52:50 +0800 (GMT+08:00)
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
Subject: [PATCH v2 2/4] rpmsg: core: use generic driver_override infrastructure
Date: Thu,  4 Jun 2026 11:52:37 +0800
Message-Id: <20260604035239.1711889-3-runyu.xiao@seu.edu.cn>
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
X-HM-Tid: 0a9e90c32b3b03a1kunm0f81216d28d0c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCQ01KVk5CSBhIGEwZTktMSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Z+ZpfeIlcsyakIp+2dJdmyLiafu+Q1ewvgfSJUPRMq1+iFblMZVbCm2i+mrbvCaWqy5XqZJY3RnWSI4Mb2tDiE/1iHtdla+5Lxr8GEAO+YCShf0DEbXws4w8FrzBlYSjYrbRrsK2uariKlpARqKL0qqAPE6XxKIFH7QlFE6qsh0=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=4m5lAv5Y2vm0X6WsxxKQwzOypiG0pQhWs1EBrVLkQNM=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11474-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:linux@armlinux.org.uk,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:nipun.gupta@amd.com,m:nikhil.agarwal@amd.com,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: B097463CC19

RPMSG still keeps driver_override in bus-private storage.

That private pointer can be updated from the sysfs driver_override
attribute, and also from rpmsg_register_device_override(). Both paths
replace the pointer and can free the old value.

However, driver_match_device() can call rpmsg_dev_match() from
__driver_attach() without holding the device lock, and rpmsg_dev_match()
still dereferences that private pointer directly.

This leaves the match path racing with concurrent driver_override
updates, with the usual risk of comparing against freed memory.

Switch rpmsg to the driver-core driver_override infrastructure. This
removes the private storage, uses device_match_driver_override() for the
locked read in rpmsg_dev_match(), and converts
rpmsg_register_device_override() to device_set_driver_override() so the
in-kernel override path uses the same core-managed storage. With that
storage now owned by struct device, drop the remaining rpmsg transport
release-path frees of rpdev->driver_override as well.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/
Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
drivers/rpmsg/qcom_glink_native.c |  2 --
drivers/rpmsg/rpmsg_core.c        | 41 ++++++--------------------------------
drivers/rpmsg/virtio_rpmsg_bus.c  |  1 -
include/linux/rpmsg.h             |  4 ----
 4 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index e7f7831d37f8..11d3007db5cd 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -358,33 +358,6 @@ rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &rpdev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", rpdev->driver_override);
-	device_unlock(dev);
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
@@ -405,7 +378,6 @@ static struct attribute *rpmsg_dev_attrs[] = {
 	&dev_attr_dst.attr,
 	&dev_attr_src.attr,
 	&dev_attr_announce.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rpmsg_dev);
@@ -424,9 +396,11 @@ static int rpmsg_dev_match(struct device *dev, const struct device_driver *drv)
 	const struct rpmsg_driver *rpdrv = to_rpmsg_driver(drv);
 	const struct rpmsg_device_id *ids = rpdrv->id_table;
 	unsigned int i;
+	int ret;
 
-	if (rpdev->driver_override)
-		return !strcmp(rpdev->driver_override, drv->name);
+	ret = device_match_driver_override(dev, drv);
+	if (ret >= 0)
+		return ret;
 
 	if (ids)
 		for (i = 0; ids[i].name[0]; i++)
@@ -533,6 +507,7 @@ static void rpmsg_dev_remove(struct device *dev)
 
 static const struct bus_type rpmsg_bus = {
 	.name		= "rpmsg",
+	.driver_override = true,
 	.match		= rpmsg_dev_match,
 	.dev_groups	= rpmsg_dev_groups,
 	.uevent		= rpmsg_uevent,
@@ -560,9 +535,7 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 
 	device_initialize(dev);
 	if (driver_override) {
-		ret = driver_set_override(dev, &rpdev->driver_override,
-					  driver_override,
-					  strlen(driver_override));
+		ret = device_set_driver_override(dev, driver_override);
 		if (ret) {
 			dev_err(dev, "device_set_override failed: %d\n", ret);
 			put_device(dev);
@@ -573,8 +546,6 @@ int rpmsg_register_device_override(struct rpmsg_device *rpdev,
 	ret = device_add(dev);
 	if (ret) {
 		dev_err(dev, "device_add failed: %d\n", ret);
-		kfree(rpdev->driver_override);
-		rpdev->driver_override = NULL;
 		put_device(dev);
 	}
 
diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 401a4ece0c97..d9d4468e4cbd 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1626,7 +1626,6 @@ static void qcom_glink_rpdev_release(struct device *dev)
 {
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 
-	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1862,7 +1861,6 @@ static void qcom_glink_device_release(struct device *dev)
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
-	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 5ae15111fb4f..1b8bb05924af 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -374,7 +374,6 @@ static void virtio_rpmsg_release_device(struct device *dev)
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
 	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
 
-	kfree(rpdev->driver_override);
 	kfree(vch);
 }
 
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 83266ce14642..2e40eb54155e 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -41,9 +41,6 @@ struct rpmsg_channel_info {
  * rpmsg_device - device that belong to the rpmsg bus
  * @dev: the device struct
  * @id: device id (used to match between rpmsg drivers and devices)
- * @driver_override: driver name to force a match; do not set directly,
- *                   because core frees it; use driver_set_override() to
- *                   set or clear it.
  * @src: local address
  * @dst: destination address
  * @ept: the rpmsg endpoint of this channel
@@ -53,7 +50,6 @@ struct rpmsg_channel_info {
 struct rpmsg_device {
 	struct device dev;
 	struct rpmsg_device_id id;
-	const char *driver_override;
 	u32 src;
 	u32 dst;
 	struct rpmsg_endpoint *ept;
-- 
2.34.1

