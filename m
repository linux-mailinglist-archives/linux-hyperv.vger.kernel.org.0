Return-Path: <linux-hyperv+bounces-2962-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565BD96CDD2
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2FC284C70
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0D618C345;
	Thu,  5 Sep 2024 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeGquxni"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2141154C0A;
	Thu,  5 Sep 2024 04:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509888; cv=none; b=L+OXDNG5hKpZwhJYbvImxW9v9PYwTT0ReMl2yE3y2DptMsN1TlKgPsFFaLmdpzfb5UpS4gtW6u95HSwp8UzOFoY0F8cujuCM0x0cJxJJ72F/Owa36kSJ1qzJwUB3pOJkJemj5utDOtUWMB/BSHxbd+lZ5uZq/MhntFioEcDNQUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509888; c=relaxed/simple;
	bh=XvngD4VqarzUQtOcte+139wHHgYptJyp/bfLvV9NY2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTt/4u0r+QkS2rD3g+yBWAHox55wRfSxGdOce+ogNftABy1HMc7eea0cyw00cD1xHH/l2UeiNLWvQ1C4vH535iV4hwtjRkJ5bsiMekjYH++m0v27OfLBQt25SjwwLLJhLwiTKRX3fd1FLf1JoaQ0Ad8dX/XcuXoXQk2JpuBHkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeGquxni; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-277e4327c99so232631fac.0;
        Wed, 04 Sep 2024 21:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509886; x=1726114686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RJDHa/X116xPB0VZS9gOnIwjZdjbYo4abWgUGhtfDc=;
        b=UeGquxni+Rmma1j9ZcwU4QBc8VvMNwDw0ei/+zydACzLxPqN21R8lV7LYFDqY8Rpvs
         hvdEXlJtAXQ/XshMajnkutukCJO64zlirAUd9S9LPbYXQQRC5b/Tyf1oyt2AP0/fLSLg
         nykT4lhug+oX0nuOMO/3mfy8CnkQQvVXhOqTCyIFuIVmBBjqCoex3iNgGLRbfG+1RjQt
         Yb2QkHB8TqRlAr4T5UHD6iboQDOCpt6H7/5EALF5P+Cv3k6XKuF0OvQI9W8+8KLG+hCh
         eGLt3juvb/S2vvpzrNvSU5ppIZdIhEwWcCx1mzp0vvq71mjwmsH2AtYbOSYMgSkLHJlg
         oFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509886; x=1726114686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RJDHa/X116xPB0VZS9gOnIwjZdjbYo4abWgUGhtfDc=;
        b=HFyMU2po3hH+jcGsDz8E8MYUSxXZBZv0tnJId5xhUO9qPaXj7T7H3XZoW0Sy/33P1P
         TFKFlgXgSdFIX3IcyozAjcD2yZPdnpO6G2sYS4axi6jtpqGa6htxBvXk2Ck7hMX7eFyG
         hp6lvitU2pKOZVGKOevdfb7GnSTB2z3dnvMkqKQyVEK0uRz8tD/mDmWUjZalZpD/uf2/
         mhznnCPLzFD1nhRL/F22lW38AfUPY2fcJdTBnGeIfe1v8cm3pVWObCY1PA3EILQdjfJ2
         +hH4eD3xpTsiIANhaZGzgKs2BPe/FFonLhLf4kZyxAK7lN0r9WcJc0xe0zz5KeQZ0gUg
         3Fmg==
X-Forwarded-Encrypted: i=1; AJvYcCUlP0GotZ/MN7KznyixEksb8EDdf2Axc/hIVQn1MeSLjf9kmmQYDG+kiKSB8jylsP/kO6ajk9odWFrBlFm2@vger.kernel.org, AJvYcCXDeyP3lbe7J6/8BCnnd4gsCAROt7p5t/tn7jSM2I9LgLV9Bz3La2uDWUT0U0JzwXnBV/Go+yZcNaMNd3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG6YgDqrxgllV9RynekSluah7aJAjOu6zR7qkOGpzFzgzEZv76
	k2fYGOMGKu/KmvXHTl/zp/M4C6QW9Ta7+MwuRmeOc+X8WCCR1X8b6muhPw==
