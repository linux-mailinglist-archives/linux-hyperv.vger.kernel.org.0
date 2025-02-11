Return-Path: <linux-hyperv+bounces-3889-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A45A302A8
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 06:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A4AD3A4955
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD371CA84;
	Tue, 11 Feb 2025 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZx9g4/d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168F326BDA8;
	Tue, 11 Feb 2025 05:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739250080; cv=none; b=LnKFCJAACd720+yZZ5gQtz8LILvFlnUPc0PQBYo9e7ZPIWvUMTQRHOdg6ElZyxwUMjfi/G/nR+f0ruOa7G1q+JmVBmSAphUZLV6ETrFJsAivHchX+EeGfjvFgugBkTYreWZHnDi8zgN0kvp7+/CyYkW/wKG2rLNHv5z41cI4TMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739250080; c=relaxed/simple;
	bh=vQKDtT4wJGad+6Sz/sx6EE35wJIhNtG2rluetYFBFso=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uyr+GG/6EY+9FAW3luF3JwXqomWuS7WqydkUogBBPtwEBFSwd76+/PznEHpzzfsIgd2GohKLsAncEDPwVaxQPOkPga4BS9DUa36fUaZlGSuBOFSwwxasxPvPK7AnR8abSkPt1WkWcR7HVDRaECN458KuIgzpA/4tfkNVLlxMjwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZx9g4/d; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2339dcfdso80820115ad.1;
        Mon, 10 Feb 2025 21:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739250078; x=1739854878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq1Y9JbzCZgzqj2j4bCWH4V3xZwBd5s8EtAojnql/Ss=;
        b=RZx9g4/dtNZFkOAanbLtOBeRW0KY5/T/b7MpRn1K8ijKPjCvuj7fjPmozEupmRx2RH
         Ywj6D3j0aDGnm16r8+Z1kd8FHoDpyEbRrDnTobI4Ao83T1F2FISdQGxiOYGLPT7bHtEi
         r/kzZfV+IbknaQHn2LhqIKsOSfzBZpYCEcwhVzLI6zMnLsMp0b8EVS/XURkkD9IT8xBA
         l/Fl9WNmHFP8z7mkE3Z8WHiRh5V3Tq/psgfdE6vXxjXrtnd/p4JdKz0vm4gB/cdOtb7o
         vwWzoKMvedgM6t/EH458EfwsMiYq3EuCac0G5ZGgSMqNohCleL9cRSxIJ5a0zh1oHQFb
         Gkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739250078; x=1739854878;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq1Y9JbzCZgzqj2j4bCWH4V3xZwBd5s8EtAojnql/Ss=;
        b=r7uSRw/vaCPtNFouwrvdjak7SlpXiDlA5EVGjXqHHMCiSI6pVEuIWVOXR9NcsYkJuJ
         +TxsltMFT5KdPonxWGQSeeVvxtwjQZz4IqmyJ9DP03ey4ykfFhB/+0laGyLzGvJcJQX0
         X91QV2KLwM0+Yj1xVvH3Do60ku4+FdpGNLHfFvT9QN9AnwVvfM3+hZ85nAOnB6DbPMf/
         BBixSPShQ/FhjLGdPcfhKfzhkX0d3kHp6ErrOYi8QlVZXlnnwmhYvvsajP02fGu+61CK
         TNaXDRbosmHZYoDiByfl9VbNtgCXxR2sT/cgwdaD8G1P90UDAacfD0Q1GPJN4rAW5lef
         l5hg==
X-Forwarded-Encrypted: i=1; AJvYcCV+oqeJ++7woiS92g/4BxYJW6ZW8biVqW1yPS51zyiymu24f12WtMQ0gF7ZDBW3+74S1Vc0lJQAn9fD4Gc=@vger.kernel.org, AJvYcCVbEH8TGi0Ow35bCCduLoyZuQy97n40kH8Hv25gOMzabQZUYJA/jZvrwC0e8Iay4dAie0vIgjSzhFWM9Vgd@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsmqSv7KEEXCKxKwMLOmb+d9VEzImh+R9rn/cR6HJDt64T8ft
	qzdLqIvEO+1igAJrXpLJYDX3fHIHnn8Nur5aURu1Tg4XFT2kf5Vi3GOlHQ==
