Return-Path: <linux-hyperv+bounces-9724-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIRqD0bkwWnLXgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9724-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:09:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A84300490
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 02:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17B933142E6B
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2026 01:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB437EFF7;
	Tue, 24 Mar 2026 01:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLAmVR6g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AB123EAB0;
	Tue, 24 Mar 2026 01:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774314088; cv=none; b=MV5ViPufvcxZLp6lYOZU9EuJXDVanlC9nKqdacvdQPVNO1sDVIZz87zvX3vp4oANRnegtkIt/BSKCr6eUvjD5CJfhJdhwWHcSix/yx2jP6mNSICquRgOPi6a/5xm54bBYpcEiC1R01mKVtt2k/WKDB664YC0GABucpDRuvuYdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774314088; c=relaxed/simple;
	bh=KpxTlQdpK2jKnd62P5I8EEqT3CEkSotjkNoM+lvw6Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4LSTj0Rg4rK6KZ+W4mHDCzkVVLaCZWx3Vn9ruf1FNrfMYs3np1aZj7aA4jloOdvTe11JHey/EcXmxJOWkjsdm3CTmk3gaOAz3qKWdaKXM0+P9Cdnv1phyzymc9QgjSWTKriMQcruVXDK6lcGsIRT4UzISai3BMPJPaidC73YhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLAmVR6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0E8C4CEF7;
	Tue, 24 Mar 2026 01:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774314087;
	bh=KpxTlQdpK2jKnd62P5I8EEqT3CEkSotjkNoM+lvw6Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rLAmVR6groUQSZRplygjMn68KJDDiLrGR9Vctd6Afc3mLDKzHEaYGbMFZ3KXs4fK4
	 MUoXCr/h6SfvTEE4yAlc7KGjraQ8CFJXtGn8f5BkmJWMm1J/pjXgfy9qXciydDWGLj
	 XNYlWwVjufJG5KD0z7v9ARc0FuEyAjjiYRe15HPbrYCuuNFi4/b/eyHrklVGEVsCSm
	 lE5k5muPCMjo/9hKdfl5T5LohS8mNpZoGcTFibqf76OQzdeH43NHUrx9bEVbSisncq
	 g/N4LXJNuBtUlzaGXa8b6D8KnPgXir5STaz/+AS+2urYkPCvbB6vpDfKREYcWyPp9d
	 47Lib8DntPlsA==
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
Subject: [PATCH 12/12] driver core: remove driver_set_override()
Date: Tue, 24 Mar 2026 01:59:16 +0100
Message-ID: <20260324005919.2408620-13-dakr@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9724-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A7A84300490
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

All buses have been converted from driver_set_override() to the generic
driver_override infrastructure introduced in commit cb3d1049f4ea
("driver core: generalize driver_override in struct device").

Buses now either opt into the generic sysfs callbacks via the
bus_type::driver_override flag, or use device_set_driver_override() /
__device_set_driver_override() directly.

Thus, remove the now-unused driver_set_override() helper.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/base/driver.c         | 75 -----------------------------------
 include/linux/device/driver.h |  2 -
 2 files changed, 77 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 8ab010ddf709..7ed834f7199c 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -30,81 +30,6 @@ static struct device *next_device(struct klist_iter *i)
 	return dev;
 }
 
-/**
- * driver_set_override() - Helper to set or clear driver override.
- * @dev: Device to change
- * @override: Address of string to change (e.g. &device->driver_override);
- *            The contents will be freed and hold newly allocated override.
- * @s: NUL-terminated string, new driver name to force a match, pass empty
- *     string to clear it ("" or "\n", where the latter is only for sysfs
- *     interface).
- * @len: length of @s
- *
- * Helper to set or clear driver override in a device, intended for the cases
- * when the driver_override field is allocated by driver/bus code.
- *
- * Returns: 0 on success or a negative error code on failure.
- */
-int driver_set_override(struct device *dev, const char **override,
-			const char *s, size_t len)
-{
-	const char *new, *old;
-	char *cp;
-
-	if (!override || !s)
-		return -EINVAL;
-
-	/*
-	 * The stored value will be used in sysfs show callback (sysfs_emit()),
-	 * which has a length limit of PAGE_SIZE and adds a trailing newline.
-	 * Thus we can store one character less to avoid truncation during sysfs
-	 * show.
-	 */
-	if (len >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	/*
-	 * Compute the real length of the string in case userspace sends us a
-	 * bunch of \0 characters like python likes to do.
-	 */
-	len = strlen(s);
-
-	if (!len) {
-		/* Empty string passed - clear override */
-		device_lock(dev);
-		old = *override;
-		*override = NULL;
-		device_unlock(dev);
-		kfree(old);
-
-		return 0;
-	}
-
-	cp = strnchr(s, len, '\n');
-	if (cp)
-		len = cp - s;
-
-	new = kstrndup(s, len, GFP_KERNEL);
-	if (!new)
-		return -ENOMEM;
-
-	device_lock(dev);
-	old = *override;
-	if (cp != s) {
-		*override = new;
-	} else {
-		/* "\n" passed - clear override */
-		kfree(new);
-		*override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(driver_set_override);
-
 /**
  * driver_for_each_device - Iterator for devices bound to a driver.
  * @drv: Driver we're iterating.
diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
index bbc67ec513ed..aa3465a369f0 100644
--- a/include/linux/device/driver.h
+++ b/include/linux/device/driver.h
@@ -160,8 +160,6 @@ int __must_check driver_create_file(const struct device_driver *driver,
 void driver_remove_file(const struct device_driver *driver,
 			const struct driver_attribute *attr);
 
-int driver_set_override(struct device *dev, const char **override,
-			const char *s, size_t len);
 int __must_check driver_for_each_device(struct device_driver *drv, struct device *start,
 					void *data, device_iter_t fn);
 struct device *driver_find_device(const struct device_driver *drv,
-- 
2.53.0


