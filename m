Return-Path: <linux-hyperv+bounces-9722-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI7UM2DlwWkYXwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9722-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:14:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D66300604
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 384C3306A04E
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 01:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037336DA16;
	Tue, 24 Mar 2026 01:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erU7fvhz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99681ACA;
	Tue, 24 Mar 2026 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314068; cv=none; b=mMm/T3BRFFp5sYTc+AZ+dU8XWe7Viq5iBG3nxNs9mkk1/xxg7wRXJKx4FUKj5ZpaKYHhdjuZVu6d9crYBoJdaruHgsS51j03OnDFdwZQyghfjuZXpEuyHtOfClsob/hARziekDxlg+P2Lly3mp65Rp+3KV8lEZ5cCzkyhZ33FAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314068; c=relaxed/simple;
	bh=A7+ilLlUptt8NahoteAzf0RgIRgwKuFBHYBpfbQD/9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5NVkRfPG+yFRveexDWi3ejtqeh7POuy/lOtInHRoimQdK5na70FCm/fZOg94ItBvEajm9UyqVJUzEjmGUX8o6xO8lKjE3dj4Mcog5gvtpMBv/RnuGRBBrYlWJCJrTsd2TjXK6V2WW5OiuRwNMfkz5pvvngtCZ8ctpM+d5E2DEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erU7fvhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931DBC2BCB0;
	Tue, 24 Mar 2026 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314068;
	bh=A7+ilLlUptt8NahoteAzf0RgIRgwKuFBHYBpfbQD/9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=erU7fvhzJv2tp5KrkKrqx+Erdif01ZeeUOpNA4f3SMGY5Zd3volrXG0e/GJE1PA+4
	 eGQrxZX3PAs12r5SMw5wVj3Dru900+u5sZlt2HAhjsWXohecP7okhBQJqUVMGYmK9x
	 t4JpMcZVTz48+PY+wk5zYrMxets8K+lB6YlpzvSaaUxQizoh9N8ogOZ6kZFkBtVUt/
	 +2U/I6kRnURbopqcXHThSae0+v5nsjA+MtxnO1+6Qp2DXSnViA+Sg/1CnS+DYaIbv9
	 MmwreYV6dk6ePxO92r/nW6iGASWXgbC1mouwugaLRXGpdUBgdYK22pwqvUSENOqNbX
	 RFBSTYbpYZsGA==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 10/12] s390/ap: use generic driver_override infrastructure
