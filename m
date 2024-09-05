Return-Path: <linux-hyperv+bounces-2953-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B2B96CDB7
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42255289290
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403C817B514;
	Thu,  5 Sep 2024 04:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbU5zWSh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3064176AD7;
	Thu,  5 Sep 2024 04:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509875; cv=none; b=jqJZ/6JEokeAHldV12K9AluDzr7oPayycdRahUznM0F1WuMqGp9XF4Wc+U9Ab+7Mu45wO0u5U+UjWg9IWJHoEfsCI8qMwf0oRNsHV/aIL3cskC9LDBS5gCuzzwzDp0c89mzwj9AYjXjv0WvY31rcBGcmcrD/ufWJ9q7dI+sEjUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509875; c=relaxed/simple;
	bh=K3lNfpiPv/q6z+V6V8RF6mvsiNWEY/iFwwY6BFi6TGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9wwwuNMs0A1WXFSFEfiEp5rAyhJD/bSeEMSb2VB0fAsXgKvZF/MAsWfvKRE3SC8GpD5bEZva5i64zj2FP8e+GXNgK+f6IJMBj2ksKwggd1xV1OsTeqO7ijI+6qwNiR095AHJFBM0kqZOMq5HKvsTOgIItIKQJZb4o/+HdbYGUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbU5zWSh; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd830e0711so220030a12.0;
        Wed, 04 Sep 2024 21:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509873; x=1726114673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7/TrOieKDmokvB+76CstcAo/MHXLXuZvmD2LpyYQbI=;
        b=XbU5zWShgI/YkYhjSPPQow7zNGaV49Y9dd7lD3xz56fnSPzXjCS7+VmHfMTRGx6vQR
         JKjsTJKn43z+Ff4PzeDupAuP2jx9QPMzccPergBh5mzrndzm0xNnPQpCV7GHG+XWz2Ao
         tkyy4qblZv+2zX1hjs6+3ixnQfGICN/u19FY7I17KI+fxiLYjf+SFZRhh72tO9OUz3IR
         1s2+YmdzcgXbSJ30EH+ULjooN0Ig4U7P7Xh2rxxgzOLPK51+6revZBfywsmWILWWl3xu
         P9fmUm7h8f7BSGa11TMcqbgZsVZEVqkbhk+nNqDLtu4KfGt/cnsZGs6hUPBkmPBzqYcM
         ozAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509873; x=1726114673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7/TrOieKDmokvB+76CstcAo/MHXLXuZvmD2LpyYQbI=;
        b=fufy1ikHT0IxFbx90EUBWxU1qHaJeYMjnCDoPTTKSxqtMliZh/9aZnNX2xzq/+0KiZ
         QlRvx71hWpTshnZD3oW666TwWVryLo19esV4wlJ/RLtt+/yeRa7ScRnpRv+lJN8sXXlY
         1sZ8tMDeYX77cH7Yd0cE0oFyAu8IVYM7IATYGLAjpgMSpEtt5QOVkEUq9clG3yE9pPA0
         XxW2vEj/eq5B9QvdRIK1kwQbBVem0IBzOWcXcHuQk1nC6uGX2iwjDHurtmlneO7p7Eis
         1G4LsdsWswMH342ndTqXJmo9sOIhkfY13Cv+qIrOIJ7lslalsSuBtvMT8Y+Uja01j2kG
         P7yg==
X-Forwarded-Encrypted: i=1; AJvYcCVjmv/j1xCD8/ooD0YpaWzgkBiyfkxKjNUsd9e5grhFjzXOFqM8in8p+jI7rAc2QO2b8eIBseeEToHovDw=@vger.kernel.org, AJvYcCXhjIG2m2ch7lPpHWkYfvR2icMGdXL+a1olG+oNNGShGxt2KaCXSykTdpuZjhflUnUbIzKx4mEmJR02FJpW@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCQfKBM8Qj4zwgb58b++igA8oMWlOoxlg/P7eV+q30TptR3co
	TsFhJo93aHNT8hejtmxswWW4wqNyO3gUzruEDb3goXNXt4BUD6/ZGMv+dQ==
X-Google-Smtp-Source: AGHT+IEVTNgBOGvJQB0FLDExyZ1paUWKmbJHsocyoE4L6WqC4aDyBtqt1vWJsKWhqiIBmoYibKVEkg==
X-Received: by 2002:a17:902:e5ce:b0:206:a6fe:2343 with SMTP id d9443c01a7336-206b7d0aaf2mr83347615ad.8.1725509872338;
        Wed, 04 Sep 2024 21:17:52 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:52 -0700 (PDT)
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
Subject: [PATCH 06/24] Input: atkbd - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:11 -0700
Message-ID: <20240905041732.2034348-7-dmitry.torokhov@gmail.com>
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
 drivers/input/keyboard/atkbd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 5855d4fc6e6a..ec94fcfa4cde 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -713,9 +713,9 @@ static int atkbd_event(struct input_dev *dev,
 
 static inline void atkbd_enable(struct atkbd *atkbd)
 {
-	serio_pause_rx(atkbd->ps2dev.serio);
+	guard(serio_pause_rx)(atkbd->ps2dev.serio);
+
 	atkbd->enabled = true;
-	serio_continue_rx(atkbd->ps2dev.serio);
 }
 
 /*
@@ -725,9 +725,9 @@ static inline void atkbd_enable(struct atkbd *atkbd)
 
 static inline void atkbd_disable(struct atkbd *atkbd)
 {
-	serio_pause_rx(atkbd->ps2dev.serio);
+	guard(serio_pause_rx)(atkbd->ps2dev.serio);
+
 	atkbd->enabled = false;
-	serio_continue_rx(atkbd->ps2dev.serio);
 }
 
 static int atkbd_activate(struct atkbd *atkbd)
-- 
2.46.0.469.g59c65b2a67-goog


