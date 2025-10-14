Return-Path: <linux-hyperv+bounces-7215-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC427BDAECA
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 20:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86837354C6F
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Oct 2025 18:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115C72877D4;
	Tue, 14 Oct 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R35U3C86"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AA21CAA7B;
	Tue, 14 Oct 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760466021; cv=none; b=Jwk9bwDS4pXTjdbyvnAc70PKtKaoZ3mqFDkj5W0WsggnS2IkJkPdLceH5W+We/M24wqKMmIv0+oegsoYreEBqLd24nOTSpZm4f/RmdpSQHygkd3LgTmLsnpRcihMwHeBNrBjPme0ONd9OhwrvRWatiAXbe5nIRrNeN+1vyojGSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760466021; c=relaxed/simple;
	bh=Ge8bZzqTZtACS03wuCkjnuQUyh5+wlGvsRm04Lsr0JM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=E/Q8BGJy02ifRHw5m5QBlV0HZaeKVaz+duekkfbMSM2Zbu5ItR3e6btxzFCbR3STBIG3rD20DWFDsfpiA3KkppVdEWulF0TXsvkM38mnpPYoWVoTYCLl69BCpT+SsgXKhoDNpRAt0i99X0hBUYVedE5Y7n5mGOa+A81bdwTvzT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R35U3C86; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 229A82065960; Tue, 14 Oct 2025 11:20:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 229A82065960
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760466019;
	bh=CJ/Zr2rIDGDNMpH4+REXEGv2gQYlaByJWMAnj1Z/WwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=R35U3C86/Tt3lPw2xDKhvuvFQrD0DDiWdIMNmkYFQqgWJNlzcuxx3T0X1Q6kTOu9K
	 LgMBmERtZnGBp88Fh3Xu9/gSRe+eeOuj+vwWdYTQghNSgNUOCeExctqi+2+Qoa9QyQ
	 o06452e4UyES6XTcKjRbh1YX5UhlbyPgWyVp637M=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	skinsburskii@linux.microsoft.com,
	mhklinux@outlook.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH] mshv: Fix VpRootDispatchThreadBlocked value
Date: Tue, 14 Oct 2025 11:20:17 -0700
Message-Id: <1760466017-29523-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

This value in the VP stats page is used to track if the VP can be
dispatched for execution when there are no fast interrupts injected.

The original value of 201 was used in a version of the hypervisor
which did not ship. It was subsequently changed to 202 so that is the
correct value.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e3b2bd417c46..8a42d9961466 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -41,7 +41,7 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
 /* TODO move this to another file when debugfs code is added */
 enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
 #if defined(CONFIG_X86)
-	VpRootDispatchThreadBlocked			= 201,
+	VpRootDispatchThreadBlocked			= 202,
 #elif defined(CONFIG_ARM64)
 	VpRootDispatchThreadBlocked			= 94,
 #endif
-- 
2.34.1


