Return-Path: <linux-hyperv+bounces-2744-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 561B494AE68
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 18:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678E5B216AD
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9413A27D;
	Wed,  7 Aug 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJF/O2p9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NqleyJK3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4F2D05D;
	Wed,  7 Aug 2024 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723049433; cv=none; b=JuhSp7ikZgzAdXCg73lU7jYFOLlGNXb7XWZeKUkQEG1FoBn/7byJKldQoXZUtJNaMNUQ+y4/wIGHra5kXisSkqtk9jR1G9MlmtpqyGgkhp86v4bgr2gusqRjjhHa/fjS3FJ4JlVi2mbGnlh6cdh0bPy0s1QjlcjA3V+2wmFsjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723049433; c=relaxed/simple;
	bh=HGL0oXbjlbRusyfBugrb+Rkg/33YKXeRPuHpw4R//M8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cFVhFg5zYPtwbfIbQTKRu0tmO/6MAKZhynm1BJCcXgFE4hEeFS1M9GXz3m/DsG1iJZ0CyzICt1tQ1ewaCy3HWTQQk9aDHoIEH9cefEI4U7gukzb25PyRK8pwQB8yejKVLDf9YnL1Oh26ujdO1/gVi0djV4a0CkR/IoKjAcA9/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJF/O2p9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NqleyJK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723049429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PbgZu6jJQqKx5eAg7S2Xg9YY/wFzAD6EqlFUAxNjEeU=;
	b=HJF/O2p9rsdZjb8UOWRDijV69igFLVGikVu+KTg/Sn1mqyUaoSZB9O1AyPte13G+yccrxo
	v22aEze8FDSuMBjaLH9bALFuDOhVfibi34KDTRvJh34XdwZXay7vjYtO5FEytUIzj3cmoM
	OLgCrIiSxRhjp9oAXirmaNHD8IftrOBzFJtO2lU6VSkHl5XHe79uI/N4Qf8b6M8ngS5tJa
	MnYVBKxBOkV+nCJa9WSOmOUGaQAGrqgDDmycBcdOLjkbLt0WjrhScpY8SXH9am/Lnu1d3V
	zo0nsnlxP6QWz6X0CBNqdiM3ctGifCHv5ORBJchs4D4xCoTcYpi7u0rNvXm0Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723049429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PbgZu6jJQqKx5eAg7S2Xg9YY/wFzAD6EqlFUAxNjEeU=;
	b=NqleyJK3nVo3JhF6hXxD1TCGsGQPsFNlNsFQetaDWwzunij//nGt0dU2OJGiwhG7S9Bkob
	VWhLbHCpcT38dvDA==
To: Yunhong Jiang <yunhong.jiang@linux.intel.com>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, rafael@kernel.org, lenb@kernel.org,
 kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-acpi@vger.kernel.org,
 yunhong.jiang@linux.intel.com
Subject: Re: [PATCH 3/7] x86/dt: Support the ACPI multiprocessor wakeup for
 device tree
In-Reply-To: <20240806221237.1634126-4-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-4-yunhong.jiang@linux.intel.com>
Date: Wed, 07 Aug 2024 18:50:29 +0200
Message-ID: <87frrg2s6i.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Aug 06 2024 at 15:12, Yunhong Jiang wrote:
>  
> -static int __init acpi_mp_setup_reset(u64 reset_vector)
> +static int __init __maybe_unused acpi_mp_setup_reset(u64 reset_vector)
>  {
>  	struct x86_mapping_info info = {
>  		.alloc_pgt_page = alloc_pgt_page,
> @@ -226,7 +228,7 @@ static int acpi_wakeup_cpu(u32 apicid, unsigned long start_ip)
>  	return 0;
>  }
>  
> -static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake)
> +static void __maybe_unused acpi_mp_disable_offlining(struct
> acpi_madt_multiproc_wakeup *mp_wake)

Please move those functions into the #ifdef CONFIG_ACPI

>  {
>  	cpu_hotplug_disable_offlining();
>  
> @@ -248,6 +250,7 @@ static void acpi_mp_disable_offlining(struct acpi_madt_multiproc_wakeup *mp_wake
>  	mp_wake->mailbox_address = 0;
>  }
>  
> +#ifdef CONFIG_ACPI
>  int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
> +
> +#ifdef CONFIG_OF
> +int __init dtb_parse_mp_wake(u64 *wake_mailbox_paddr)

Why not returning the mailbox physical address and 0 on failure instead
of that pointer and a integer return value which is ignored at the call
site?

> +{
> +	struct device_node *node;
> +	u64 mailaddr;
> +	int ret = 0;
> +
> +	node = of_find_node_by_path("/cpus");
> +	if (!node)
> +		return -ENODEV;
> +
> +	if (of_property_match_string(node, "enable-method",
> +				     "acpi-wakeup-mailbox") < 0) {

Please use the 100 characters line width and spare the line break.

> +		pr_err("No acpi wakeup mailbox enable-method\n");
> +		ret = -ENODEV;
> +		goto done;
> +	}
> +
> +	/*
> +	 * No support to the MADT reset vector yet.

s/to/for/

Also a single line comment is sufficient for this.

> +	 */
> +	cpu_hotplug_disable_offlining();
> +
> +	if (of_property_read_u64(node, "wakeup-mailbox-addr", &mailaddr)) {
> +		pr_err("Invalid wakeup mailbox addr\n");
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +	acpi_mp_wake_mailbox_paddr = mailaddr;
> +	if (wake_mailbox_paddr)
> +		*wake_mailbox_paddr = mailaddr;
> +	pr_info("dt wakeup-mailbox: addr 0x%llx\n", mailaddr);
> +	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
> +done:

newline before the label please. Up there you waste 3 lines for a
trivial comment and here you make the code unreadable...

Thanks,

        tglx



