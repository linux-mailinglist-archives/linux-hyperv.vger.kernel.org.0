Return-Path: <linux-hyperv+bounces-4603-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D450BA68A1F
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 11:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E542291A
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Mar 2025 10:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB900254AE8;
	Wed, 19 Mar 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UOd5M6Yp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrfOFdIi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEF253F31;
	Wed, 19 Mar 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381801; cv=none; b=GXbtvWlSn4RtG4tFzbPj2qcJHwSPVAZKeiE741Xe2xeVkSQu7FIbuPd68OdDjZLGop/HFWSOClxfQm0AM+4/1J9iSU1zfvI1mZcEk7PGkGcN63IYdE2aixPG3lAq8oPB9PhNiaRVCX96Wsge+uzucnbgQibXtXba94n3betxk2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381801; c=relaxed/simple;
	bh=Ehz6wGfNoZMQOJoQ8b6MOWl08l4/ri784urifvlmYZs=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dwPynEkfidurL6YqsT0c2tWPCPl/oOPvW7P19GxJK7y9rmPMpCuMBvHcJXu3zjsYdhnRpP8OT/jxxhKjdYC0wmY6fyP5ZP1IPj78d//bwqGMhD9kGqCrRZthUfHGg3JKSGqHpDiZSFkZpuZVBeFakhFaeKO+2olC/v8AFWlnCB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UOd5M6Yp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrfOFdIi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250319105506.083538907@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xUu3pje6wUy/ZavkO5yRoyA7cOqryRXhXYC4SRrMQk8=;
	b=UOd5M6YpT1A8Sso8t0kqBDVB4tb2/88/W+5HS4tZxGT2fAIg4I0zZXQSZ0+X8dyJYtIq02
	QacjZaZPTsfoIEuZfV5t/ngRmFjRX4OuPEDvabRj6y9zmlPYYEExrQtUl15UVGiFsAwevp
	KL8AynJfrZNUw1SHR1a8g3G1fmPREjM28jJRPnoXaZqVXErTYCbEL8Gl1BW5As7oapT1a6
	z49AnGvihi41AaQy9gQ2+hWUvz8AMyRhbvLVKs/QQDLikSt1LMxAs5EuSMVRQel5q7gkb1
	QQXn6PrqDYqZotWrQGCfOi+7C1AAzIpgA9yO0axKLj+5aO+Xbl2qeyoXOcBR9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=xUu3pje6wUy/ZavkO5yRoyA7cOqryRXhXYC4SRrMQk8=;
	b=LrfOFdIint6AnnrXXaflm0yuoQSio41wFLV+D0y78vGc2P8B4atEfGX8rT0arbG8JFGdv8
	Y3eYNpHVIX00r7DA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V4 01/14] cleanup: Provide retain_ptr()
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:56:38 +0100 (CET)

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
V4: Cast to void so can't be used as return_ptr() replacement - James
---
 include/linux/cleanup.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -216,6 +216,22 @@ const volatile void * __must_check_fn(co
 
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
+#define retain_ptr(p)		((void)__get_and_null(p, NULL))
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):


