Return-Path: <linux-hyperv+bounces-2970-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83DC96CDEA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E828569E
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A0619309A;
	Thu,  5 Sep 2024 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6+uJdtz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BEC192D78;
	Thu,  5 Sep 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509899; cv=none; b=qHvyryyUImFZCOm+qyaZ4jZg+TkmgkuUFit80UpCXfpG6h8kHofoRAX3OVw84nQd1RUVHDndE46r+7YXGlm2qYOu4i4WNVIDCBvc4cQ6sbOPCxEz/T3lNn5h3G89fw9JngBnCPkiDrH3oEjeWLeGa49RiZDVzcySDkHL+UsgDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509899; c=relaxed/simple;
	bh=5GigJjEmPSDI+ItuxoJq+Z/lu1obXOo3IU5s0mY7pME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QN9XLDrVJs7WcsVEAxdCi20F4lRT6c7ZISxEMQb2jTSqSwL0b1PEKYwnINMkOCwg6agOMlwdjsO/JD4Vq8JBj5P0ybz0WowRFmxzKEQ5WnjqW/YBPEkEDWPYsyaRKTnEDG+gSg2xwMnn7Ec28r7tn9qY+zIkr7CbdtAWAUySshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6+uJdtz; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7176212de5cso259886b3a.0;
        Wed, 04 Sep 2024 21:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509897; x=1726114697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KAMMGFcdQQuvbLfMZ1RSK1JtSdD6Ii5X8caybj72d5Y=;
        b=j6+uJdtz87BaWwSrLuBzdxwgLAeDjAyxJoYGj6oRAUrR8bRXoOAygP3ly085Qc6jWg
         0q+L2ybXqFmBA7SSK8QVY7A6oh4vVGrej3t1Xyq2QS1UDR/1rrY5Cab8WVwW3p3lvCZx
         3/1xh9utyIYz9hn5Wz4vG0kENC8Y9dUUV2SiD40xvGU5LeASO75DT9sPacNAltUyJJ4O
         snMX2L87GNbG9trjhDOzn+eeabpsXt/TObzoolZXtUDoFVn6OUeLwi1niGiLlmQRZdYD
         yd54SiBFgs3LAh74DxiKtTaA2r66mQFexkD2qYz/P0xLa5aIvq+xYD3gPSnBSNF0CQAR
         XV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509897; x=1726114697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAMMGFcdQQuvbLfMZ1RSK1JtSdD6Ii5X8caybj72d5Y=;
        b=G30iSwnkcu3cWZbBCOthJO685moH14siwFR/YrIwGi3SUiohl14xH1poImS8shbl3l
         YZcarJHWPXh+gVeGWwaz9T1oWoyzcnyJQT5Qc+eRsxBU2hlIhK+dY8rrHhyANFHGf268
         MegV0vJ3Bruo/BVDrDc08H4eX6Kl4fZlJYfm0+pGjv+KYZJ6WC6QvTp6vmi2TFazbBEh
         LfA4avDNYXOF2+gzp6N6Rrh0g53+H48w4bGXhQOt4i4y5y/vzFxufx4fpOciqXwF8xrg
         7CsjV7ufaBjVBqT7eLFILGhiZPEMb6FJxWuQsfn5BkgE1D7fG051UtYVpR6pnUY+L2Uq
         HP4g==
X-Forwarded-Encrypted: i=1; AJvYcCVJS32CMaNsoev0D2NBRjmqQvGpv8VzKPA0Mh2fzzEfqobir8IllTfvnOYoA8DCoQqdwdaYQHq3O6Xxipk=@vger.kernel.org, AJvYcCWjbN+MvD7VfXzoIRCOg/NBGpv+eTburEXZCv00yW30HF1VEBqgDAT7J/p3EvF+IIrTcPoGe5js8wIA7DEy@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSWT870WvKduz4DRzl9YCEJTwf9HxSlLLEBmlMtvTpiVoqD+l
	wVUkZTGHV9a/d9U/8hjOU3e6I9GKDyKurHhLEaVv4fVm/QCXI2hNAjuZdA==