X-Gm-Gg: ASbGncvsYxTYTNkrT4lATkkCzdBHoK5spyhRdBNFR2bCR1QJC6nDOtEnxY99APFs0PA
	lpjM7veFBeMRwHzIKhAHO2U9ty86/hJp2bWnkJNzr/i6M1yG2nOPm2SkTrkz9Wm49DUTiSNzf5B
	HUe91KcpwURm9alMUV2NrgUD9wsID4d8l5ZZ4yWNpIZOVc+My2CFP340qmfRgGY8DTnavg/uPFa
	vf5/oeQ/vh6K5p3F/2ChD++mgz7xCXrRHkAPiJTfejgyek+hGkR9yrdCDkqf8qrdBBBJJo20Lzm
	bktzTi8+sbTykaXei1Mrd8a8iSvFinGGDtAv/XtR6+2eOt0qy4wdmyaiX2/YoV07Chj7WQ==
X-Google-Smtp-Source: AGHT+IFmEuK5z8XunW2O1A6bS0UYEJirLSunHSkUWdLKfumlWyTv8inVsijdQt6JRN7jNypRQGAzyA==
X-Received: by 2002:a17:902:ccce:b0:216:4676:dfb5 with SMTP id d9443c01a7336-21fb6f3034dmr28026735ad.21.1739250078184;
        Mon, 10 Feb 2025 21:01:18 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f36561397sm87673425ad.89.2025.02.10.21.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 21:01:17 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	jakeo@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()
Date: Mon, 10 Feb 2025 21:01:14 -0800
Message-Id: <20250211050114.1716-1-mhklinux@outlook.com>
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

The VMBus driver manages the MMIO space it owns via the hyperv_mmio
resource tree. Because the synthetic video framebuffer portion of the
MMIO space is initially setup by the Hyper-V host for each guest, the
VMBus driver does an early reserve of that portion of MMIO space in the
hyperv_mmio resource tree. It saves a pointer to that resource in
fb_mmio. When a VMBus driver requests MMIO space and passes "true"
for the "fb_overlap_ok" argument, the reserved framebuffer space is
used if possible. In that case it's not necessary to do another request
against the "shadow" hyperv_mmio resource tree because that resource
was already requested in the early reserve steps.

However, the vmbus_free_mmio() function currently does no special
handling for the fb_mmio resource. When a framebuffer device is
removed, or the driver is unbound, the current code for
vmbus_free_mmio() releases the reserved resource, leaving fb_mmio
pointing to memory that has been freed. If the same or another
driver is subsequently bound to the device, vmbus_allocate_mmio()
checks against fb_mmio, and potentially gets garbage. Furthermore
a second unbind operation produces this "nonexistent resource" error
because of the unbalanced behavior between vmbus_allocate_mmio() and
vmbus_free_mmio():

[   55.499643] resource: Trying to free nonexistent
			resource <0x00000000f0000000-0x00000000f07fffff>

Fix this by adding logic to vmbus_free_mmio() to recognize when
MMIO space in the fb_mmio reserved area would be released, and don't
release it. This filtering ensures the fb_mmio resource always exists,
and makes vmbus_free_mmio() more parallel with vmbus_allocate_mmio().

Fixes: be000f93e5d7 ("drivers:hv: Track allocations of children of hv_vmbus in private resource tree")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 2892b8da20a5..7507b3641ebd 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2262,12 +2262,25 @@ void vmbus_free_mmio(resource_size_t start, resource_size_t size)
 	struct resource *iter;
 
 	mutex_lock(&hyperv_mmio_lock);
+
+	/*
+	 * If all bytes of the MMIO range to be released are within the
+	 * special case fb_mmio shadow region, skip releasing the shadow
+	 * region since no corresponding __request_region() was done
+	 * in vmbus_allocate_mmio().
+	 */
+	if (fb_mmio && (start >= fb_mmio->start) &&
+				(start + size - 1 <= fb_mmio->end))
+		goto skip_shadow_release;
+
 	for (iter = hyperv_mmio; iter; iter = iter->sibling) {
 		if ((iter->start >= start + size) || (iter->end <= start))
 			continue;
 
 		__release_region(iter, start, size);
 	}
+
+skip_shadow_release:
 	release_mem_region(start, size);
 	mutex_unlock(&hyperv_mmio_lock);
 
-- 
2.25.1


