Return-Path: <linux-hyperv+bounces-1586-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A2B85EEFA
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 03:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F331C22083
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 02:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD2C17BCA;
	Thu, 22 Feb 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dNEk7N55"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012431428E;
	Thu, 22 Feb 2024 02:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567847; cv=none; b=aY/UmYHlR8bucPj1XnyRclv8N3zxLAb4L1WKQCJ2WVkHuqs6mtWK/NaL1P7pMc3VbdPm+3jBjjoydBQ9Hp30lU0dFutU1ugsYFzlT984ZssMfbzWIT41rceyQALKKRmMX/iBUtAcBPFl0OVdZ7J2wW8Y+UzUJAoaaYkTINqkcrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567847; c=relaxed/simple;
	bh=UD5rk9PLkBp1RIi0KMC4OnruwWQq2DUII52if4k3oos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VpBayZZe3lB+1GJ3cw94tKQ7xisuPPuI5WuFJf1JwJJnAkKc4ZDOTcdtO1pBVyWvOHxp7vj14mGe7K3+4X0f8i63MrzIBRk78dPAmkzpYYB2C+NXwOy9AxdBkCUf4SXIJyU0icUfqbdPZPc3rtMWvjfJyNtERYKZHOiHMI/ADi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dNEk7N55; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567845; x=1740103845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UD5rk9PLkBp1RIi0KMC4OnruwWQq2DUII52if4k3oos=;
  b=dNEk7N55EznqGAthKQ1OxXCUixVolAdw/wTxneFyeVtS264sSbR2dXZZ
   AqUZxv8pqhxrC2WwjfJvw/N01TpuqTyga3+utRkn7mV8HH4YNFWxGjlZm
   YZKZxHfI95Sr7ZA7mKFbUV1yL95Ms+GDSRLFYIHXoHQdExE2X7sShm1Ns
   JMGCYOF9CN/ZYcXbtblROLyurAm3aXFMsJQbDEanYt7A6uFkstjr837xw
   mPq/Xd7WjVtRFYfJWtEua1TOZE88wjL6eX96JAOpHN+yBJk49bJpJZc+Q
   ZwA591dGSEpbwpECAai9Vjt5Ll3g7Ot3f3hpg93P/OK8c2s0+uwfPjnIq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2641026"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2641026"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5226890"
Received: from nlokaya-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.62.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:42 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com
Subject: [RFC RFT PATCH 2/4] hv: Track decrypted status in vmbus_gpadl
Date: Wed, 21 Feb 2024 18:10:04 -0800
Message-Id: <20240222021006.2279329-3-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

In order to make sure caller's of vmbus_establish_gpadl() and
vmbus_teardown_gpadl() don't return decrypted/shared pages to
allocators, add a field in struct vmbus_gpadl to keep track of the
decryption status of the buffer's. This will allow the callers to
know if they should free or leak the pages.

Only compile tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 drivers/hv/channel.c   | 11 ++++++++---
 include/linux/hyperv.h |  1 +
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..fe5d2f505a39 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -478,6 +478,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	ret = set_memory_decrypted((unsigned long)kbuffer,
 				   PFN_UP(size));
 	if (ret) {
+		gpadl->decrypted = false;
 		dev_warn(&channel->device_obj->device,
 			 "Failed to set host visibility for new GPADL %d.\n",
 			 ret);
@@ -550,6 +551,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	gpadl->gpadl_handle = gpadlmsg->gpadl;
 	gpadl->buffer = kbuffer;
 	gpadl->size = size;
+	gpadl->decrypted = true;
 
 
 cleanup:
@@ -563,9 +565,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	kfree(msginfo);
 
-	if (ret)
-		set_memory_encrypted((unsigned long)kbuffer,
-				     PFN_UP(size));
+	if (ret) {
+		if (set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
+			gpadl->decrypted = false;
+	}
 
 	return ret;
 }
@@ -886,6 +889,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 	if (ret)
 		pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
 
+	gpadl->decrypted = ret;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 2b00faf98017..5bac136c268c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -812,6 +812,7 @@ struct vmbus_gpadl {
 	u32 gpadl_handle;
 	u32 size;
 	void *buffer;
+	bool decrypted;
 };
 
 struct vmbus_channel {
-- 
2.34.1


