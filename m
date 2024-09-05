Return-Path: <linux-hyperv+bounces-2954-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBBC96CDBA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A05D21C22E06
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9782B183CB8;
	Thu,  5 Sep 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htwOStRQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4241714B2;
	Thu,  5 Sep 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509876; cv=none; b=U5d6LIK5oX28ZthgnEzmk4IUXgjWULasOLGn1ICC2ROhVosjluXdsX6QPe6KMNM7hgrJhQegkDg6Qkv1nnzFXdLSrBmOprHffpw8auWqz8LeOU6eXXNg8uHXmvH8I2LdGkrozBAT50U3ZQmF2ATPq5Gs5jeyIGvp7msuA8b1vx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509876; c=relaxed/simple;
	bh=BenMc1sLXCG+5vmkHGPDz29enhWQ1tx8bPuULH06bMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgZmuuOgLLG1gRNyirFC1pM/PfD2W4NS6i7rVkLUi+3BUlcTEydb3R9acruTwm9zERFoMMxrK6305GS7eGrfJdU1tf46z87u+m91AaS8vOICys8P3ZUlzyWqwddc9Xct3DDh/OHhnx6OC6dXLSzeF7VlrTORrlrjhRcdAxH2XEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htwOStRQ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5e017808428so224216eaf.1;
        Wed, 04 Sep 2024 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509874; x=1726114674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8VPXswHBHTUlmDFHKrQ5BC1wv3BR4y3AP5bfe5KlEs=;
        b=htwOStRQ7J6xBt/RMC8R8qa2cIMgxhVe6KJaTNZhIDLAfZPEjJ7S1qcPjlrPb+xOQZ
         kwHqwPGTsyc74GB1ehwt8w9mxdpEJNM4c8b8kDplIlDb7zga0v3ZuTSh0SFQcHIGyf2u
         xC7ggh93hUToCJ9rZg09kCqIWfHOBJ7jnpqESA7J8Zr3bxPkPiAwGyJRn675AzWNu3t0
         ZwLfr9UibxWTs2FhEYc8qwA7qRddm6qVOsisE7ve+7OCycSPSrIA8Ek63Z0vObT/a95d
         S+YS4RI3TnWnDfzDYYeto8/engvdbSm9FaZE0IWWyum55iL2Y0d+qDM5HCrR8Z8xUp1O
         tvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509874; x=1726114674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8VPXswHBHTUlmDFHKrQ5BC1wv3BR4y3AP5bfe5KlEs=;
        b=kvgw+3OKAfj27ukEhVb1NzZGBWUuUhCnS8UWh1LVSLYOT7FwOltqzT7Zm101qd/g+b
         UqGH9BzYEuHcwAConcUQh9xx1TR9cNxm/RHefIfmSdWDgEWbs0PSQXfGsOESuzFf0o/n
         SbcNnyt0hDud12wAM8SE47MemBYp6kxT7nmOsjU8K6G7pZSd6WZc3KGfphejUmBB7yJx
         HNVSnGH76/Ew6/Cx/xyjJnbjKUXvidm5RBQDNJ9hHevpVVbyupV9vuY3bil/xu4sZQSF
         PEIn1l7ZWmpLbaqqXfUjPgIqEET5WrsrC8vV/Hx50UpU9Sg5HU8zgmcZRvH+egHRWWsA
         CEHA==
X-Forwarded-Encrypted: i=1; AJvYcCVCylg8thQF+xqnjEV8+fcmIX6LH2OzRexN4z51jFOLExIUnqqPqkjx3kx1fGkXUU+gpc6zJRZJcq51fnY=@vger.kernel.org, AJvYcCVhfX/Uga+sk7Pu0coT4tLnIZFDN4WHM3qZpKoKdYT53gcjXkow9MG9KbpiZ9LocE8K+HdI7QGBVfYjeUAf@vger.kernel.org
X-Gm-Message-State: AOJu0YxHuYyY9DconNtdle3Zm8cnVXunqwzqgK9pR17t92LA65c2MuMs
	u5yrju1Hu4wO4DL20EP1H7FERJvQEPWpKe+fsdE3Aok3LSoBgYQr7sC1fQ==
X-Google-Smtp-Source: AGHT+IGI2QjJK2UofL6z1AHMX7SrEpAd/PMAyIbsnSlBJf71WYXVl7JagSZR9Rgb4HVgwu3bRh55Vg==
X-Received: by 2002:a05:6358:898:b0:1b8:f18:3e53 with SMTP id e5c5f4694b2df-1b8117bcb29mr1047970355d.9.1725509874043;
        Wed, 04 Sep 2024 21:17:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:53 -0700 (PDT)
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
Subject: [PATCH 07/24] Input: sunkbd - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:12 -0700
Message-ID: <20240905041732.2034348-8-dmitry.torokhov@gmail.com>
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
more robust by ensuring that serio ports are resumed in all code paths
when control leaves critical section.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/sunkbd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/sunkbd.c b/drivers/input/keyboard/sunkbd.c
index 72fb46029710..3299e1919b37 100644
--- a/drivers/input/keyboard/sunkbd.c
+++ b/drivers/input/keyboard/sunkbd.c
@@ -241,9 +241,8 @@ static void sunkbd_reinit(struct work_struct *work)
 
 static void sunkbd_enable(struct sunkbd *sunkbd, bool enable)
 {
-	serio_pause_rx(sunkbd->serio);
-	sunkbd->enabled = enable;
-	serio_continue_rx(sunkbd->serio);
+	scoped_guard(serio_pause_rx, sunkbd->serio)
+		sunkbd->enabled = enable;
 
 	if (!enable) {
 		wake_up_interruptible(&sunkbd->wait);
-- 
2.46.0.469.g59c65b2a67-goog


