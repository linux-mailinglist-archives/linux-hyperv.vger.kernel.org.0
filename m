Return-Path: <linux-hyperv+bounces-2964-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BB996CDD9
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F1111F217B3
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615218FDBB;
	Thu,  5 Sep 2024 04:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILDZvvdl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C3C155326;
	Thu,  5 Sep 2024 04:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509891; cv=none; b=T6VZC9IgZeWX/Xpq63sL5ClwWkKsv22rMpFGGYP+HrPRgAtitocEb92E9p7/k47/mN8akUMlxfgJCIRzbVYKlAEpef99pS1wHvSJ9mvvJVtnLI3+8wawL5Ys0JeSzU2OJlI7J/JOYweCHKSi01W5FlRjZdEWWgmFqqhdfeSiBX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509891; c=relaxed/simple;
	bh=+xmHtxPCJGTBzSClQJ+yBa81QsqtA24ObFByUE16CfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjgekNkN5yBwVKmiTSATAJdSxZN0qWzD34dMvNSGBIx8NQp02kxDXcc2huTZ9gFMhhXb+zGAEusDrNHffCMf3tZ7c/qLYvqRDI7YHE6pu+wUhgDe8IJWxygY4VlFXIDBSfopQ9EA2SfcHfJ4l782oI35+7cx2A8Di7ztdLk5ygE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILDZvvdl; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5df998d7a44so211997eaf.2;
        Wed, 04 Sep 2024 21:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509889; x=1726114689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hL/oJ8v77sFrESpjTE2muwhc7qNiYaOX9Ne/zSSlqk=;
        b=ILDZvvdlmDcttsrNTqqBAHO84NZqZt/83IUvkMUoWkqK6pKqzcWFVUpC3f/2IUyosf
         pTswE1n8oow0OXNn23gQwqbsOA9e2xbhQVfWsCu3zZpI9kJ4jD52R/QtCpFJpSzsUn+F
         InztcWL1ovbZX0PAb0lTZBzYo+kQyEphIJRJP+0mYOOPduw4TfAC7gvSfuHLB3jbBeka
         XQ/k2dK6tvegpxP0zeHd8I7SfMejLylRXMZnTkLnGwxWaUAXHH4CRyRmUy17igwMNP5Z
         vwJvS19Zj1j4e5W1wb9mxo/s4yex6m/FVj58x+7MvIBJJ2L2FZAiai2LtE52GmnVqKkH
         sPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509889; x=1726114689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hL/oJ8v77sFrESpjTE2muwhc7qNiYaOX9Ne/zSSlqk=;
        b=qUuQ+zlzDiDkFpXHwNFNrs4BODF+CcvIgh97twpt6RFAJucdBwexTWWWDCvC8U1aGF
         L+vle/p52C++SHjKAqaX1sPTu2rV3X4wQEHmxbBACeetKw5zgY1WXJqzNC3HBiQ7RP2C
         jZ0FLSZRUI+gRuAB92lgFnTvk0gsvqWmWTxDJqCwjJWCtyWRwCUjwjgzKlFKcWvMX9EN
         y9gCgWjouitm/BEkPdQCK4v9g4aHJ8JpjrqcttlCc2VTQ0CfTfy32tsz45yR9cWpIWxn
         S+BxRtoo02SwwylEt/uyLse5XFTSMqSSpIp5rx+GVuNqf1NXGoLiwOdLAR7joJO8P9oN
         yFug==
X-Forwarded-Encrypted: i=1; AJvYcCULLsLWf8w8TdeIxR+/t7UzTELntAoM2Y9sIagGgsg07leJg0NBKmrxdjFsXHEZ1iEQ0bgaFiRI0SxcFLZt@vger.kernel.org, AJvYcCUMewu8liXtjNyAO5r9BWz1or4O17ldlV519LjeR2/kxtlbOcF6XPPfSqJ1642brybb3JwgyubqK6oJp1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbt7+jpjOPL0GZt1IxblU/ZBtiFbxZaDNGm74SGzU4vvPwAi9b
	6HZQ770gzxd7acG7QxT9SpCbYfCiV9tC8BkwGbQv9/MuZrwWypqT4br9BA==
X-Google-Smtp-Source: AGHT+IHFtlZtt/7jfalAzcdSLrrI2tqquQOXGQfEgeIl9ZKOtYpILy5RI3LJ8SU6F2JK5e0j4C+FUw==
X-Received: by 2002:a05:6359:410e:b0:1b5:fa8a:791b with SMTP id e5c5f4694b2df-1b8117ef578mr1137606955d.23.1725509888625;
        Wed, 04 Sep 2024 21:18:08 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:18:08 -0700 (PDT)
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
Subject: [PATCH 17/24] Input: sa1111ps2 - use guard notation when acquiring spinlock
Date: Wed,  4 Sep 2024 21:17:22 -0700
Message-ID: <20240905041732.2034348-18-dmitry.torokhov@gmail.com>
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
 drivers/input/serio/sa1111ps2.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/sa1111ps2.c b/drivers/input/serio/sa1111ps2.c
index 1311caf7dba4..375c6f5f905c 100644
--- a/drivers/input/serio/sa1111ps2.c
+++ b/drivers/input/serio/sa1111ps2.c
@@ -92,7 +92,8 @@ static irqreturn_t ps2_txint(int irq, void *dev_id)
 	struct ps2if *ps2if = dev_id;
 	unsigned int status;
 
-	spin_lock(&ps2if->lock);
+	guard(spinlock)(&ps2if->lock);
+
 	status = readl_relaxed(ps2if->base + PS2STAT);
 	if (ps2if->head == ps2if->tail) {
 		disable_irq_nosync(irq);
@@ -101,7 +102,6 @@ static irqreturn_t ps2_txint(int irq, void *dev_id)
 		writel_relaxed(ps2if->buf[ps2if->tail], ps2if->base + PS2DATA);
 		ps2if->tail = (ps2if->tail + 1) & (sizeof(ps2if->buf) - 1);
 	}
-	spin_unlock(&ps2if->lock);
 
 	return IRQ_HANDLED;
 }
@@ -113,10 +113,9 @@ static irqreturn_t ps2_txint(int irq, void *dev_id)
 static int ps2_write(struct serio *io, unsigned char val)
 {
 	struct ps2if *ps2if = io->port_data;
-	unsigned long flags;
 	unsigned int head;
 
-	spin_lock_irqsave(&ps2if->lock, flags);
+	guard(spinlock_irqsave)(&ps2if->lock);
 
 	/*
 	 * If the TX register is empty, we can go straight out.
@@ -133,7 +132,6 @@ static int ps2_write(struct serio *io, unsigned char val)
 		}
 	}
 
-	spin_unlock_irqrestore(&ps2if->lock, flags);
 	return 0;
 }
 
-- 
2.46.0.469.g59c65b2a67-goog


