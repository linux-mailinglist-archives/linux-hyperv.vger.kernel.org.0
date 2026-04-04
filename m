Return-Path: <linux-hyperv+bounces-9986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 65toD/sn0Wk7GAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-9986-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 17:02:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9610E39B716
	for <lists+linux-hyperv@lfdr.de>; Sat, 04 Apr 2026 17:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48738300D6B5
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 Apr 2026 15:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB7B29DB65;
	Sat,  4 Apr 2026 15:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcd1WH1u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238BA3B7A8;
	Sat,  4 Apr 2026 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775314936; cv=none; b=hXy9wh6iRLHCgPLpwTcrMVazPACLWQ7Nh9iBsM8SymD9oawhjS87W3ieISdwGRqkxuPaO3agP6XPnj0eW8+V/n0gD+GqZAYcfzwKcbbTlbBR2BmRauKV9eOfq3mOPwl+K2JzC3zN0KUzvHiElzZrf0ypqZEr9Pfxj98ZpcnmBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775314936; c=relaxed/simple;
	bh=yS1a8GmMxhd+gaXjsrUMOyEcZUcN2vLf71oRyrhAVkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7whb4p0v2gfusZtNmzpc2g52jEEGYJwWhUfkdYnueaq0aVlNCTCg7MAvWKVqc6K91kFLa9il1ZJMXRQaqmhCo8VXCUU2Zh9MSNm5PXOjGXQ57XJ+RRvOcZVNMk8DUx3DQ7OfD6Ei/IAH07RXc/ud58vcvc9rrLW1G5sjTxG6o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcd1WH1u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BB2C19421;
	Sat,  4 Apr 2026 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775314935;
	bh=yS1a8GmMxhd+gaXjsrUMOyEcZUcN2vLf71oRyrhAVkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcd1WH1uMPDFcW95A5bP6twrmSlGywxDbhV9K4GUdxmnw9OhLho72J9OlIZREDDfv
	 Evf5eg+FhGKnEBZMEi0xrGzL0W0wBBPFC5ZbOalQpNWyhGwDm3HuLGvy/jgjYAq60X
	 Jsa257f9xIzRC/LnmHpxdh9mv/JRHNm7utYMn96WoZP6ZRATrlwe1+3BmjlR9bxRPR
	 tiA87cPHB5ojtZQJ2zSKPbtecnXGON24oyWbrZcP9XuN+XivvmLrVCQGu5orrMZe/a
	 +xDtWMIwREbTcGNYdTKbgyxE7aDCuXqmHaashK055GEOETa+XQlaspyrGVn7GrwOhI
	 UHZOaAkc+kiUA==
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
	Michael Kelley <mhklinux@outlook.com>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH v2] Drivers: hv: vmbus: use generic driver_override infrastructure
Date: Sat,  4 Apr 2026 17:01:49 +0200
Message-ID: <20260404150155.3473682-1-dakr@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <BN7PR02MB414825D0532A1DFE16F3B671D449A@BN7PR02MB4148.namprd02.prod.outlook.com>
References: <BN7PR02MB414825D0532A1DFE16F3B671D449A@BN7PR02MB4148.namprd02.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,lists.ozlabs.org,lists.xenproject.org,lists.infradead.org,kernel.org,outlook.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-9986-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 9610E39B716
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a driver is probed through __driver_attach(), the bus' match()
callback is called without the device lock held, thus accessing the
driver_override field without a lock, which can cause a UAF.

Fix this by using the driver-core driver_override infrastructure taking
care of proper locking internally.

Note that calling match() from __driver_attach() without the device lock
held is intentional. [1]

Tested-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel.org/ [1]
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Fixes: d765edbb301c ("vmbus: add driver_override support")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Changes in v2:
  - Change patch subject and comments according to Michael's suggestion.
---
 drivers/hv/vmbus_drv.c | 43 ++++++++++--------------------------------
 include/linux/hyperv.h |  5 -----
 2 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..ba7326ec6add 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -541,34 +541,6 @@ static ssize_t device_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(device);
 
-static ssize_t driver_override_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
-{
-	struct hv_device *hv_dev = device_to_hv_device(dev);
-	int ret;
-
-	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static ssize_t driver_override_show(struct device *dev,
-				    struct device_attribute *attr, char *buf)
-{
-	struct hv_device *hv_dev = device_to_hv_device(dev);
-	ssize_t len;
-
-	device_lock(dev);
-	len = sysfs_emit(buf, "%s\n", hv_dev->driver_override);
-	device_unlock(dev);
-
-	return len;
-}
-static DEVICE_ATTR_RW(driver_override);
-
 /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
 static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_id.attr,
@@ -599,7 +571,6 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_channel_vp_mapping.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
-	&dev_attr_driver_override.attr,
 	NULL,
 };
 
@@ -711,9 +682,11 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 {
 	const guid_t *guid = &dev->dev_type;
 	const struct hv_vmbus_device_id *id;
+	int ret;
 
-	/* When driver_override is set, only bind to the matching driver */
-	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
+	/* If a driver override is set, only bind to the matching driver */
+	ret = device_match_driver_override(&dev->device, &drv->driver);
+	if (ret == 0)
 		return NULL;
 
 	/* Look at the dynamic ids first, before the static ones */
@@ -721,8 +694,11 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 	if (!id)
 		id = hv_vmbus_dev_match(drv->id_table, guid);
 
-	/* driver_override will always match, send a dummy id */
-	if (!id && dev->driver_override)
+	/*
+	 * If there's a matching driver override, this function should succeed,
+	 * thus return a dummy device ID if no matching ID is found.
+	 */
+	if (!id && ret > 0)
 		id = &vmbus_device_null;
 
 	return id;
@@ -1024,6 +1000,7 @@ static const struct dev_pm_ops vmbus_pm = {
 /* The one and only one */
 static const struct bus_type  hv_bus = {
 	.name =		"vmbus",
+	.driver_override =	true,
 	.match =		vmbus_match,
 	.shutdown =		vmbus_shutdown,
 	.remove =		vmbus_remove,
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index dfc516c1c719..bf689d07d750 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1272,11 +1272,6 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	/*
-	 * Driver name to force a match.  Do not set directly, because core
-	 * frees it.  Use driver_set_override() to set or clear it.
-	 */
-	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.53.0


