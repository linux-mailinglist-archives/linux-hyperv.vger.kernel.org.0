Return-Path: <linux-hyperv+bounces-2556-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8256B92F892
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 11:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD701F22DBD
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2024 09:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1614A4C8;
	Fri, 12 Jul 2024 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C2b6stVM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321B143C5D
	for <linux-hyperv@vger.kernel.org>; Fri, 12 Jul 2024 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720778379; cv=none; b=WIpNRGMdOztEIGYj6hFT7ft2+FP5ZNWK6sSEgwVFPq5I7UtLYr37jvI9f5GVjCZ/UxkquFQGyqdedIjnhFzjG+VHr3mJp2aAo1TpTTTVlxciB4xD2MLba2B730W74kU9SUMOvPgLmkT+jhvqfaZd//fcX4BeZHw1RUnkJZ1/NNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720778379; c=relaxed/simple;
	bh=yaKBTV4ABNwERtGjuTAfd+GxzW+p6jWfZdKXfnyu23I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VWtEBjVJhUSq/YmL4BNLTg7o4UZ51X1Ib/O0mAWCsiary0HV8WmFJdMSs+ki6XnaPOsacNvPQf5NgjuG9t2CMGGImbBsTp4GF/8qIvBKG4VfOAahup+PZDjcxbzixm4qvLDulfAbuhK5lVXPH8eUXsfHJT0KPiy//69xYQHNQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C2b6stVM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720778376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNK2WNYT4hz6xvV+XWZB4439w5KRVL9zrlSdvQd6Wt8=;
	b=C2b6stVMh0sFX/L8o3ET/YM9pT5qXTqCNGrleOgFXPx8sR/3mE4jaqKa0BrxX0YC4C1kOB
	apaUEvjLGVkSiUiW80ldnmhGLD08baZBj9wAIb8HlvR8ksC0T6lZpsYKRc0iaWkRGOrRBj
	MUusPfbpzQ/bvy5T8iNHkQDUT3aUMYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-lVNVjgsvNCOe_KixcrexfA-1; Fri, 12 Jul 2024 05:59:34 -0400
X-MC-Unique: lVNVjgsvNCOe_KixcrexfA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-36787ba7ad4so1319022f8f.3
        for <linux-hyperv@vger.kernel.org>; Fri, 12 Jul 2024 02:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720778373; x=1721383173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yNK2WNYT4hz6xvV+XWZB4439w5KRVL9zrlSdvQd6Wt8=;
        b=wugfMDCyQ/Iq51pbBhpADQf7axRhkeaO2KafM6IBAxtL2W/yh/kXz/84MQtVRYuF0I
         ofYbK/8wZb/NmQ33QGo8qf/1KbPeA7VJPIcNUBkzOsCRILu5DLz7UcEK8/SFayccp63C
         a0UcrxZHYEmfGL2jk/Fzzs7HFTxoWq/KmDkfqt5ibqmBSy//QtSOiSfpgn1lDdOdaCb3
         7yW+6mo+H1hGgy7BsABkdKej17l/1/bmr1aBLW1rhfzKS55SEv3TDWtftCLdF1L1DMDB
         YaZILTcUsMjMon29MKKcMtVpsVmqiz9btpbVAKdW/prrQEfCvS52tDumEylByFnvNS39
         n3EA==
X-Forwarded-Encrypted: i=1; AJvYcCWiQR47s0557zO5fZoB47ZqFrI2Ha9lkk7zy9UweiWuACJXwUd0X/fPck5HzWzsvrnxYq8nILw1qDvi/XpCDN6qPqWfaKOmMTDxagth
X-Gm-Message-State: AOJu0YxSvpEqMGoyMM7N3/IBmCuq02Z4b9A55dv6UGf4R3xTbqi+j/4r
	XoOBcVZ561wB0o8W3dyp1+dUTl8HXh9XDo1jjVS/cOespaUgK07M+9i2EKI2rNXdleqEGDhr4ue
	gs5JBaS98ZrCFdXaK+xyr3zw4ggg8Lz1N5z+4BLpbnX6/YyYC4l61Ifq4a5sKGg==
X-Received: by 2002:a5d:4c46:0:b0:367:437f:177f with SMTP id ffacd0b85a97d-367cead1d0fmr6978780f8f.55.1720778373322;
        Fri, 12 Jul 2024 02:59:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7RTJBpoqr/TIMIUkrbE+vKpQ5fn0lcejVvLygeHOHW187lQxQdEmkBo0UptM3swvND74cmQ==
X-Received: by 2002:a5d:4c46:0:b0:367:437f:177f with SMTP id ffacd0b85a97d-367cead1d0fmr6978747f8f.55.1720778372819;
        Fri, 12 Jul 2024 02:59:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde7e187sm9900714f8f.21.2024.07.12.02.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jul 2024 02:59:32 -0700 (PDT)
