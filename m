Return-Path: <linux-hyperv+bounces-2958-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52A96CDC6
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4856B288BC9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B0188A1F;
	Thu,  5 Sep 2024 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHa602Pf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCCB188920;
	Thu,  5 Sep 2024 04:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509882; cv=none; b=MjeRPa3Do7Aw7pI2zpvZ1GLZpYj3thYEmCXC5pnqigifmKY0f/0JgJuxMxvbI9zzSh5Qa2AJFK2d6OdUpdDCCZYObKpOYIao59gaE/AZFBqSseIOUrY/0MdSfkgd6tg98z+sHM/VzPUS7ykntz1NB3mSmVvVWZqAQLsQkmtDiz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509882; c=relaxed/simple;
	bh=i9osRIZI2r8pLinAa1PuSzq4Uf0jxagbDh5hgtSxDZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWYavPbpawSBmF8oATxjkGy8Tj99pujbJCwpOQpy9jFK0eAVg7sJPTcRjrO/vl218Utt3PzbhAnT8ez0hsN3Jh0VinHBwAsbs0Cr7pwWr9w73Xqf9jdEKPX6mM3KukCvx5ghc70e0Kwa65J//GGf5IqAvt2YtFU750VtOZcKYyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHa602Pf; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df02c407c4so180216b6e.1;
        Wed, 04 Sep 2024 21:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509880; x=1726114680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wySGI9scoJi4TljRD+Hpmp4oNTGGODlyYEe5tlANPZw=;
        b=aHa602Pf0n975Sm6HlK+2pW/bKvHjAV5We7bFzYUNHPXY5AzzAouMflQwOBPsnee6U
         TG0coeM7EyqtfPtcrG448qm0WbE3qoBzosFaD30cX3WGSEkDN3CJ7670cOcc5bIpDK+r
         QOQ5uRMRfPmXzS3eR1pQzd1L6WEsJT0bu3X86qeuctZvH/T6wbPBcGxEC+AhPxkpV8kz
         1t+7m0lAr6LB9+bIhfa72JZEwYhkebaOarOMtBiXONOze5bcWC/peKZRwx5GTOWbgjr8
         C7ymwERdjI0iVsUv99gGQzbYLPApdUmwdt9Z0N/p6HROJenoC1GYd1ydAa59BOyGb9y1
         maiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509880; x=1726114680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wySGI9scoJi4TljRD+Hpmp4oNTGGODlyYEe5tlANPZw=;
        b=eS+mbq1CQWDwNYz5Vy5GSAbTZNKchYWM7l4IOdqd15J4A3UG8EGPtuuRHKXA4a0oox
         hcITZlFGOeczmKlvLIKvYAjoP3EEf97H1ACTr0Apw0L0Wc2o3K7EoWD7le2l0Ik0JatX
         oo3bmkoaWqi/y+x5Y2Jl0BQ304RBKsW9cVc0kPVPaEsoL+pFRvE5KBTf4d+tdOfG7F0E
         KhFOvjvH+xx2dPQxa1uOmJM0hpMjgPfWsEeT76UrKh7f8VWzP/2jWX3UQwS8GMvuokuJ
         E06xwEGl7SKyuPftBOMEfoF16cO7kxMKEwQ2ig0JiWBGde+3hxirXA1H+wFfVv8WWSKt
         jP0g==
X-Forwarded-Encrypted: i=1; AJvYcCVf/3uaRk131eAXpekEbBS3UR+JNKkM572G4mwyNqa6hvYKFizN/3De6Qmwmq6F+70ufmOsRO/aoz9wfmth@vger.kernel.org, AJvYcCWt8kMLr4sQTD1tm99kIh4unm4atVuhr10EnGywWsKZfCfHy6PXTo2+uDTK3AekH5ZuDVgk9srqglwVlNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ZklvIqogDv+uM9Mj6j724oHTLe7IxotIIGbImVJGBhGk7V+A
	SAre9jQPTa7FI+Ce/oXLK3kaD+XFcv4ijssxqo/60h9YdU0armTOxaCN8w==
X-Google-Smtp-Source: AGHT+IEQOPemQhEEQd4JD206/3mLVfaYjNo57sTDwNHwWOJ0RwSvTidH6chDqJAiBF7WrpAvcYyjrQ==
X-Received: by 2002:a05:6808:11c5:b0:3dc:39e9:e04 with SMTP id 5614622812f47-3df22106d0fmr17555384b6e.20.1725509879905;
        Wed, 04 Sep 2024 21:17:59 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:59 -0700 (PDT)
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
Subject: [PATCH 11/24] Input: hyperv-keyboard - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:16 -0700
Message-ID: <20240905041732.2034348-12-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/hyperv-keyboard.c | 38 +++++++++++++--------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 31d9dacd2fd1..0ee7505427ac 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -102,7 +102,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 {
 	struct hv_kbd_dev *kbd_dev = hv_get_drvdata(hv_dev);
 	struct synth_kbd_keystroke *ks_msg;
-	unsigned long flags;
 	u32 msg_type = __le32_to_cpu(msg->header.type);
 	u32 info;
 	u16 scan_code;
@@ -147,21 +146,22 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		/*
 		 * Inject the information through the serio interrupt.
 		 */
-		spin_lock_irqsave(&kbd_dev->lock, flags);
-		if (kbd_dev->started) {
-			if (info & IS_E0)
-				serio_interrupt(kbd_dev->hv_serio,
-						XTKBD_EMUL0, 0);
-			if (info & IS_E1)
-				serio_interrupt(kbd_dev->hv_serio,
-						XTKBD_EMUL1, 0);
-			scan_code = __le16_to_cpu(ks_msg->make_code);
-			if (info & IS_BREAK)
-				scan_code |= XTKBD_RELEASE;
+		scoped_guard(spinlock_irqsave, &kbd_dev->lock) {
+			if (kbd_dev->started) {
+				if (info & IS_E0)
+					serio_interrupt(kbd_dev->hv_serio,
+							XTKBD_EMUL0, 0);
+				if (info & IS_E1)
+					serio_interrupt(kbd_dev->hv_serio,
+							XTKBD_EMUL1, 0);
+				scan_code = __le16_to_cpu(ks_msg->make_code);
+				if (info & IS_BREAK)
+					scan_code |= XTKBD_RELEASE;
 
-			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
+				serio_interrupt(kbd_dev->hv_serio,
+						scan_code, 0);
+			}
 		}
-		spin_unlock_irqrestore(&kbd_dev->lock, flags);
 
 		/*
 		 * Only trigger a wakeup on key down, otherwise
@@ -292,11 +292,10 @@ static int hv_kbd_connect_to_vsp(struct hv_device *hv_dev)
 static int hv_kbd_start(struct serio *serio)
 {
 	struct hv_kbd_dev *kbd_dev = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_dev->lock, flags);
+	guard(spinlock_irqsave)(&kbd_dev->lock);
+
 	kbd_dev->started = true;
-	spin_unlock_irqrestore(&kbd_dev->lock, flags);
 
 	return 0;
 }
@@ -304,11 +303,10 @@ static int hv_kbd_start(struct serio *serio)
 static void hv_kbd_stop(struct serio *serio)
 {
 	struct hv_kbd_dev *kbd_dev = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&kbd_dev->lock, flags);
+	guard(spinlock_irqsave)(&kbd_dev->lock);
+
 	kbd_dev->started = false;
-	spin_unlock_irqrestore(&kbd_dev->lock, flags);
 }
 
 static int hv_kbd_probe(struct hv_device *hv_dev,
-- 
2.46.0.469.g59c65b2a67-goog


