Return-Path: <linux-hyperv+bounces-2503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F4491B7E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 09:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2781C20C1A
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2024 07:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8D13DB90;
	Fri, 28 Jun 2024 07:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G1BZhPGj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D345413C695
	for <linux-hyperv@vger.kernel.org>; Fri, 28 Jun 2024 07:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719558800; cv=none; b=CkI4C6wQmYLSGBXbugPTrW0GXprnO2ia8awnOQkqpGYQ33adtY22CZsrM1N2XQJAUarxx23fJLVIVs8VaC3iFGZ8eqUQSIw5jemGcNG0YfMQDMVbQybOCjeahZDA1EJj+e9tBtzSarB7nh4+sS65alwRadUyu4E6ZhuBj6mSoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719558800; c=relaxed/simple;
	bh=RwA6DNAy80mutbsLBHzLNYjy0s1N5E3RGjgs2E4XDr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVVQrv4ME31mvtrtAMPNjW81fZwI5GNZVciikxNnaNs+PSeuh49TH4zAwnjm2uP52DazH7IReeS+eTjrkifaCNgx0TSmOZBQT5Hqe406cLzXFil1mS+xHRoMJMkde76oR7Yu7pElHMvLJ8CR2Y9CsnGcG3QHMvsvY6WbktljUsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G1BZhPGj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719558797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uBCG6Aq7g5s4IKz6cGy3Qa4TvJeSerIQI/YPWTkVSgw=;
	b=G1BZhPGj/8qN5SKsEVi7e/Jm+KGYZSJNRAoVmN20uX8fXJBklm3ddTsPsMsl75RnZx9G0v
	afKmC6LEmIKh+1W0ozlhypsvV8ePyVtsBxRUGWm+A1CL4mqy746KH2qA/xidmJGVGscw6Q
	1irbj3/EvYV8Cplzq4dds5wN1HstA/g=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-TpR4FokCPJ6Fkiujua0W3A-1; Fri, 28 Jun 2024 03:13:16 -0400
X-MC-Unique: TpR4FokCPJ6Fkiujua0W3A-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52cdc4a8f44so297435e87.0
        for <linux-hyperv@vger.kernel.org>; Fri, 28 Jun 2024 00:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719558794; x=1720163594;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBCG6Aq7g5s4IKz6cGy3Qa4TvJeSerIQI/YPWTkVSgw=;
        b=lY6dDmQ5aggA+cvJLki95pKuEUKh/nQjRwp4voTz5wXNzbK8xiDKt1mwRGpqyF+evg
         7Qxwq3/pqOcZlsi+skZPSxRb9jkv3I3Nwdn4en3tyPkmSK83ZVf6xBZBedTxePbyWsaY
         xdBzVv3o8kIv8BEQ0fxxYi1Cu8oKjMgik95qBMcGG9JR5NbDB+OCYXM6onMwofastvXi
         T1VkaPj9hQ+o34vgKgJ+XlmY8zYKKrWfGAf7VOZeuAN32nnl4OCQFkl9BlhJ3dJbQYBv
         jyUr0Scz0QXRF10updePxRPikimRQ3bKa2XRMwC0OnWiikE3ImFN4GkTJybU/NFbgJGn
         dU6A==
X-Forwarded-Encrypted: i=1; AJvYcCVO7yThp8xzwzUcEnE86CAv+RV6URkcPOpPrU1lHr/xbkMUTekKhHd8asiG53Zx19gafVFlWYGMjh806KjQYP7sRWhaopl6upIJRKoZ
X-Gm-Message-State: AOJu0Yw/tXVAk/1EG4kaBqudrhThWiMCxnQZusBo4mu1HLMlwwYrd9yw
	DVvadi1s2Li+4R3SdRY9cWZ9vklLw0jy/Q2k1PXpntPZSZAsDB+ypkLKSGKgjLu61RP9+FTlA9L
	TEdfGEao035ibfPCCccQTKadPO/aermLMQX5pwP0K7SCg+DAmhVlgKIp0RM51hw==
