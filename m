Return-Path: <linux-hyperv+bounces-2963-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C497996CDD5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 826AB28258A
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7F18E743;
	Thu,  5 Sep 2024 04:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgadB+tS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73B18BC24;
	Thu,  5 Sep 2024 04:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509890; cv=none; b=egjd6u7CDUrssqEVEjHwGa4FyIxlOTTOsUI3eIPf0xA7H0jLAyJeVEEjIOmnF1uMQscJj/0T/5p+sCvBWEFdiLKnY13aQDxl884lMuT9zLlU+05mgfbcK7Xq9O2mOC3oYd1HJ0y42pzLdGdX3IQuBFdoErPOHppq6ZlbDjVtngc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509890; c=relaxed/simple;
	bh=vmkU8MnH9ykeMGj0Lb9zkmS8M2GYo6xV57O1AmagHA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZzPvZ0wrtf10GZcs71oUmuQjrQ8h6PhDUJTykyKJh9btkED7+RobC4tiCHc6JmagEga/8O01ae46Kxq8Wih3RkI4wlaOP8uYpQMgjxAsVC2iiF5jHvaWNPCAmtOpKNJFY5oMs8njl9EgwH2ZodLg5Pi33svs5YdoOKQb3kAZ7Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgadB+tS; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-70f6a7c4dcdso251236a34.1;
        Wed, 04 Sep 2024 21:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509887; x=1726114687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAvYQ5QLNfvwvbAxc5bD+RAm1KaOm8ejwTdtW3p547k=;
        b=LgadB+tSInEwyJcVWdnybnXRLCztZ7tylvRjv5/NU7VvjHpvNBEKWKflfPpDNSgT8y
         OxZbiyKCpkx7+YFPBcVC8rDaK93iMYs8j6PU0M4B9CchglWhALNPWenxz3voVK+XWB9i
         H95VqJwJGoJE0tTdYmjf2+JGQexjin31REqMe5SRmPYroxkJczoYSZdsNVuIL/ka0VYI
         g5faYigh9HwNbbkC8dQTGyE1Nu0qwEOTE4Rgf/hYFpfJY/AgsCungMDpgJiW4lQqxg9n
         WDJdM4DPUPQuDa12dGjS2q/FTyTnSWbOMv9KtBlSzPFeyT0RhrwxL9LJsDr5QHzpXGkf
         PLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509887; x=1726114687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAvYQ5QLNfvwvbAxc5bD+RAm1KaOm8ejwTdtW3p547k=;
        b=Ger0HSCVWF9o5VncgG+rv94rXnPzQPWSiV44ldxEbiAOyZiid9n30+mJSFQ+vAMYMN
         SEtO2IVfZ80wVXHPFdTa9kDPmdhJ+DWK6uq3SJLadA/1oBIymUSADrlqyvXizta/BGuV
         GhMm1udHWPPsuSU2xqpfObwVmkF0S5n/9IDKhJ2pBxJo79OO4jP92K+Wnmc7dUHBjfrA
         PwXTTUUueGKKXkVTp/o9vsBVOusXFH7V9jlXS/YNFBMxRunc6CWMs842eTMMM6gEun0t
         Fd2wRAtWfnvumhBlG+q30kvvp2eC9EZazJqBjTpMFQnvqmzIKvrUBXBOSIzfh6+If9Vk
         8WBA==
X-Forwarded-Encrypted: i=1; AJvYcCUyXwizjy28/W3OKnm+lQwm6geyYk8dJjrKjIsA54WfNhLHxo0IJSO6UjiSbXJQOMdqVmGsq0hEFRJTXQOn@vger.kernel.org, AJvYcCXHjSvOkX58Gx/Pf8Ju03djQ7Juv1FDYVtkZDwnJ7zoG5GIUK/vrn12Oh/CJpv3nbH//phu0CxkfAiy4uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfcUwcuLI1XwGymCeme2HIuoBt0kOjgvDusSebqHMt41jIhBK
	OF9ZVokDjQBHc8cwJQys9oa75L6qmqReRgh4cGmks8Ecji6pTyqdBAnQ2w==
X-Google-Smtp-Source: AGHT+IH8XXYpPAwHhXPSp4iUYFOHjf3DLK6g5FeTGZwm65nE42PqOHWe35HEYgcGmzcKxgF6JQHDJQ==
X-Received: by 2002:a05:6830:618b:b0:703:77bd:9522 with SMTP id 46e09a7af769-710af6baa99mr9458024a34.17.1725509887298;
        Wed, 04 Sep 2024 21:18:07 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:06 -0700 (PDT)
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
Subject: [PATCH 16/24] Input: q40kbd - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:21 -0700
Message-ID: <20240905041732.2034348-17-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/q40kbd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index cd4d5be946a3..cdd5c4ef9b36 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -39,17 +39,14 @@ struct q40kbd {
 static irqreturn_t q40kbd_interrupt(int irq, void *dev_id)
 {
 	struct q40kbd *q40kbd = dev_id;
-	unsigned long flags;
 
-	spin_lock_irqsave(&q40kbd->lock, flags);
+	guard(spinlock_irqsave)(&q40kbd->lock);
 
 	if (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG))
 		serio_interrupt(q40kbd->port, master_inb(KEYCODE_REG), 0);
 
 	master_outb(-1, KEYBOARD_UNLOCK_REG);
 
-	spin_unlock_irqrestore(&q40kbd->lock, flags);
-
 	return IRQ_HANDLED;
 }
 
@@ -60,14 +57,11 @@ static irqreturn_t q40kbd_interrupt(int irq, void *dev_id)
 static void q40kbd_flush(struct q40kbd *q40kbd)
 {
 	int maxread = 100;
-	unsigned long flags;
 
-	spin_lock_irqsave(&q40kbd->lock, flags);
+	guard(spinlock_irqsave)(&q40kbd->lock);
 
 	while (maxread-- && (Q40_IRQ_KEYB_MASK & master_inb(INTERRUPT_REG)))
 		master_inb(KEYCODE_REG);
-
-	spin_unlock_irqrestore(&q40kbd->lock, flags);
 }
 
 static void q40kbd_stop(void)
-- 
2.46.0.469.g59c65b2a67-goog


