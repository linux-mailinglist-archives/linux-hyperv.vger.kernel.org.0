Return-Path: <linux-hyperv+bounces-546-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D534D7CCDE5
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 22:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 458EF281407
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F3430FF;
	Tue, 17 Oct 2023 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibyLT5Me"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D343118
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 20:25:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2023FF;
	Tue, 17 Oct 2023 13:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574336; x=1729110336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DeK9M9T8xLg82lbSzsd9PGh1edTcS0OzTNpNIQkWt+o=;
  b=ibyLT5MepQhobD67/052nfhe6pYBEQu/Oy3Bz4PQaXwxoNNmUsmzruXB
   2JPoCZAuETRn+kV2/hlOIGcSyYiXnaUswIaSF2sLKUwmiDjLAOg1dmWPo
   Sqq1GjHNS8STK5wZMyEe1a07nKuHWJSYa5ngdAihkYtDajbUVsnMg3VF3
   yjGWnGMICqR3JPuwu+uYdamomDxnCuokp3b9kAgRM9lCmpGbYWuuu3OIf
   LRvwnG3p7I/8VTAz9aLtOi4nOFsAdtPqgtNxEDHHHfcqH8JHIS6lwBX1Y
   1ZmhTDMShiAWHq5g6mdmSDRWwF8ydRUtrOjByStvvBPm9jASHivRKQ5xe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429573"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429573"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040468"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040468"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:32 -0700
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
Subject: [RFC 07/10] hv: Use free_decrypted_pages()
Date: Tue, 17 Oct 2023 13:25:02 -0700
Message-Id: <20231017202505.340906-8-rick.p.edgecombe@intel.com>
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

Hyperv could free decrypted/shared pages if set_memory_decrypted() fails.
Use the recently added free_decrypted_pages() to avoid this.

Only compile tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 drivers/hv/channel.c    |  7 ++++---
 drivers/hv/connection.c | 13 +++++++++----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..1ad8f7fabe06 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -153,9 +153,10 @@ void vmbus_free_ring(struct vmbus_channel *channel)
 	hv_ringbuffer_cleanup(&channel->inbound);
 
 	if (channel->ringbuffer_page) {
-		__free_pages(channel->ringbuffer_page,
-			     get_order(channel->ringbuffer_pagecount
-				       << PAGE_SHIFT));
+		int order = get_order(channel->ringbuffer_pagecount << PAGE_SHIFT);
+		unsigned long addr = (unsigned long)page_address(channel->ringbuffer_page);
+
+		free_decrypted_pages(addr, order);
 		channel->ringbuffer_page = NULL;
 	}
 }
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 3cabeeabb1ca..cffad9b139d3 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -315,6 +315,7 @@ int vmbus_connect(void)
 
 void vmbus_disconnect(void)
 {
+	int ret;
 	/*
 	 * First send the unload request to the host.
 	 */
@@ -337,11 +338,15 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
+	ret = set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
+	ret |= set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
 
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+	if (!ret) {
+		hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+		hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+	} else {
+		WARN_ONCE(1, "Failed to re-encrypt memory before freeing, leaking pages!\n");
+	}
 	vmbus_connection.monitor_pages[0] = NULL;
 	vmbus_connection.monitor_pages[1] = NULL;
 }
-- 
2.34.1