X-Received: by 2002:a05:6512:398f:b0:52e:6d6e:5770 with SMTP id 2adb3069b0e04-52e6d6e580emr4883305e87.14.1719558794370;
        Fri, 28 Jun 2024 00:13:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRNgxsh6SyinhqzjcyCteF/29SBwjZ8FpGkU83w6uoSo0McICUu/E5sqzerM5X1kwtLLuEIw==
X-Received: by 2002:a05:6512:398f:b0:52e:6d6e:5770 with SMTP id 2adb3069b0e04-52e6d6e580emr4883265e87.14.1719558793916;
        Fri, 28 Jun 2024 00:13:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e? ([2a01:e0a:c:37e0:38da:a7d9:7cc9:db3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0642acsm22012305e9.25.2024.06.28.00.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 00:13:13 -0700 (PDT)
Message-ID: <06899fda-de75-4d44-bda5-dcbb3e35d037@redhat.com>
Date: Fri, 28 Jun 2024 09:13:11 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] printk: Add a short description string to kmsg_dump()
To: Kees Cook <kees@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, John Ogness
 <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240625123954.211184-1-jfalempe@redhat.com>
 <202406260906.533095B1@keescook>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <202406260906.533095B1@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/06/2024 18:26, Kees Cook wrote:
> On Tue, Jun 25, 2024 at 02:39:29PM +0200, Jocelyn Falempe wrote:
>> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
>> callback.
>> This patch adds a new parameter "const char *desc" to the kmsg_dumper
>> dump() callback, and update all drivers that are using it.
>>
>> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
>> function and a macro for backward compatibility.
>>
>> I've written this for drm_panic, but it can be useful for other
>> kmsg_dumper.
>> It allows to see the panic reason, like "sysrq triggered crash"
>> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> Seems reasonable. Given the prototype before/after:
> 
> dump(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason)
> 
> dump(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason,
>       const char *desc)
> 
> Perhaps this should instead be a struct that the panic fills in? Then
> it'll be easy to adjust the struct in the future:

yes that's a good idea, so it's a bit more flexible.

> 
> struct kmsg_dump_detail {
> 	enum kmsg_dump_reason reason;
> 	const char *description;
> };
> 
> dump(struct kmsg_dumper *dumper, struct kmsg_dump *detail)
> 
> This .cocci could do the conversion:
> 
> 
> @ dump_func @
> identifier DUMPER, CALLBACK;
> @@
> 
>    struct kmsg_dumper DUMPER = {
>      .dump = CALLBACK,
>    };
> 
> @ detail @
> identifier dump_func.CALLBACK;
> identifier DUMPER, REASON;
> @@
> 
> 	CALLBACK(struct kmsg_dumper *DUMPER,
> -		 enum kmsg_dump_reason REASON
> +		 struct kmsg_dump_detail *detail
> 		)
> 	{
> 		<...
> -		REASON
> +		detail->reason
> 		...>
> 	}
> 
> 
> Also, just to double-check, doesn't the panic reason show up in the
> kmsg_dump log itself (at the end?) I ask since for pstore, "desc" is
> likely redundant since it's capturing the entire console log.

It is present in the kdump log, but before all the register dumps.
So to retrieve it you need to parse the last 30~40 lines of logs, and 
search for a line starting with "Kernel panic - not syncing".
https://elixir.bootlin.com/linux/v6.10-rc5/source/kernel/panic.c#L341
But I think that's a bit messy, and I prefer having a kmsg_dump parameter.

-- 

Jocelyn
> 
> -Kees
> 
> Here's the patch from the above cocci:
> 
> 
> diff -u -p a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -207,13 +207,13 @@ static int hv_die_panic_notify_crash(str
>    * buffer and call into Hyper-V to transfer the data.
>    */
>   static void hv_kmsg_dump(struct kmsg_dumper *dumper,
> -			 enum kmsg_dump_reason reason)
> +			 struct kmsg_dump_detail *detail)
>   {
>   	struct kmsg_dump_iter iter;
>   	size_t bytes_written;
>   
>   	/* We are only interested in panics. */
> -	if (reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
> +	if (detail->reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
>   		return;
>   
>   	/*
> diff -u -p a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
> --- a/arch/powerpc/platforms/powernv/opal-kmsg.c
> +++ b/arch/powerpc/platforms/powernv/opal-kmsg.c
> @@ -20,13 +20,13 @@
>    * message, it just ensures that OPAL completely flushes the console buffer.
>    */
>   static void kmsg_dump_opal_console_flush(struct kmsg_dumper *dumper,
> -				     enum kmsg_dump_reason reason)
> +				     struct kmsg_dump_detail *detail)
>   {
>   	/*
>   	 * Outside of a panic context the pollers will continue to run,
>   	 * so we don't need to do any special flushing.
>   	 */
> -	if (reason != KMSG_DUMP_PANIC)
> +	if (detail->reason != KMSG_DUMP_PANIC)
>   		return;
>   
>   	opal_flush_console(0);
> diff -u -p a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -73,7 +73,7 @@ static const char *nvram_os_partitions[]
>   };
>   
>   static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason);
> +			  struct kmsg_dump_detail *detail);
>   
>   static struct kmsg_dumper nvram_kmsg_dumper = {
>   	.dump = oops_to_nvram
> @@ -643,7 +643,7 @@ void __init nvram_init_oops_partition(in
>    * partition.  If that's too much, go back and capture uncompressed text.
>    */
>   static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason)
> +			  struct kmsg_dump_detail *detail)
>   {
>   	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
>   	static unsigned int oops_count = 0;
> @@ -655,7 +655,7 @@ static void oops_to_nvram(struct kmsg_du
>   	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
>   	int rc = -1;
>   
> -	switch (reason) {
> +	switch (detail->reason) {
>   	case KMSG_DUMP_SHUTDOWN:
>   		/* These are almost always orderly shutdowns. */
>   		return;
> @@ -671,7 +671,7 @@ static void oops_to_nvram(struct kmsg_du
>   		break;
>   	default:
>   		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
> -		       __func__, (int) reason);
> +		       __func__, (int) detail->reason);
>   		return;
>   	}
>   
> warning: detail, node 59: record.reason = ... ;[1,2,21,22,32] in pstore_dump may be inconsistently modified
> warning: detail, node 105: if[1,2,21,22,54] in pstore_dump may be inconsistently modified
> diff -u -p a/fs/pstore/platform.c b/fs/pstore/platform.c
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -275,7 +275,7 @@ void pstore_record_init(struct pstore_re
>    * end of the buffer.
>    */
>   static void pstore_dump(struct kmsg_dumper *dumper,
> -			enum kmsg_dump_reason reason)
> +			struct kmsg_dump_detail *detail)
>   {
>   	struct kmsg_dump_iter iter;
>   	unsigned long	total = 0;
> @@ -285,9 +285,9 @@ static void pstore_dump(struct kmsg_dump
>   	int		saved_ret = 0;
>   	int		ret;
>   
> -	why = kmsg_dump_reason_str(reason);
> +	why = kmsg_dump_reason_str(detail->reason);
>   
> -	if (pstore_cannot_block_path(reason)) {
> +	if (pstore_cannot_block_path(detail->reason)) {
>   		if (!spin_trylock_irqsave(&psinfo->buf_lock, flags)) {
>   			pr_err("dump skipped in %s path because of concurrent dump\n",
>   					in_nmi() ? "NMI" : why);
> @@ -311,7 +311,7 @@ static void pstore_dump(struct kmsg_dump
>   		pstore_record_init(&record, psinfo);
>   		record.type = PSTORE_TYPE_DMESG;
>   		record.count = oopscount;
> -		record.reason = reason;
> +		record.reason = detail->reason;
>   		record.part = part;
>   		record.buf = psinfo->buf;
>   
> @@ -352,7 +352,7 @@ static void pstore_dump(struct kmsg_dump
>   		}
>   
>   		ret = psinfo->write(&record);
> -		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
> +		if (ret == 0 && detail->reason == KMSG_DUMP_OOPS) {
>   			pstore_new_entry = 1;
>   			pstore_timer_kick();
>   		} else {
> diff -u -p a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -8,7 +8,7 @@
>   #include <os.h>
>   
>   static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
> -				enum kmsg_dump_reason reason)
> +				struct kmsg_dump_detail *detail)
>   {
>   	static struct kmsg_dump_iter iter;
>   	static DEFINE_SPINLOCK(lock);
> 


