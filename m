Return-Path: <linux-hyperv+bounces-2969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D396CDE8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA33B2322F
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C42192D8D;
	Thu,  5 Sep 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MksIINeG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BA4192B72;
	Thu,  5 Sep 2024 04:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509898; cv=none; b=UlUOo9/8ACMmUpulrwLqK9hjqzJN2Rcz/1DhV6LkTSw8RI2Mf501tCz5lM8ku+m3RY+RLYx8ScTI6Fth83+Th1MIB1l0JLftz+XmQdz4/pW5Zhdpr54k43WKyX/E5PR/nhm0jeNv44yjHz2qEvbddDPPoQ+LthVxkRd7W07qNcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509898; c=relaxed/simple;
	bh=jrCdNxs3nPBprZ1EecOJZBm3IZPKT2/NNteZ18Jw+dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dF67uxbQrbdPiEjeMCjYAjF+QJbbYyz/xD1HaT2penZ034wpXPEvETM5/zyVHmcb57VPbZMDZ1haapWnGbUPK+1ZLFTEXnS5SS0yPHs+YKceilUhjQxCweczw1WqOMoYSbntcfqlDoc8oyZ6vS163FPSFoVgPDbE0UqPxOcyXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MksIINeG; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7093997dffdso168892a34.2;
        Wed, 04 Sep 2024 21:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509896; x=1726114696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz2erQSg3sDaQU8qTCUlHXjZi76BIHFsta/dILnpIUo=;
        b=MksIINeGNGEUAYYwSLfJGv1NFUAFtedZr2Lo7fTMlH7CXEnCtEbfmbJotrbc9JZG6K
         t8r/s1pU7Lq//RG1aEJuD0VL+DNj3s7dx5w9Au8hBvp3izCAGL8zjn/Ko+VCnUNhdr15
         L/RBKivcN5y4bF+VmFDGMfT5++LOM9lkp2Vskx3awHsR+tiIfQ5kDgUosc7zl3DjCwLf
         wsXOqMP+2293xsxpYJzCPaxuorsYbheLpImR860Dni/9fhn08eJc5RoHGTLZna+9i8eF
         yjpi7txTZyQkY4OTBdyHik4JgYFR27Wpm/9VoKx1Hs7JKQiuemi7xjk1NQqlVeCYRFvD
         7b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509896; x=1726114696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz2erQSg3sDaQU8qTCUlHXjZi76BIHFsta/dILnpIUo=;
        b=IHbmg+/rATCGPxFNagOGPXGFQwcRzLGwP7swaoZrbvvFh49lEqcC8zAOcjjKD2qWju
         uJbRri6n/BlHXn5ceKKTSJn9iV8n7pbxCDLxzU8gH2ulzL54ZC7w7+ZfDGVM7gKYBCNF
         hFAc8VfUVe0idGZdSUg2S8gVtiY+QqujmYHYMdObPBLf5GsX0V3qqypkfU+ATWM7ZjMb
         saT4HqED5mCbv/LkVQ0Q3K4OCWDgoRUqDbUZ/rkxprmqQqjdIi//aZv534Tp4y+aTgym
         ksJISKJmEFC4/fj5hLhwz3DPbURQlnJLQihiDx6W0oEPYyad0PPFmU5Dbc1RztlTqpGD
         ZWAw==
X-Forwarded-Encrypted: i=1; AJvYcCV3NX0aOkWHt2jIpX9mP1D23mkb4tdbAUMlLKw8mPMGBW+SuDcdVwcTUVmsn4I86uj5baMh9HuLNFYxlTA=@vger.kernel.org, AJvYcCXj3mXpaGxA8Mj8a1+67Hv5sftOjJCnnVLYaKIW2tCnoh3hBQLv8IHKfgqZPW5h74/EUOuwfdUwml6rHxU3@vger.kernel.org
X-Gm-Message-State: AOJu0YyigFqCBKGgw6DGMYd+wMXEF39o5VQ4yyJCxa3D0Yc06FKtWw1p
	FE6VH5mDgkWyHRzkEogg5G4B4Sdk/XC7B/7m7fXBTYkhEnGjU3A/W1+6DA==
X-Google-Smtp-Source: AGHT+IFPTVGs3vyKg3Li6dflqJQ+JnKv/J7SxlC09OoKIqCCU5IWw2pa42IFrQdn8vuEJ1eR5r+pIw==
X-Received: by 2002:a05:6359:5f8a:b0:1b5:e9e0:2421 with SMTP id e5c5f4694b2df-1b7e37a5389mr2316618255d.6.1725509895909;
        Wed, 04 Sep 2024 21:18:15 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:15 -0700 (PDT)
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
Subject: [PATCH 22/24] Input: sun4i-ps2 - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:27 -0700
Message-ID: <20240905041732.2034348-23-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/sun4i-ps2.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/sun4i-ps2.c b/drivers/input/serio/sun4i-ps2.c
index 95cd8aaee65d..267214ca9b51 100644
--- a/drivers/input/serio/sun4i-ps2.c
+++ b/drivers/input/serio/sun4i-ps2.c
@@ -101,7 +101,7 @@ static irqreturn_t sun4i_ps2_interrupt(int irq, void *dev_id)
 	unsigned int rxflags = 0;
 	u32 rval;
 
-	spin_lock(&drvdata->lock);
+	guard(spinlock)(&drvdata->lock);
 
 	/* Get the PS/2 interrupts and clear them */
 	intr_status  = readl(drvdata->reg_base + PS2_REG_LSTS);
@@ -134,8 +134,6 @@ static irqreturn_t sun4i_ps2_interrupt(int irq, void *dev_id)
 	writel(intr_status, drvdata->reg_base + PS2_REG_LSTS);
 	writel(fifo_status, drvdata->reg_base + PS2_REG_FSTS);
 
-	spin_unlock(&drvdata->lock);
-
 	return IRQ_HANDLED;
 }
 
@@ -146,7 +144,6 @@ static int sun4i_ps2_open(struct serio *serio)
 	u32 clk_scdf;
 	u32 clk_pcdf;
 	u32 rval;
-	unsigned long flags;
 
 	/* Set line control and enable interrupt */
 	rval = PS2_LCTL_STOPERREN | PS2_LCTL_ACKERREN
@@ -171,9 +168,8 @@ static int sun4i_ps2_open(struct serio *serio)
 	rval = PS2_GCTL_RESET | PS2_GCTL_INTEN | PS2_GCTL_MASTER
 		| PS2_GCTL_BUSEN;
 
-	spin_lock_irqsave(&drvdata->lock, flags);
+	guard(spinlock_irqsave)(&drvdata->lock);
 	writel(rval, drvdata->reg_base + PS2_REG_GCTL);
-	spin_unlock_irqrestore(&drvdata->lock, flags);
 
 	return 0;
 }
-- 
2.46.0.469.g59c65b2a67-goog


