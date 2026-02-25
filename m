Return-Path: <linux-hyperv+bounces-8979-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK/fA3/nnmkCXwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8979-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:13:51 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C2B197193
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C187030238E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBD13ACF08;
	Wed, 25 Feb 2026 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="tXmwoLy4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F604392822;
	Wed, 25 Feb 2026 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772021518; cv=pass; b=pHjGpqDKZhutmfvrFAUyz0nTRd55pW/BIoDWu5sCk61Zkn+KvICK6bQK6dmTzcAH0HV5B0hSFmeELX8WilaAAwT6C0qpdEYppN2Zmn3TtIa+MVcle8MAciJ2CYWEZzOs1wt8VeQdS7KoifkxDOTM3iR0vn5jfam8v7Va6uXCSL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772021518; c=relaxed/simple;
	bh=3hNDYnNJ3Ec/17kIkipNa2xDEAr4vJwBuyuVkMUYud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCcFF/QTDmJ+jiVT23kWO5XCbarh6dqUrGL4Gfkk7NFRfAJ3whDMhlKEHzaLnDU6VAeOBKzj5TzRvxq4jMSeJkiYelrDUW7rkSDzQ/gOC63sQzlzDR4JUrzyDeaPE4odKkAfgywdSxGerhX9av+JddASwxsouOA6oyvn2EQGRC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=tXmwoLy4; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1772021509; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=E4pbYYswiGsQIa2UQBlT8VUIvNNhcPyzYHshfA8GkF7rHauBYNyr2PtkvaqtptQcb+W9ahxboC5s+QnDGt2eg/dNdhHtjROTianVkOjqgLeKQKRX5CE9w5tkClmg8X6w1ltCG7rgskqbR/v3u9LLEqu/gfA3HSRsc5gkAq7su8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772021509; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CRuey6den6dI84nzZyb4RNlr+g68GzekppcrlOc2u+c=; 
	b=V0ok8kS7F4uwwMLIX0omsh3ObElVqFdkP1M8kiREQ6Y2ZxtrD5YfcvVk2qMdSVHA5RzYYETaTNtNWL5SG0TYV/5CbxgMBtNOdP0cceB1QnS28EQZUfylKiOe1MLnR1K8wQVxSXeOK8IIyghLp945xe0l0Dbbwr4BkSe6rCABBgg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772021509;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=CRuey6den6dI84nzZyb4RNlr+g68GzekppcrlOc2u+c=;
	b=tXmwoLy4i3Op4nE0SOtyF7qwGIBH1lE0S6Q+MI3S+sQqbKJ0TzuWE+WY28iK9K+J
	M7SZTykgxA2QnCwZtHUus4FH+YXg5p2w9r0+lsoiSGKNyIPAYds6DvJtG645Y2rjQsz
	kll+UPPXh60VM9IJtbBapQLg2+tL+kpJYrafIL/g=
Received: by mx.zohomail.com with SMTPS id 1772021505754741.1670376489449;
	Wed, 25 Feb 2026 04:11:45 -0800 (PST)
Date: Wed, 25 Feb 2026 12:11:41 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mshv: add arm64 support for doorbell & intercept
 SINTs
