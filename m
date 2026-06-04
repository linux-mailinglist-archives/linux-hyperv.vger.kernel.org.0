Return-Path: <linux-hyperv+bounces-11487-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v4liNfBZIWopEwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11487-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 12:56:48 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B90663F3C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 04 Jun 2026 12:56:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=B82TNq9C;
	dkim=pass header.d=redhat.com header.s=google header.b=MbaR1EaB;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11487-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11487-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECFDB3078E70
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2026 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0630407597;
	Thu,  4 Jun 2026 10:45:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B37C935
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 10:45:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569911; cv=none; b=iGlnxuFslExD0pTLqninTcKmCzvm66MbDo7c71ERqJT66nf5I/N2t7ULoTfGMuTIt5cAVS8JQuNByMyuxHqnYyCfZhFvp7HI8j3hJSRml2PiVH/PcAbcSdq4C9J+7JzDmLkvhNnHvtfBeRmxRkHUZ+nVzIstnIF9HsOINsON8vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569911; c=relaxed/simple;
	bh=pXOC3ieQ42cIu2RuSkFAP20upsmn2zTEUHKrLTllEys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LGSyC81cOkmk51/Te4DXcr1S9i9Sz8owNCXnEzPGrowhG9peF0l9lXRmSg1BYKjdZC70WPaYdHi5m2euMOuN0dxFz7hnMzPga9SuQ0N/uqO9lWz3oEYD3Uj8RxGcaIyrUJBdAl97eL98mZ+alH1Wp0OyAjnIe4Pb1Q8CdApJZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B82TNq9C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MbaR1EaB; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780569909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
	b=B82TNq9C7CU9wajSDKTsX9f6HT6Sd8VD3QhviMzJjQhy4tEOM3lgvatP8/cxpvkgzBpB5e
	I5b5KGewjnC7zpBVEIy54vg8QIP3yNZStLzqKk3UZYZtjHJzs83kWvwvY8mSaVBGMjm4Dp
	UKdrTLnsblnNee2D/oobRt9y0kIsK1M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-Gs6KkofXO22QJlMZ7eLu4Q-1; Thu, 04 Jun 2026 06:45:08 -0400
X-MC-Unique: Gs6KkofXO22QJlMZ7eLu4Q-1
X-Mimecast-MFC-AGG-ID: Gs6KkofXO22QJlMZ7eLu4Q_1780569907
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef9437b7aso388495f8f.0
        for <linux-hyperv@vger.kernel.org>; Thu, 04 Jun 2026 03:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780569907; x=1781174707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
        b=MbaR1EaBzuQi6kWyyyeG9yiP71rnPBoQpA6gULTMXy1ppsS4fGeiTBJm25xmOm08+S
         LJL/Sz8X1F7m/ulP5/h2bGXSmbbJPZ+A9y+x/IuI9ehTPqYfxePshWe34T/FjetoldbS
         6dj277tA8Z9ior2ExYwd/+GcXNpNQzcGz2go0jxlJEQrtTJXtsOdSgSj6boy9bGvAxXS
         5maSIIHjmwc7OviPWvkoe1Vndaf+vN+m1pGWzn9hF5buM0Xugc2xm9JU/XcrlDgKzq94
         1JDxueuRI3KC2Efk/6Zgc2RO3vHUQLyqfvEtv0Y8vCYDl9o8qcLXAZ6v4SVZVLqWCaxw
         iqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780569907; x=1781174707;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wbsaCU5Vs3pFhS9fw5gs64Im6dVDjZtVePKSfJVpfmE=;
        b=Sw6CqLvjH3X793Hi+81/4+h6C45VnT4B77vgIhyXN6c1N2CU5y5NqHFHoZc2YNx3Ta
         QYGwCq5UUuq0IZgcy7C8F6S2wzYM1WxBy6SB87CbU2+soogNKzOtlTjy/SxA3xOIWynf
         OI/5liCw+WWkeYu6Bqc0zXx7qj35kzfPjutkT8MIRjtbTkCmHyuEnnpKyCoMu7VBDq63
         ysqNCItb8/Ou+8U0UPylwWHRfNKqgfDVKfya9Xk1rxHwl75BvDjPG6ty1e/MUlFm0ZVa
         q3cAYWaBQ59lQFqATM8J6hNbjtUyTljnxevqECugAOM2xPe/QuMkxXaVGayncEIRj+Pu
         Rv+w==
X-Gm-Message-State: AOJu0YzBOMPahfFU68pdtJNRZIlHJCQ1cx4xEJsDE25BzgDIPHQqaBvo
	M0Bb4pJtVbRCkOrZ1XQJwglovhr2ofo8Zg9wfSxGY1gmmOTTBKr9/pPx5DFfBJLY/QO7ZpRgfS/
	UVetOEe+Yodask7FTcmHUJpR1gDhxCR2iGc94vLc/q3A2g7FgtqI4bkxsvIh2S1GY5A==
X-Gm-Gg: Acq92OGCK4XqhVffVCCoSwIhBy1t93ke2qk8UoEQqk8IcDg+9BC8Klz7L8If6NnpPCJ
	fYSUJ4wRU554cL9WY91yGxrTLkf48hN3G4BOJpDy+zVn6Qh8O9+N4quJ6t90nPIKFhkyjK0pkLB
	hdJATlz/Zt3WN0Eg8YrPRD014t//Hui4xplijhhe3qko3hu5j86CPLWwer5J6GFoAv1nhfWrTf5
	okrGWp9CCnYNNHXZHVq7IqboZ+Z/S3pJnCvfkvV/aJ1TFttnUm3gfZMybruwGgpLXMPwsyVeCa5
	eH/yU1944sljPo5x0ePnH+TwuOxnBGK5r7cz5WvJrQkIjpD/r8jjSM1er7F5JXatI1NygtXjEUc
	pRhYtrplBeK+g0UBvLuTvj7LVnMaicWNvVvHumAOQwYmbiL5N1sBwtFiELlVihOaKZt8=
