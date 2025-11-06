Return-Path: <linux-hyperv+bounces-7445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18695C3D8DA
	for <lists+linux-hyperv@lfdr.de>; Thu, 06 Nov 2025 23:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3435188B239
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Nov 2025 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FD128C014;
	Thu,  6 Nov 2025 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hsLdwz6v"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5012773E6;
	Thu,  6 Nov 2025 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467214; cv=none; b=OrDer1P46Hxg3SZ9dMldDpZr9OZyy9zQOMaMgcQfuqk5MNFueHOGKUjjAERoMMbl+J26zS0PpUPjxWXj20QjcU/oWzxb3Ik3ADD1P/a65cX5/bJaye2miGVKKosHyfsuEGZlmIaJlDofe5wUiTJBt/wFNBZ+S8MzM7NQrYXrWos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467214; c=relaxed/simple;
	bh=RhjRaTQDb/aH+7ce1bs7MNDW/yq9CBrZUdwK7uRcmRE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hGMZezNWs2CKOzKEPgBfwllMFTJqd3f5F3VAaTzHtGfxeJ69tYMMQigWfoNhn/XGqnOo+5AiVyjs/3HcLLzs1u/nibkz2gq7cdcukQgAMGLSbZGepCgXH3i/1ICVUYpNXAoKh1+q6E/3sPbKAoJ5Lby/hVH9CqybWp0rqGCEkxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hsLdwz6v; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 777B8211CFAF; Thu,  6 Nov 2025 14:13:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 777B8211CFAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762467212;
	bh=b7sfTf728Ih9zvv3gAb/QuGUQWX4OQNArbjmiwdlG0E=;
	h=From:To:Cc:Subject:Date:From;
	b=hsLdwz6vOz1we8cvZ1m6Y6LMypQOaqPUDwficEG0jyVOFeBpzqy4WnupP8rL2oKLV
	 UMuSCy7RAgjksS4zIz/gVInBGe4auSPVSux9htElzYqEmMeJ5zmKU+F/EU1ZvdPYCW
	 0PmL4HBvbPsatTSOyorXrAwmHwyP8X5cV3giUzcw=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	magnuskulke@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	skinsburskii@linux.microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	muislam@microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v2 0/2] mshv: Allow mappings that overlap in uaddr
Date: Thu,  6 Nov 2025 14:13:29 -0800
Message-Id: <1762467211-8213-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently the MSHV driver rejects mappings that would overlap in
userspace. Remove this limitation as it is overly restrictive and
allowing overlap is useful for VMMs.

Before make this change, fix the region overlap checking logic
which is broken.

---
Changes in v2:
- Add a patch to fix the overlap checking [Michael Kelley]
- Move deletion of mshv_partition_region_by_uaddr() to the fix patch

---
Magnus Kulke (1):
  mshv: Allow mappings that overlap in uaddr

Nuno Das Neves (1):
  mshv: Fix create memory region overlap check

 drivers/hv/mshv_root_main.c | 27 +++++++--------------------
 include/uapi/linux/mshv.h   |  2 +-
 2 files changed, 8 insertions(+), 21 deletions(-)

-- 
2.34.1


