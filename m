Return-Path: <linux-hyperv+bounces-3866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0ADA2E1AD
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Feb 2025 00:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F6B3A763A
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Feb 2025 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89D15B115;
	Sun,  9 Feb 2025 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCfHRKz2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CAB243398;
	Sun,  9 Feb 2025 23:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739145186; cv=none; b=b5ZxnKlVcLk6KdtOXwgToRxEIl7D1+GxPYBd5KTiXPLT5aoww92UxHYaF7Qb54p+JVemyJoG2VUXYCI4wBSRX15BpuqI2FHGL89eaw7Q/yMe5fhAa+xRXbcIfesvcrNrhjTi6g0Vxq9Ihh0iWYgZ7rcBMYfozPOxKp5lGghuxno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739145186; c=relaxed/simple;
	bh=n1ZhMzB9WqBdOr79nn2ngDyHin+0zLTEs1PHbhdl5oI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFY3wiowQysOMkR1pou50Raf5+TaQJLjoVifVHixDaGo57781SzZ5Zwv9SBDzINBiU55GHCj9zlyrBX8M8bwmlehgvct4Bc+jFf3htSlJCC/Djw3zRMEGeR7v8vBuGw9WFkSVQkDmyFN6h+7Lkp2XwdjbkKq3UndOrPHCLCo5/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCfHRKz2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f78b1fb7dso12609545ad.3;
        Sun, 09 Feb 2025 15:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739145184; x=1739749984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWCnWPYL68r0Z2Bnk7TaHU9Wrb4IP7n7TPpDNfmxihM=;
        b=cCfHRKz2b4tDA+Gz8pcJx1a9SjqhcAW80OGl8JW5L0Re0tkUiqv+Mh9pQPgVvugP1o
         PqmuYp8jKYyFLj3G/yjmHvieI8bU19OBGpzDqJ/PK10yXMr23f5urD65J47qc+6xawhN
         MgxMOTaUOPghfSNSFYF3ajuhAEl7R1p6vN8eAcfO6o7YA91t9VQYoxGYYnD9O0FdzB9v
         P1TxPletFE1OqPM+D5l5qap/ovw1PXsKIAVaO9b1NiyeJ3bIuU7ePZLi2RKznRBK+ZxQ
         I9pcg6VfuaEsEAZ8Sw09LserKRMJ8bRohWW9txzkFWnuhf13uaf4s6u8GDPY/15DhW/S
         2Sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739145184; x=1739749984;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWCnWPYL68r0Z2Bnk7TaHU9Wrb4IP7n7TPpDNfmxihM=;
        b=fUe30SBIFtFMp1lID9DTpnsJ4KtoYfV2wob5L5IAJQmpvCbXgmab0VkpFHfz4CUKW2
         CX02Om9DwPMCpLbmYg8yHKV29PHcCIwtxqkkwcMhVqAfBOZIdL+6CU1F49TciJ/0y64l
         ut/CIGYSIliAiDkyk3pF5KP8gRJ6lh0nk+OFMgO1npkrWi0mMs2/Oah/vOSnW0QqGV2+
         1Oy2wSnJnrMKcHXlb/tRL693Dib/n38Zngtw5YIAUdEX20WAAersIrSeJ9M7spEAi20V
         NykqYCD5QOlWAf5UxXw6kLCMHbYy6R1G/8COfRYL83SgG5DrR9+7OWNIU2Sqt3JrpDja
         OWoA==
X-Forwarded-Encrypted: i=1; AJvYcCUkHUQB22zksgWY7MaBf5np6AOwJ/2KS3MIDjz3p9SteBQ+tQcE2qzCxc2xs/CfM6GZZ3rtEOYvlkJhXK1U@vger.kernel.org, AJvYcCVcTT0zXnrM25ns+0QUik8nF30dKSRKRjAflAPBAu2CBXt1xvFyBjJZB542yV0mNdUU++xJBooHDHq4m8Wy@vger.kernel.org, AJvYcCXhGxmjeXb7Pgays9YYHIPleOkoQP0AYqD84BPqf8SmOAl0Ug/83uncpP9k9XOWWAOhvREUH8P8xgmUMg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyfK9EuH66s1gyroff+J6DHpA6Ymsg07UEUVIeh6oq4lcmnIhJ
	Y2mC0OSZ1P3NrydXcM4INvI/AKyJd+UTLv1YknwrUZOuudHNTdNtqLVylg==
X-Gm-Gg: ASbGncs5gfazwUL2tQrG7pS+WZd2R24jjksl8IostdaAXfEQ6a9DlQog4VXpz9W+Vq3
	41dOi/1DiJA9n+RHGIaEV64YQjNr7uBgVC2eaqbtX5ClMKw+Za+XfvOuAFeqekF7kgWA1g/lvY2
	O1/6AU7sler7TZZcFh/M+iJk88y5mvgMZK3m61BmWjQFrazwj37i9zCq6DKbLBsDSdBXQdRKxPL
	/zlWV2mr+tOqEviisjpz5/P0vbQbKg0vgszN2eWRNd8XA10zEBO4XtyLtnagn0f7OZhc3+1mRo1
	6PPRPtcgJNtHFI3U2/Q+sAUS15b2S1eywvGADQIrLsGkIhrKffTAzg33Vx/DqRMo/8Ishw==
X-Google-Smtp-Source: AGHT+IE4FJPyNy5xGYQRplvww+BnPsgZJRqLjMHqBPSL43m6jWzmeKRSRadCcA59GdXx5pLc7fGXtA==
X-Received: by 2002:a17:903:3d05:b0:21f:3e2d:7d58 with SMTP id d9443c01a7336-21f4e6ba733mr154138565ad.13.1739145184345;
        Sun, 09 Feb 2025 15:53:04 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650e6aasm65021435ad.12.2025.02.09.15.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 15:53:04 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	deller@gmx.de,
	weh@microsoft.com
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] fbdev: hyperv_fb: iounmap() the correct memory when removing a device
Date: Sun,  9 Feb 2025 15:52:52 -0800
Message-Id: <20250209235252.2987-1-mhklinux@outlook.com>
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

When a Hyper-V framebuffer device is removed, or the driver is unbound
from a device, any allocated and/or mapped memory must be released. In
particular, MMIO address space that was mapped to the framebuffer must
be unmapped. Current code unmaps the wrong address, resulting in an
error like:

[ 4093.980597] iounmap: bad address 00000000c936c05c

followed by a stack dump.

Commit d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for
Hyper-V frame buffer driver") changed the kind of address stored in
info->screen_base, and the iounmap() call in hvfb_putmem() was not
updated accordingly.

Fix this by updating hvfb_putmem() to unmap the correct address.

Fixes: d21987d709e8 ("video: hyperv: hyperv_fb: Support deferred IO for Hyper-V frame buffer driver")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/video/fbdev/hyperv_fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 7fdb5edd7e2e..363e4ccfcdb7 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1080,7 +1080,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 
 	if (par->need_docopy) {
 		vfree(par->dio_vp);
-		iounmap(info->screen_base);
+		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
 		hvfb_release_phymem(hdev, info->fix.smem_start,
-- 
2.25.1


