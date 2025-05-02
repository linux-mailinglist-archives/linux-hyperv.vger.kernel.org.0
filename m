Return-Path: <linux-hyperv+bounces-5296-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8798AA69A9
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A38E7B3B23
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 04:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39321A9B46;
	Fri,  2 May 2025 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX/CIMg5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430761A3154;
	Fri,  2 May 2025 04:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746158739; cv=none; b=ZxbT7Q4Ucp/fG1JmtM4rd5dg5AbsZepGzXs8HDSldw+X6o6MQY7CHsvVrlf+pCkJCk1yJ6s5XDeoWMRBlvWaAdpZWVzvX28wNk3ir4Haot5FBmB0RyyHH3P6AqJekDugYGchiX71EkPiNi+Yk1zNMMyT0dehSx5RKH+8RrfsDNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746158739; c=relaxed/simple;
	bh=UqNvfT8UNcQF1ajewAq/dch5PAUIobvrkdEpLmAZ7wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djFDmPnkKitOaumMZNb0/Rv9jSyRHtTBujvou2W2AHtsGlP6BH0nj0R2bM5gQl/yqFGWfORfYh2assirDwH0n6kpiLqLKJDUdGVwBMJtCOXp1P77OU5q8ORS5QP11X0Uk8zZum+8rLgHYs4xiKD5rQfpsgKfIer7Zw+5qXdM7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX/CIMg5; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2255003f4c6so18124695ad.0;
        Thu, 01 May 2025 21:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746158737; x=1746763537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=FX/CIMg5gyUgloz0wp++qlbHkK+ks6ibb6weIdVo+I8jrtKOXVg7b1wNZULDCtyL4d
         kIZTlqdI2iDjFgOn5l6d8rqISxzPQopvr51Thyd47VxMICDTWdnyhOP/nhRfoKup6lR6
         jDYJ+r02kZcQliAU08AX/ExeSNULKXXzYDzCbHPVRZhrAPvwZlMkzxs2+X6707giskYq
         F9wec+IZqQfACYuI14UPS6oODynOUbSniiObHrmdDKwdX9IvdlU0kWeluobw4rSrJeQr
         rkEfhikaI2XRHNwhLHGlBgJ78CSnptxmusaCxCJZEjbbWdBXlwGPIkF7bA8P/EilwnPR
         y/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746158737; x=1746763537;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNk2zZpC65xRherJZoi8fazJtKf8aShkVrAnPTjrn2Y=;
        b=qJQiEBZDwjMRlv5gpzd46xRBWIMrlB08iO12NL97Hdg8v8jN/iS083mzzQB3cxPG29
         uc0734Eom72WHsbjojJ/8ZthIHlkxeuC7lkf8SwTcQd6VjEQVXG5o1zn8wv96VkSIq6W
         GK1WM4+7VHXnLtrUeXAmn/fntMMNEexiJDO6dyFT6o6aqJCHssSyrvTUM0igm/wt7T6I
         o54QKowg4DRpdjqr2iGoXvGzVVs46OrMWvxChrKEMYhRnkujANDvGsjXoU63QWr4j4TZ
         KNzMLBxfEJFSmWTWvuKs9HMW7UGAljKAn8jv+MX12rw8MWTbwVFfn95LzaEA6u9ovwzB
         vknw==
X-Forwarded-Encrypted: i=1; AJvYcCUVdw6mS4lY1xZJkeZ1OzjZ7OzPWgeoCz91ZSKM54StFgbwZ/j9ltIi4QdU9EpPDl1oeoaLwLrLt21zoQ==@vger.kernel.org, AJvYcCWI5jYchNssOtqWNd0mmnPAVoaxfW4XW970kmX7Slniherq2Yq8V61P1oVjsaMA+PZ+iFY0Z5G88sf95Zm2@vger.kernel.org, AJvYcCWsGDkzxlBdxl8iyYpVLHbXjoLrq8BFBfjNhp8txa1qWb/35kVM7HrWou7/R/eNS04OtbGjSLBF0HSnsM+q@vger.kernel.org
X-Gm-Message-State: AOJu0YyBvcvcJxPyNi7ibfv6NexQR6Nc7hq2PV9V1x1npKG9Ox84jhJv
	Rp/KljzO05AbDbxCSM2dr9W0+L3IQlqplhqBCTx8ikGUkY70Xl1u
X-Gm-Gg: ASbGnct8Y+jXPjYVIbUzuTjXasjP1sTSWkujuW6Yi0AMLX1tWXHHZhS15aeGboQd4Kx
	EzB9djRnfva0OVgMl1f0U24jgNGTbWSXALmB5Zc+CJHWC668Ypk3EcXCdRhNHqlJiDkbDU+QKre
	js8cR5Rvd01CezlL4y0mgCsGWpaNIm1GNcgc4SW/9Nf4p/VuvW8ZmTdo/3Pa57W2emQak8P5bzT
	dXBCEu/zZrD5IjJiFianH0CHf1HFyg+/xb0z7dVYaUuxY8Dt2RxOPB07TbtkijHmThAg+ZZjc1l
	TdSx5fv2K1ZdSH55GTzLKxFKHS4I3q15yvGliypFo6UQYYW/ToXWT0OjKgORfrEBfZDbV/x6dTD
	PWYsryoazAxizp1H6V+U=
X-Google-Smtp-Source: AGHT+IHj4Tzm6nKdcO1N5Fay8la+VC6hlU5iu6zD3k8sB96/zhwVRurosFkLDRNOZP+yc+Pg/6Qmxg==
X-Received: by 2002:a17:902:da90:b0:224:c47:cbd with SMTP id d9443c01a7336-22e102363f5mr23127825ad.0.1746158737314;
        Thu, 01 May 2025 21:05:37 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fb836sm4510635ad.141.2025.05.01.21.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 21:05:36 -0700 (PDT)
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
Subject: [PATCH v2 3/3] fbdev: hyperv_fb: Fix mmap of framebuffers allocated using alloc_pages()
Date: Thu,  1 May 2025 21:05:25 -0700
Message-Id: <20250502040525.822075-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250502040525.822075-1-mhklinux@outlook.com>
References: <20250502040525.822075-1-mhklinux@outlook.com>
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


