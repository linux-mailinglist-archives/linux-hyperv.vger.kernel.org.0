Return-Path: <linux-hyperv+bounces-6657-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B99B3AFEF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 02:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56BAC7B39FF
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Aug 2025 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134611ADC83;
	Fri, 29 Aug 2025 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k+d65/uK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32B19E992;
	Fri, 29 Aug 2025 00:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428236; cv=none; b=l++ajXojtQtrBxoC9+TppQiHCdJotWugDtrf+Wxz7k8xHPWcdwLKE+JAla/DpGyVdviSIW+Dw6FKDxMR/qF70gXEkPEg02k55zcr/3BfpsOvVgKyYH9OddAwnauhN86IftjfsIPBjI5H82yUN9wxUy3UGUO0GKf2dE1QuwE26r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428236; c=relaxed/simple;
	bh=jFSw61IOLTiTAbm5gRQkIEwbOTz3g/CuYWr/PcJWtAM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hjFS4aHRw3AEPUiW0RetmGPef9F173Wn4e3jXz68C1jB9wpVldgUB0cnV5yvt6EzvHLAozmJkfE5+OdZ26LGqbrQUH8gRSt19Ljh3oM81VvNT47rnByKGU/1hxxRrAbqS8pzogS5ICMYyCwkLimb6Qx51azJ7Czi86Ov5yYCHxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k+d65/uK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 437E6211080D; Thu, 28 Aug 2025 17:43:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 437E6211080D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1756428234;
	bh=UBWvFegNau9U+GCCjgmpGfBGeHuAarZxBhsnzY50k6Y=;
	h=From:To:Cc:Subject:Date:From;
	b=k+d65/uKGOV1/zhY1jofA/8z7/gXcg5QM1egr3cmIzts8Tls5UY8guHT219MebCFc
	 BTq8LFQGdRMAwQ710YYRoPuBdZVVI2ZGokj+6cHk4Tmm9fGDbMtofULONu9w2PiO4L
	 3YM6dR42ZrOi1U7SJQ1FeAdS8sD/JmFL5Rhh5ehw=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH 0/6] mshv: Fixes for stats and vp state page mappings
Date: Thu, 28 Aug 2025 17:43:44 -0700
Message-Id: <1756428230-3599-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

There are some differences in how L1VH partitions must map stats and vp
state pages, some of which are due to differences across hypervisor
versions. Detect and handle these cases.

Patch 1:
Fix for the logic of when to map the vp stats page.

Patch 2:
Compatibility fix for configurations where hypervisor does not provide a
"PARENT" stats area, only "SELF". Fall back to just using "SELF".

Patches 3-6:
On newer hypervisors L1VH partitions must allocate and free stats and vp
state pages, and use a new hypercall HVCALL_MAP_VP_STATS_PAGE2 to map the
stats page.

Add HVCALL_GET_PARTITION_PROPERTY_EX to query a feature bit to determine
whether to allocate the pages and use the new stats hypercall.


Jinank Jain (2):
  mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH
  mshv: Introduce new hypercall to map stats page for L1VH partitions

Nuno Das Neves (1):
  mshv: Only map vp->vp_stats_pages if on root scheduler

Purna Pavan Chandra Aekkaladevi (3):
  mshv: Ignore second stats page map result failure
  mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX hypercall
  mshv: Get the vmm capabilities offered by the hypervisor

 drivers/hv/mshv_root.h         |  24 ++--
 drivers/hv/mshv_root_hv_call.c | 227 ++++++++++++++++++++++++++++++---
 drivers/hv/mshv_root_main.c    | 140 ++++++++++++--------
 include/hyperv/hvgdk_mini.h    |   2 +
 include/hyperv/hvhdk.h         |  40 ++++++
 include/hyperv/hvhdk_mini.h    |  33 +++++
 6 files changed, 390 insertions(+), 76 deletions(-)

-- 
2.34.1


