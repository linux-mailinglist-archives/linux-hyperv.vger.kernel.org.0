Return-Path: <linux-hyperv+bounces-5519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94496AB793E
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 00:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B333E3B2443
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 May 2025 22:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B83B221719;
	Wed, 14 May 2025 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnXxQZ8b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07560819;
	Wed, 14 May 2025 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263315; cv=none; b=ToAJOvFfG55cPukrk/pee8WLu4aNABJhVsqIerCM6VtVNPReZ6Hka16LF3LYUI9qLOsxfT/f84iK8RQdy/9yeNZ0jbwgAgwd6cMFesxwjc6wG6AUJyHXevbqupKos5ZkbPK2bF4xCQ9Hmcp5YZZmM8D0vh9QYMGrC8P6At6U/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263315; c=relaxed/simple;
	bh=ul4p2nhDlYMDAuWjdhI3Qs3UCy4nJe/GHHVMqGsnWk8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=dn2GK/rMkrDJvb8ruashuDkBNOiT7aTClE13bw3tLw6AerY1EFi6WhK2LzIrgQWDNXOXM/5xplfzq5erkwaAC0N+yYxImrqz0ee510gN/vsi9e+0TdFoRM9Yg+gqQskzjFboYPlHqLUviMZ0jgVKVMqiN4HBBhXJDTlj1fJUOTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnXxQZ8b; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30a8cbddca4so411064a91.3;
        Wed, 14 May 2025 15:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747263313; x=1747868113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/xKb1DZ5U5cNTFiCxutLyCHmkLxs6r0FDVO+PvPUrLg=;
        b=VnXxQZ8bxnQTSuh3/E5kRr1rdeKAS8755z6wktLH7/3+csEqunb7Xug86rS6Z4EDI7
         Jv5ObjjVjVigbRKvmAf5So3P8JtpUK6P7twgtzhQxy9ZOWinXStwqZ92Hci8S3YVta2v
         Y7tTc5ibOgHNDUIGUWNLs8Pt91f6E0BufSnIOlQ96Lr/3xnYviXePUyT/EqL0ghRXxwt
         uYReidjA3nGylrea1LGqVhDRHZmaU04yoRip0ui3Dd1IdwOwwlqJvoxVzzubwQ9C0w+R
         qOqFXBjMbUpuYfo6GZAdhlLMWtAAwkHOXeQH5UIDaaQrYEqJD5YXRrc4RD6NjMl3f8vP
         /xDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747263313; x=1747868113;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xKb1DZ5U5cNTFiCxutLyCHmkLxs6r0FDVO+PvPUrLg=;
        b=iX8hAsulD4USY1Ef5L1UDkDrX/cCc5IvFWNhd5z791g8qq+AFe5hTACElGcl3Xow1i
         hAOoQBSyBobQ+tmw2cN1QgFS5kmhKOq2ZBCU8aQs3KAUdkWaN/TmDLID844Q0oJOQqvz
         MmSllCou0IBtZs038zNPd90zpItrilSk77CMnpUhAH55WNOL0pOY7qHpriUnhlBb74sv
         o/lhTgxdcTL0i3aw6RCHvSPQfmYVZNkqWAH2c8goSFFivEUjq2/oeePJsL9soresl1xe
         RJXFoS4rMlVdVGaC7FxQLLZoO42s7InOt6sXiT1vblUkwvebSn/FuoLCKI8fZak1IVGS
         mNkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsNkblZXh6eujH5YNzcrKbdZxg0RbVq0Ax5f0/AB/UcS4N4MncBfsaY85LdVQBhzzGyynWa8yTp/H5jbA=@vger.kernel.org, AJvYcCXoEpgEifnp7Ttdo2yw8W5/m2l8526quYL8OXyplh9ybtsw9ZhlXbx1Dkq4hnRGMCldHXGN6egO+dtFj+cZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyANv6wu5MeMYm8i/oc6gh2kMe75u0b/qLnjlBVPzELBHw83Xsp
	aaaJyo0gGyr8MakNtpw28yBnfQ3tHsZJU+Yi+RuBPGR34b6A3Sg2u9yQZQ==
X-Gm-Gg: ASbGncuixrUyGjzslNZfdjwzEZ2XSCgx+bOid7rHS2m4ADXLD4rMNxlBiooHdkapEjb
	1Sp2opA0QR/MsaRUj2zZfP5DJLDhFO5wMVQb9FLK7araU5+pH2mMQyFm0WuFBWP84QR4elf8neR
	KfxmrzJjJPjc1zpdqKaEoG/h3v2t/KuHXoR8ycXaFncba0HQ+1kinU1yZO+FN5t7YoMdeo4duHo
	AWA3Ykkh9JUIY/D1jRS5zUDHOktKkgV0Fg9qjMhwcTiU9jP6svI+82Ob4QWpBHpaRq6V0z46eq2
	3++AmsR6InC99Vh/vu4YyVc5YguJNmeOkJjCZPSvglHE3L7gZjhNQFh8R/WwGAJOTN2IRi7DiKK
	v9RRywN/sL/SIDntChpG8jhzz6YtUcA==