Message-ID: <aZ7m_Zv3pQekTXaP@anirudh-surface.localdomain>
References: <20260223140159.1627229-1-anirudh@anirudhrb.com>
 <20260223140159.1627229-3-anirudh@anirudhrb.com>
 <aZys_5A657AYq5DQ@skinsburskii.localdomain>
 <SN6PR02MB41575AC771D08F64AC00DC17D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575AC771D08F64AC00DC17D477A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8979-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 81C2B197193
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:49:37PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Monday, February 23, 2026 11:40 AM
> > 
> 
> [snip]
> 
> > > +
> > > +static int __init mshv_sint_vector_init(void)
> > > +{
> > > +	int ret;
> > > +	struct hv_register_assoc reg = {
> > > +		.name = HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID,
> > > +	};
> > > +	union hv_input_vtl input_vtl = { 0 };
> > > +
> > > +	if (acpi_disabled)
> > > +		return -ENODEV;
> > > +
> > > +	ret = hv_call_get_vp_registers(HV_VP_INDEX_SELF, HV_PARTITION_ID_SELF,
> > > +				1, input_vtl, &reg);
> > > +	if (ret || !reg.value.reg64)
> > > +		return -ENODEV;
> > > +
> > > +	mshv_sint_vector = reg.value.reg64;
> > > +	ret = mshv_acpi_setup_sint_irq();
> > > +	if (ret <= 0) {
> > > +		pr_err("Failed to setup IRQ for MSHV SINT vector %d: %d\n",
> > > +			mshv_sint_vector, ret);
> > > +		goto out_fail;
> > > +	}
> > > +
> > > +	mshv_sint_irq = ret;
> > 
> > nit: given that mshv_sint_irq can't be zero, the logic can be simplified by
> > using 0 instead of -1.
> 
> The test for <= 0 is actually wrong -- it should be just < 0. Zero is a valid
> Linux IRQ number. For example, here's the output of /proc/interrupts on
> a Gen1 VM on Hyper-V, where IRQ 0 is used by the legacy timer:
> 
> root@gen1ubun:~# cat /proc/interrupts
>            CPU0       CPU1       CPU2       CPU3
>   0:         18          0          0          0 IR-IO-APIC   2-edge      timer
>   1:          0          9          0          0 IR-IO-APIC   1-edge      i8042
>   4:          0          0          0        792 IR-IO-APIC   4-edge      ttyS0
>   6:          6          0          0          0 IR-IO-APIC   6-edge      floppy
>   8:          0          0          0          0 IR-IO-APIC   8-edge      rtc0
>   9:          0          0          0          0 IR-IO-APIC   9-fasteoi   acpi
> 
> But I see other places throughout Linux kernel code that treat IRQ 0 as
> invalid. So I dunno .... But it's probably better to treat 0 as a valid IRQ
> number.

Agreed. I will fix this check in v6.

Thanks,
Anirudh.

> 
> Michael
> 
> > 
> > 
> > 
> > > +
> > > +	ret = request_percpu_irq(mshv_sint_irq, mshv_percpu_isr, "MSHV",
> > > +		&mshv_evt);
> > > +	if (ret)
> > > +		goto out_unregister;
> > > +
> > > +	return 0;
> > > +
> > > +out_unregister:
> > > +	mshv_acpi_cleanup_sint_irq();
> > > +out_fail:
> > > +	return ret;
> > > +}
> > > +
> > > +static void mshv_sint_vector_cleanup(void)
> > > +{
> > > +	free_percpu_irq(mshv_sint_irq, &mshv_evt);
> > > +	mshv_acpi_cleanup_sint_irq();
> > > +}
> > > +#else /* !HYPERVISOR_CALLBACK_VECTOR */
> > > +static int __init mshv_sint_vector_init(void)
> > 
> > nit: `init` is usually paired with `exit` or `fini`, so maybe `cleanup` can be
> > renamed to `exit` as well for better consistency?
> > 
> > Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > 
> > > +{
> > > +	mshv_sint_vector = HYPERVISOR_CALLBACK_VECTOR;
> > > +	return 0;
> > > +}
> > > +
> > > +static void mshv_sint_vector_cleanup(void)
> > > +{
> > > +}
> > > +#endif /* HYPERVISOR_CALLBACK_VECTOR */
> > > +
> > >  int __init mshv_synic_init(struct device *dev)
> > >  {
> > >  	int ret = 0;
> > >
> > > +	ret = mshv_sint_vector_init();
> > > +	if (ret)
> > > +		return ret;
> > > +
> > >  	synic_pages = alloc_percpu(struct hv_synic_pages);
> > >  	if (!synic_pages) {
> > >  		dev_err(dev, "Failed to allocate percpu synic page\n");
> > > -		return -ENOMEM;
> > > +		ret = -ENOMEM;
> > > +		goto sint_vector_cleanup;
> > >  	}
> > >
> > >  	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > > @@ -713,6 +810,8 @@ int __init mshv_synic_init(struct device *dev)
> > >  	cpuhp_remove_state(synic_cpuhp_online);
> > >  free_synic_pages:
> > >  	free_percpu(synic_pages);
> > > +sint_vector_cleanup:
> > > +	mshv_sint_vector_cleanup();
> > >  	return ret;
> > >  }
> > >
> > > @@ -721,4 +820,5 @@ void mshv_synic_cleanup(void)
> > >  	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> > >  	cpuhp_remove_state(synic_cpuhp_online);
> > >  	free_percpu(synic_pages);
> > > +	mshv_sint_vector_cleanup();
> > >  }
> > > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > > index 30fbbde81c5c..7676f78e0766 100644
> > > --- a/include/hyperv/hvgdk_mini.h
> > > +++ b/include/hyperv/hvgdk_mini.h
> > > @@ -1117,6 +1117,8 @@ enum hv_register_name {
> > >  	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
> > >
> > >  	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
> > > +#elif defined(CONFIG_ARM64)
> > > +	HV_ARM64_REGISTER_SINT_RESERVED_INTERRUPT_ID	= 0x00070001,
> > >  #endif
> > >  };
> > >
> > > --
> > > 2.34.1
> > >
> 

