Return-Path: <linux-hyperv+bounces-1585-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22685EEF8
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 03:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95742835FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AAD179A5;
	Thu, 22 Feb 2024 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/xjGkef"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3514A96;
	Thu, 22 Feb 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567847; cv=none; b=Gs+zTrQzWMFsPEURP2Z1nojmutr3vtzBe5SHWFRpw+fi+TLxN3JNGMaHUCOzDxO1YRbi9+FWGZSRC1//7erTgOKh4Qv406M64Q0FrWRYQeMc/SDtf7uBRrDb+Vv3DYcW3ghkKz725R6DMBXcW5va3Lo6P6cSKAT0kjNZLdoOzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567847; c=relaxed/simple;
	bh=8XkLUNnnlS6h4MhP9sFztYAow339/JGLs2qnxvPxDGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S0hKdVG+CxQ/64TEYVtDiBt9YLmtnsH1wBZJRtnTTiccuip4ALsEwzCF62+PXWxkWbKw2o9qE4iDDxPa10lMI9UZd6ZeHtPoQ0fhy8iNxWoTqmjT3s4jQ+yHfaGDgKhbL4Ef6RrKFapdjx3nzmRgZbLP7P2NOp06d0uSyzJfZt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/xjGkef; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567846; x=1740103846;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8XkLUNnnlS6h4MhP9sFztYAow339/JGLs2qnxvPxDGk=;
  b=T/xjGkef1PZh7rc1gJpvbYkGcHDFto9w7zc8ugyH65oQWUyeSepB968l
   1h90SPNv12YUfQv4BecEkz4ypZO0IV2kkErZLQK0S4raCdnIuizAZAZjW
   SIAwaae0FydEuXTsDc21dGabOJf/OIAbQddrS5WUN0xkajW4nCuDlqdWS
   N2uS68+Nm8KbIexCVu7QkfE8GPB5jFELqwCUL7a5DGKeFRg3bXXAo0qIc
   83jiXRTAM9UqicJ2gseLqDOu9oIryzgPubvTAKlijJlH6gJSiX1FQpWtV
   h9x+z+dctEpwiXJDCmcDwIaVrTWAbffoUULixDpo0H8Pxe4Htc9Yc6gzy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2641036"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2641036"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5226895"
Received: from nlokaya-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.62.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:43 -0800
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
Subject: [RFC RFT PATCH 3/4] hv_nstvsc: Don't free decrypted memory
Date: Wed, 21 Feb 2024 18:10:05 -0800
Message-Id: <20240222021006.2279329-4-rick.p.edgecombe@intel.com>
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

hv_nstvsc could free decrypted/shared pages if set_memory_decrypted()
fails. Check the decrypted field in the gpadl before freeing in order to
not leak the memory.

Only compile tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 drivers/net/hyperv/netvsc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index a6fcbda64ecc..2b6ec979a62f 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head *head)
 	int i;
 
 	kfree(nvdev->extension);
-	vfree(nvdev->recv_buf);
-	vfree(nvdev->send_buf);
+
+	if (!nvdev->recv_buf_gpadl_handle.decrypted)
+		vfree(nvdev->recv_buf);
+	if (!nvdev->send_buf_gpadl_handle.decrypted)
+		vfree(nvdev->send_buf);
 	bitmap_free(nvdev->send_section_map);
 
 	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {
-- 
2.34.1


