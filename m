Return-Path: <linux-hyperv+bounces-5357-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BFDAAB90C
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3996E3B7B64
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842B732A6EB;
	Tue,  6 May 2025 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="o3s59huh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53370297A7A;
	Tue,  6 May 2025 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493009; cv=none; b=lSy3psvvPEBg99KIrSpC4IckV7SewaMnI15q9KY6Laf9OMynrhiIA/QTLpyykoeatYwT0hTLa25hhrKMCpKSpGXuDSnKPzJ54fzLrAut4Kx5ucCk7ILJDuYengGSYidYqNOWQM8txxTceUHXrkHkLiWb/B/5X0jSnTUamVeqQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493009; c=relaxed/simple;
	bh=wrgaENVci0P+r4viKopRMHVU9QIEi4adrnMipn6O+sU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cvb25TLFMAJP9/KLSPNXbrpfAgkfEfugNYaNIQF4CHAkBTdB8VcBP5zm1gZg88pWTxT7mvBi+esOKl4qNgQHz+hAs9DqEbEBa0E+HnZ1V4VVe0CyrmuqvHxmRejBxxpqH55+u4+M6r6ylMOQYI9FpfaJ1Z+H/uQ5Flofuj5Stcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=o3s59huh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 044D3204E7F7; Mon,  5 May 2025 17:56:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 044D3204E7F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493008;
	bh=8jbp63pflYYMxnViW5Z1+xVgB+8SXsI21hIdEexRN78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o3s59huhmwiOwbGcGSxJkJ3L3wW6IEAmRnuOOKBiFcWgW3yuESzfYFfEfoX5YOpqt
	 jbn8uvkof160BuFuu36iBc8+y1T+3U6fexz0vJ8SAGpStizXSOTxFK7vKEMKJlrOID
	 7pTJoLr8mIfHd42ti6eec1oD4pA8ncFbCmaiHSzo=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v3 4/5] Drivers: hv: Use kzalloc for panic page allocation
Date: Mon,  5 May 2025 17:56:36 -0700
Message-Id: <1746492997-4599-5-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

To prepare for removal of hv_alloc_* and hv_free* functions, use
kzalloc/kfree directly for panic reporting page.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/hv_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a7d7494feaca..a5a6250b1a12 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -272,7 +272,7 @@ static void hv_kmsg_dump_unregister(void)
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &hyperv_panic_report_block);
 
-	hv_free_hyperv_page(hv_panic_page);
+	kfree(hv_panic_page);
 	hv_panic_page = NULL;
 }
 
@@ -280,7 +280,7 @@ static void hv_kmsg_dump_register(void)
 {
 	int ret;
 
-	hv_panic_page = hv_alloc_hyperv_zeroed_page();
+	hv_panic_page = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hv_panic_page) {
 		pr_err("Hyper-V: panic message page memory allocation failed\n");
 		return;
@@ -289,7 +289,7 @@ static void hv_kmsg_dump_register(void)
 	ret = kmsg_dump_register(&hv_kmsg_dumper);
 	if (ret) {
 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
-		hv_free_hyperv_page(hv_panic_page);
+		kfree(hv_panic_page);
 		hv_panic_page = NULL;
 	}
 }
-- 
2.34.1


