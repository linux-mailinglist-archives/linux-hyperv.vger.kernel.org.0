Return-Path: <linux-hyperv+bounces-2955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 051DA96CDBD
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F511C22369
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8218661B;
	Thu,  5 Sep 2024 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx/iADOE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0D153BED;
	Thu,  5 Sep 2024 04:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509878; cv=none; b=KR7aI0hqgHDlDe+U8i7JoCJuQlXai9p8P48sA5JMvYjdu0XhCiuLThgG6GfK/ANDqRvSBIJnxZvL1y6Ny+8mEHlKMpCHgf+jOozWu88klVAXpyOdPevmgzybXU0D/xY4YUtEliBua35nH7uihDOYQdL0bnd6Bz9LnnekINL75P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509878; c=relaxed/simple;
	bh=YBqMCDM4+M0yOaTIf2DxfFz/daeISV5+YgDaRESvbI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TPMWkMBEqjdsH8V52ax5ldELfCQB0CSoUexmK1B3w7gz9auFZZyW6c9KUmOO13anXIvIaXCuX9xdzxwiYbQq+DWf2JM0rqIylr+oQ5EeisZ1Vz4t/4OAHpqEZz+P+vYfVE2x1KG/sj6qgjQBhLARhGvWa/FNL4mNGilIVyiGSOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx/iADOE; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70f73ca989aso254898a34.2;
        Wed, 04 Sep 2024 21:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509875; x=1726114675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mhjJvDJNhv2xHoY3ut/g1TUbMfaB7j2eg1v0tOHhm4=;
        b=fx/iADOEB7g7DI+kFxafGPr83AiTBoDcuNdMucXXAL8S4adUfYdUIeQ353WZNTJXRt
         LDHD9lnUf942LWuXzEOpt1zXEgcAdWOjpRzOiHpkKcYi6ciCsyn6/VcHuaRjLHlwzXGG
         btWphKyg8sKr4WDmKm7qhqx0AAxw03ylpDM1TCKYnX2q03J0gSzzFMMxQSlqDVKgpxEV
         dnc76N4caZeAl8HkJBVHZKQlY1g6VAA7XBbeBdfJxte5ak9qNvmfpzJqBdBCd4xLGrpx
         Wz9xSuclJBwkrYz9BKOqYAsLBhdIYQlODBo1VpW8nW2ZVlJpvYmVECjGmLvTLpN/CPgb
         KlMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509875; x=1726114675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mhjJvDJNhv2xHoY3ut/g1TUbMfaB7j2eg1v0tOHhm4=;
        b=V51QZdI7BZx1TBHFv5uKHTxknGbcF+Qhvow2XC78W6R2w6CvHxE+gzkeJ9xBuBWd7Y
         xFxxNVOeWk1Q/gRBxPu6bR5ysIGEJhNvLwk5xjmhaCENorJe4jXvrDbz9IJBn+iF91O9
         pS4OjNA4tsxy3susq4/Tpa1mDidUa3rxgCnw2eYchdOX1PVXlT2JHWzOLVT9J/BKycBR
         12PWYYuNzfo/QWknF1ewpFTz0TINBBNhJpWVhAnPSUx1iasgzijCIhTRTbDk2cyU/792
         nhvQRJ8T8X3s0K8pAKBMGivNZqVG5o+FD2r9odeDtaGqDsocmQtoNgr4yr5s/zlH2Ilv
         t0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3LU+r0ddrUGLdSwiDayFTZ9VFvP2x5Qzgcl5/Rk/WqKnbdAPkNNvuWc+VWNYbxirEQvv5tOmKz6MQjIw=@vger.kernel.org, AJvYcCW8tjbKMgjy+AF20wZD6bEM+ECIyUOLWzaxk2mvMmjVb0RHl2WsGDr9izSzWfSDJUCBeF7Q5gS9VkdZwwVP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9iQKCZaWySNYrRmAxxyaLc4Q5u81W1JX4WOURyRzsIZfCNG7E
	9Skk6pG8R9j6M0zd2sKCa88Pz1DHIWkgQW2zqiUTzfOnGIziuCcA6qwwdg==
X-Google-Smtp-Source: AGHT+IH0JYEg6QtSOGjiEfpDAKUS/a7YvjIKxseySaiP7VkfsPIL/Y4j2nA5ofHv3vaP5pULVvdK1g==
X-Received: by 2002:a05:6359:5f9e:b0:1b5:a36f:cf52 with SMTP id e5c5f4694b2df-1b603bee046mr2609562155d.2.1725509875510;
        Wed, 04 Sep 2024 21:17:55 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:55 -0700 (PDT)
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
Subject: [PATCH 08/24] Input: synaptics-rmi4 - use guard notation when pausing serio port in F03
Date: Wed,  4 Sep 2024 21:17:13 -0700
Message-ID: <20240905041732.2034348-9-dmitry.torokhov@gmail.com>
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
 drivers/input/rmi4/rmi_f03.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f03.c b/drivers/input/rmi4/rmi_f03.c
index 1e11ea30d7bd..e1157ff0f00a 100644
--- a/drivers/input/rmi4/rmi_f03.c
+++ b/drivers/input/rmi4/rmi_f03.c
@@ -61,14 +61,14 @@ void rmi_f03_commit_buttons(struct rmi_function *fn)
 	struct f03_data *f03 = dev_get_drvdata(&fn->dev);
 	struct serio *serio = f03->serio;
 
-	serio_pause_rx(serio);
+	guard(serio_pause_rx)(serio);
+
 	if (serio->drv) {
 		serio->drv->interrupt(serio, PSMOUSE_OOB_EXTRA_BTNS,
 				      SERIO_OOB_DATA);
 		serio->drv->interrupt(serio, f03->overwrite_buttons,
 				      SERIO_OOB_DATA);
 	}
-	serio_continue_rx(serio);
 }
 
 static int rmi_f03_pt_write(struct serio *id, unsigned char val)
-- 
2.46.0.469.g59c65b2a67-goog


