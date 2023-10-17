Return-Path: <linux-hyperv+bounces-548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C5C7CCDE7
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 22:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3A2281ACC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3FB43113;
	Tue, 17 Oct 2023 20:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Um+2RAUy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623343118
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 20:25:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2110F;
	Tue, 17 Oct 2023 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574337; x=1729110337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSf/vP0NH+csMyG/vIllMJkrSA3cYI1t+FXhK7zth7Y=;
  b=Um+2RAUycHg4eO51TJWq4jYMYZ6sC8BRA31uq0cfcE7e/l2kMDKlCic+
   XXbJWSGe/0QxqaqPMuEFCrlu32xJ1yPAxbJ7PB7pb9OdP7xXDHWoy02s+
   ZgLnqmBz6NdOqZLxWy+uS9iDfBz+/EzJ9gs9uuEa5AKYBdGkZBmLx4aq1
   qNTxNpFhF+rxvwnuUXS0TctXsQWuEK4Nx2EeDyVZYsgqSpaJubi4Dksjf
   8BxRN8SyEAJueIixOnv+Vg39pppoDdUzYkjnvWwH3VoM+PM+ihlz80IjU
   GukS1tRaIzt1FdHk2VegNZuk3AC3Wc2MQHcJxCjxjneFjggAHcLAGjrTh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429585"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040471"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040471"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:33 -0700
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
Subject: [RFC 08/10] hv: Track decrypted status in vmbus_gpadl
Date: Tue, 17 Oct 2023 13:25:03 -0700
Message-Id: <20231017202505.340906-9-rick.p.edgecombe@intel.com>
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
index 1ad8f7fabe06..0a7dcbb48140 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -479,6 +479,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	ret = set_memory_decrypted((unsigned long)kbuffer,
 				   PFN_UP(size));
 	if (ret) {
+		gpadl->decrypted = false;
 		dev_warn(&channel->device_obj->device,
 			 "Failed to set host visibility for new GPADL %d.\n",
 			 ret);
@@ -551,6 +552,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	gpadl->gpadl_handle = gpadlmsg->gpadl;
 	gpadl->buffer = kbuffer;
 	gpadl->size = size;
+	gpadl->decrypted = true;
 
 
 cleanup:
@@ -564,9 +566,10 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 
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
@@ -887,6 +890,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
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


