Return-Path: <linux-hyperv+bounces-1493-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A6845113
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 07:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D00A4B24BF4
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 06:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566080055;
	Thu,  1 Feb 2024 06:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nH0VE7Sa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9A710A32;
	Thu,  1 Feb 2024 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767258; cv=none; b=j4PZ+rgUL8Qbp7b3jGGgTHiNAge7uG2jiasTsFpC8VclxTV1+bi/XgwKsCRTLnXp39uOFjYixeEPaWIhk9rIairGl0u3KoTKhIy4uB3SewVlK2tDTnLORrNhn7CjlYrt08exkW1WYb6uWjj4v4ltakex9t3cAgjAu8Xlu0fZMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767258; c=relaxed/simple;
	bh=uXeCpDY6WAGGJZR6enMwI9bH990VMkzDoU/cPePVUGo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idzGSbFoDLY6iFfZi6AyHghGStH7mVxbAqRIBQu+wvRRuEJBc6MSO3ujTlyHS3fr6B0EM+eQbFo4hUwywt6cgkzd/k02VnrsQ1FAxLu97tHuhuVQ5BY6lx6sCSG7unUNrqPIkNCFNlC/yfKJdUBvh0KaW4Qmu3tMAnrnMQH1jxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nH0VE7Sa; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59502aa878aso268093eaf.1;
        Wed, 31 Jan 2024 22:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706767256; x=1707372056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNqK50nnoYYuan190E0eP8SeFX+t45XrkVrq9dZoFeQ=;
        b=nH0VE7Sawvf6aU1erofvbyFEbv/NXg3nv2NxZ17IwE9a02o0x0dM6zr+uk80MmDZOc
         stNSyxp7t0aqVqfskk6Xql5HOZs/JqtQQJI0CJ8vrv53vnGaHM+lFBCqD85FHFtUJxEc
         l36FgMKoOig3xhWPT2gSREgVdJwk+tM3rftiTvdWiYfyillpcz7RRXBF5bUs96upcCP2
         KTk7o5mHUAmA2kpdOdoNTT0EwyDUZj+t2Ks6i/Y4vBoYc2pU7p1I5U1OQYF4Z3sBkE/o
         h3KZ17xfhM83F8uWqdwp5JS6IDEwdU/yucig27IbLSHTcHKmHgD8LTzlapQwjPSlDZ6V
         6pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706767256; x=1707372056;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TNqK50nnoYYuan190E0eP8SeFX+t45XrkVrq9dZoFeQ=;
        b=TSaPnVzSWBQmvZpkafzsUptrfdieXtbW4aAIvVkJjDAcFl2ZO+slv6KqP4kKJuNS04
         RAT24miqiIHSeYioaOMiAr49U8dQaOOFW7mvvf/hTBUs43ScPlmRcRtJQKdaypIZ6gA6
         6LRGfYQDzL0xhUbfaaYV+5mEjjdSssQTegfIwgfx5nmpmXOOMBHKdvndRq2h+ibOgCYA
         cOGUf0Uny4dXZRwPXk44G3RM5dmSHjsK1k3fOXtmpoJk8ogjf7tPNBcSBO+o8chpdjXi
         DS++J8+vzVgGa+E6Rx1pgjEsQfx6uxwK+ZvJhmY4UERV5X87PCytbNT7V/v77g36qVhq
         u55w==
X-Gm-Message-State: AOJu0Yx2Xp2VM9qbfQNvrGbGu/Qa+tN6ze9/S/wg8e7oksnB7RcTuqeZ
	xedv15wwMPPOZ5jD2rElF+LL7jZwwEQkoTKgBozvfk2Uk0weJGvc
X-Google-Smtp-Source: AGHT+IHcVlLzVN688P71oGlESCZpzZCNnOKzQYQpaj46pVgz4n3hzhfDPwZCWeDPvMepB8EpgU0gdg==
X-Received: by 2002:a05:6358:3121:b0:176:40fb:e123 with SMTP id c33-20020a056358312100b0017640fbe123mr3761793rwe.5.1706767255698;
        Wed, 31 Jan 2024 22:00:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW58zNQ7RRUJl0D+6XE/IYfATzZDmZFvUbCxlFidY8YBavKgky0QSUOOhjkOYy9906WTlThIMqRkWE+7aieaxHv9tHsSR5CGpAAf201CKtb2IC5k0DYeA84HEX5RZxuUGD9Q96lXx1J3zNDOBhAHnGoOL07ggTkssJDJYhynhYyOMdqxA0Dv62eolWhvzWivqopxphjMVN3JTYGgE6/wlo8xoN+IJ+YYuv97uiPIfwm+9ILuozFkkSr3uwtegMaQNnzH6ZsfDVIAZtEDGTnoZTYWJgVdKkQXIcwHRBPgfZnrJDaWV+QwGU4mdkriukD9O7EE31MBicntRRm7oshX5NE8Xg1XbAJYFDt01xKfl9gpXLf2ldR3wMQi6hzxXKBEiyVtMQK
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id ka7-20020a056a00938700b006d9a38fe569sm10809913pfb.89.2024.01.31.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 22:00:55 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	drawat.floss@gmail.com,
	javierm@redhat.com,
	deller@gmx.de,
	daniel@ffwll.ch,
	airlied@gmail.com,
	tzimmermann@suse.de
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] fbdev/hyperv_fb: Fix logic error for Gen2 VMs in hvfb_getmem()
Date: Wed, 31 Jan 2024 22:00:22 -0800
Message-Id: <20240201060022.233666-1-mhklinux@outlook.com>
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

A recent commit removing the use of screen_info introduced a logic
error. The error causes hvfb_getmem() to always return -ENOMEM
for Generation 2 VMs. As a result, the Hyper-V frame buffer
device fails to initialize. The error was introduced by removing
an "else if" clause, leaving Gen2 VMs to always take the -ENOMEM
error path.

Fix the problem by removing the error path "else" clause. Gen 2
VMs now always proceed through the MMIO memory allocation code,
but with "base" and "size" defaulting to 0.

Fixes: 0aa0838c84da ("fbdev/hyperv_fb: Remove firmware framebuffers with aperture helpers")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/video/fbdev/hyperv_fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index c26ee6fd73c9..8fdccf033b2d 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1010,8 +1010,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			goto getmem_done;
 		}
 		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
-	} else {
-		goto err1;
 	}
 
 	/*
-- 
2.25.1