Message-ID: <2d886ba5-950b-4dff-81ea-8748d7d67c55@redhat.com>
Date: Fri, 12 Jul 2024 11:59:30 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] printk: Add a short description string to kmsg_dump()
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jani Nikula <jani.nikula@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org
References: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20240702122639.248110-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/07/2024 14:26, Jocelyn Falempe wrote:
> kmsg_dump doesn't forward the panic reason string to the kmsg_dumper
> callback.
> This patch adds a new struct kmsg_dump_detail, that will hold the
> reason and description, and pass it to the dump() callback.
> 
> To avoid updating all kmsg_dump() call, it adds a kmsg_dump_desc()
> function and a macro for backward compatibility.
> 
> I've written this for drm_panic, but it can be useful for other
> kmsg_dumper.
> It allows to see the panic reason, like "sysrq triggered crash"
> or "VFS: Unable to mount root fs on xxxx" on the drm panic screen.
> 
> v2:
>   * Use a struct kmsg_dump_detail to hold the reason and description
>     pointer, for more flexibility if we want to add other parameters.
>     (Kees Cook)
>   * Fix powerpc/nvram_64 build, as I didn't update the forward
>     declaration of oops_to_nvram()
> 
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---
>   arch/powerpc/kernel/nvram_64.c             |  8 ++++----
>   arch/powerpc/platforms/powernv/opal-kmsg.c |  4 ++--
>   arch/um/kernel/kmsg_dump.c                 |  2 +-
>   drivers/gpu/drm/drm_panic.c                |  4 ++--
>   drivers/hv/hv_common.c                     |  4 ++--
>   drivers/mtd/mtdoops.c                      |  2 +-
>   fs/pstore/platform.c                       | 10 +++++-----
>   include/linux/kmsg_dump.h                  | 22 +++++++++++++++++++---
>   kernel/panic.c                             |  2 +-
>   kernel/printk/printk.c                     | 11 ++++++++---
>   10 files changed, 45 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index e385d3164648..f9c6568a9137 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -73,7 +73,7 @@ static const char *nvram_os_partitions[] = {
>   };
>   
>   static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason);
> +			  struct kmsg_dump_detail *detail);
>   
>   static struct kmsg_dumper nvram_kmsg_dumper = {
>   	.dump = oops_to_nvram
> @@ -643,7 +643,7 @@ void __init nvram_init_oops_partition(int rtas_partition_exists)
>    * partition.  If that's too much, go back and capture uncompressed text.
>    */
>   static void oops_to_nvram(struct kmsg_dumper *dumper,
> -			  enum kmsg_dump_reason reason)
> +			  struct kmsg_dump_detail *detail)
>   {
>   	struct oops_log_info *oops_hdr = (struct oops_log_info *)oops_buf;
>   	static unsigned int oops_count = 0;
> @@ -655,7 +655,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>   	unsigned int err_type = ERR_TYPE_KERNEL_PANIC_GZ;
>   	int rc = -1;
>   
> -	switch (reason) {
> +	switch (detail->reason) {
>   	case KMSG_DUMP_SHUTDOWN:
>   		/* These are almost always orderly shutdowns. */
>   		return;
> @@ -671,7 +671,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>   		break;
>   	default:
>   		pr_err("%s: ignoring unrecognized KMSG_DUMP_* reason %d\n",
> -		       __func__, (int) reason);
> +		       __func__, (int) detail->reason);
>   		return;
>   	}
>   
> diff --git a/arch/powerpc/platforms/powernv/opal-kmsg.c b/arch/powerpc/platforms/powernv/opal-kmsg.c
> index 6c3bc4b4da98..bb4218fa796e 100644
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
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 4382cf02a6d1..419021175272 100644
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
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 948aed00595e..8794c7f6c0ee 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -655,11 +655,11 @@ static struct drm_plane *to_drm_plane(struct kmsg_dumper *kd)
>   	return container_of(kd, struct drm_plane, kmsg_panic);
>   }
>   
> -static void drm_panic(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason)
> +static void drm_panic(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detail)
>   {
>   	struct drm_plane *plane = to_drm_plane(dumper);
>   
> -	if (reason == KMSG_DUMP_PANIC)
> +	if (detail->reason == KMSG_DUMP_PANIC)
>   		draw_panic_plane(plane);
>   }
>   
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9c452bfbd571..7a35c82976e0 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -207,13 +207,13 @@ static int hv_die_panic_notify_crash(struct notifier_block *self,
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
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 2f11585b5613..86d49db9196d 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -298,7 +298,7 @@ static void find_next_position(struct mtdoops_context *cxt)
>   }
>   
>   static void mtdoops_do_dump(struct kmsg_dumper *dumper,
> -			    enum kmsg_dump_reason reason)
> +			    struct kmsg_dump_detail *detail)
>   {
>   	struct mtdoops_context *cxt = container_of(dumper,
>   			struct mtdoops_context, dump);
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index 3497ede88aa0..9c6b7c97fa3c 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -275,7 +275,7 @@ void pstore_record_init(struct pstore_record *record,
>    * end of the buffer.
>    */
>   static void pstore_dump(struct kmsg_dumper *dumper,
> -			enum kmsg_dump_reason reason)
> +			struct kmsg_dump_detail *detail)
>   {
>   	struct kmsg_dump_iter iter;
>   	unsigned long	total = 0;
> @@ -285,9 +285,9 @@ static void pstore_dump(struct kmsg_dumper *dumper,
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
> @@ -311,7 +311,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>   		pstore_record_init(&record, psinfo);
>   		record.type = PSTORE_TYPE_DMESG;
>   		record.count = oopscount;
> -		record.reason = reason;
> +		record.reason = detail->reason;
>   		record.part = part;
>   		record.buf = psinfo->buf;
>   
> @@ -352,7 +352,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
>   		}
>   
>   		ret = psinfo->write(&record);
> -		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
> +		if (ret == 0 && detail->reason == KMSG_DUMP_OOPS) {
>   			pstore_new_entry = 1;
>   			pstore_timer_kick();
>   		} else {
> diff --git a/include/linux/kmsg_dump.h b/include/linux/kmsg_dump.h
> index 906521c2329c..65f5a47727bc 100644
> --- a/include/linux/kmsg_dump.h
> +++ b/include/linux/kmsg_dump.h
> @@ -39,6 +39,17 @@ struct kmsg_dump_iter {
>   	u64	next_seq;
>   };
>   
> +/**
> + *struct kmsg_dump_detail - kernel crash detail
> + * @reason: reason for the crash, see kmsg_dump_reason.
> + * @description: optional short string, to provide additional information.
> + */
> +
> +struct kmsg_dump_detail {
> +	enum kmsg_dump_reason reason;
> +	const char *description;
> +};
> +
>   /**
>    * struct kmsg_dumper - kernel crash message dumper structure
>    * @list:	Entry in the dumper list (private)
> @@ -49,13 +60,13 @@ struct kmsg_dump_iter {
>    */
>   struct kmsg_dumper {
>   	struct list_head list;
> -	void (*dump)(struct kmsg_dumper *dumper, enum kmsg_dump_reason reason);
> +	void (*dump)(struct kmsg_dumper *dumper, struct kmsg_dump_detail *detail);
>   	enum kmsg_dump_reason max_reason;
>   	bool registered;
>   };
>   
>   #ifdef CONFIG_PRINTK
> -void kmsg_dump(enum kmsg_dump_reason reason);
> +void kmsg_dump_desc(enum kmsg_dump_reason reason, const char *desc);
>   
>   bool kmsg_dump_get_line(struct kmsg_dump_iter *iter, bool syslog,
>   			char *line, size_t size, size_t *len);
> @@ -71,7 +82,7 @@ int kmsg_dump_unregister(struct kmsg_dumper *dumper);
>   
>   const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason);
>   #else
> -static inline void kmsg_dump(enum kmsg_dump_reason reason)
> +static inline void kmsg_dump_desc(enum kmsg_dump_reason reason, const char *desc)
>   {
>   }
>   
> @@ -107,4 +118,9 @@ static inline const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
>   }
>   #endif
>   
> +static inline void kmsg_dump(enum kmsg_dump_reason reason)
> +{
> +	kmsg_dump_desc(reason, NULL);
> +}
> +
>   #endif /* _LINUX_KMSG_DUMP_H */
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 0843a275531a..0a8b29c44f3c 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -378,7 +378,7 @@ void panic(const char *fmt, ...)
>   
>   	panic_print_sys_info(false);
>   
> -	kmsg_dump(KMSG_DUMP_PANIC);
> +	kmsg_dump_desc(KMSG_DUMP_PANIC, buf);
>   
>   	/*
>   	 * If you doubt kdump always works fine in any situation,
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 5dcc05e1aa56..19bc414be5f0 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -4272,16 +4272,21 @@ const char *kmsg_dump_reason_str(enum kmsg_dump_reason reason)
>   EXPORT_SYMBOL_GPL(kmsg_dump_reason_str);
>   
>   /**
> - * kmsg_dump - dump kernel log to kernel message dumpers.
> + * kmsg_dump_desc - dump kernel log to kernel message dumpers.
>    * @reason: the reason (oops, panic etc) for dumping
> + * @desc: a short string to describe what caused the panic or oops. Can be NULL
> + * if no additional description is available.
>    *
>    * Call each of the registered dumper's dump() callback, which can
>    * retrieve the kmsg records with kmsg_dump_get_line() or
>    * kmsg_dump_get_buffer().
>    */
> -void kmsg_dump(enum kmsg_dump_reason reason)
> +void kmsg_dump_desc(enum kmsg_dump_reason reason, const char *desc)
>   {
>   	struct kmsg_dumper *dumper;
> +	struct kmsg_dump_detail detail = {
> +		.reason = reason,
> +		.description = desc};
>   
>   	rcu_read_lock();
>   	list_for_each_entry_rcu(dumper, &dump_list, list) {
> @@ -4299,7 +4304,7 @@ void kmsg_dump(enum kmsg_dump_reason reason)
>   			continue;
>   
>   		/* invoke dumper which will iterate over records */
> -		dumper->dump(dumper, reason);
> +		dumper->dump(dumper, &detail);
>   	}
>   	rcu_read_unlock();
>   }
> 
> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e

Gentle ping, I need reviews from powerpc, usermod linux, mtd, pstore and 
hyperv, to be able to push it in the drm-misc tree.

Best regards,

-- 

Jocelyn


