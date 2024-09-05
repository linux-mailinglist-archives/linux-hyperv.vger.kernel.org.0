Return-Path: <linux-hyperv+bounces-2965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7104196CDDC
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28E68280F13
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82F1922ED;
	Thu,  5 Sep 2024 04:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZ8jOGk1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F1F18F2C3;
	Thu,  5 Sep 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509893; cv=none; b=fnbpD4C+L5rcWex9qL1Y7LNArYqyoqjZpr7kvnp1IPydP2hXj7FtIhUthOmi9d1FPtNulPXM0Lbwp3GwU1T3p7+DeFatBrnKgxZwC034sCT/JbZXXu8ut2pI37xdQNgw2WIgAwUEqJsmn8SV8uLc0DXqNEIY8KZqTJQi+jEKDus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509893; c=relaxed/simple;
	bh=1ANKjU3VKrs6X/QdpJ9WLabYERlHb97KjzLTZSjxQWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XX41ubWeu+Ujw7qlNLfSu2iLLkclqMqFyxNxJCvagIQCQVXNb9Ji9eqv3uLwlbKO3VnwH46LjVCVJS+a+73VdLJZA8m67fS0zMrdrtg7fbUy37tpEKuVFe2KMKXq825vsAe4+wFSF0Hc6uZ8tMr2df6xPPMfVKTSHdQnY8UNnUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZ8jOGk1; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f6e65d605so210223a34.3;
        Wed, 04 Sep 2024 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509890; x=1726114690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdj97WNnHfmaSgwSXHcMMW5oApE6Xxi6ExD1cTeMbgs=;
        b=FZ8jOGk1yZWfOKa+fHpy5E7ST+zv1Vlz7LYPzbmcgOh1hffumkdJEzb8k6jw5/bQG2
         ogq9NxMdiV4qiXCdzAyTIWT6W6PUiL8MWMjORDoY2jswqNyV8yIAb55XdVsdQXZh0KJd
         SJ53uxXXOF/U35jPYgmmf3f5BOlm4BKhUSLzM5ngZ0MJKRweFq3HLQHTx7gZhGyqaD+K
         iXkRbmwFPbAOnqcquTC4yOxSWk178uu3jiLMDkS0jXa1shHoZo1IPaG3IZoyrDNzCgzd
         Jv4k0mg5LW+kvFScxEGY/E3vNPrNgP8391wlIBDEj+rToL7e6IEOk2dX8QP/v7LdMvHj
         SojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509890; x=1726114690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdj97WNnHfmaSgwSXHcMMW5oApE6Xxi6ExD1cTeMbgs=;
        b=YCTbgSwiIr4kp+viKfC9vgKCaPyyjKhiRZjOdxnED2teIWm9wxvRxHCBEjf3fEPDrz
         mnbMXai55MrBpWpvbblrtGXGteA7BcsG7h0lsrdinXJ3QOYx7GK9rCKQ+9tbLH64KaUF
         fwXd+aVKR3bWFoAgnokfaYid4P6PBdidOXypSrPkR7xixQnYflhdsCxn9D9Zr2ePwM/l
         OofMO35KG9VesrQYo2R+sznOvsB+Q2xrXEGyo2j9qSdEOCUBmWhn+SnHWR30Wt9Mcy2t
         js+Jv4JtA4MxarL+6oRoh4wltYyppCIEz8oSNWLqQYgAIqD9b66zguPxEm39T1avwKjy
         vgiA==
X-Forwarded-Encrypted: i=1; AJvYcCVlUvmvqvtYzgPajtLXNSFkfcSzsameyVZ8KyR7CwFizsWTnWrQyEH5k3yV6KNu+e8m0KH76IBSJDxJnWs=@vger.kernel.org, AJvYcCWPw7HmyKJbgC3wWly/FDn3iz04uMmeN0V0MMxBSxg/boK5dUWHT2aETiIlANmr50nMJAzRdlK/n8fTzkM5@vger.kernel.org
X-Gm-Message-State: AOJu0YxwGAjHTWavlgWkLx9c3f2CkUVu5GKv4Ql46OvOb+6BXIXYpGX9
	Lq7dgT2cW2EI42FOOa2tHWL6+A9gdV03aYsYz2MVbFWrmsJnRPao16ym3w==
