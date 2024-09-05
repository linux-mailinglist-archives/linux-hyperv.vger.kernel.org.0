Return-Path: <linux-hyperv+bounces-2950-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 523EA96CDAE
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851141C22709
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E91156968;
	Thu,  5 Sep 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyX28won"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3915574D;
	Thu,  5 Sep 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509870; cv=none; b=dsZIFF80rI8NO6kMNxaVStQwN6YP3ilMC7V43bTWDAxhizXWY3cgeu4f7gJxlFRdU4sNBmFKz8TrYd166888WU+/6V96Vv7e6TuenSxnAQukD60bY6U+xlMwQjCVnu58+WStcx9xeKJW5J9xrus2E/PjuXCIIP8FePpzKLWEsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509870; c=relaxed/simple;
	bh=z+lGZlowZLX9dvF58rYUpc9T2wArxI80gBzLlyOWaSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4e/BNTIwsXG9wbcZn0ZyY9kiCZJViGg4XG9q2CG1KK7LojuPhntPEiSHgvs8BdbsxY1Nlk0nULPh48KtomHaeAT23BUQsoo6CDFBGxzhqv8tRnLjprUGmpetfl+HoCQM2drKQoH23OmSujkrc3ZcNIv/X4BKC/4IykTW0E5heA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kyX28won; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70f6732a16dso268004a34.3;
        Wed, 04 Sep 2024 21:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509868; x=1726114668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOurL+niKTuTYRrWkCUZcFZDU3uO6ZkmtonuLPtkVjM=;
        b=kyX28wonQbYyvWDeyqReX2vVHkqPHyV1Wm9zdD8yWnATI49DMsOGFp6uQAgcRCTSzF
         ZKqtKlQX4VaS4gUi7JkxkI4i4GdSPRxDhDyWOybwyuRrF7iN+PL+ipLb3+bZiFluT4Py
         ln+XorXJe8wBai5cIqgdWLx0AmYbWflawXvai4/8F3ArPByVjd4GEc2zHiY6747CAxMn
         5JTY4j4cpB89yLJxA8760ZHvX/1zc/OmKvCwN4nXcRZDzs1a2pPOAhcjaLuF4UHe6ALJ
         GJLUWQ9v6Tz53uH4uUwcnU1dZkNi4PPME0qaDPS5nahhghqa///qlM/LJrjxSfOD75Jl
         VdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509868; x=1726114668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOurL+niKTuTYRrWkCUZcFZDU3uO6ZkmtonuLPtkVjM=;
        b=DyTQBJ1UfDlzuSjtMFQs5JhxrwoNTVzeij6MGvVHvMoZs7iQ+KQABbWCvdlmq2XGaM
         xkibIsHMguVvolABnHKlyk75U9zB95J7aY6oUo04mKCvcROyvLbHWYyhhhjL6JZGIwwB
         7HyWsIkk2tPBPXk2b0TY3r6zMoligQOTg+FELiv/dUu6PPsIcRlsHhKWd3VUWeTShZNk
         laKNXB1yAFvopJ6+0q5VzHq209QW2boJQA04Nt4hT/BTslSEVcWZ2VFEjaYUlfDDNgTE
         GkLL+PEudGHJzKm7hL0kw660Tl+oyLtGSr6pt15+b+qJwlR7Hy++Ahgt+pIS0j94+l2Z
         Ff1w==
X-Forwarded-Encrypted: i=1; AJvYcCUn8J5RuhlcHMl0jO1xMmgiNF9sBIPUofRhkDy4x23k3DT6+K9fBNK2qcipPOS8+d3I8TAebaqUvZN2D0qW@vger.kernel.org, AJvYcCXFKRweE8X4uVLvlFo1HCQzavMa+peSODx3DZnMMUmv2aKeT9FRrY9+f5kOkAnoDLwHBrsosZisKrRdTqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8blRhDXhmEcOD8Q0gvcMOe0PF+lNshTQ9gyn6kBKHtWrZeprT
	TASMX+NEGo09dGSPNGZjxYeu1CSZ1Fc0NgF5YEhc2NnP03Y4ypEVUUhY9A==
X-Google-Smtp-Source: AGHT+IGv36a3rXrN6zFd3TS7W1uho2zPf6Uqpg1TIUhSE/xaGckBL/aTYfQZ78HZQTFPboprAViM+w==
X-Received: by 2002:a05:6830:268f:b0:70a:948c:6b3f with SMTP id 46e09a7af769-710aada57c6mr9102268a34.12.1725509868353;
        Wed, 04 Sep 2024 21:17:48 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:47 -0700 (PDT)
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
Subject: [PATCH 03/24] Input: alps - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:08 -0700
Message-ID: <20240905041732.2034348-4-dmitry.torokhov@gmail.com>
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
 drivers/input/mouse/alps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4e37fc3f1a9e..0728b5c08f02 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1585,7 +1585,7 @@ static void alps_flush_packet(struct timer_list *t)
 	struct alps_data *priv = from_timer(priv, t, timer);
 	struct psmouse *psmouse = priv->psmouse;
 
-	serio_pause_rx(psmouse->ps2dev.serio);
+	guard(serio_pause_rx)(psmouse->ps2dev.serio);
 
 	if (psmouse->pktcnt == psmouse->pktsize) {
 
@@ -1605,8 +1605,6 @@ static void alps_flush_packet(struct timer_list *t)
 		}
 		psmouse->pktcnt = 0;
 	}
-
-	serio_continue_rx(psmouse->ps2dev.serio);
 }
 
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
-- 
2.46.0.469.g59c65b2a67-goog


