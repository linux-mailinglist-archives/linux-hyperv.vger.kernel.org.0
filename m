Return-Path: <linux-hyperv+bounces-5293-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E2AA69A2
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 06:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA3C57AA97C
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 May 2025 04:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8593A17A31B;
	Fri,  2 May 2025 04:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMyDlUiV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A881211C;
	Fri,  2 May 2025 04:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746158736; cv=none; b=OcnDUO61wR3WB1AolLPmpJbdRbkW2a9wq7+tCCyUofsi2BrKBKa3Y4eT0W6RKmcEwzajxiuj6trQBKdJ0BG/yzwF+MtDXLPhNAIHfizEdeEllNhmho8Vzm0GTzWNr8jBgHAb/0VpZZHd+1CLeCiAxa+r2JWYY31jqoJJO2yo3ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746158736; c=relaxed/simple;
	bh=TL3f3BW2tAyt74rHrlzhrwreyDMYGP3h4muuCeK4s9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JnG4/bnJi2bXRYKVJJImDLa8ninkpcLlI7SouOe42Y+g+Y9HQsgAW6+YJLj3musQlvv5GNiy3Rb0CWNbLr5wWKKwY6JFxK14VJY2AryDmnkcCJDKH594zV2jbqEDD1c2e3M4IfUrD/BBzDXpxXghn5icPigapZ5wJkrP6p42fAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMyDlUiV; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22c33ac23edso18897395ad.0;
        Thu, 01 May 2025 21:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746158734; x=1746763534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dSub1wuh8nlEkm+pKUMg5wgv6Gx8ymFTnPqus5nWjls=;
        b=bMyDlUiV4rmO8HYRRQIewfeHukRR4oHohPjqAcQw9nEOPCqc46kQ5onbA5hgwDlNXL
         YvXiSuAznY34iMdWWrLKOO8Agx3LRcFI1um70yrJcufa+MzY66gxFF4zmROvA+MBHJ2q
         Ko0KcoNB+PcOcF1Uk8xSx8GGg70UZDcFzaDwrPKIPeMahpSe3K5+pnWaRlNla1GEp8LF
         vxutwd5sK0FbnG3My596w/cIN9zNqLBpZbHPPn4TC89BThqXxq1RdizySiiHOnn0jh/T
         DRwQ/ajxTe1hH6k99iioJGTQa3VizJKXvODyasmDo39vi/LiaEa4Bh09EIhl+z7f+fEC
         /0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746158734; x=1746763534;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSub1wuh8nlEkm+pKUMg5wgv6Gx8ymFTnPqus5nWjls=;
        b=BgCGkvSy6NUSe69edhHr1uVkJEjL3M5XvgTonXG1KjaVAu5WsY8g7MsnCv0oYBT2ek
         YRdqnj6eURONhVIqsbwj3nuh3xSypm9b0rm1GKYTW5de60DEAEMFMaoBAulSekzBGLL7
         5Xp+fwdmdkAzKKPSoChr+xwT0bMDPMJt/vCM0Q5zl6zeEhfw7ISpm83lp+2NdlNvmgbi
         ZFewIZ8KaEe3Adao7Swexmoh+L91/JPrw9J2WSKfQ++ftMoUu2w4N6cwv4t76haKPlMB
         CvXa+LMgZaSZUxLwoMM1he/V1HLeuuKxLuB2E9+1YNlyBuf8SQtrOoJ/34XAY2KXpw5C
         Ptpg==
