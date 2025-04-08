Return-Path: <linux-hyperv+bounces-4827-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43464A814CB
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 20:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAC4E0398
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Apr 2025 18:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19A8241678;
	Tue,  8 Apr 2025 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcycZ41T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88423F41A;
	Tue,  8 Apr 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137423; cv=none; b=mGfVyIE7MnVR3/wrb1qpS0ey2tW/xIKz3HEK+s3wJDyKG14vDdbx4DUUFzL5CYL1CdmZk6JouxQt4UehR4lPgOgojWSb4d4D117W0Dzpcuy7WoltmkNeAbOu92DHMw/bpIKM4aQK9Tqbz30LKRXSt2qulBj54VpVMbAn1YpVaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137423; c=relaxed/simple;
	bh=UqNvfT8UNcQF1ajewAq/dch5PAUIobvrkdEpLmAZ7wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfHV7JRRZ0KHs4C8QNoDpOTq2MYEs2w97Jcqrbs7oRKmbsoUVuTJlNppZglDBTGN88YSU+MVgGHMPshaHhX3ODGki3ZhR6LQT6azP7fwDdWx5PpvF+/8IGrI3nfYuYDM8qNL2Ek4ksL6qHV2ccyROny5Zq5CV/wa6QjxwRWzKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcycZ41T; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so5768724b3a.1;
        Tue, 08 Apr 2025 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744137422; x=1744742222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=UcycZ41TStHYwMBAJKANR2K4DeRBT5cC+aqEOwXFeCrQDf1xlkYInVRPiwOrgrOgKq
         FAVZerV6gVNRlfMzfWWj3UWlAoyzDwvyUg9XNmN1fUOG0W0z1un7+uarrD52CwlkHuAx
         3qMpP8j1+ucFwwc/7sK2a7OOX5aF2ClEZHers+zxvPo7HBfntrQW70GzG8nWk02sHZpz
         9cx7yB4Fs8W/zuD4wNBgFGwnFUMmbckU2WBQLN7EAFHi1TMFL0rZ4FXsi6s5ZMzFsZeu
         PuLqmcMO1cFehxvV//aQYrEq9iOYZUxnOs6rLrpBjpp6E36uznh1z5EobuelDrsl7ruf
         xDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744137422; x=1744742222;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=u+iJJ3dqogzg1ZxyzafqSmmpfPYOJ/St8KykhzNHFsZKqexRuMN2OZMcpfs2Dp1Fuq
         nNkNkB9huBpO3CC7Da5AoWaGCyShvcQ2FLDNPE3e2qr7MaDRL+kQyFL7EH/ZNfGxeIQa
         i/g09rYAR2zDeaq5fTFxuatq2XQUOP/+BJj1x4h5B4K6CGdB17UZ5Py7HGBIQ4pzarDo
         aRg0CqHDTybnJ2sQJkITYhSV37dsf+hMoztWI5ubyp4BzUGGoeGtL6OMsu85JYvxJRDb
         CXo853bF1o8QU5kXYK4Jnra/KB4C6jau8C6Jbd/czDvO0l5rotcZ+tZMklJnIJxM7JSP
         0zzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV7CY3n38wTJZZLKN3s8hWyQfvuGK0PDfMpv6vNF5BXDAkeIz6XZxSKrWadiJj5oc8US7rkW2qMC33Uw==@vger.kernel.org, AJvYcCUdFOgfeTuB4IFtJflQjt92+T35vsuwgeJsMDSm6cOe8t79S5BkiGDRI9U1MCIhRZDNk8FvfkrXwMC46dSE@vger.kernel.org, AJvYcCUmDJZGWTTAzotJZjAGE92MNSGJDWBy5fH6kd+sI8lI50baCYYYw6rD2cUXOdzDWJLCXvX0MD6+KL893+UJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxiS/RVX+A2f3YF8CE13Y/h+20vPK0G+g4hoy8avASWx9fes/Ah
	mPSCS6Ma2fxdTi9CwXew+VGtIQd1rDb9CBGIo2qDx1CWoBnGieo+
X-Gm-Gg: ASbGncsAnPwb0qjPtVrevJtP21YIviflJIO3i2KfcL7X6ia51waOcMHx0L7Vb4cJ4a6
	efkHWdh8jtO5fjpI5N9bwh+80IO6HYmOMpml2SeUjbzS8mclhxsSsYIf7Zzb2z1s2VE7+3eywLR
	Lxsds1/fzEj26w9w7uxy7K7fAd/omLxTEarUTCB2buI6Zfme+cXc9dtdfp7aGB/FVSNKM6azRpp
	qv/vjGCP2bwQvMHb8MmX1yS4ARnxXyTpWNQkQcoedEWzkPREaqLyCj1C+4tN8pGAyfXINoD0f5+
	M+UoXyQ/knkeszAbC15SdB0uzEptWNz39A2Za3p9BIBU84bD+k+YfWs5zOQ9eRjAnHihKixw2Hi
	9lFjX8s+bgGu1W5ZpU2esmLg=
X-Google-Smtp-Source: AGHT+IFoxxArLlbdFj00rZFAC5VSPOC5ZnT2KxxJEAFIcKSD0E+nUXdTHUx2/AnLXQqCMh8+l9gjPg==
X-Received: by 2002:a05:6a00:2408:b0:737:e73:f64b with SMTP id d2e1a72fcca58-73bae497469mr99517b3a.1.1744137421614;
        Tue, 08 Apr 2025 11:37:01 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97d32b2sm10960469b3a.5.2025.04.08.11.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 11:37:01 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: jayalk@intworks.biz,
	simona@ffwll.ch,
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
Subject: [PATCH 3/3] fbdev: hyperv_fb: Fix mmap of framebuffers allocated using alloc_pages()
Date: Tue,  8 Apr 2025 11:36:46 -0700
Message-Id: <20250408183646.1410-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250408183646.1410-1-mhklinux@outlook.com>
References: <20250408183646.1410-1-mhklinux@outlook.com>
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


