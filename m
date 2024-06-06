Return-Path: <linux-hyperv+bounces-2329-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1812E8FDD02
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 04:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B431F21636
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2024 02:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F271B977;
	Thu,  6 Jun 2024 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciSxMqdz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66136182BD;
	Thu,  6 Jun 2024 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717642581; cv=none; b=j4tnoR190J9tbSygE41CTe+ga0A/d+XBCyfUnu+/FXGyxPf9Ii4GiIIyczQBChUBcpl8KHn5oA3QSvk5fPuEiRH6Ax2UWS7pxxTD67SjlPf/s8oRR+E6kJKTgFes7VewrR1sCzqV1I83EDprjHT7FL0Y0ebSko3ZSnahO6/me5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717642581; c=relaxed/simple;
	bh=arBtpOn5cjxcy4mYPgqkevr/bxut5L6hGsMnEK17c+g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EwKetTylECvurq9IZH2zYpoLD2Ou8fmTkbw0hKAaS1sNphDxyXjgmbBpQcRPAE9TU93QvX5NQg9hJdttpcRKNFcUO6RNbnq6NY5cawUiQDU3/g03fditHWjECar4q36LVTALGB7PzlbLJWndfvZqjXtLSWbAAvJTV5YzWmPS+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciSxMqdz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-703fec25cc5so79791b3a.0;
        Wed, 05 Jun 2024 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717642579; x=1718247379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tda2DkZwVgqEQjgA5uAUkLDSA6bMtgBgYubd1iKZW+Y=;
        b=ciSxMqdzNjzDs6TOPe0ZtW6nHzLWjmpimAqxxZRW18vq/6I+k2kvHAcvFUkBTTcUiI
         PAVjtSpULKKGjYI+t+zgsQN05aD6ajWSvIzTZS5VpggH7FKR/UJ8E8sa3/hbY9KYaHUo
         wAyu/867U7XdelhXp2/ikXK0LPI0LF1x6qtFaTYowU+HcUEKxRiOtF3gUWgtTeY15zal
         XVrmGsdb90t++FAKpUqdEc62j8hFSEjHYWIteXKXDSdrN112elN0iF9x4l6tYtkpzu9k
         NDBSQVMZdnJEIrg3arZ9GlYWXw2RTXlNwiVgXRt5IsVImyVgUo0Cil3pkr4oORNf7Isc
         Mk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717642579; x=1718247379;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tda2DkZwVgqEQjgA5uAUkLDSA6bMtgBgYubd1iKZW+Y=;
        b=YagaO5saHPXjowKjQV67ZuOPoJgUQ2fYPRZadserxMMm6mFiicV8mdQMjYy1PhObKu
         bJKYJKO1fsYxKkNuIeAUESw92Q7ZPmccPUqIi6Cwb6hWVZdA87ntL3Egxz2p3zAGrkyr
         IZArvSxAoU28YvsonlRhy+ceappWF88Qm8SV22rR4RWKuxSZk3NKGnl1EqfK0ZJkmXXV
         JGPcPutKWzAdvQpLrqthvd71fqawRApzC0fcWxaU3q2ZrRaxIviFu83AlJ2RXYck/Xru
         yp6xeHOsesiQx3HgKEF77nPqiSoVdLXusTGGm7kVhnkZSwUsIF8u40RccspH9M99t/yh
         wh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW37Eyp5FYPb6dlo6CQvwkeBPC9I2qs84yDnge1EbTzRmhVeRXSDpirilWp3XqiAavv6NojXP2wIIIgJhPFyX9GDgOE20aUgHOTjDqHwbbEQzmOyJS/sSM5mPhUFJgWG8Ph+dPNVfrypBBx
X-Gm-Message-State: AOJu0Yx5DeebekQyMl+rygsiJNBjCqCuFVK/ikjJYUiXeAApF7+N7/3+
	Wy+2xvH564KNJky0D92ST84ImtQCdn+6IchRAeqQthrB3BtpA6nF
X-Google-Smtp-Source: AGHT+IE2KaNTjlc0m7jjBilwAEwta2SjTv0KQbbFPalExhbVdi5gyKFzB7cInSq9v29oEI6lyDsSVg==
X-Received: by 2002:a05:6a20:244d:b0:1b2:53c5:9e71 with SMTP id adf61e73a8af0-1b2b6fa3436mr5260536637.25.1717642579562;
        Wed, 05 Jun 2024 19:56:19 -0700 (PDT)
Received: from localhost.localdomain (c-67-161-114-176.hsd1.wa.comcast.net. [67.161.114.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76b16dsm2678195ad.74.2024.06.05.19.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 19:56:19 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] x86/hyperv: Set X86_FEATURE_TSC_KNOWN_FREQ when Hyper-V provides frequency
Date: Wed,  5 Jun 2024 19:55:59 -0700
Message-Id: <20240606025559.1631-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

A Linux guest on Hyper-V gets the TSC frequency from a synthetic MSR, if
available. In this case, set X86_FEATURE_TSC_KNOWN_FREQ so that Linux
doesn't unnecessarily do refined TSC calibration when setting up the TSC
clocksource.

With this change, a message such as this is no longer output during boot
when the TSC is used as the clocksource:

[    1.115141] tsc: Refined TSC clocksource calibration: 2918.408 MHz

Furthermore, the guest and host will have exactly the same view of the
TSC frequency, which is important for features such as the TSC deadline
timer that are emulated by the Hyper-V host.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e0fd57a8ba84..c3e38eaf6d2f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -424,6 +424,7 @@ static void __init ms_hyperv_init_platform(void)
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
 		x86_platform.calibrate_tsc = hv_get_tsc_khz;
 		x86_platform.calibrate_cpu = hv_get_tsc_khz;
+		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
 	}
 
 	if (ms_hyperv.priv_high & HV_ISOLATION) {
-- 
2.25.1


