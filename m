Return-Path: <linux-hyperv+bounces-8290-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BB3D20BD7
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 141CC3024E67
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jan 2026 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE6C3346BE;
	Wed, 14 Jan 2026 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq3dxirv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCA133375A
	for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414516; cv=none; b=dvJSS/GlrmY+xeI1MwAB7tD9TGeckr0CW6ZqO8BgNnHBWH6OYggdST1HPT5khc8hpqVxL4xrTim8MpX0pFnbMFjzhFEJeSpCNrvcUZGGqnz8oFF/hZtDnWUXjt/uMKtW3uOKv2ahhAUUC5bS/TiR0XgEAK5V8nPBBDwoBD4PL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414516; c=relaxed/simple;
	bh=rW1ZqxogCDjiGxyN+dAZxBf5fB/69U7V5wvJFQfWmEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KvqtVEmYxaCxvhc4+ev/5Q+uofKl4jQPhdUMIa6VbbeGXxU51Dvff5mMIsvuvLNPAxrNfYq2DwPe9WY1rFsbRO3kGkndZFgGgk/O3MvjC1hgZy5llZL8AJOvhWNKDYUHBKmfORPe+xwRU/8bZb4SUd3Tz0BZ8OmdGwZCSR+aCYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq3dxirv; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81e93c5961cso60258b3a.0
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Jan 2026 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768414514; x=1769019314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8D6RpKurz3eg36uw/bVnaf4+112TvEN8wCabvWoOoL8=;
        b=bq3dxirvnD3lCLYYaCdjvgWe2NR6znYI9aAEzZK0Oj6wvtdIRin5ZhYq7o8Y3VUwJP
         K6sKFcVYKOts697SlwNdy2j22nzKX5XETi0+puuJWRIsrk0Pi8sC7KETupLaxf6zD3Lq
         SIVPenrur7d+r47LsXX+okA1RzM6F54peDsX7Mr4aEJXsneY1Ly3kmk0tP33+ouuFLN1
         N8cXzkrR4XZjSD2JKEObjgviQvpgIZAhriJo0TLASyexG50tdszeYpo4jkmSHu1ENUHh
         ngf7yMo4EgFH72yL22d44NLZ6G13+N7oft7dfTlvaAIxKocqlmm7Cy/pexOYmu5j0kBi
         ylDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768414514; x=1769019314;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8D6RpKurz3eg36uw/bVnaf4+112TvEN8wCabvWoOoL8=;
        b=oxxAEalx5TucDQVRxf38+Nncx9lq7gv99051IdLObOYHwGLCXH7dW+7T9KYQ5p7EAv
         mkK5GIN+3yI0mqLWTYyBe5hGM7qvAeQwdvVxJiFXvZFTOEcHe9vjAgjXN6BN1O4+xb5/
         cqavJW8o5oDaNKtZXo0b2BD6knO5f7t7IeS2M/487LylgND7gUKokJKkcnFXa0Iw2NKr
         57zd3Bu3fDKh48NGmQuVOAZdfftM37MuaVneTTCW5R0s3S7JkXCLMfwyNGpsHBzPlLui
         G78QZfxkFzhl0qnNFlIl3f5LCkXkPsklzDneZ3V6+7HiXLw1DWDlKCTUvgxRRCl5pC+H
         1MLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOABEJS9X1DRRc7PYxttPFk+0wW4YZBlObkw27ihswHp0xt/KvM7mNxH2LhX5ChgeE8N/ppRDF56yxRa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YySKnD6A+UTTevKDh7HPVenziR6XXth0WgDwHnSJAsrvL+1x3Xn
	pqQxdpvZ5m/gesNVYZjNS+s8rggKntYwH5pugh+ujHY2n5P3bpR5JPgu
X-Gm-Gg: AY/fxX5tovIT+YY6rzXUF6PDvsxT/lapvK3eNd+WRh4D/qmcQv0fpaL6LidJ5ruYYvQ
	2dohnCmMinBCayOJTr+pinHiGJxT+IwkpIqU3V/oEn7h5LDgLEaKm+R3/2ev6bXEv7JHZDlBjLk
	5I3IJ6bWI7PDRfuO7R/5MVJaogMb3WT955OhkoMv3rrltMpQevCFPtx+Fh3vAEFdBnW28Z2SZKS
	LS55L6FPXCMnV8m+AT8iVZTxpi+m3Oosk/Y34m+vca3f/nN/tkk2qOkE+aJJJ+jIbK721DnoXL6
	/eZbovp2wdT9FrpSGDdtb6tSEO4/QOrjUtuqRaigLTRzAirvKoKHvUQp4TwrpQWWatcRULJeCTl
	RhbNeKzCRQmHrU/1/M42/eQuBjV+yWhjGO+8e+y/og5cHyIMKwyFUtUpWwSLgCvVfkKWmFeTm10
	9SkRNZG+10+7Tzj0OBZyvQPeSp/4EwXTG3r+VjixpTpQhA7xCxs3LMu+gOnLQ0y+h4kA==
X-Received: by 2002:a05:6a00:35cf:b0:81f:4060:338e with SMTP id d2e1a72fcca58-81f8202f7e9mr3541903b3a.70.1768414513657;
        Wed, 14 Jan 2026 10:15:13 -0800 (PST)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81f8e4f19c5sm229884b3a.23.2026.01.14.10.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 10:15:13 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mshv: Add __user attribute to argument passed to access_ok()
Date: Wed, 14 Jan 2026 10:15:08 -0800
Message-Id: <20260114181508.143564-1-mhklinux@outlook.com>
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

access_ok() expects its first argument to have the __user attribute
since it is checking access to user space. Current code passes an
argument that lacks that attribute, resulting in 'sparse' flagging
the incorrect usage. However, the compiler doesn't generate code
based on the attribute, so there's no actual bug.

In the interest of general correctness and to avoid noise from sparse,
add the __user attribute. No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512141339.791TCKnB-lkp@intel.com/
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/mshv_root_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index eff1b21461dc..5673af9fe101 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1280,7 +1280,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	long ret;
 
 	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
-	    !access_ok((const void *)mem.userspace_addr, mem.size))
+	    !access_ok((const void __user *)mem.userspace_addr, mem.size))
 		return -EINVAL;
 
 	mmap_read_lock(current->mm);
-- 
2.25.1


