Return-Path: <linux-hyperv+bounces-8110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5248FCECDD2
	for <lists+linux-hyperv@lfdr.de>; Thu, 01 Jan 2026 09:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 913E43001023
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jan 2026 08:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08531427A;
	Thu,  1 Jan 2026 08:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Q74tprR5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7140C3C17;
	Thu,  1 Jan 2026 08:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767254512; cv=none; b=s+HjYRYGiE5m5IxlmfCauaDVBTGmLiB15u22EbAodMT7qEBC45w4Y7atIqIdL8b0hVqC1BNg2G4MMv97atQzURWO0ZqiK82+1HbWKTrTI7LxLjvYvqEoP8Pt3vt0rLibc85QtlYa7bwxu1Ys+Gb4MBmIrLIwXFsddb/uPMB+ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767254512; c=relaxed/simple;
	bh=kzs4wR9IZPNjlIkJCBOykOq4DbRGG1uQMqjDepeMAB8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=NA+O1PlMbXvzmWm5Kqx231pN9wWA3483bzZKyKGZAfA+XJgg/LhL9/H7nKvNmsgNHKxf8LRRZwv9xGhigKJTiIR+a9HeeDaotUFU9CLRYDGYjckEQlqTVBqvTdqUrlmcSOYoh5kz6dnwtnbSeOxDB3WAM7IDMXSV6gsxiCss+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Q74tprR5; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dhfHN3SV5z9tLZ;
	Thu,  1 Jan 2026 08:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767254080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJO9QIRPZ04c6RXDwd1oOEFxxK44JcOz7OS3ehZbJ04=;
	b=Q74tprR5iM9pXvvZrM7N7OLjc4P3lUNF3e2og6fV1q4wD8ehEs+vQF+EsKuwEptSsa9BxD
	L8YrDAfKRHGrtxdiHdLdDaRgLzFSeN6i+fVQd8N3ZhuJsf5bI0cdhpFnAeHrpGLL6hj1kb
	V8x0853jBx7rWFU+hzmJ2FqXJrzIkAZRdsq58qXfMPR/CkQFomR1I55jqfwAlcsB2tuATr
	kinWbYGozsgG5A1ns352USq03h62cnDk9EQlexs6l/eM+Jfj6a9IDDuZ09Q/evsrs10Da0
	00U99jYuzPTCe3fTSpvjQH4/l9pQgmy/7Sm20/25uzmCLhFfImfFQo4shbBgpw==
Date: Wed, 31 Dec 2025 23:54:38 -0800 (PST)
From: vdso@mailbox.org
To: mhklinux@outlook.com
Cc: "mhkelley58@gmail.com" <mhkelley58@gmail.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Message-ID: <2102622831.80983.1767254078431@app.mailbox.org>
In-Reply-To: <20251231201447.1399-1-mhklinux@outlook.com>
References: <20251231201447.1399-1-mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/1] Drivers: hv: Always do Hyper-V panic
 notification in hv_kmsg_dump()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-ID: a2580bb052e1ff11be6
X-MBO-RS-META: qrdpkhb1ea1wkp99rk54366h4fzi8k48


> On 12/31/2025 12:14 PM  mhkelley58@gmail.com wrote:
> 
>  
> From: Michael Kelley <mhklinux@outlook.com>
> 
> hv_kmsg_dump() currently skips the panic notification entirely if it
> doesn't get any message bytes to pass to Hyper-V due to an error from
> kmsg_dump_get_buffer(). Skipping the notification is undesirable because
> it leaves the Hyper-V host uncertain about the state of a panic'ed guest.
> 
> Fix this by always doing the panic notification, even if bytes_written
> is zero. Also ensure that bytes_written is initialized, which fixes a
> kernel test robot warning. The warning is actually bogus because
> kmsg_dump_get_buffer() happens to set bytes_written even if it fails, and
> in the kernel test robot's CONFIG_PRINTK not set case, hv_kmsg_dump() is
> never called. But do the initialization for robustness and to quiet the
> static checker.
> 
> Fixes: 9c318a1d9b50 ("Drivers: hv: move panic report code from vmbus to hv early init code")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/202512172103.OcUspn1Z-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Reviewed-by: Roman Kisel <vdso@mailbox.org>

> ---
> Changes in v2:
> * Reworked patch to focus on always sending the panic message, with
>   resolving the uninitialized variable report as a side effect. See
>   discussion on v1 of the patch [1]
> 
> [1] https://lore.kernel.org/linux-hyperv/20251219160832.1628-1-mhklinux@outlook.com/
> 
>  drivers/hv/hv_common.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 0a3ab7efed46..f1c17fb60dc1 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -195,13 +195,15 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  
>  	/*
>  	 * Write dump contents to the page. No need to synchronize; panic should
> -	 * be single-threaded.
> +	 * be single-threaded. Ignore failures from kmsg_dump_get_buffer() since
> +	 * panic notification should be done even if there is no message data.
> +	 * Don't assume bytes_written is set in case of failure, so initialize it.
>  	 */
>  	kmsg_dump_rewind(&iter);
> -	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> +	bytes_written = 0;
> +	(void)kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
>  			     &bytes_written);
> -	if (!bytes_written)
> -		return;
> +
>  	/*
>  	 * P3 to contain the physical address of the panic page & P4 to
>  	 * contain the size of the panic data in that page. Rest of the
> @@ -210,7 +212,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  	hv_set_msr(HV_MSR_CRASH_P0, 0);
>  	hv_set_msr(HV_MSR_CRASH_P1, 0);
>  	hv_set_msr(HV_MSR_CRASH_P2, 0);
> -	hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
> +	hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic_page) : 0);
>  	hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
>  
>  	/*
> -- 
> 2.25.1

