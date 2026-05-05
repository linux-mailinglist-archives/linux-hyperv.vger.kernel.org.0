Return-Path: <linux-hyperv+bounces-10629-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LWJJS/z+WmcFQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10629-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:39:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 767524CEA9B
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5AE230028A3
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 13:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106547DD77;
	Tue,  5 May 2026 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HX2jNred"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2CD47DD66;
	Tue,  5 May 2026 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988393; cv=none; b=dMe/TgZ8eUqBGs52yQVJkbHcaoTd1zyCRXqwN0ikdISLvsNagWTheF7M7K+uoWePd1rMqwpFsZ7LVRAOHLAzfzkkrbW1q2zo454qZKqDaqyvSQ3YOLXcV7uTOTP9fsc3GxU1hiJ5S4TERPuIau+QoSySbPw0aaLxMBnjRSKnr10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988393; c=relaxed/simple;
	bh=NcRSyq08XzhT27dPM3OyW2/65CqnGGNof3VyzjgXpkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldukjYD7i4diaP7QRWGcVQv7X7nDhkUohAvEKIwHRbPFFtAKRNQ9WncpzZCRivkgCOpxpmoL8sioeAsWqkzS80PjFThxwelhSsfRE6/RLwQ/l2Sp05NhytCX+gEnTtXZjGwwHVBYFU6K/2ZWyzFSU5fRHtIIbW2t5y6s+TNXOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HX2jNred; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C2CC2BCB9;
	Tue,  5 May 2026 13:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988392;
	bh=NcRSyq08XzhT27dPM3OyW2/65CqnGGNof3VyzjgXpkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HX2jNredAUTkneqERbse6tir4Lsoj6nH/q8unuSBYEE703WCP62DLIp3B79XXeRKR
	 3KBI+rvggdVDcdkGCtgjOqWoSm0z3fYkGNee0pAiAclDQ+eF7HKd4OoigFfhiPl96C
	 YZVDloFrj7BoetPERTvbOC1EPkTwJHSwqHIEu6xisDCPFIqFwrF7r9RIOBSJYWuAwe
	 KsOAFwpdDA6tQKmoLllVRR/IkI9ApElDiS2JJ9zuqo00f1EAjtuaFmVVEm24JvPLFQ
	 dYnxTOb3lvgeeDIelDmdqfKekAxotWYTDvpj9QR2Zo56QDh2T/ARL1Zz7WVsAzOYiU
	 GuAOscXPO+omQ==
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
Subject: [PATCH v2 1/5] amba: use generic driver_override infrastructure
Date: Tue,  5 May 2026 15:37:21 +0200
Message-ID: <20260505133935.3772495-2-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 767524CEA9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10629-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

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
Fixes: 3cf385713460 ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/amba/bus.c       | 37 ++++++-------------------------------
 include/linux/amba/bus.h |  5 -----
 2 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 6d479caf89cb..d721d64a9858 100644
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
@@ -209,10 +181,11 @@ static int amba_match(struct device *dev, const struct device_driver *drv)
 {
 	struct amba_device *pcdev = to_amba_device(dev);
 	const struct amba_driver *pcdrv = to_amba_driver(drv);
+	int ret;
 
 	mutex_lock(&pcdev->periphid_lock);
 	if (!pcdev->periphid) {
-		int ret = amba_read_periphid(pcdev);
+		ret = amba_read_periphid(pcdev);
 
 		/*
 		 * Returning any error other than -EPROBE_DEFER from bus match
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
@@ -436,6 +410,7 @@ static const struct dev_pm_ops amba_pm = {
 const struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_groups	= amba_dev_groups,
+	.driver_override = true,
 	.match		= amba_match,
 	.uevent		= amba_uevent,
 	.probe		= amba_probe,
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
2.54.0


