Return-Path: <linux-hyperv+bounces-4498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75CA60D7E
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0D58820A5
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Mar 2025 09:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FE21EEA46;
	Fri, 14 Mar 2025 09:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5Ce7r+J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3401DE4D6;
	Fri, 14 Mar 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945057; cv=none; b=VVCjkXkso0dj7C0u7I0aKIiWn6tGmUI1ZcE1FlNJBRInCZfMoJsOrJaK3WGmMjTWFZ/wg8QWyQu3FPxobQn67mnlv9EnG5CZr9wfzOStyGqW2gnajuRn1g8HBynRqX39KVS0N6ZUJHa5UnY/hF4ziQl5xTu1s3tt9k4MjlQ4PMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945057; c=relaxed/simple;
	bh=Fjgr2aFaWgmQHGHqcXstlnmekThE3AVn9chYHcPpIQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amt59Sm1k61KajBrAgWKIjvEGK7BJngUB3bylBSVDIegzv1lk0BtxntNk108+Qd/E6aUHXxiYfrbMjtlnlCPs6AUtdSxE/rhyqNjaKi/w019H9on/83m5Z9Ai/D1Z1bK6tHNydl2DqkuHOm7slAtYfXSQHpZi3dKNt+EMZrPTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q5Ce7r+J; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/qgsKlDiT9BP/oIoId2DK84ZUVdJn5GENc/rrkdVUCM=; b=Q5Ce7r+JgAyL9BgcLONl0OR20V
	XgOcSIKb8GXyGW30KGk2DpDS9w7YcUuwwTMRtoYcAkVfMXsKu1hUrD0FEwxQZ6x7fBVoJec2ex69e
	giz+rK8wU0FzfurRDgYgHJHoVkoyGw82LzLKkdblVd0UslzK3avQjGW1Nji3hwNL7Lh7ibbwuZ5h7
	7/SQRBvnaBEyZ56r4fHvvVSoj6AE+WFLvfzlRdmOWCabn+kWpiQ3lD/RwPkLnA+iS7gEGbE/RmF2H
	7HneaI5OwU2LmAWgPxPIk2RZTyHEyn7neMU7/pyafy7XgZ9dlyJdYHO9ODV/WvwQC3MQbfoaNQkyk
	MuXRiYTg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tt1Te-0000000FCOp-2oKj;
	Fri, 14 Mar 2025 09:37:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3E7483006C0; Fri, 14 Mar 2025 10:37:14 +0100 (CET)
Date: Fri, 14 Mar 2025 10:37:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	linux-hyperv@vger.kernel.org, Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: Re: [patch V2 01/10] cleanup: Provide retain_ptr()
Message-ID: <20250314093714.GW5880@noisy.programming.kicks-ass.net>
References: <20250313130212.450198939@linutronix.de>
 <20250313130321.442025758@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313130321.442025758@linutronix.de>

On Thu, Mar 13, 2025 at 02:03:38PM +0100, Thomas Gleixner wrote:
> In cases where an allocation is consumed by another function, the
> allocation needs to be retained on success or freed on failure. The code
> pattern is usually:
> 
> 	struct foo *f = kzalloc(sizeof(*f), GFP_KERNEL);
> 	struct bar *b;
> 
> 	,,,
> 	// Initialize f
> 	...
> 	if (ret)
> 		goto free;
>         ...
> 	bar = bar_create(f);
> 	if (!bar) {
> 		ret = -ENOMEM;
> 	   	goto free;
> 	}
> 	...
> 	return 0;
> free:
> 	kfree(f);
> 	return ret;
> 
> This prevents using __free(kfree) on @f because there is no canonical way
> to tell the cleanup code that the allocation should not be freed.
> 
> Abusing no_free_ptr() by force ignoring the return value is not really a
> sensible option either.
> 
> Provide an explicit macro retain_ptr(), which NULLs the cleanup
> pointer. That makes it easy to analyze and reason about.

So no objection per se, but one way to solve this is by handing
ownership to bar_create(), such that it is responsible for freeing f on
failure.

Anyway, I suspect the __must_check came from Linus, OTOH take_fd(), the
equivalent for file descriptors	also don't have that __must_check. So
clearly we have precedent here.

