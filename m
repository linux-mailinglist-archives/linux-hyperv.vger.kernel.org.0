Return-Path: <linux-hyperv+bounces-2961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E54F96CDCF
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1EBA285479
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954C18B49A;
	Thu,  5 Sep 2024 04:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ljD7Mk73"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815B014A0B7;
	Thu,  5 Sep 2024 04:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509886; cv=none; b=ZutwQijYEDPYzp3kubf4diBaYwDf40EjX4NRCJm5vSpxlVH4CFTQO6lMoSan4EUEbJj1sJlrYwdzfbuYH1QeJtWZOnfEe1cK6VZb9GYXyF1jzbxtC1bxsojR3UJ+49bYjx39V+6bEHTuFLZnkWgw3NvxnC8p+d5CHavLgf0whqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509886; c=relaxed/simple;
	bh=6OZz/CQ5C04CYHdb2al2sR2aCuKWbUvrddF0iZDtVw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXHHTpflfyGAMSsRI37UbI+S4hyuZp3uiUOSMamEby7p56Si9Gf34+BRaUGB/szehF7FfLOws+EpKNPwNIuhs3lC41bL2krx53zvxlxTPMUi8qb0hkXR31LmzrdBNZFwxJlIOZmjGyEbF494LsTEHsA7FE/HXfCvHx/58zni2Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ljD7Mk73; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-70f6a7c4dcdso251221a34.1;
        Wed, 04 Sep 2024 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509884; x=1726114684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3btFCntery0ta6nV0jjerZVdR60/Gk5jQnmpE6Mqz8=;
        b=ljD7Mk73zUhiF6Tl5xKQYRZPAMrHI41kgfxhWyjUXJIz+08F3SYBZohHM1URC8bvU0
         TjVkT8qeqygdCvqQ+YDvuoYfVRC8F9AY9FBz5TpRRWeiOpc0cPmG9ZdLQWfMKZ0QJoBK
         qFXwuOYWy5JSwm7OBPL58ZQ88t1YZaFJvbKh63McheN6xesAFZezOYrta+KcY03KjtcO
         EUrntRXrRJOoG2/wru/ueSMPY/Lxxgf1U9SxOjhwJ1C5/QgsFjWXMUu6F7qyIbgj7AsA
         1UeE4AZTU9k7sTmzYiNGgYa2WNYp7EGWMda1RzQ+78YOEPZZIU69SR7TqKaMxMnlsyNv
         2z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509884; x=1726114684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3btFCntery0ta6nV0jjerZVdR60/Gk5jQnmpE6Mqz8=;
        b=EISWYRP7+pU17x5/zSD1qiNebpNK8mYkKt0Uk1vswXgIvWlL3+0xBxj+C7IG/BBmP2
         FynMSAAxaUFQj3rB+eBmYgVKsJTlw9nCpyvGgdTG6gBuOpIf1CT4Yktjlsr1Zjh6KbvV
         p5milQwGJ3f17wVaGd43pT3itnumF6WO+iigeF03jWaxp5aAMuEwc6/1VERVKDG1azwr
         N6KQG3jqj8cSssjvL1NPJjn/6kP0MnFD+8WpNubmU1TaIlUdDPlEEhFqhgSWtNKzFgf2
         9pU88CeQRcF/btCwWtIuU/MWK3brepw7LlYVufYEHTYtgmoS8rbTSMYUt18ucvXwQ5OS
         6r/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlLkhvFeFVO+h8x0MeFc2kPF9bPPXiwjccmAvtjGfJB/za0D83SbIUbTEFbnDJVLBbfI/f/m8jKs4MC14=@vger.kernel.org, AJvYcCVAjJIZNxHI/av6YYWTfe/iI71VYLh/OwfnM2r+ZT7wMkKpIsZxh420T2Kpx6cKevtRnUPCSaOE3VjHLSpx@vger.kernel.org
X-Gm-Message-State: AOJu0YyJXA/gu16XVZm+l9Q0ti6InjkWUDD0w7/02ddoNeLyICyva0pf
	2e6t4Lz9z1HRKl+hV9/+YzoX48WbPs/XKu/+vWipF7WCAkvln0LwA6/ZjA==
X-Google-Smtp-Source: AGHT+IFL+aSox2tT+ROcWimEdBXmALGnwGMrd8DuDbiXAmTxOicOS1tEjKJAt+iSvmj/V84cB+BBpg==
X-Received: by 2002:a05:6830:349b:b0:709:4793:8757 with SMTP id 46e09a7af769-710af68fc2fmr8717442a34.2.1725509884434;
        Wed, 04 Sep 2024 21:18:04 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:04 -0700 (PDT)
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
Subject: [PATCH 14/24] Input: ps2-gpio - use guard notation when acquiring mutex
Date: Wed,  4 Sep 2024 21:17:19 -0700
Message-ID: <20240905041732.2034348-15-dmitry.torokhov@gmail.com>
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
more robust by ensuring that mutexes are released in all code paths
when control leaves critical section.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/ps2-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index 0c8b390b8b4f..c9c382989e55 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -133,12 +133,12 @@ static int ps2_gpio_write(struct serio *serio, unsigned char val)
 	int ret = 0;
 
 	if (in_task()) {
-		mutex_lock(&drvdata->tx.mutex);
+		guard(mutex)(&drvdata->tx.mutex);
+
 		__ps2_gpio_write(serio, val);
 		if (!wait_for_completion_timeout(&drvdata->tx.complete,
 						 msecs_to_jiffies(10000)))
 			ret = SERIO_TIMEOUT;
-		mutex_unlock(&drvdata->tx.mutex);
 	} else {
 		__ps2_gpio_write(serio, val);
 	}
-- 
2.46.0.469.g59c65b2a67-goog