Date: Tue, 24 Mar 2026 01:59:14 +0100
Message-ID: <20260324005919.2408620-11-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9722-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_TO(0.00)[armlinux.org.uk,linuxfoundation.org,kernel.org,nxp.com,amd.com,microsoft.com,google.com,gmx.de,linaro.org,linux.ibm.com,redhat.com,linux.alibaba.com,shazbot.org,suse.com,epam.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15D66300604
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the AP masks are updated via apmask_store() or aqmask_store(),
ap_bus_revise_bindings() is called after ap_attr_mutex has been
released.

This calls __ap_revise_reserved(), which accesses the driver_override
field without holding any lock, racing against a concurrent
driver_override_store() that may free the old string, resulting in a
potential UAF.

Fix this by using the driver-core driver_override infrastructure, which
protects all accesses with an internal spinlock.

Note that unlike most other buses, the AP bus does not check
driver_override in its match() callback; the override is checked in
ap_device_probe() and __ap_revise_reserved() instead.

Also note that we do not enable the driver_override feature of struct
bus_type, as AP - in contrast to most other buses - passes "" to
sysfs_emit() when the driver_override pointer is NULL. Thus, printing
"\n" instead of "(null)\n".

Additionally, AP has a custom counter that is modified in the
corresponding custom driver_override_store().

Fixes: d38a87d7c064 ("s390/ap: Support driver_override for AP queue devices")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/s390/crypto/ap_bus.c   | 34 +++++++++++++++++-----------------
 drivers/s390/crypto/ap_bus.h   |  1 -
 drivers/s390/crypto/ap_queue.c | 24 ++++++------------------
 3 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index d652df96a507..f24e27add721 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -859,25 +859,24 @@ static int __ap_queue_devices_with_id_unregister(struct device *dev, void *data)
 
 static int __ap_revise_reserved(struct device *dev, void *dummy)
 {
-	int rc, card, queue, devres, drvres;
+	int rc, card, queue, devres, drvres, ovrd;
 
 	if (is_queue_dev(dev)) {
 		struct ap_driver *ap_drv = to_ap_drv(dev->driver);
 		struct ap_queue *aq = to_ap_queue(dev);
-		struct ap_device *ap_dev = &aq->ap_dev;
 
 		card = AP_QID_CARD(aq->qid);
 		queue = AP_QID_QUEUE(aq->qid);
 
-		if (ap_dev->driver_override) {
-			if (strcmp(ap_dev->driver_override,
-				   ap_drv->driver.name)) {
-				pr_debug("reprobing queue=%02x.%04x\n", card, queue);
-				rc = device_reprobe(dev);
-				if (rc) {
-					AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
-						    __func__, card, queue);
-				}
+		ovrd = device_match_driver_override(dev, &ap_drv->driver);
+		if (ovrd > 0) {
+			/* override set and matches, nothing to do */
+		} else if (ovrd == 0) {
+			pr_debug("reprobing queue=%02x.%04x\n", card, queue);
+			rc = device_reprobe(dev);
+			if (rc) {
+				AP_DBF_WARN("%s reprobing queue=%02x.%04x failed\n",
+					    __func__, card, queue);
 			}
 		} else {
 			mutex_lock(&ap_attr_mutex);
@@ -928,7 +927,7 @@ int ap_owned_by_def_drv(int card, int queue)
 	if (aq) {
 		const struct device_driver *drv = aq->ap_dev.device.driver;
 		const struct ap_driver *ap_drv = to_ap_drv(drv);
-		bool override = !!aq->ap_dev.driver_override;
+		bool override = device_has_driver_override(&aq->ap_dev.device);
 
 		if (override && drv && ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
 			rc = 1;
@@ -977,7 +976,7 @@ static int ap_device_probe(struct device *dev)
 {
 	struct ap_device *ap_dev = to_ap_dev(dev);
 	struct ap_driver *ap_drv = to_ap_drv(dev->driver);
-	int card, queue, devres, drvres, rc = -ENODEV;
+	int card, queue, devres, drvres, rc = -ENODEV, ovrd;
 
 	if (!get_device(dev))
 		return rc;
@@ -991,10 +990,11 @@ static int ap_device_probe(struct device *dev)
 		 */
 		card = AP_QID_CARD(to_ap_queue(dev)->qid);
 		queue = AP_QID_QUEUE(to_ap_queue(dev)->qid);
-		if (ap_dev->driver_override) {
-			if (strcmp(ap_dev->driver_override,
-				   ap_drv->driver.name))
-				goto out;
+		ovrd = device_match_driver_override(dev, &ap_drv->driver);
+		if (ovrd > 0) {
+			/* override set and matches, nothing to do */
+		} else if (ovrd == 0) {
+			goto out;
 		} else {
 			mutex_lock(&ap_attr_mutex);
 			devres = test_bit_inv(card, ap_perms.apm) &&
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 51e08f27bd75..04ea256ecf91 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -166,7 +166,6 @@ void ap_driver_unregister(struct ap_driver *);
 struct ap_device {
 	struct device device;
 	int device_type;		/* AP device type. */
-	const char *driver_override;
 };
 
 #define to_ap_dev(x) container_of((x), struct ap_device, device)
diff --git a/drivers/s390/crypto/ap_queue.c b/drivers/s390/crypto/ap_queue.c
index 3fe2e41c5c6b..ca9819e6f7e7 100644
--- a/drivers/s390/crypto/ap_queue.c
+++ b/drivers/s390/crypto/ap_queue.c
@@ -734,26 +734,14 @@ static ssize_t driver_override_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
-	struct ap_queue *aq = to_ap_queue(dev);
-	struct ap_device *ap_dev = &aq->ap_dev;
-	int rc;
-
-	device_lock(dev);
-	if (ap_dev->driver_override)
-		rc = sysfs_emit(buf, "%s\n", ap_dev->driver_override);
-	else
-		rc = sysfs_emit(buf, "\n");
-	device_unlock(dev);
-
-	return rc;
+	guard(spinlock)(&dev->driver_override.lock);
+	return sysfs_emit(buf, "%s\n", dev->driver_override.name ?: "");
 }
 
 static ssize_t driver_override_store(struct device *dev,
 				     struct device_attribute *attr,
 				     const char *buf, size_t count)
 {
-	struct ap_queue *aq = to_ap_queue(dev);
-	struct ap_device *ap_dev = &aq->ap_dev;
 	int rc = -EINVAL;
 	bool old_value;
 
@@ -764,13 +752,13 @@ static ssize_t driver_override_store(struct device *dev,
 	if (ap_apmask_aqmask_in_use)
 		goto out;
 
-	old_value = ap_dev->driver_override ? true : false;
-	rc = driver_set_override(dev, &ap_dev->driver_override, buf, count);
+	old_value = device_has_driver_override(dev);
+	rc = __device_set_driver_override(dev, buf, count);
 	if (rc)
 		goto out;
-	if (old_value && !ap_dev->driver_override)
+	if (old_value && !device_has_driver_override(dev))
 		--ap_driver_override_ctr;
-	else if (!old_value && ap_dev->driver_override)
+	else if (!old_value && device_has_driver_override(dev))
 		++ap_driver_override_ctr;
 
 	rc = count;
-- 
2.53.0


