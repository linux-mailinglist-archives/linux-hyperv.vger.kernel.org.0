Return-Path: <linux-hyperv+bounces-1707-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1B8784BD
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6777FB20E73
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Mar 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0774AEED;
	Mon, 11 Mar 2024 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0n89fpa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D3481C7;
	Mon, 11 Mar 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173789; cv=none; b=Up/nq0//LMDnVie89tKEkwNe5a3HSOF9bZTRIP+bE8PgsabTEMtGC03o2BtLLAPGPrTrB2H9I8Vj3+TN+k/j5F9lgVRfaocLB60u6gME0PjedZumNLGA2eBrd7GUV4HPENqVQl+mUx/YxNwk+Lu0lFQneLe+gwzYE8/ad9jO7bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173789; c=relaxed/simple;
	bh=KPYk9JxotgHUynNFnqxGdycQ5ugdp7osOeSdIU/c5rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KXVCtImhD/1Y73UID6gjTjICbiW85IOyTC+Cm4BRWsKtGPYJzbmEOpYBCbcmQOUpiS1UaJdU/utWF9kEtgG1bCwlJJd2MrGkUIcgp9W13A5t1b9Ee31yu11/FgF7zKyjwsMtI05CGfJYnEQp39jUVWWAcRNc7S0c5NYtSJrZQio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0n89fpa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2229061a12.1;
        Mon, 11 Mar 2024 09:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710173787; x=1710778587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4lQ8bQAzdsnyz/nAyILsXiibH//empkPkLI+o99v2ns=;
        b=j0n89fpawCUkTF1j9vaA2GcxlhpifHRNHry1tcBxEF/Ldc+QWOVibLTodul1ku9mBg
         e/DWEOVGqVLBJbgBZB7oGsleUdtz4ksqzO7o9u+7SkHV9gejmDS9C0UYI/70aeUoVfoc
         50qhMopsSnY2s7FOFZAwyj1qMCB8Owy6KiKAN6ifSQ59ulRdE6IAcimp40G4iVyIfcVq
         07SWFY3hqz6XE6/7UxdmcQx8wlKRKe0fkeIzl5eFPp1nCJlVGmZElpKZTWjhsb1xl8Kb
         xFHTx6Am53awglu0p4Td6lJUmZRSZCw6icJ1B4GC/Vs+OArfPG2+erbaxFtUg8qGHKE1
         5CiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173787; x=1710778587;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4lQ8bQAzdsnyz/nAyILsXiibH//empkPkLI+o99v2ns=;
        b=dh88e5Q2BEnelVguANMSHxDBoFassfeMSXBfmzm/2Vy1QdSu2yPZaQxr+onMKMfJj1
         XFhg278M62A9W1txb0lBjalhp9GNh6jazxEP26fasIhqIpQOMzGT2U73xoTO28t0br34
         1E6gozBa2jlr+fLfFUKRLu6fDFIzQVCeO+fWwMsRO8Ge8MbPgITTRQPeIYNv1mJshCK+
         U+qkDNpCISeCA1OyxIVRrmj/QisJR2PFkFSwL1v6RYX84wErSiIuEGkc6sQU8DfSigM2
         CeLYayzbJXQxwGGxR5zQmSqLu+qG4GsrydlGcR256D6Orjn4+Bbm23x1Ez7ZEmXqmFvF
         pHHg==
X-Forwarded-Encrypted: i=1; AJvYcCX7TRPAncKtbxK6zZRONRjVkSK6MOvd0E1SwNuG1XGVCgDexj6dTnuc2NKMQSiK97PAVdtKSehCJ+s3vK1Yfpgp6O55iPRJfborMokhd3snewuYkXaeUE3SxgNSYiujaV0c2jS8Xz9sgFsHuAH3cd/IlXPXtMD8M8ywc+wMWKtMmcV3
X-Gm-Message-State: AOJu0Yxaoz0Pdkfpe4p53H5muQdp/ZwECSTL4trhHGJp3FuachVnQmds
	yHPRzfqgcg+sPaNyeF6859XaUUrjNCkvNBfoyZdI4Kx+rrSSkOeg
X-Google-Smtp-Source: AGHT+IGjodke58rrus9B6GEFDDUSlZJWk9z76M96k2TqGgCOmRDPjs6BiylAzmS3N6VxdyT69FyDew==
X-Received: by 2002:a05:6a20:d38c:b0:1a1:57f1:1a01 with SMTP id iq12-20020a056a20d38c00b001a157f11a01mr9184678pzb.42.1710173786938;
        Mon, 11 Mar 2024 09:16:26 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id m22-20020a056a00081600b006e52ce4ee2fsm4576325pfk.20.2024.03.11.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:16:26 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: rick.p.edgecombe@intel.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com
Subject: [PATCH v2 2/5] Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl
Date: Mon, 11 Mar 2024 09:15:55 -0700
Message-Id: <20240311161558.1310-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240311161558.1310-1-mhklinux@outlook.com>
References: <20240311161558.1310-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rick Edgecombe <rick.p.edgecombe@intel.com>

In CoCo VMs it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to
take care to handle these errors to avoid returning decrypted (shared)
memory to the page allocator, which could lead to functional or security
issues.

In order to make sure callers of vmbus_establish_gpadl() and
vmbus_teardown_gpadl() don't return decrypted/shared pages to
allocators, add a field in struct vmbus_gpadl to keep track of the
decryption status of the buffers. This will allow the callers to
know if they should free or leak the pages.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/channel.c   | 25 +++++++++++++++++++++----
 include/linux/hyperv.h |  1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..bb5abdcda18f 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -472,9 +472,18 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
 
 	ret = create_gpadl_header(type, kbuffer, size, send_offset, &msginfo);
-	if (ret)
+	if (ret) {
+		gpadl->decrypted = false;
 		return ret;
+	}
 
+	/*
+	 * Set the "decrypted" flag to true for the set_memory_decrypted()
+	 * success case. In the failure case, the encryption state of the
+	 * memory is unknown. Leave "decrypted" as true to ensure the
+	 * memory will be leaked instead of going back on the free list.
+	 */
+	gpadl->decrypted = true;
 	ret = set_memory_decrypted((unsigned long)kbuffer,
 				   PFN_UP(size));
 	if (ret) {
@@ -563,9 +572,15 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
 	kfree(msginfo);
 
-	if (ret)
-		set_memory_encrypted((unsigned long)kbuffer,
-				     PFN_UP(size));
+	if (ret) {
+		/*
+		 * If set_memory_encrypted() fails, the decrypted flag is
+		 * left as true so the memory is leaked instead of being
+		 * put back on the free list.
+		 */
+		if (!set_memory_encrypted((unsigned long)kbuffer, PFN_UP(size)))
+			gpadl->decrypted = false;
+	}
 
 	return ret;
 }
@@ -886,6 +901,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
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
2.25.1


