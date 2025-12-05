Return-Path: <linux-hyperv+bounces-7976-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA66CA93DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 05 Dec 2025 21:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1736330C4098
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Dec 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B272128A1D5;
	Fri,  5 Dec 2025 20:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hiPmfBoc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D2D20010A;
	Fri,  5 Dec 2025 20:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764965852; cv=none; b=iFjYadA/xBriq3N5/zqouBjcF3J09ktR61PEB9R0x/ZU1xQ7a7GsZsRP6IRtBlrFIe/vEVkLrH1+H9j045vVbHZY0My+AWhmZVTiA2lKviGhvHbECp4C1jvOIVyycNUcN3J6z2vcZXqcnEi0EEgnNO11dFy4pD4DT3PXCBB+vaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764965852; c=relaxed/simple;
	bh=n9gV4DrpdvreX38QQ1D2a1kZySMSBZwlagGVB9JHbt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S8cOCYtgEjLc0MKjTGJ8jkaOCRwEy70+DjkYZXCZ7IWKdZz7EL1Bh8hluhonI0VCh5MOJWMGUbqtaAI12lNZzqssnCfpD8tC92n0a14csWcmpDhBNW+bozJPRlbbQUuuMAPKLnTi+n5+VUTbytUiMxtsq59tuiRTTV88DaXxq8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hiPmfBoc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from home (unknown [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9A7A82116020;
	Fri,  5 Dec 2025 12:17:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A7A82116020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764965850;
	bh=e8rblt25W34KVLuFYTjAZnmSf2qSFyvu+2x0Oe8gFKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hiPmfBocTm/CA0mr47LqhV10bIN2wclQHPIHwhiVt86d4XFPCSSqFDn6+t+x//5SQ
	 HBVXHmKUCWVo18qyesCw7GtT5TRH/Un8BJpwqYfPu63ajBSzOxAk0bkwYCz09qYwVH
	 GL0LBKMLTFcwexRAvm/iGGY1aj6hPYW4CDeu1yXY=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com,
	skinsburskii@linux.microsoft.com
Subject: [PATCH v7 1/4] fixup! Drivers: hv: Introduce mshv_vtl driver
Date: Fri,  5 Dec 2025 14:17:05 -0600
Message-ID: <20251205201721.7253-2-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205201721.7253-1-prapal@linux.microsoft.com>
References: <20251205201721.7253-1-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the spurios "space" character in Makefile condition check
that causes mshv_common.o to be built regardless of the CONFIG settings.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 58b8d07639f3..6d929fb0e13d 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -20,6 +20,6 @@ mshv_vtl-y := mshv_vtl_main.o
 # Code that must be built-in
 obj-$(CONFIG_HYPERV) += hv_common.o
 obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
-ifneq ($(CONFIG_MSHV_ROOT) $(CONFIG_MSHV_VTL),)
+ifneq ($(CONFIG_MSHV_ROOT)$(CONFIG_MSHV_VTL),)
 	obj-y += mshv_common.o
 endif
-- 
2.51.0


