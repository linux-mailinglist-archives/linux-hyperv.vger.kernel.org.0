Return-Path: <linux-hyperv+bounces-2951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 072B196CDB1
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862991F21C19
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F85B15F3FB;
	Thu,  5 Sep 2024 04:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ai5gc5AP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D703B156886;
	Thu,  5 Sep 2024 04:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509872; cv=none; b=nTetBYk8D3979VD3QARj/HAZkAIxsO7VUiUzVjVeR84x9RvhUrRU//dLLhmGriJdlh4eS8AYhSGxfOxLFJXzfLyZsXl5wTeFYQJJXZWAk06tK9m08IB1zO4nLRkFBwy4bGblsoTGcPz9eFDLOr8dm4Vu4ibNmWVG8LdpVYwUvss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509872; c=relaxed/simple;
	bh=jD9Ue/cXOL5pkFXSYKDYrZ35NLToW/Fmj0WfDt8SVLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9pm8WvMdh1rHTVZPAJoIqQoEepEB/QNkqjrGJdDFDa8o+ia8Remvhhsqn0q+3wCYq80UqfCBBwOTp+k/rQX26TCqMKCdKkS4UJFYEzJB6/RuEY50wuqcwVlQvLT0+VkO5O56e/+5o8BD0/1oDN8WNdJtvYJDSv2p+ex1lVHQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ai5gc5AP; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7092dd03223so112190a34.1;
        Wed, 04 Sep 2024 21:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509870; x=1726114670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RnFN3EVlk3VoY/i2sKWDmOIShT35NS9PrPlyqQEJBY=;
        b=ai5gc5APIYzYm4TmxHqeFhbuDrOqOnqrIqV+WzazqIeN7yte9NrtZTtX9mCeXC8U6J
         3HTLujqPnPHmg9ReAri7c3z8EDvfJv7bV4JDxJLRDd79NgVFOMqNBVT3HSSNg/2cA1Li
         zEny0hUjcesBxh1tijmLfovj6If1KBjPoisvVVUa8Ftx8bLHeo9YsDZl9UCRVJomBwma
         JrNPUXHk6OWyeFyPCYNWssZRxM3LwnFoiZnzPCUwPulWfFhd+K2imdMbdghb83IeHIQ1
         dYjmeRAyKurZMkMNwZIBxcUpEGoGAhXNVAH7Ic4cWicRb2jtjrbAKXQamrDcCCgnzpaz
         jCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509870; x=1726114670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RnFN3EVlk3VoY/i2sKWDmOIShT35NS9PrPlyqQEJBY=;
        b=VoUuH9nTXZXAjPSaAzKT5dApZm1F3Kz1mhcNB/JJZdR6bRnIPXCQ/jSOh9ZMQTUWzV
         kYoQy0QKU/fuPIft/8jzBSqutXNNXXSg/qBPZXXuRmyF9+jHpQ1/aFZ3QsiZz0oROlEv
         J7XkHgq8biS9NQACaMLWK8qRabL2FP0/KjmoyeSPqdYaGNNtbNkZUgtVYZ6h/MQwdOrv
         wI7KcNRE3AawGwzh+rfhjhDTPbKQfrkOpqyT3zSaQtX4F19AOxFpX8UDFPHiIREDKDan
         g1vJwPXRc++9wtQNUxeUfr9NjUY7UDRrw3xrWZ4EfDgQyDQVAeymUiapGIlXIXMB1n3o
         Pggg==
X-Forwarded-Encrypted: i=1; AJvYcCV8spZDYeaiWnZ80Colp9EwUeGfChMtX6lrVbhqHvHOC5GxB1voxFDD/Fk8EhD4/xgfq5zmzLgs3JExne4=@vger.kernel.org, AJvYcCVw+XS0OT0/8nFQZRRFLKunldD1WPOl7B8f0hXR6LXZzSa3YGPYpblaUC+a/CgmJsW5YMepxs2Ya/F/YsVA@vger.kernel.org
X-Gm-Message-State: AOJu0YyGiVUBNRCA90RWSM+OHBOhaPrXhn94KCA4jBLzz46td4aBxqWB
	+4+aqJ3IA0HRZlLNJIc07zogPKUAlYXeXbRncdUeYNCBxLNQbPbY6H0nzw==
X-Google-Smtp-Source: AGHT+IErwMioNhwmn1dsG6jz5WUbE6Tfb09I0yh8Z59wc3+setGX3kYdpiz4wU4pA3/BcQ951wC+fg==
X-Received: by 2002:a05:6830:2709:b0:70d:f448:575c with SMTP id 46e09a7af769-70f706e362amr17541035a34.7.1725509869713;
        Wed, 04 Sep 2024 21:17:49 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:49 -0700 (PDT)
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
Subject: [PATCH 04/24] Input: byd - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:09 -0700
Message-ID: <20240905041732.2034348-5-dmitry.torokhov@gmail.com>
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
 drivers/input/mouse/byd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 221a553f45cd..654b38d249f3 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -254,13 +254,12 @@ static void byd_clear_touch(struct timer_list *t)
 	struct byd_data *priv = from_timer(priv, t, timer);
 	struct psmouse *psmouse = priv->psmouse;
 
-	serio_pause_rx(psmouse->ps2dev.serio);
+	guard(serio_pause_rx)(psmouse->ps2dev.serio);
+
 	priv->touch = false;
 
 	byd_report_input(psmouse);
 
-	serio_continue_rx(psmouse->ps2dev.serio);
-
 	/*
 	 * Move cursor back to center of pad when we lose touch - this
 	 * specifically improves user experience when moving cursor with one
-- 
2.46.0.469.g59c65b2a67-goog


