Return-Path: <linux-hyperv+bounces-8088-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2681CE5E6C
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 05:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A4AD30056C0
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Dec 2025 04:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB1E225408;
	Mon, 29 Dec 2025 04:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qWLDS3gD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6C347C6;
	Mon, 29 Dec 2025 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766981531; cv=none; b=u9ZWZiwaaovnDz8PrIAMH9nVXAM16FqEA6jajC0ArZ2HYYWPmSgMF/sxCblMg73RanW+rvv1nuPIFrfeIGVG7jR74mx0Uqr/bYb/6mLPgLmBrBDtmZjaDeUWHk1K9hGsBcCBy4WBfnDgK/kqLPeEJBAiwBtCqin/i/KgJEaX+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766981531; c=relaxed/simple;
	bh=pTQhGj3UZQCFDlx49OVhDi2ykIv5+5tascxi1ALpC+c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=GN7FI2KpWtZsPZEABlZmozoTd277FrWvfv0lp0oFoTaJEIhHD64RwP983zedJqtmOCCUHlWKmq8ZGVGJE+BPixiBgJMUSJSo0yKisAbpo2RN+qk1LqFvxfaEPti788ua/ML3MpL9LHpL3fU5r4VfbalX43b1nJeCDIrYHshQrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=qWLDS3gD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dfjTq4Xwwz9sjn;
	Mon, 29 Dec 2025 05:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1766981519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1fIbK13XwL9Jd4sQewXIbcJZGoAFKlLGbC5j8dsHsi8=;
	b=qWLDS3gDEEJm4eRe1WsoxjK+VvMzsZKxZ2q1WLs9nEyK2C2U2yOWghEPZ3GroXgW1ds4Ja
	TohYf2lEtPjvtVWvlawHZPz5hvV+afjb+LZ4MelEr3G6PlnZfVnTGwoJ6TbBJXe17dAR+s
	ocpx1NDeuiPPcjU+9ozcpw5EiuJax1XDjUvTq18TwhemKLJEsHjCHyEUtX+WVSXhH5/4iY
	BqEvssxHrzSMQ2BTSn8WaCQSCT1rORV8v3sv3y1z8JAe9yzpBtG7xQffnHxUE66WjV8y4k
	lATWGW0ods64fUTlGEg39er1bvUAM/s+ljXd71xOPmENAXmZhT2iZMFtm+lPsw==
Date: Sun, 28 Dec 2025 20:11:56 -0800 (PST)
From: vdso@mailbox.org
To: mhklinux@outlook.com, mhkelley58@gmail.com
Cc: "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Message-ID: <21281086.36492.1766981516854@app.mailbox.org>
In-Reply-To: <20251219160832.1628-1-mhklinux@outlook.com>
References: <20251219160832.1628-1-mhklinux@outlook.com>
Subject: Re: [PATCH 1/1] Drivers: hv: Fix uninit'ed variable in
 hv_msg_dump() if CONFIG_PRINTK not set
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
X-MBO-RS-ID: b56d187125630677009
X-MBO-RS-META: jya9dcwmzf9hdxatw6ije7gmmrdbbmeh


> On 12/19/2025 8:08 AM  mhkelley58@gmail.com wrote:
> 
>  
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When CONFIG_PRINTK is not set, kmsg_dump_get_buffer() returns 'false'
> without setting the bytes_written argument. In such case, bytes_written
> is uninitialized when it is tested for zero.
> 
> This is admittedly an unlikely scenario, but in the interest of correctness
> and avoiding tool noise about uninitialized variables, fix this by testing
> the return value before testing bytes_written.
> 
> Fixes: 9c318a1d9b50 ("Drivers: hv: move panic report code from vmbus to hv early init code")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/202512172102.OcUspn1Z-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/hv_common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index f466a6099eff..de9e069c5a0c 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -188,6 +188,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  {
>  	struct kmsg_dump_iter iter;
>  	size_t bytes_written;
> +	bool ret;
>  
>  	/* We are only interested in panics. */
>  	if (detail->reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
> @@ -198,9 +199,9 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
>  	 * be single-threaded.
>  	 */
>  	kmsg_dump_rewind(&iter);
> -	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> -			     &bytes_written);
> -	if (!bytes_written)
> +	ret = kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
> +				   &bytes_written);
> +	if (!ret || !bytes_written)
>  		return;
>  	/*
>  	 * P3 to contain the physical address of the panic page & P4 to

The existing code

1. doesn't care about the return value from kmsg_dump_get_buffer.
   The return value wouldn't make the function return before, why does that
   need to change? 

2. returns early when there are no bytes written.
   I think it shouldn't as otherwise the crash control register isn't written to,
   and the panic isn't signalled to the host. Is there another path maybe that
   I'm not noticing?

That said, would it make sense to you the patch be something similar to:

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 0a3ab7efed46..20e4a9a13b32 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -188,6 +188,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 {
        struct kmsg_dump_iter iter;
        size_t bytes_written;
+       bool ret;
 
        /* We are only interested in panics. */
        if (detail->reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
@@ -197,11 +198,16 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
         * Write dump contents to the page. No need to synchronize; panic should
         * be single-threaded.
         */
+       bytes_written = 0;
        kmsg_dump_rewind(&iter);
-       kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+       ret = kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
                             &bytes_written);
-       if (!bytes_written)
-               return;
+       /*
+        * Whether there is more data available or not, send what has been captured
+        * to the host. Ignore the return value.
+        */
+       (void) ret;
+
        /*
         * P3 to contain the physical address of the panic page & P4 to
         * contain the size of the panic data in that page. Rest of the
@@ -210,7 +216,7 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
        hv_set_msr(HV_MSR_CRASH_P0, 0);
        hv_set_msr(HV_MSR_CRASH_P1, 0);
        hv_set_msr(HV_MSR_CRASH_P2, 0);
-       hv_set_msr(HV_MSR_CRASH_P3, virt_to_phys(hv_panic_page));
+       hv_set_msr(HV_MSR_CRASH_P3, bytes_written ? virt_to_phys(hv_panic_page) : NULL);
        hv_set_msr(HV_MSR_CRASH_P4, bytes_written);
 
        /*

--
Cheers,
Roman

> -- 
> 2.25.1