X-Google-Smtp-Source: AGHT+IEyJTE+N3Qv0f7ttaXIyG/8keAzaKAvXbrbJ7A+pfVCnMeo13WTSc0SglCKvBdgbqiQWQivcw==
X-Received: by 2002:a17:90b:520f:b0:2f6:f32e:90ac with SMTP id 98e67ed59e1d1-30e2e5b70famr8626661a91.11.1747263313131;
        Wed, 14 May 2025 15:55:13 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334019b0sm2304271a91.7.2025.05.14.15.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 15:55:12 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Add comments about races with "channels" sysfs dir
Date: Wed, 14 May 2025 15:55:08 -0700
Message-Id: <20250514225508.52629-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

The VMBus driver code has some inherent races in the creation of the
"channels" sysfs subdirectory and its per-channel numbered subdirectories.
These races have not generally been recognized or understood. Add some
comments to call them out. No code changes.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e3d51a316316..4d4f75f578c7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -707,7 +707,30 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 	return id;
 }
 
-/* vmbus_add_dynid - add a new device ID to this driver and re-probe devices */
+/* vmbus_add_dynid - add a new device ID to this driver and re-probe devices
+ *
+ * This function can race with vmbus_device_register(). This function is
+ * typically running on a user thread in response to writing to the "new_id"
+ * sysfs entry for a driver. vmbus_device_register() is running on a
+ * workqueue thread in response to the Hyper-V host offering a device to the
+ * guest. This function calls driver_attach(), which looks for an existing
+ * device matching the new id, and attaches the driver to which the new id
+ * has been assigned. vmbus_device_register() calls device_register(), which
+ * looks for a driver that matches the device being registered. If both
+ * operations are running simultaneously, the device driver probe function runs
+ * on whichever thread establishes the linkage between the driver and device.
+ *
+ * In most cases, it doesn't matter which thread runs the driver probe
+ * function. But if vmbus_device_register() does not find a matching driver,
+ * it proceeds to create the "channels" subdirectory and numbered per-channel
+ * subdirectory in sysfs. While that multi-step creation is in progress, this
+ * function could run the driver probe function. If the probe function checks
+ * for, or operates on, entries in the "channels" subdirectory, including by
+ * calling hv_create_ring_sysfs(), the operation may or may not succeed
+ * depending on the race. The race can't create a kernel failure in VMBus
+ * or device subsystem code, but probe functions in VMBus drivers doing such
+ * operations must be prepared for the failure case.
+ */
 static int vmbus_add_dynid(struct hv_driver *drv, guid_t *guid)
 {
 	struct vmbus_dynid *dynid;
@@ -1921,7 +1944,8 @@ static const struct kobj_type vmbus_chan_ktype = {
  * ring for userspace to use.
  * Note: Race conditions can happen with userspace and it is not encouraged to create new
  * use-cases for this. This was added to maintain backward compatibility, while solving
- * one of the race conditions in uio_hv_generic while creating sysfs.
+ * one of the race conditions in uio_hv_generic while creating sysfs. See comments with
+ * vmbus_add_dynid() and vmbus_device_register().
  *
  * Returns 0 on success or error code on failure.
  */
@@ -2055,6 +2079,20 @@ int vmbus_device_register(struct hv_device *child_device_obj)
 		return ret;
 	}
 
+	/*
+	 * If device_register() found a driver to assign to the device, the
+	 * driver's probe function has already run at this point. If that
+	 * probe function accesses or operates on the "channels" subdirectory
+	 * in sysfs, those operations will have failed because the "channels"
+	 * subdirectory doesn't exist until the code below runs. Or if the
+	 * probe function creates a /dev entry, a user space program could
+	 * find and open the /dev entry, and then create a race by accessing
+	 * the "channels" subdirectory while the creation steps are in progress
+	 * here. The race can't result in a kernel failure, but the user space
+	 * program may get an error in accessing "channels" or its
+	 * subdirectories. See also comments with vmbus_add_dynid() about a
+	 * related race condition.
+	 */
 	child_device_obj->channels_kset = kset_create_and_add("channels",
 							      NULL, kobj);
 	if (!child_device_obj->channels_kset) {
-- 
2.25.1


