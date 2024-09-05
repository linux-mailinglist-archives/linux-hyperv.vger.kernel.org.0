Return-Path: <linux-hyperv+bounces-2952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2896CDB5
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41541F2354A
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A817A595;
	Thu,  5 Sep 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvTyAI9t"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8A1714BE;
	Thu,  5 Sep 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509874; cv=none; b=kOGXJvGwkWlWhC53qL68E2vgE81GjehidsNveAuH2MoQxxR5JaiwIFFBKem7YDFyQgTqd6STD6+9iBwPMAvR6oJYP5VBIRzUl5q81Yx2JP4iL8fvJNyR30hInURirF4ThhdeYmdqWNC+cOx6RWTcZH8TG47SdKoOeRLZkmKq4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509874; c=relaxed/simple;
	bh=GTMszsxFP3FUMteNDzoBJGZ+be0o81i435ERu6zYnMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VupOeacwCV5ptDU1PIgRirrZT+cGzPbrdSEbMLAmhHg5n3EZmEZcmUNSGjCrYnfqseZvTXq/3NenI9/fFFqciV+GZJQFycMy/5qhDs3oCidxcmwrFVpmf9bzqXNWxwHsNqAv9TasdhRczpCfAKSM2Sv84zL9WETnp4mM8cswNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvTyAI9t; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3df07fe03acso184744b6e.3;
        Wed, 04 Sep 2024 21:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509871; x=1726114671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0EXapSSsCRGMYSuYgIhJLIKriJqRLmvnrfU3aGsX6c=;
        b=bvTyAI9t2F9FolUWhSfgWsFF76fJQKw/NTnf6MxDFuLyOqVpdimQVaZ1+wT27+DLWi
         DWX+4POH3AUmGRcIp4oHUyOJXgYCy8e/iGgWa4a5MkwRxOepHGpBoBtgkcRK2Y2GextX
         XysEp4PrbP/WbhIv4MhQbYbj/6kWU+kI1iFPmyyMuahYflH30ajZxnrmAUd2B534Hg41
         eK7Y669/eF8AtBfeS/MThboiY6JNnBPJuKFNQaDWdFZzNm6Ih6Q/FOK1xY1fM0cUlerb
         MVvHdCOhUsOq4rRSv1F6FAfpW5WLFaCSvJUYY7aXTZ3BAAvM+CAkq2oNXo30LFXE9lDn
         bk9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509871; x=1726114671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0EXapSSsCRGMYSuYgIhJLIKriJqRLmvnrfU3aGsX6c=;
        b=Csz8xXMmUJZRSFm0S0BMbgdqKbGGlqSoAivBIHfb35PPrFZMXciWnA1BwadD3xEitw
         ODI5G90H8kZyLY2VhSBY2PAXFqpscUPjGRypJMcNVY5M6vkUizEof4H1f86Pd2xuBDMf
         ZyL9S/khwIUNGbkASlocT1GaIh8rSAB7QvBDnbbGV4Qv7sSSNFqPl5IHYoMMe7L5b+V1
         GAXU8rXJxgz5+lgvA6++kaA4/zDnKVUnkGPGfmU9L0H85NjJi4HkktEki9g7a16+kHeF
         zw9HUw97MANHJu9zo/8papEtstUXbeu7ORmbcYTIjnE/4+xd2AbMMr4OmlkXxtifOK6Y
         1Iqg==
X-Forwarded-Encrypted: i=1; AJvYcCWOTJJZ9cypeDQDFozCE+ENlaVn4fE3E/tIOsdmN0lpGvdRYTCTbK+adPZjyFiyKv1/XEvMF/7aIAo7An3W@vger.kernel.org, AJvYcCWSWzq3TjN1naNXWO/bX4TQQJ5CljpV0D65z8xpA9jgBvWSMKgRwPIbIsqfCpXsUUqZczad3NKXkkvmtnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw8qIXODev4bu5WrgtsWYSHo1ZBsGkpJy1oddJADS/OobbXm+M
	710NivqtcZlTAPy0GX30xzfri9lfthTKNFJqr26QH3Mo4jMJp3pRy+KAPA==
X-Google-Smtp-Source: AGHT+IGhPGvVxRbF3Iu8u5rEKkCm3Ue+quK2XnAYIQLdPlMcym1uORvuIvaEIla7+lCAvI2New5hng==
X-Received: by 2002:a05:6808:3197:b0:3da:aae9:7182 with SMTP id 5614622812f47-3df1d5b87b5mr19628930b6e.2.1725509871047;
        Wed, 04 Sep 2024 21:17:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:50 -0700 (PDT)
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
Subject: [PATCH 05/24] Input: synaptics - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:10 -0700
Message-ID: <20240905041732.2034348-6-dmitry.torokhov@gmail.com>
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
 drivers/input/mouse/synaptics.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 380aa1614442..2735f86c23cc 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -650,9 +650,8 @@ static int synaptics_pt_start(struct serio *serio)
 	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	struct synaptics_data *priv = parent->private;
 
-	serio_pause_rx(parent->ps2dev.serio);
+	guard(serio_pause_rx)(parent->ps2dev.serio);
 	priv->pt_port = serio;
-	serio_continue_rx(parent->ps2dev.serio);
 
 	return 0;
 }
@@ -662,9 +661,8 @@ static void synaptics_pt_stop(struct serio *serio)
 	struct psmouse *parent = psmouse_from_serio(serio->parent);
 	struct synaptics_data *priv = parent->private;
 
-	serio_pause_rx(parent->ps2dev.serio);
+	guard(serio_pause_rx)(parent->ps2dev.serio);
 	priv->pt_port = NULL;
-	serio_continue_rx(parent->ps2dev.serio);
 }
 
 static int synaptics_is_pt_packet(u8 *buf)
-- 
2.46.0.469.g59c65b2a67-goog