X-Received: by 2002:a5d:630a:0:b0:45e:e44b:3147 with SMTP id ffacd0b85a97d-4602178318cmr7176632f8f.5.1780569906584;
        Thu, 04 Jun 2026 03:45:06 -0700 (PDT)
X-Received: by 2002:a5d:630a:0:b0:45e:e44b:3147 with SMTP id ffacd0b85a97d-4602178318cmr7176572f8f.5.1780569906004;
        Thu, 04 Jun 2026 03:45:06 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcad5sm16588064f8f.5.2026.06.04.03.45.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:45:05 -0700 (PDT)
Message-ID: <6d1fa9d9-73c2-48b5-95a1-51710d81b3ed@redhat.com>
Date: Thu, 4 Jun 2026 12:45:03 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Simon Horman
 <horms@kernel.org>, Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Dipayaan Roy <dipayanroy@linux.microsoft.com>,
 Shiraz Saleem <shirazsaleem@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Yury Norov <yury.norov@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
 Shradha Gupta <shradhagupta@microsoft.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>, stable@vger.kernel.org
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11487-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,outlook.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:shradhagupta@linux.microsoft.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6B90663F3C3

On 6/1/26 12:27 PM, Shradha Gupta wrote:
> In mana driver, the number of IRQs allocated is capped by the
> min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> than the vcpu count, we want to utilize all the vCPUs, irrespective of
> their NUMA/core bindings.
> 
> This is important, especially in the envs where number of vCPUs are so
> few that the softIRQ handling overhead on two IRQs on the same vCPU is
> much more than their overheads if they were spread across sibling vCPUs.
> 
> This behaviour is more evident with dynamic IRQ allocation. Since MANA
> IRQs are assigned at a later stage compared to static allocation, other
> device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> weights become imbalanced, causing multiple MANA IRQs to land on the
> same vCPU, while some vCPUs have none.
> 
> In such cases when many parallel TCP connections are tested, the
> throughput drops significantly.
> 
> Test envs:
> =======================================================
> Case 1: without this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
> 	TYPE		effective vCPU aff
> =======================================================
> IRQ0:	HWC		0
> IRQ1:	mana_q1		0
> IRQ2:	mana_q2		2
> IRQ3:	mana_q3		0
> IRQ4:	mana_q4		3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU		0	1	2	3
> =======================================================
> pass 1:		38.85	0.03	24.89	24.65
> pass 2:		39.15	0.03	24.57	25.28
> pass 3:		40.36	0.03	23.20	23.17
> 
> =======================================================
> Case 2: with this patch
> =======================================================
> 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> 
>         TYPE            effective vCPU aff
> =======================================================
> IRQ0:   HWC             0
> IRQ1:   mana_q1         0
> IRQ2:   mana_q2         1
> IRQ3:   mana_q3         2
> IRQ4:   mana_q4         3
> 
> %soft on each vCPU(mpstat -P ALL 1) on receiver
> vCPU            0       1       2       3
> =======================================================
> pass 1:         15.42	15.85	14.99	14.51
> pass 2:         15.53	15.94	15.81	15.93
> pass 3:         16.41	16.35	16.40	16.36
> 
> =======================================================
> Throughput Impact(in Gbps, same env)
> =======================================================
> TCP conn	with patch	w/o patch
> 20480		15.65		7.73
> 10240		15.63		8.93
> 8192		15.64		9.69
> 6144		15.64		13.16
> 4096		15.69		15.75
> 2048		15.69		15.83
> 1024		15.71		15.28
> 
> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>

Why do you consider this patch a fix? To me is a configuration
improvement and should land on net-next.

> @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +/* should be called with cpus_read_lock() held */

Minor nit: s/should/must/ or just drop the comment, as
`for_each_online_cpu()` usage implies that.

> +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> +{
> +	int cpu;
> +
> +	for_each_online_cpu(cpu) {
> +		if (len == 0)
> +			break;
> +
> +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> +		len--;
> +	}

As this is another heuristic regarding irq spreading, why don't you
implement that inside irq_setup()?

> @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  	 * first CPU sibling group since they are already affinitized to HWC IRQ
>  	 */
>  	cpus_read_lock();
> -	if (gc->num_msix_usable <= num_online_cpus())
> -		skip_first_cpu = true;
> +	if (gc->num_msix_usable <= num_online_cpus()) {
> +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> +		if (err) {
> +			cpus_read_unlock();
> +			goto free_irq;
> +		}
> +	} else {
> +		/*
> +		 * When num_msix_usable are more than num_online_cpus, our
> +		 * queue IRQs should be equal to num of online vCPUs.
> +		 * We try to make sure queue IRQs spread across all vCPUs.
> +		 * In such a case NUMA or CPU core affinity does not matter.
> +		 * Note: in this case the total mana IRQ should always be
> +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> +		 * in HWC setup calls
> +		 * However, if CPUs went offline since num_msix_usable was
> +		 * computed, queue IRQs will be more than num_online_cpus().
> +		 * In such cases remaining extra IRQs will retain their default
> +		 * affinity.
> +		 */
> +		int first_unassigned = num_online_cpus();
> +		if (nvec > first_unassigned) {

An empty line is needed between the variable declaration and the code.

/P


