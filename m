Return-Path: <linux-hyperv+bounces-2956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6AB96CDC0
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 06:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC3B1C22730
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA998188583;
	Thu,  5 Sep 2024 04:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqK5arM7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331F1186615;
	Thu,  5 Sep 2024 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509879; cv=none; b=ZBNgfNPOgm8k2k7A105DDzYjIQ8v6WOheUkJvzZWTntHGf85XA7T2JvtECtaaVrjkatZqY4R9T0maubFDbg/zNI+JpBmE/bFrMPqceWzixFKA1qzS1P2Y2dCub6jaaljexwXLjCMiTTzsZYhxm8Ui+TBC3kyK3ncRSY2s+6mHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509879; c=relaxed/simple;
	bh=vydiQbG1/1szEzLjhnhj91G7z0QVE9gqOa1tJ68qVcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grOzfwAXxhBoJ8J2nuLOGbQPuciteeY0gNSOz/VhwfzuOjT9GiOxD46XNiRKOFK7atkD/kqiUthRKKdU0sH5HizaMTOY38H0uo7v+QznTh/uspE6k4lFYuOorlk9IAeGaQOgwxUfr4IAzAUBnpjptrErdZ/5SNxbVl48QFIEE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqK5arM7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5e16cb56d4aso190383eaf.1;
        Wed, 04 Sep 2024 21:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725509877; x=1726114677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mdzi002JGx1/VTYSFinhnta06n3PxzWkqyJNw8JR4ro=;
        b=MqK5arM7iAr2Gg/hs+A3kvFn8gemAJGQmWsXnh9j4NwW7XYSi7cffZGS4p0jUvlz9K
         yEVSCSlVYI74ERPaEDKBAyZxJj5z6snUdcjIyrQkQoTicTl77sPChyJpr7Lk37fI7rpJ
         G0EQZubDXb5zYpuMgmmhCfd/0Ig3IPEAGv3yYPPDrh7aoKl68Z8Qq57abcBZ74Q1szxe
         PlBuRECyRIBk/Q3RzAwwx0kHaiqTSoM45ZD0nvmPZwQ+rZh/QwYk0SWqKOuao2Lar1ov
         LUO6i0W7ny9tWneV/hlMHjqCadtnPCxTOAO2cDdAhBJ8l3I8JT4zxeOepnFsGnjCPxGw
         PTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725509877; x=1726114677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdzi002JGx1/VTYSFinhnta06n3PxzWkqyJNw8JR4ro=;
        b=FrMYZbqfllqpHpQB2Y+tsxfdj9vQ/+m/rG5PWb3+mH7wj8Ej42SaaIpAU0aZLsicSV
         efHY06KOoRJu9CKG977G+TaOQuUB08D4Rhj7oKDXPdk9mz+1ruxWxE9kRt/6gswi15D7
         EYIY+suyltjOliarFvID/yu/MwdE1YP6g2xidG8Y0LCcaJ2oN6stuk+UpHktbRCEAKQN
         Lhc2G8mSGe/eVDZngAEY6ZXz7XZr2LSglkMXzEogeMGNcR2kssDOCAlxhwpl4UOw30XE
         yZDGynOZDD1HQCo3AP3161xvn4jsPjaYa4XgMC43cqp7nccmCFQ3ajTf3uTOO9ufZIcU
         t+EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxvK+ik/dHYBtlfdXD3LtsvkqcaHguRyE3ClhoLlpRCFXgNTpwoY34kMPyctJrC6imAU8ayzw6S1lW9FUX@vger.kernel.org, AJvYcCXhrB69tpJ7A2qnVuk4WV2bIA0dq2lJx+cKg/owjdIzE5S1Z7ZJTauTf/Niv5l8ex2+67QiNwermP2+xl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ygfedqQ54GJg9OIXw1NqNegb7krd6ZzgIm4l39bbVIFT8gFs
	Cpj9IIDm8yBB5QxNtF8UgG6auBFFZh7ulUn0AYoQJvnC/mncIFmVx0O1vA==
X-Google-Smtp-Source: AGHT+IEeegP8PYdaxOx1oJdq99u2b/mnBeID80CKAiS5INtYMrMJc2IOIAmttT7NOBEVZS4HWjLcJw==
X-Received: by 2002:a05:6870:3d8c:b0:270:1dab:64a9 with SMTP id 586e51a60fabf-277c8055c7dmr17330298fac.14.1725509877129;
        Wed, 04 Sep 2024 21:17:57 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2620:15c:9d:2:13bd:b4e:4c0f:4c37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d4fbd8d52esm2450216a12.32.2024.09.04.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:17:56 -0700 (PDT)
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
Subject: [PATCH 09/24] Input: elo - use guard notation when pausing serio port
Date: Wed,  4 Sep 2024 21:17:14 -0700
Message-ID: <20240905041732.2034348-10-dmitry.torokhov@gmail.com>
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
 drivers/input/touchscreen/elo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index eb883db55420..ad209e6e82a6 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -225,10 +225,10 @@ static int elo_command_10(struct elo *elo, unsigned char *packet)
 
 	mutex_lock(&elo->cmd_mutex);
 
-	serio_pause_rx(elo->serio);
-	elo->expected_packet = toupper(packet[0]);
-	init_completion(&elo->cmd_done);
-	serio_continue_rx(elo->serio);
+	scoped_guard(serio_pause_rx, elo->serio) {
+		elo->expected_packet = toupper(packet[0]);
+		init_completion(&elo->cmd_done);
+	}
 
 	if (serio_write(elo->serio, ELO10_LEAD_BYTE))
 		goto out;
-- 
2.46.0.469.g59c65b2a67-goog


