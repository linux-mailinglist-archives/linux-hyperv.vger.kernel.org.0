Return-Path: <linux-hyperv+bounces-7047-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B793CBB20CD
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 01:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76AD83C796E
	for <lists+linux-hyperv@lfdr.de>; Wed,  1 Oct 2025 23:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3C9288C96;
	Wed,  1 Oct 2025 23:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k9/Bxxex"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338C25C70D;
	Wed,  1 Oct 2025 23:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759360130; cv=none; b=JsUmnxDCSUY2ZJhdeE/y8P7d2+GBGVuWDYTtdE/km2ZddUu0Op4IPbeg8Q9ne/Wsk8zmM8R78dEHZUVeIcXnKBexHFa63v+O/bphvuZccGsGvYYBk37hQjMS5+xX6JlsTgg2PBAwejgernrQv4AmrwIiW6PITKHg9cQqEU5AAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759360130; c=relaxed/simple;
	bh=YMmsb4G1uzXBYcOqTyh1VxCZc8xEot6/8E8vBWAsaHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CVA1Gs7yF2shqBy9r7oi1VDGzuD8a7/k1Wkgf633iNinE60gs8sftO3Wk627+uAth7sqhbD2xXqHJVjtrxvX2RyRFxGm6vlEuwWQZHiEf6+PtW+hA9K8/n68O08EbzTLWNmj9hno6FeSoCW7Y29g7OFu3YsvBmwAKx0taP2mmu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k9/Bxxex; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.1.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57DD6211B7A0;
	Wed,  1 Oct 2025 16:08:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57DD6211B7A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759360128;
	bh=r6gpP7tkcYevXHNP/4erkMaiUhflR5w3HHz5mWg+LZ4=;
	h=From:To:Cc:Subject:Date:From;
	b=k9/BxxexLZ8ap7S3zS5dZIV7et0as3F8ey3TIGz3o0sQLI2ozkzAAeAAGv3lzyvig
	 8h6vPo0Kj8l/83Wp0BxcOi/j5p1D5KPSN6fhZti8/U7CvONrFEW+0+Am92GFMt7cSk
	 jUHohM4R1lVBHt+2o7usbZevScKqnqmBOoEXHXmk=
From: Roman Kisel <romank@linux.microsoft.com>
To: decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: benhill@microsoft.com,
	bperkins@microsoft.com,
	sunilmut@microsoft.com,
	romank@linux.microsoft.com
Subject: [PATCH hyperv-next] hyperv: Remove the spurious null directive line
Date: Wed,  1 Oct 2025 16:08:46 -0700
Message-ID: <20251001230847.5002-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file contains a line that consists of the lone # symbol
followed by a newline. While that is a valid syntax as
defined by the C99+ grammar (6.10.7 "Null directive"), it
serves no apparent purpose in this case.

Remove the null preprocessor directive. No functional changes.

Fixes: e68bda71a238 ("hyperv: Add new Hyper-V headers in include/hyperv")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 include/hyperv/hvgdk_mini.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 1be7f6a02304..77abddfc750e 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -597,8 +597,6 @@ struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
 #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
 #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
 
-#
-
 /* Hyper-V defined statically assigned SINTs */
 #define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
 #define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001

base-commit: e3ec97c3abaf2fb68cc755cae3229288696b9f3d
-- 
2.43.0


