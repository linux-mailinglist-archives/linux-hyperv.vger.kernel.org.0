Return-Path: <linux-hyperv+bounces-2971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A96AF96CDED
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D22E284AC4
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E228193432;
	Thu,  5 Sep 2024 04:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bozavwzq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCB19308A;
	Thu,  5 Sep 2024 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509901; cv=none; b=X97k9P2uW+bZA7Wsp2PyBo8dARktRrbjwYsxPe0XQZzdsWDYKLehp2UPD4DHPrwnugCdSvpO9Hy9Svd4JE/jYQiipLGQax5jFdxoJ8bkI33nh/IekklTJzdJK/AC0NvPi+GBoEGSdjbsuNlk7aJLz6QCwet8OZ25DwgrSZlrZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509901; c=relaxed/simple;
	bh=MHsAD0oZqhdrdbvskc4Y/1xHUoW4vv9RJ2c2ipgeFJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RMzKZMScGi3G8qqt4iqCA9MnfFzYPF8agOL7o3Og+s1A/1e0EayeKMP/eniXs9v83cPly0SKTKZ2HMDnpgOeK6Cx7zUCQByrEEM55sRazYuCbXmyhwUidNQX6Nh0gDI14ENcDm1SXgIWDtZSSPOPj/geDLwS8hMTFTjv6hU/yVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bozavwzq; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e174925b7bso237429eaf.0;
        Wed, 04 Sep 2024 21:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509898; x=1726114698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDTJQsChimFHLTafhuTJQvaUHnDbeVQTacrVKRN5TeI=;
        b=BozavwzqkNkXC3KFqxMCIochr+C75FCHn1Pqt18R60iPYNZJ73Af2SzK/8+cCbxf4E
         seiL65iWUo+IznPW9mQYYFQS4d3G2XwewGKQ/lZiLytZLhfLytzVLzHecqwQTqXmri32
         thrYo1hCc02A7mwAIbPGO2e6MmIXtejaLkq+GOHP02o5thuDS+6U8cRTWMG52fbXOFYL
         2yJDSHh20RTcjHCnDd19NfmqJe8gjNDgirJlTti4eu6uiejXTVnr5LB4WGFOq+iu+X+W
         IjRJUF0m04LFQXKd4mMsXaUinHvNadQCky4fAx2AqpELFsU1xwTJQUUBpko2qgV+CCeH
         WBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509898; x=1726114698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zDTJQsChimFHLTafhuTJQvaUHnDbeVQTacrVKRN5TeI=;
        b=d2UKQITRhzp45njSvY0IM80hnb1rnGfuMlFjwTV/rTpJqACg+kP6bPcxEJmX/dzPqj
         9ece+90BkjHiluh/9AYR1an9D0IC3YMKQmpBU3o2qHc3NhjcP/0GuKauIhI5K1mJwzju
         OMnyxelmPaFT4c95xbRJQXiiHEAgXEpe/JYi8DVBrF/pHtk7f0Fly8cg7MaizedlXkna
         10hBlRS5rx8uwjoRASj9vqFsXqh/i7DWnICXhHUQ8SmHlwTJXoX1LiiwYS1OCH+3k15m
         P0ztO7L6CIoBRNx1mt0f7mNxXnZ5b/tR6AT5I8OahO0tIHZyBSCT07lgncidQfEKg5ys
         LnTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoP+kB6orc532Q1glUbk+GWnENdJ6od5k2U6Y6SO9/QZGNHrEx9L0LmGU7SVgNis0Wkrm24b1NtgxKDmM=@vger.kernel.org, AJvYcCWxhHoz9w9JMr0X5nuDRl3rxQTtkWUNG5IL3bwyRyUVj8DHwIuEyw1qpFm2NBLJhmQBzc8nEO5BGG569tch@vger.kernel.org
X-Gm-Message-State: AOJu0YyFdXqOUYIpYPqTbWHk26wwlfzb6AuSFK4OaQ52kTA7h8F94slh
	wE4wiXLurgYw3b+9NuEOTJcLmQMhNe9Y6GwjXe+iNzcJtINKwbahoew8aQ==
X-Google-Smtp-Source: AGHT+IF0/9UveaFIJMl/u+qc1yPJ7R6KvpVX6O3R+fF7tqh50k2XIbvJeO1Zme0x2qVQgrJC9rNwrA==
X-Received: by 2002:a05:6870:1b17:b0:261:88b:36fe with SMTP id 586e51a60fabf-277c804bfc3mr18648317fac.15.1725509898618;
        Wed, 04 Sep 2024 21:18:18 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:18 -0700 (PDT)
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
Subject: [PATCH 24/24] Input: xilinx_ps2 - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:29 -0700
Message-ID: <20240905041732.2034348-25-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/xilinx_ps2.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 1543267d02ac..0316760168e5 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -155,22 +155,17 @@ static irqreturn_t xps2_interrupt(int irq, void *dev_id)
 static int sxps2_write(struct serio *pserio, unsigned char c)
 {
 	struct xps2data *drvdata = pserio->port_data;
-	unsigned long flags;
 	u32 sr;
-	int status = -1;
 
-	spin_lock_irqsave(&drvdata->lock, flags);
+	guard(spinlock_irqsave)(&drvdata->lock);
 
 	/* If the PS/2 transmitter is empty send a byte of data */
 	sr = in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
-	if (!(sr & XPS2_STATUS_TX_FULL)) {
-		out_be32(drvdata->base_address + XPS2_TX_DATA_OFFSET, c);
-		status = 0;
-	}
+	if (sr & XPS2_STATUS_TX_FULL)
+		return -EAGAIN;
 
-	spin_unlock_irqrestore(&drvdata->lock, flags);
-
-	return status;
+	out_be32(drvdata->base_address + XPS2_TX_DATA_OFFSET, c);
+	return 0;
 }
 
 /**
-- 
2.46.0.469.g59c65b2a67-goog


