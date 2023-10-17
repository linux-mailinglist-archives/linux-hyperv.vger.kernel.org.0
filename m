Return-Path: <linux-hyperv+bounces-547-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620D47CCDEA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 22:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E774FB21302
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204D4310E;
	Tue, 17 Oct 2023 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXuEGd1Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747E2D02B
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 20:25:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EE113;
	Tue, 17 Oct 2023 13:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574338; x=1729110338;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n7cfqZUhm+mNRuq80sD29C7/lYhruGMsgMoNg518Mk8=;
  b=YXuEGd1YuuA8OqolNFitTWvyC72DXCtDVrq4iC64qSq0H+WUXbWwob+q
   moFldGrUAkrqIsmMoMBrwZ6+cuYbWgJb5SdNWl1xgaz271bELU9leP1Ew
   xzjHZB5UBcLRhfA3PLkJz1TK4OaCFuGBDJeRzpeRCuibVL7Jf3clrDbTy
   mNqR85YNWgSggizAPJxn3LEW2iBDTt1tJg/EpOSRWV1fSyhnn8uv4TGKX
   z2snsrvYHjwgkdn6EsgEwlC3CYsavy99A7Qulh4pyuiTTo9VxKiittR0C
   muzvRKkUiEFuZ0p6cHvGUTg99J7FnvevMoN32XQfR/dDcVVhpZOGCrPtu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429596"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429596"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040475"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040475"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:34 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com,
	isaku.yamahata@intel.com,
	seanjc@google.com,
	Michael Kelley <mikelley@microsoft.com>,
	thomas.lendacky@amd.com,
	decui@microsoft.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org
Subject: [RFC 09/10] hv_nstvsc: Don't free decrypted memory
Date: Tue, 17 Oct 2023 13:25:04 -0700
Message-Id: <20231017202505.340906-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
index 82e9796c8f5e..70b7f91fb96b 100644
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