X-Forwarded-Encrypted: i=1; AJvYcCUI9pnomrJGYKaz4SqHTtKH0qUA1FUKZqEKZknq6yYhs739XnPphpIJtkUo3TG4jbIt/MAzwp3RgMwVmIkr@vger.kernel.org, AJvYcCVy0lQTVXOxYO6mC+RbQWGpK4r6XhjNcgPLrzOSXa7LnP0lEaftigsI9j+XKE4t6+yforoBXoQy2o0K5g==@vger.kernel.org, AJvYcCWgxqPxlJZpS+rTC1lvBmaoT275H2BEqvaPL3BIjd+3kYzxp54azqKUV/ePH2nB9hkRXRbh7O5+O1gphULi@vger.kernel.org
X-Gm-Message-State: AOJu0YwLq3UZc0f43kaz4D9SJFH3TJvIm+Pe2NOEq5nHCHolwpY1ZJ6M
	zb/K4dmlG1ur/IeXS4HNLe7uXnDIBPnJb7vIVcc0NYnMAzaWxsTA
X-Gm-Gg: ASbGncvbvrTvtUg+RoFWa9tJzWe3HD47rgUPJ3uh/ggbWWYgcIyZ9bIcp8RlH9psAFA
	scUDGDTdUZcWR8ZUyCEMg85W6ZId4T5GR6VOd6+b7mmdariiTWaQTvpiMDIcGYMsbRR5VrXyQ62
	BZsClH5HRWgWuO9JHlO9yAHkoh6DzDYVKvuDjm1f8DUNQjUv7ZyWxNpDVA1iC6pjGWWbL6fKAp1
	jBXyutLnIZE9JhIz/RAZdUvNmkrqwhqJ4ZA5S8vRQq7Gb7W9dkC3rYt4ZDJh7prZA1owLmvXA2d
	po1SKgkKebIvGBG3qiZpB5u5rv95AgwVQsdx7WjgGsM50Z+gsn/noB4Aaiqc/DiAN5OoCNR4LCy
	U0n/melVihd+ZArlYCbD9UNpAxRPGZw==
X-Google-Smtp-Source: AGHT+IHgEx/So5EIbHlSMpzfphWaNj6WsLQNTdHJsmuELyjZ0DzDKhxqJDDpr/U0LH8lOLMGSv6Ucw==
X-Received: by 2002:a17:902:ef0b:b0:223:6657:5003 with SMTP id d9443c01a7336-22e103899d1mr22760535ad.32.1746158734054;
        Thu, 01 May 2025 21:05:34 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fb836sm4510635ad.141.2025.05.01.21.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 21:05:33 -0700 (PDT)
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
Subject: [PATCH v2 0/3] fbdev: Add deferred I/O support for contiguous kernel memory framebuffers
Date: Thu,  1 May 2025 21:05:22 -0700
Message-Id: <20250502040525.822075-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current deferred I/O code works only for framebuffer memory that is
allocated with vmalloc(). The code assumes that the underlying page
refcount can be used by the mm subsystem to manage each framebuffer
page's lifecycle, which is consistent with vmalloc'ed memory, but not
with contiguous kernel memory from alloc_pages() or similar. When used
with contiguous kernel memory, current deferred I/O code eventually
causes the memory free lists to be scrambled, and a kernel panic ensues.
The problem is seen with the hyperv_fb driver when mmap'ing the
framebuffer into user space, as that driver uses alloc_pages() for the
framebuffer in some configurations. This patch set fixes the problem
by supporting contiguous kernel memory framebuffers with deferred I/O.

Patch 1 exports a 'mm' subsystem function needed by Patch 2.

Patch 2 is the changes to the fbdev deferred I/O code. More details
are in the commit message of Patch 2.

Patch 3 updates the hyperv_fb driver to use the new functionality
from Patch 2.

Michael Kelley (3):
  mm: Export vmf_insert_mixed_mkwrite()
  fbdev/deferred-io: Support contiguous kernel memory framebuffers
  fbdev: hyperv_fb: Fix mmap of framebuffers allocated using
    alloc_pages()

 drivers/video/fbdev/core/fb_defio.c | 128 +++++++++++++++++++++++-----
 drivers/video/fbdev/hyperv_fb.c     |   1 +
 include/linux/fb.h                  |   1 +
 mm/memory.c                         |   1 +
 4 files changed, 111 insertions(+), 20 deletions(-)

-- 
2.25.1


