Return-Path: <linux-hyperv+bounces-4572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91671A66E75
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 09:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56EFE3A5FC9
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Mar 2025 08:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FAF1F4C9C;
	Tue, 18 Mar 2025 08:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3amw0Cyu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WRj1eVa/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60703202965;
	Tue, 18 Mar 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287045; cv=none; b=Ux8ufOhIBaudJJZO9PGf1/b5qsRAJsbVhad6lSgW+e/h4QqWTiyjsdVK4iNDRxib6jezWBvwYOsKL6p81Ur2jnicnjRd5iMXptUct4LVis1LzmQkgiXmNoXZvYHTqtDCFb4TLtKdK+oSV+tBDSGAMmSUf0sHFOlwufP1I7OD4Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287045; c=relaxed/simple;
	bh=rG11UNZBVJ1KkEF1+Gss/7La8ypbqms1pnRBr0mUDU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mqX4gyAq1Sag0dlnjzFRW7GfawpkLwGqv3eIbYCRZc0D76Hgjr65mYSvOe4QnCaDXSyR18xj9fpOyfsV4eXrRY4yVIZbW9MRIemMlEydzTkOtXUBckby6LWZfr9XGpoYsOMfV6kgGnmlycC+n3wkgBIrRieXQI1fn2GqV12Q0Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3amw0Cyu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WRj1eVa/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742287041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Ux5DDZ722AHEGEPlRVneQLCXL4UKBN2OiVk+yaoB0=;
	b=3amw0CyuRj/3XZJIV8Lwe+4nAkeVMAoSgJeBZlfnk2p1v+LsnzMiMa2FW36Lu+zjgufVGA
	EqHivtQUx5JtK7LiV6QsINzk0AOOLkf0qlGMO5eAq4bP1ok4kG0MW6J1yByltysrdHglxp
	GBZGg+NZLWQ1U+bwiJVrupJPOnRFS0hOpawMaMpVk/+34B1Jrq+fGX8cfTaMSx0fNsB94S
	jcB4PfodpetbDB1XSZM916bMlr+VI9Z8xGCSVO5R+d6ALmN48CQkZKIeo6Ak0IWWuM8tVf
	3XhpgyDMFFigNP8SshDy1Qm+r5C2oldM/nVhcBoQSuxiSxCCZr9PJO52gxDqWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742287041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x5Ux5DDZ722AHEGEPlRVneQLCXL4UKBN2OiVk+yaoB0=;
	b=WRj1eVa/xw3Y4RXocS0EToFEwbENQkqjdodbTM2y/3dGgQPB5IjuM98CQcyN4QJMR0FgXY
	97qUuqivpM18TAAA==
To: James Bottomley <James.Bottomley@HansenPartnership.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nishanth Menon
 <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh
 Shilimkar <ssantosh@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, Allen
 Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, Bjorn Helgaas
 <bhelgaas@google.com>, linux-pci@vger.kernel.org, Michael Kelley
 <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V3 01/10] cleanup: Provide retain_ptr()
In-Reply-To: <4a6efcf37b3cf8812dcfaaa66d4c1760b3e2a95a.camel@HansenPartnership.com>
References: <20250317092919.008573387@linutronix.de>
 <20250317092945.764490535@linutronix.de>
 <4a6efcf37b3cf8812dcfaaa66d4c1760b3e2a95a.camel@HansenPartnership.com>
Date: Tue, 18 Mar 2025 09:37:14 +0100
Message-ID: <87r02u4tvp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 17 2025 at 09:57, James Bottomley wrote:
> On Mon, 2025-03-17 at 14:29 +0100, Thomas Gleixner wrote:
>> +#define retain_ptr(p)				\
>> +	__get_and_null(p, NULL)
>
> This doesn't score very highly on the Rusty API design scale because it
> can be used anywhere return_ptr() should be used.  To force the
> distinction between the two cases at the compiler level, should there
> be a cast to void in the above to prevent using the return value?

Indeed. Delta patch below seems to do the trick.

Thanks,

        tglx

---
diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 6537f8dfe1bb..859b06d4ad7a 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -231,8 +231,7 @@ const volatile void * __must_check_fn(const volatile void *val)
  *		retain_ptr(f);
  *	return ret;
  */
-#define retain_ptr(p)				\
-	__get_and_null(p, NULL)
+#define retain_ptr(p)		((void)__get_and_null(p, NULL))
 
 /*
  * DEFINE_CLASS(name, type, exit, init, init_args...):

