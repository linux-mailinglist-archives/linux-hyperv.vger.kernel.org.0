Return-Path: <linux-hyperv+bounces-5649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A232AC2759
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 18:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4436E3A40C2
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 May 2025 16:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE94297A45;
	Fri, 23 May 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu7XiHdo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94549297104;
	Fri, 23 May 2025 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016949; cv=none; b=nahlCNz/lLafHCI6rsWGKZOc2c92wNonkaOmmXxpG5JSVc+VFN5yIutuvM/Pkc3mKpM1H2hf+4tlGsLuHDocbY8esFyzSR1lQhDnj10r9QTYcVeqqfxX4IZtWBypmhXnxa51BnLC0MfaMlpGQ5GcSudYxX+k6J/5HoKQo4+qERs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016949; c=relaxed/simple;
	bh=UqNvfT8UNcQF1ajewAq/dch5PAUIobvrkdEpLmAZ7wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c5zpNeFPHfSY/BQUKuwqHR2jDBt3X5kYvZo+Chiqd33Jaad9gne3BMI/xtu5Whgh7uHfN+yxKut1EsZoB6jB62C88+2wnDl/i9nGDOmH3XWVn58F54oaOKV42qkkss8ux3R4at1VS4H4wwgDZB3XWqRqo6Yp14GzPp3gy9a5OyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu7XiHdo; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30ea7770bd2so155607a91.0;
        Fri, 23 May 2025 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748016947; x=1748621747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=Cu7XiHdoJy9Zr3DyJmFBzr7/ZWGBucsF/KnfVoOUReqlubC7o6HzBUSLeGWF3K2ZVm
         f2i9u6jkOVgnU8bntVWMX30O3mLH28sl2EhR3n7RoqP+qmf1c1ILoFK329/dH5rqHojl
         jEK4i2GHgvfBA29kD+/km+FfJUAtDfN1iI9Uyp4l1gmjjV92bSoG4WSD/rjxaOHOu9Vv
         UTSU6mwp/uE2cvkMWcr3d31jCZOM78kOpKL1Bup/uivjpS53OQjJ5Z49ebbm8Y0bRVqA
         VtxXhUJ9W6ScKXc9uRnRsj2e3dUh5LlTxIODDj3Je62fYFE6A1i+Kv0DF3h+r5d2jNYf
         s6KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016947; x=1748621747;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=ZQZhapoMprdv7kyStv4C8JcjW1o1/nXwZSOc7z0m4bfeZglWoI+VpAl94r3L6XHq5Y
         fziFVYy/tTOT4/rB826CDiusvENIIpyv590dx9+FeCd/SapNpFvDisdLa1Rii8t+qY2Y
         Bm/4ttIMb4NIdKvG06SZSLtemTukPZ/Dfzeo3e2FatWKDypNA3ggboS0sDahQBY0lPn3
         yTX/7BBxPf7+/1sR4WMfxU3baDLP6o/AjsFC9Ayg3t8NT/Eup+GriubPmQp8Qmy4oKVO
         tZZTfQqFd9KZMM+7KQKAxfwwx3rgKcBB6k7t0YSWUsOz/j/rRcT5W0/C0a1IkUJqIN/N
         wp1w==
X-Forwarded-Encrypted: i=1; AJvYcCU6Zeo6gTj2VdQza/PGr0kbtiXTz0SWUbLymWuz4ZCG9SpndoLpsAM8hT7e4ByjU1i/miRULI8wIUEVGuOB@vger.kernel.org, AJvYcCUfTMS6keZu6X0izDgNi2Dk+FhihLpgBeZTIIX8aKinwbNuErmsvt7tUcxZNrPaOAXJKCwXZl9YdRXRtQDg@vger.kernel.org, AJvYcCWTVlZnEwuU/S+KhRV1NHrUKzfco2gJuP7UOa3kYW1ChDW4uLzySuUbVg4GFK59e2cX8Tbli3HmlODnew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9db3TlLAFVQQ1CY5N/S1V7XD7O2VOyrVi/x4rbVXfTbZ9jA4
	g74y5/U/8d6QraiUOm+MwPfsCC5AahHpY6gNNiSRrYdmwu0NwfurS3r5
X-Gm-Gg: ASbGnctab+ht3+C0P9Wd2uKC0kMh8FEjjULW3mtvsL9Dfv9PtjRTYCfk/47HDWCR/o9
	kph3Kwv9IHzg7fet5B8OID9q3H69z+Lzpbzr/QEak/QnbQSRgF8pO8ZyRdXgpoi5oto+ToX7Vrf
	SIh1oFPdYq4T+h24+G717aKkVqCT90nhjysb++5UqimZO14Uim8VpfNIWq5wx/yOufNEnCZVS6C
	Ywlb7Kd16q8sHOaY5PWFbBFwlhSTZYJf3qvhuCwR0TPA94iIHKUz8ziRMCHrW+cRmWXNEilcwq4
	7W8VRSAVoomGq2GgNeg9wfao+KIfecoKprSbAkNCbGLitvK0RfBHDdO2wuw+UQKHxZPZ1KgZH8U
	m39V6TkQzWXSl/Ge9wBcQp1RYoPBt0g==
X-Google-Smtp-Source: AGHT+IFx/FJsdG8AnNi6eg+BilBglUFlrj6JEqa2pyvzhIeq+c199ROzKQxdHjIHsfWSCrtByMxf5Q==
X-Received: by 2002:a17:90b:394d:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-30e7d5bb433mr53256647a91.33.1748016946693;
        Fri, 23 May 2025 09:15:46 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d46ffsm7526565a91.25.2025.05.23.09.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:15:46 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: simona@ffwll.ch,
	deller@gmx.de,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	akpm@linux-foundation.org
Cc: weh@microsoft.com,
	tzimmermann@suse.de,
	hch@lst.de,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 4/4] fbdev: hyperv_fb: Fix mmap of framebuffers allocated using alloc_pages()
Date: Fri, 23 May 2025 09:15:22 -0700
Message-Id: <20250523161522.409504-5-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523161522.409504-1-mhklinux@outlook.com>
References: <20250523161522.409504-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Framebuffer memory allocated using alloc_pages() was added to hyperv_fb in
commit 3a6fb6c4255c ("video: hyperv: hyperv_fb: Use physical memory for fb
on HyperV Gen 1 VMs.") in kernel version 5.6. But mmap'ing such
framebuffers into user space has never worked due to limitations in the
kind of memory that fbdev deferred I/O works with. As a result of the
limitation, hyperv_fb's usage results in memory free lists becoming corrupt
and Linux eventually panics.

With support for framebuffers allocated using alloc_pages() recently added
to fbdev deferred I/O, fix the problem by setting the flag telling fbdev
deferred I/O to use the new support.

Fixes: 3a6fb6c4255c ("video: hyperv: hyperv_fb: Use physical memory for fb on HyperV Gen 1 VMs.")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/video/fbdev/hyperv_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 75338ffc703f..1698221f857e 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1020,6 +1020,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 			info->fix.smem_len = screen_fb_size;
 			info->screen_base = par->mmio_vp;
 			info->screen_size = screen_fb_size;
+			info->flags |= FBINFO_KMEMFB;
 
 			par->need_docopy = false;
 			goto getmem_done;
-- 
2.25.1