X-Google-Smtp-Source: AGHT+IEMAZJeCSqiHRSgN3+WWWCHuQRgdHGicuqXLtwn/x3wJa2d1mAi8u8uVrAj+0Ri9jh32shyow==
X-Received: by 2002:a05:6830:6e8f:b0:70f:7752:3967 with SMTP id 46e09a7af769-70f77523c01mr18497699a34.27.1725509890118;
        Wed, 04 Sep 2024 21:18:10 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:09 -0700 (PDT)
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
Subject: [PATCH 18/24] Input: serport - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:23 -0700
Message-ID: <20240905041732.2034348-19-dmitry.torokhov@gmail.com>
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

Using guard notation makes the code more compact and error handling
more robust by ensuring that locks are released in all code paths
when control leaves critical section.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/serport.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 5a2b5404ffc2..74ac88796187 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -50,11 +50,9 @@ static int serport_serio_write(struct serio *serio, unsigned char data)
 static int serport_serio_open(struct serio *serio)
 {
 	struct serport *serport = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&serport->lock, flags);
+	guard(spinlock_irqsave)(&serport->lock);
 	set_bit(SERPORT_ACTIVE, &serport->flags);
-	spin_unlock_irqrestore(&serport->lock, flags);
 
 	return 0;
 }
@@ -63,11 +61,9 @@ static int serport_serio_open(struct serio *serio)
 static void serport_serio_close(struct serio *serio)
 {
 	struct serport *serport = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&serport->lock, flags);
+	guard(spinlock_irqsave)(&serport->lock);
 	clear_bit(SERPORT_ACTIVE, &serport->flags);
-	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
@@ -118,14 +114,13 @@ static void serport_ldisc_receive(struct tty_struct *tty, const u8 *cp,
 				  const u8 *fp, size_t count)
 {
 	struct serport *serport = tty->disc_data;
-	unsigned long flags;
 	unsigned int ch_flags = 0;
 	int i;
 
-	spin_lock_irqsave(&serport->lock, flags);
+	guard(spinlock_irqsave)(&serport->lock);
 
 	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
-		goto out;
+		return;
 
 	for (i = 0; i < count; i++) {
 		if (fp) {
@@ -146,9 +141,6 @@ static void serport_ldisc_receive(struct tty_struct *tty, const u8 *cp,
 
 		serio_interrupt(serport->serio, cp[i], ch_flags);
 	}
-
-out:
-	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
@@ -246,11 +238,9 @@ static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
 static void serport_ldisc_hangup(struct tty_struct *tty)
 {
 	struct serport *serport = tty->disc_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&serport->lock, flags);
-	set_bit(SERPORT_DEAD, &serport->flags);
-	spin_unlock_irqrestore(&serport->lock, flags);
+	scoped_guard(spinlock_irqsave, &serport->lock)
+		set_bit(SERPORT_DEAD, &serport->flags);
 
 	wake_up_interruptible(&serport->wait);
 }
@@ -258,12 +248,11 @@ static void serport_ldisc_hangup(struct tty_struct *tty)
 static void serport_ldisc_write_wakeup(struct tty_struct * tty)
 {
 	struct serport *serport = tty->disc_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&serport->lock, flags);
+	guard(spinlock_irqsave)(&serport->lock);
+
 	if (test_bit(SERPORT_ACTIVE, &serport->flags))
 		serio_drv_write_wakeup(serport->serio);
-	spin_unlock_irqrestore(&serport->lock, flags);
 }
 
 /*
-- 
2.46.0.469.g59c65b2a67-goog


