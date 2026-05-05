Return-Path: <linux-hyperv+bounces-10633-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLR6GVnz+WmcFQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10633-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:40:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0839D4CEAE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CBE3301AF77
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383A47ECD8;
	Tue,  5 May 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgTWVgBn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5752047DFBF;
	Tue,  5 May 2026 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777988409; cv=none; b=BI/vJ7pFEyqmrqfsw3GdM/NuAweIRQL1SHOT3li7Scuj4dXyEJ7XjyscF4KRQLOXxmXj/lPKRA+diYoG7COe65rfcZnOxXypG1tXyt5hQVoijUx9d7D7IPjLlb+bQsokE/jaoMefZeYBrWzkPaY4kwkzB+8/obkuLhIzAmNbuPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777988409; c=relaxed/simple;
	bh=enQ/kAE46gHWFkx72vT1p5afv0nIyc37eTTmR0xPPp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHTuAHFqrBEK6LQEf4EusjOV3q/hx1eml7TPtMTNiOt9uMUE9Xpav1oTwDi1jRTOR45J/AkWsXcyTF6wMzFiGLAoWdfvhVeNM9wE8uD65i8NxZ7itfT3IF1cX+nchdeLdh56QGKg6Q6mWUy2kcM1sNhoavlhxdm80avCm6dqw1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgTWVgBn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E726C2BCB4;
	Tue,  5 May 2026 13:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777988408;
	bh=enQ/kAE46gHWFkx72vT1p5afv0nIyc37eTTmR0xPPp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgTWVgBn2k2vD++6osj/Kv2LEBVXP4pPJ00tFXFMWSXzbfrkgludFr/5/BH6DB7ci
	 9f7IkJPx12KmXwtpbVwftKqmXqMPjC6Selkp+WVf7O72fm9lrCVEUhpqqMToEywMZx
	 whznVCgNNsmRenBLfdzUEXWBN3DcqVyrKxsjZ/I8nqfnmUPwnI4x2V88PqNFS2sNXA
	 dl8a5obHr8hzsiaQikP/gD+wMuC5mPjl3Ag1pTSNaJezCguayYitHTn55riXn9GG22
	 wHjBuF9gvFDs0pmR75xr9GMB20lcSFS3oK5uBRhGlPKQRjOvjMn9duO26CMuvNcSfe
	 fgdroxm2KJXYQ==
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 5/5] driver core: remove driver_set_override()
Date: Tue,  5 May 2026 15:37:25 +0200
Message-ID: <20260505133935.3772495-6-dakr@kernel.org>
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
X-Rspamd-Queue-Id: 0839D4CEAE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10633-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email]

All buses have been converted from driver_set_override() to the generic
driver_override infrastructure introduced in commit cb3d1049f4ea
("driver core: generalize driver_override in struct device").

Buses now either opt into the generic sysfs callbacks via the
bus_type::driver_override flag, or use device_set_driver_override() /
__device_set_driver_override() directly.

Thus, remove the now-unused driver_set_override() helper.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220789
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.54.0