X-Google-Smtp-Source: AGHT+IH6QFeFw4VUowxHMGT9IipF2N4THVz6A6eh0ihPM11BJx1xPLmHqcSlKYJ5qoFGXbsOklObVw==
X-Received: by 2002:a05:6870:6b89:b0:260:ebf7:d0e7 with SMTP id 586e51a60fabf-277d03ac4f7mr18125009fac.15.1725509885896;
        Wed, 04 Sep 2024 21:18:05 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:05 -0700 (PDT)
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
Subject: [PATCH 15/24] Input: ps2mult - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:20 -0700
Message-ID: <20240905041732.2034348-16-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/ps2mult.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/input/serio/ps2mult.c b/drivers/input/serio/ps2mult.c
index 937ecdea491d..b96cee52fc52 100644
--- a/drivers/input/serio/ps2mult.c
+++ b/drivers/input/serio/ps2mult.c
@@ -76,9 +76,8 @@ static int ps2mult_serio_write(struct serio *serio, unsigned char data)
 	struct ps2mult *psm = serio_get_drvdata(mx_port);
 	struct ps2mult_port *port = serio->port_data;
 	bool need_escape;
-	unsigned long flags;
 
-	spin_lock_irqsave(&psm->lock, flags);
+	guard(spinlock_irqsave)(&psm->lock);
 
 	if (psm->out_port != port)
 		ps2mult_select_port(psm, port);
@@ -93,8 +92,6 @@ static int ps2mult_serio_write(struct serio *serio, unsigned char data)
 
 	serio_write(mx_port, data);
 
-	spin_unlock_irqrestore(&psm->lock, flags);
-
 	return 0;
 }
 
@@ -102,11 +99,10 @@ static int ps2mult_serio_start(struct serio *serio)
 {
 	struct ps2mult *psm = serio_get_drvdata(serio->parent);
 	struct ps2mult_port *port = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&psm->lock, flags);
+	guard(spinlock_irqsave)(&psm->lock);
+
 	port->registered = true;
-	spin_unlock_irqrestore(&psm->lock, flags);
 
 	return 0;
 }
@@ -115,11 +111,10 @@ static void ps2mult_serio_stop(struct serio *serio)
 {
 	struct ps2mult *psm = serio_get_drvdata(serio->parent);
 	struct ps2mult_port *port = serio->port_data;
-	unsigned long flags;
 
-	spin_lock_irqsave(&psm->lock, flags);
+	guard(spinlock_irqsave)(&psm->lock);
+
 	port->registered = false;
-	spin_unlock_irqrestore(&psm->lock, flags);
 }
 
 static int ps2mult_create_port(struct ps2mult *psm, int i)
@@ -148,16 +143,12 @@ static int ps2mult_create_port(struct ps2mult *psm, int i)
 
 static void ps2mult_reset(struct ps2mult *psm)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&psm->lock, flags);
+	guard(spinlock_irqsave)(&psm->lock);
 
 	serio_write(psm->mx_serio, PS2MULT_SESSION_END);
 	serio_write(psm->mx_serio, PS2MULT_SESSION_START);
 
 	ps2mult_select_port(psm, &psm->ports[PS2MULT_KBD_PORT]);
-
-	spin_unlock_irqrestore(&psm->lock, flags);
 }
 
 static int ps2mult_connect(struct serio *serio, struct serio_driver *drv)
@@ -234,11 +225,10 @@ static irqreturn_t ps2mult_interrupt(struct serio *serio,
 {
 	struct ps2mult *psm = serio_get_drvdata(serio);
 	struct ps2mult_port *in_port;
-	unsigned long flags;
 
 	dev_dbg(&serio->dev, "Received %02x flags %02x\n", data, dfl);
 
-	spin_lock_irqsave(&psm->lock, flags);
+	guard(spinlock_irqsave)(&psm->lock);
 
 	if (psm->escape) {
 		psm->escape = false;
@@ -285,7 +275,6 @@ static irqreturn_t ps2mult_interrupt(struct serio *serio,
 	}
 
  out:
-	spin_unlock_irqrestore(&psm->lock, flags);
 	return IRQ_HANDLED;
 }
 
-- 
2.46.0.469.g59c65b2a67-goog


