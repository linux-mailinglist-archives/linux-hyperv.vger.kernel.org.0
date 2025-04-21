Return-Path: <linux-hyperv+bounces-4984-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D4A95414
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 18:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B909B1892604
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Apr 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0F1CAA92;
	Mon, 21 Apr 2025 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2gtsnZC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795729D0B;
	Mon, 21 Apr 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253100; cv=none; b=Wl33sQlNmK74brGNthTbwH/WziPzBldd3QxdAwL6Hmy8BxMfYOHgUG2cX7kxjvhGKEH5QBHY7pKUGGEwp+QVSu9aR6A4HEFbr+4UVDgyvyq5Bz3W0TWzZHOn0CZKM1g8zwrQY115WZtuenNhBfFw+QDxWIkodDZ6PQorsF/FvAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253100; c=relaxed/simple;
	bh=3lrE0+63AWEPmGxlEgL/uu5jRCeKcE6towtu7BmXinQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=f4/NnIwLVZYI9uNsUndG0qcKwCURnxsoy8OAaL3TPSV+Ar56NBKmiiQuE/GbkHFteb8RYnZv0h68Dx/CStnNRkVeJowPIXw8Y3R4gwAhSvmSe4UFk2CBf0OUWMOis9vOjsL+l+y1br3L9xccY3ve0RTCTSltxWQjlhItCtsQQRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2gtsnZC; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd581c2bf4so3355584a12.3;
        Mon, 21 Apr 2025 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745253098; x=1745857898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClCH8jXA6JW+/hC5t2stoAlBQ8ZgdUL5ZJ20aMzFJZw=;
        b=J2gtsnZClwgUIqwtTU0s5CygEHRZbhyR+/fA2bsYDOuZTFhHSEQzmoiqYoQbogB+vv
         Jymi/SR4c0HlylRkb6QAcRqERopkJP0I0mjyXndZAvQK7W0LZpR4bZLl1g8qYnodjMFl
         vPLqT2DqDcB5pqHm6ARp/ibFGe3Xyrk9FN9Nr5gjSGOQZCuM0/Qqc5nAiSdLs7qcuF4a
         oyk/xCE1Lh5E8i5/IVS2wv+SwEYf0PkS41qO8fbg5fWsrwMwZzq3ndZ6so3+Q/7JDj74
         p+BDUAGfGGzG0d6fsE2MaGGUR0Xi/3DpCLm5vppnCLfG3XT5QtvFQALNieHDUVtsF7AI
         8IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745253098; x=1745857898;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClCH8jXA6JW+/hC5t2stoAlBQ8ZgdUL5ZJ20aMzFJZw=;
        b=EkuwaMzpSu+r/sCl8TgEFhirWM1Rj59PXNQDjghdqHLO5Q742fWUUCLNww7N9M5//k
         01oRt1tO4mrb7GHYci1nm1HURYAOtJmhfktgYWFyVYwJnc/NtVFORWNWleAyx5g9TiHC
         PZ0eGSzw/M4Os2cRIKlHSQAVCYmFUFL0wT2mh5e7z3aL8Hxf82qYMS77VGq4Mfi1g6uz
         zDbJqNP8D4bHPKMIUA/371s5y84xQ0X+A0VumXyEHG7kknyIuAdVtdl0wd5aEWFh57Y2
         VIQKOpEr1RoylB4YfYPxxX97/5sMt40k75Z8KSNA41pmwJ6Fn4PAINt7nheEZlfYUvYX
         RwIw==
X-Forwarded-Encrypted: i=1; AJvYcCUtC//auNjSDRCR29Hl/0KktqHqPKQS9HEkItiThDFrnv8RusrgXa3xD79Id6pOvvNopOnG4Lu8vMwPRxBI@vger.kernel.org, AJvYcCWaK8hBzqRygmeGAqYo0+f4BPc0m+nW4M4D7ZRZ6p03HxUs/cPPM8ERmEbPrNonlSku/8iMxY25+5brk74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRKa+bopo5dN71VA39Cid8nYg0zY3rpFgR8hBs5Z6wjSWYw968
	hGwwJShDClM/9OLYh2nL1NILmvnup7IGE9WiODcZwXGxzxk3BaOx
X-Gm-Gg: ASbGncvtnuDvWvhQmvLgpzpE6ZOYbVHyRNyoC1HIbr89s6OWOwwk5mhRV1TvUR5d4n6
	BFLD/GVjKpcmF0TYbeeIlrytTK8BvFBdrcWtEkppE+ZDuK0tZVrO61QXPoMT3W2jd4gJqmFhIMF
	OO7GYOxDIloFesCNK7VSt+U4fdGVc5FfOQDH0dhX1d4un77bDiMMToSZG5A1YrzKA8K4TUDKlNj
	j30P8o3jUKGsHRPwLbbuaBZNqzPy816jXw1cSO8gR/V0tYOShBW+AA7IvBG++8mNZ0o+Y1QXZuM
	MvVW8z/+li9UdPWwwht/YgdBRS1vuJTvcMvLBb6Skc+0bGDHJcZ1fvSEhAaUBQuEYq+30c4PeeH
	0CXzR0vwAo7KiemAeHSl2R+ScM74EvQ==
X-Google-Smtp-Source: AGHT+IGe+ua1jK0NE4n/pHXgK8IkUWJ2fSSgauPCGPzNdgi/gx2ffm6fSKTwsaH6vwLHmxK0tbEsEw==
X-Received: by 2002:a17:90b:498f:b0:2fe:8282:cb9d with SMTP id 98e67ed59e1d1-3087bbb7085mr18361246a91.28.1745253098532;
        Mon, 21 Apr 2025 09:31:38 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e224a06sm6790518a91.46.2025.04.21.09.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 09:31:38 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	kys@microsoft.com,
	nunodasneves@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Fix bad ref to hv_synic_eventring_tail when CPU goes offline
Date: Mon, 21 Apr 2025 09:31:34 -0700
Message-Id: <20250421163134.2024-1-mhklinux@outlook.com>
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

When a CPU goes offline, hv_common_cpu_die() frees the
hv_synic_eventring_tail memory for the CPU. But in a normal VM (i.e., not
running in the root partition) the per-CPU memory has not been allocated,
resulting in a bad memory reference and oops when computing the argument
to kfree().

Fix this by freeing the memory only when running in the root partition.

Fixes: 04df7ac39943 ("Drivers: hv: Introduce per-cpu event ring tail")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/hv_common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index b3b11be11650..8967010db86a 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -566,9 +566,11 @@ int hv_common_cpu_die(unsigned int cpu)
 	 * originally allocated memory is reused in hv_common_cpu_init().
 	 */
 
-	synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
-	kfree(*synic_eventring_tail);
-	*synic_eventring_tail = NULL;
+	if (hv_root_partition()) {
+		synic_eventring_tail = this_cpu_ptr(hv_synic_eventring_tail);
+		kfree(*synic_eventring_tail);
+		*synic_eventring_tail = NULL;
+	}
 
 	return 0;
 }
-- 
2.25.1


