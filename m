Return-Path: <linux-hyperv+bounces-549-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C5C7CCDE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 22:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D8A81C20CFF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 20:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1943116;
	Tue, 17 Oct 2023 20:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bAwYhPFD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1B043115
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 20:25:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273F8118;
	Tue, 17 Oct 2023 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697574339; x=1729110339;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=acK3P8RbFbLJ3Y/qsHvg8A7W0ea+PDycu9fLk45ERVg=;
  b=bAwYhPFDDn2o4/g5Fs2i2s5um2j26EQWQIyBaZJ2aaH4c46DESSmKzjG
   m8qgnDnrDqfr9zfj/plTmMMnQ9zukuTursZT/jQ40fKZMUrMtz/at8UjB
   2l4v9tWYfqrSphZ+M3Cau2AbRLqI7cmk5duZAgPeY3kh5iehrPes69QO8
   jBjP+2X9WgAAlW4iqXjd8rIbUUlrF8lLVOJR7htbOzfKiGP3cWF0qEI1e
   21/snBiup9feaslOPp3z2p9HInLQpMahJKFB49EzoOfCu4atkY9+5wd+O
   Yaa8lCqGFJg1pF8Gipjp5bndl2kLgoWjnStIFm212TwtidEDXcPnrKg6U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="7429610"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="7429610"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:25:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="900040478"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="900040478"
Received: from rtdinh-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.212.150.155])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 13:23:35 -0700
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
Subject: [RFC 10/10] uio_hv_generic: Don't free decrypted memory
Date: Tue, 17 Oct 2023 13:25:05 -0700
Message-Id: <20231017202505.340906-11-rick.p.edgecombe@intel.com>
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

uio_hv_generic could free decrypted/shared pages if
set_memory_decrypted() fails.

Check the decrypted field in the gpadl before freeing in order to not
leak the memory.

Only compile tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 drivers/uio/uio_hv_generic.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 20d9762331bd..6be3462b109f 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -181,12 +181,14 @@ hv_uio_cleanup(struct hv_device *dev, struct hv_uio_private_data *pdata)
 {
 	if (pdata->send_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->send_gpadl);
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 	}
 
 	if (pdata->recv_gpadl.gpadl_handle) {
 		vmbus_teardown_gpadl(dev->channel, &pdata->recv_gpadl);
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 	}
 }
 
@@ -295,7 +297,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
 				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
 	if (ret) {
-		vfree(pdata->recv_buf);
+		if (!pdata->recv_gpadl.decrypted)
+			vfree(pdata->recv_buf);
 		goto fail_close;
 	}
 
@@ -317,7 +320,8 @@ hv_uio_probe(struct hv_device *dev,
 	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
 				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
 	if (ret) {
-		vfree(pdata->send_buf);
+		if (!pdata->send_gpadl.decrypted)
+			vfree(pdata->send_buf);
 		goto fail_close;
 	}
 
-- 
2.34.1