X-Google-Smtp-Source: AGHT+IFRCdJkRXUogbTin1hoFmZGnh04XwNGpXWLmx6ydoLDsoywhBNvkL2ZX38vN1+wCOtB2uPKFA==
X-Received: by 2002:a05:6a00:3e1c:b0:70d:2a4d:2eeb with SMTP id d2e1a72fcca58-7173c1e3e18mr16886428b3a.3.1725509897218;
        Wed, 04 Sep 2024 21:18:17 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Helge Deller <deller@gmx.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Samuel Holland <samuel@sholland.org>,
	Lyude Paul <thatslyude@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 23/24] Input: userio - switch to using cleanup functions
Date: Wed,  4 Sep 2024 21:17:28 -0700
Message-ID: <20240905041732.2034348-24-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
References: <20240905041732.2034348-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use __free() and guard() primitives to simplify the code and error
handling.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/userio.c | 141 +++++++++++++++++------------------
 1 file changed, 70 insertions(+), 71 deletions(-)

diff --git a/drivers/input/serio/userio.c b/drivers/input/serio/userio.c
index a88e2eee55c3..66c9838a1fa7 100644
--- a/drivers/input/serio/userio.c
+++ b/drivers/input/serio/userio.c
@@ -55,18 +55,15 @@ struct userio_device {
 static int userio_device_write(struct serio *id, unsigned char val)
 {
 	struct userio_device *userio = id->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&userio->buf_lock, flags);
+	scoped_guard(spinlock_irqsave, &userio->buf_lock) {
+		userio->buf[userio->head] = val;
+		userio->head = (userio->head + 1) % USERIO_BUFSIZE;
 
-	userio->buf[userio->head] = val;
-	userio->head = (userio->head + 1) % USERIO_BUFSIZE;
-
-	if (userio->head == userio->tail)
-		dev_warn(userio_misc.this_device,
-			 "Buffer overflowed, userio client isn't keeping up");
-
-	spin_unlock_irqrestore(&userio->buf_lock, flags);
+		if (userio->head == userio->tail)
+			dev_warn(userio_misc.this_device,
+				 "Buffer overflowed, userio client isn't keeping up");
+	}
 
 	wake_up_interruptible(&userio->waitq);
 
@@ -75,9 +72,8 @@ static int userio_device_write(struct serio *id, unsigned char val)
 
 static int userio_char_open(struct inode *inode, struct file *file)
 {
-	struct userio_device *userio;
-
-	userio = kzalloc(sizeof(*userio), GFP_KERNEL);
+	struct userio_device *userio __free(kfree) =
+			kzalloc(sizeof(*userio), GFP_KERNEL);
 	if (!userio)
 		return -ENOMEM;
 
@@ -86,15 +82,13 @@ static int userio_char_open(struct inode *inode, struct file *file)
 	init_waitqueue_head(&userio->waitq);
 
 	userio->serio = kzalloc(sizeof(*userio->serio), GFP_KERNEL);
-	if (!userio->serio) {
-		kfree(userio);
+	if (!userio->serio)
 		return -ENOMEM;
-	}
 
 	userio->serio->write = userio_device_write;
-	userio->serio->port_data = userio;
+	userio->serio->port_data = userio;;
 
-	file->private_data = userio;
+	file->private_data = no_free_ptr(userio);
 
 	return 0;
 }
@@ -118,14 +112,32 @@ static int userio_char_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static size_t userio_fetch_data(struct userio_device *userio, u8 *buf,
+				size_t count, size_t *copylen)
+{
+	size_t available, len;
+
+	guard(spinlock_irqsave)(&userio->buf_lock);
+
+	available = CIRC_CNT_TO_END(userio->head, userio->tail,
+				    USERIO_BUFSIZE);
+	len = min(available, count);
+	if (len) {
+		memcpy(buf, &userio->buf[userio->tail], len);
+		userio->tail = (userio->tail + len) % USERIO_BUFSIZE;
+	}
+
+	*copylen = len;
+	return available;
+}
+
 static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
 				size_t count, loff_t *ppos)
 {
 	struct userio_device *userio = file->private_data;
 	int error;
-	size_t nonwrap_len, copylen;
-	unsigned char buf[USERIO_BUFSIZE];
-	unsigned long flags;
+	size_t available, copylen;
+	u8 buf[USERIO_BUFSIZE];
 
 	/*
 	 * By the time we get here, the data that was waiting might have
@@ -135,21 +147,8 @@ static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
 	 * of course).
 	 */
 	for (;;) {
-		spin_lock_irqsave(&userio->buf_lock, flags);
-
-		nonwrap_len = CIRC_CNT_TO_END(userio->head,
-					      userio->tail,
-					      USERIO_BUFSIZE);
-		copylen = min(nonwrap_len, count);
-		if (copylen) {
-			memcpy(buf, &userio->buf[userio->tail], copylen);
-			userio->tail = (userio->tail + copylen) %
-							USERIO_BUFSIZE;
-		}
-
-		spin_unlock_irqrestore(&userio->buf_lock, flags);
-
-		if (nonwrap_len)
+		available = userio_fetch_data(userio, buf, count, &copylen);
+		if (available)
 			break;
 
 		/* buffer was/is empty */
@@ -176,40 +175,21 @@ static ssize_t userio_char_read(struct file *file, char __user *user_buffer,
 	return copylen;
 }
 
-static ssize_t userio_char_write(struct file *file, const char __user *buffer,
-				 size_t count, loff_t *ppos)
+static int userio_execute_cmd(struct userio_device *userio,
+			      const struct userio_cmd *cmd)
 {
-	struct userio_device *userio = file->private_data;
-	struct userio_cmd cmd;
-	int error;
-
-	if (count != sizeof(cmd)) {
-		dev_warn(userio_misc.this_device, "Invalid payload size\n");
-		return -EINVAL;
-	}
-
-	if (copy_from_user(&cmd, buffer, sizeof(cmd)))
-		return -EFAULT;
-
-	error = mutex_lock_interruptible(&userio->mutex);
-	if (error)
-		return error;
-
-	switch (cmd.type) {
+	switch (cmd->type) {
 	case USERIO_CMD_REGISTER:
 		if (!userio->serio->id.type) {
 			dev_warn(userio_misc.this_device,
 				 "No port type given on /dev/userio\n");
-
-			error = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		if (userio->running) {
 			dev_warn(userio_misc.this_device,
 				 "Begin command sent, but we're already running\n");
-			error = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 
 		userio->running = true;
@@ -220,32 +200,51 @@ static ssize_t userio_char_write(struct file *file, const char __user *buffer,
 		if (userio->running) {
 			dev_warn(userio_misc.this_device,
 				 "Can't change port type on an already running userio instance\n");
-			error = -EBUSY;
-			goto out;
+			return -EBUSY;
 		}
 
-		userio->serio->id.type = cmd.data;
+		userio->serio->id.type = cmd->data;
 		break;
 
 	case USERIO_CMD_SEND_INTERRUPT:
 		if (!userio->running) {
 			dev_warn(userio_misc.this_device,
 				 "The device must be registered before sending interrupts\n");
-			error = -ENODEV;
-			goto out;
+			return -ENODEV;
 		}
 
-		serio_interrupt(userio->serio, cmd.data, 0);
+		serio_interrupt(userio->serio, cmd->data, 0);
 		break;
 
 	default:
-		error = -EOPNOTSUPP;
-		goto out;
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static ssize_t userio_char_write(struct file *file, const char __user *buffer,
+				 size_t count, loff_t *ppos)
+{
+	struct userio_device *userio = file->private_data;
+	struct userio_cmd cmd;
+	int error;
+
+	if (count != sizeof(cmd)) {
+		dev_warn(userio_misc.this_device, "Invalid payload size\n");
+		return -EINVAL;
+	}
+
+	if (copy_from_user(&cmd, buffer, sizeof(cmd)))
+		return -EFAULT;
+
+	scoped_cond_guard(mutex_intr, return -EINTR, &userio->mutex) {
+		error = userio_execute_cmd(userio, &cmd);
+		if (error)
+			return error;
 	}
 
-out:
-	mutex_unlock(&userio->mutex);
-	return error ?: count;
+	return count;
 }
 
 static __poll_t userio_char_poll(struct file *file, poll_table *wait)
-- 
2.46.0.469.g59c65b2a67-goog


