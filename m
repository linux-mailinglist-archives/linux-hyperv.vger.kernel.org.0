Return-Path: <linux-hyperv+bounces-4470-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D689FA5F535
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 14:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B05D1884DA6
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530D267737;
	Thu, 13 Mar 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="shj5CAde";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="byiMxgR9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9568C26770C;
	Thu, 13 Mar 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871022; cv=none; b=geSS9zuo4cCw8L4Ba9aOW3RXTFSAg6f9UEPz93mG5ZxJv4XJkrBj0Wr41h3N8ykYwohCp7smNtrRf4zWuPIqhscpUhi30ykXBIvdVA7dT6dCN6ku+suKQK2vd3KgyElwYe4XLDwt9NBm/HmOIei8nFOYZrFSJGHCH1ugrYCIVUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871022; c=relaxed/simple;
	bh=98KRXcGEbIO50H7NCISaJsrQv87mCIk32utux6MRmis=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Y0hoa9Ylj53X1ckX8OQwvfAkakh1v4fsfhynxrLGX61IAg5pRnBDvXjLPcGLZHdixUsmTrdpISusVpqZk1vwNesfXcQNgFOlGQeHdd4AMnh7/krYsaMgKB4SoaHKdGARys0KiSUM5xx8ZR+YPEJJoY/U0F1gNaqLCd8gGcj2Gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=shj5CAde; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=byiMxgR9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250313130321.442025758@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VeVnnwSReah5wOC9Iz7ded+zOeZPkraBXHsDPNXcIs4=;
	b=shj5CAdewFdh89n7ia0O9o8wc9yKPHi/tldIDoAodBKxyF+cFmiDEmEjtYyMAPgZjYScMI
	l5cNO6lvwa+TmWNrr+Qsyrf630p24vGKBMnTExIq2Y/T92SWfvXg2xzGgBY+1cGMYLsivY
	DlZcq4AVeT0feSydUHjIczYk9QZ3X5zE4vfK9Fc2VnZDWzQ2PAj1t8nKypbEiszDEQ356a
	Fe/V+/OEHJ3wLYHJYTPJt4V2zXoTF1HxXwB2K00o21Dx48t5thojcjBdb3jNb/QVAjuF7P
	eCUrGrSsp+EBC75dRo/DClUSWmDbo4FXhDbtHGiZi+lTpQjoyUqfqDb3bN1ErQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=VeVnnwSReah5wOC9Iz7ded+zOeZPkraBXHsDPNXcIs4=;
	b=byiMxgR9qFLezNWz2uxirZ2d+2cD07D0KcxtSE0jlqbSKJ+lcH/sx6VeqWfua+hDn1Tu7X
	4A/2eBhQq0y7SIAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Nishanth Menon <nm@ti.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V2 01/10] cleanup: Provide retain_ptr()
References: <20250313130212.450198939@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 14:03:38 +0100 (CET)

In cases where an allocation is consumed by another function, the
allocation needs to be retained on success or freed on failure. The code
pattern is usually:

	struct foo *f = kzalloc(sizeof(*f), GFP_KERNEL);
	struct bar *b;

	,,,
	// Initialize f
	...
	if (ret)
		goto free;
        ...
	bar = bar_create(f);
	if (!bar) {
		ret = -ENOMEM;
	   	goto free;
	}
	...
	return 0;
free:
	kfree(f);
	return ret;

This prevents using __free(kfree) on @f because there is no canonical way
to tell the cleanup code that the allocation should not be freed.

Abusing no_free_ptr() by force ignoring the return value is not really a
sensible option either.

Provide an explicit macro retain_ptr(), which NULLs the cleanup
pointer. That makes it easy to analyze and reason about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/cleanup.h |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,23 @@ const volatile void * __must_check_fn(co
 
 #define return_ptr(p)	return no_free_ptr(p)
 
+/*
+ * Only for situations where an allocation is handed in to another function
+ * and consumed by that function on success.
+ *
+ *	struct foo *f __free(kfree) = kzalloc(sizeof(*f), GFP_KERNEL);
+ *
+ *	setup(f);
+ *	if (some_condition)
+ *		return -EINVAL;
+ *	....
+ *	ret = bar(f);
+ *	if (!ret)
+ *		retain_ptr(f);
+ *	return ret;
+ */
+#define retain_ptr(p)				\
+	__get_and_null(p, NULL)
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):


