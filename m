Return-Path: <linux-hyperv+bounces-11540-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sv+IFQJEJ2p7uAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11540-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 00:36:50 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A18FA65B001
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 00:36:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Vh54mUpR;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11540-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11540-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44D9830078D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 22:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA43B38A9;
	Mon,  8 Jun 2026 22:35:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBE3B27FF
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 22:35:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958147; cv=none; b=f2EJR6nfF7tbZPWO1rE/6FzUXQZRh+SkJWulAyh1v2BVJiIZ3bZa+KZBDYaHbh6MT8ekrhjCJRRQJBueqLLq096h98bLQteQmSHoJ7pcKWsbV9M8egfHHnWTMLSlB0JLaBGXpUoFgMHBUdUWtYgGQ3WhvDFGTfoou8XtM0k6uPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958147; c=relaxed/simple;
	bh=6Sa36424MSv00wIROIK0Z1DKRCewQ8z+IXYeMBIjWr0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6W7dPIJrqK93P5jYa2cxhUwuQNLl/dOuHdhaotSebEu60oKUeaUr5FK1oC3UFUMMWjCW+uis99MWusY9hD4aBHxwHg+h6kPbUH0kl6DAIw4KJ5quo1TU/Fg+OP9VejXdZTXFVgvlygYJVqq4Z5CGVowrvMIwzLT8U912LLq1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh54mUpR; arc=none smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7ea16f090b4so62473087b3.2
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Jun 2026 15:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780958145; x=1781562945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i/mflWhGCiGSEtCw4YVqLmLSuwD4pElR/cCJrqUuFZ4=;
        b=Vh54mUpRkFx3btdAXF6TL5/HEV13M7IhOLAf9tiEs7wwt+TuyG1PjY8ERuUaFhzZTa
         RsixwxZMZmUMXBnd3u5G/VADnQ23WJXNx9h5DXdg8BAcn9AvSdwHEwWNlrGoAv4eSRmH
         rb8Gkm7fnqymcF2VwOn38I8zWnP9mdcDSHZ4lkXb5xY7VUDILumthC/1n6Nd2iY6LQGr
         /Wg355sXC77QChFyqdajcL6WxibIjGagOC3MAQ7PCb6iTN2C4Tx1MOueRITMCqni+IeK
         xbqzSixM2EhacD0zNMFEK/R+LMeyuJY/M42lBvq7AowIy5URR2o3Dq/tDbRNU75YOStJ
         NvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958145; x=1781562945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/mflWhGCiGSEtCw4YVqLmLSuwD4pElR/cCJrqUuFZ4=;
        b=LBGdmevr2HxH/x+6NMGiZFSBcszxUMi5VJO71+QLajBuT/Au3YZ2H27CC6RKyOafmB
         CogYwV+0hldjEZgotntnDy7u/M9pb61JsWMjvk9jA4ibgbc/sVLG3TlYZ04dY3JtCzXl
         Y6dAKIK1vATSRF+Cg6f91ZNqfXxi2QZbAuf0jZi+CBiEP19FWd6vNZf4mLIEsxD9B2JB
         PvvKKo5F86moC3zMGlaY4NbWuclhyL5PmfUAolF7La0ihONl8LHysbd+V8j8M0CEyN5o
         nxLQTLzjHO3X4Xskx28LTfbODVddeVOZtKWEV/XCr8tOlRM/2tDdUxl/Dxd2VxY3BO3s
         ha/A==
X-Forwarded-Encrypted: i=1; AFNElJ9zWPo987Hjy8H5LheXYofzUEEhYyCBx/J1yz48Je6/NPENllTyw1nLQxW6hfHYHipgUJUvSxSQmnHR+aM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz26ypuQbSak6CeH3qscVVJruRQh/5S/TVetluX3OIshQew4uR
	vj1grQ3Vq5X9MAT4wlZWNWfY02hgeP742pOz3dOK0Tv+m396w1AV2OCe
X-Gm-Gg: Acq92OF3nW6PasTF3Us6r+6r39UVPxH1Bjm1KxLRBRcYVHi9RqzvWcjeEkXGGzQXv6W
	1rqPCShzkcV6dSUZj7Fnj6lN78tFhdB1xkLTGEx5kadErTQiwAFRNGOhI16hbtQD0wh9PQM9SDo
	qFunMUw22c+oYKe/MbYUv+T3nuWF0aGxlaAC33XRNtGviemqmpce3yencjigfjcozzIeKiM4G2m
	6ZDa7QHaJy028urfyK+a2xF/QABTS2FzNVZr1i/Ko2pPnZ8rTKREp4AjD/H3OPE/++KNrbJrALS
	wOYVXpfoDqlNVgMd+rI38MtXvAeXTKMJTJksQH13m2HXo9Ej9mtCkNzy4quaYsIk9NmQa3ER67j
	VdNAxm6RocDI581I1SigCqqDyRh9kt2Dp+/qJZ2f8BabuhZ4aQEHUwBeI78/IDxLoXZk2z9O7X9
	NMqBWEdQ12iEuXL8Fd3rZpB8eiJoma
X-Received: by 2002:a05:690c:48c7:b0:7d1:cd93:c8f3 with SMTP id 00721157ae682-7ed0b778ffcmr175899307b3.13.1780958144910;
        Mon, 08 Jun 2026 15:35:44 -0700 (PDT)
Received: from localhost ([50.221.107.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea2167945csm88014667b3.18.2026.06.08.15.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 15:35:44 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
X-Google-Original-From: Yury Norov <ynorov@nvidia.com>
Date: Mon, 8 Jun 2026 18:35:44 -0400
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>, Yury Norov <yury.norov@gmail.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <aidDwAQqnQRCNQP1@yury>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11540-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[yurynorov@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:shradhagupta@linux.microsoft.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurynorov@gmail.com,linux-hyperv@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[yury:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A18FA65B001

On Mon, Jun 01, 2026 at 03:27:46AM -0700, Shradha Gupta wrote:
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
 
So, case 1 is irq_setup(), and case 2 is irq_setup_linear(). Is that
correct?

On the previous round we've discussed a no-affinity case:

        irq_set_affinity_and_hint(irq, NULL);

My naive view is that the more freedom you give to the scheduler in
balancing the IRQ handling load, the better results you've got. But
your numbers show that the 'linear' distribution is still better. Can
you add the results of that experiment as the 'case 3' please? Any
ideas why the linear case wins over the no-affinity?

Thanks,
Yury

> Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> Cc: stable@vger.kernel.org
> Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changes in v3
>  * Optimize the comments in mana_gd_setup_dyn_irqs()
>  * add more details in the dev_dbg for extra IRQs 
> ---
> Changes in v2
>  * Removed the unused skip_first_cpu variable
>  * fixed exit condition in irq_setup_linear() with len == 0
>  * changed return type of irq_setup_linear() as it will always be 0
>  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
>  * added appropriate comments to indicate expected behaviour when
>    IRQs are more than or equal to num_online_cpus()
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 60 ++++++++++++++++---
>  1 file changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 712a0881d720..00a28b3ca0a6 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -197,6 +197,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
>  	} else {
>  		/* If dynamic allocation is enabled we have already allocated
>  		 * hwc msi
> +		 * Also, we make sure in this case the following is always true
> +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
>  		 */
>  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
>  	}
> @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
>  	return 0;
>  }
>  
> +/* should be called with cpus_read_lock() held */
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
> +}
> +
>  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  {
>  	struct gdma_context *gc = pci_get_drvdata(pdev);
>  	struct gdma_irq_context *gic;
> -	bool skip_first_cpu = false;
>  	int *irqs, irq, err, i;
>  
>  	irqs = kmalloc_objs(int, nvec);
> @@ -1729,6 +1744,8 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
>  		return -ENOMEM;
>  
>  	/*
> +	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
> +	 * nvec is only Queue IRQ (HWC already setup).
>  	 * While processing the next pci irq vector, we start with index 1,
>  	 * as IRQ vector at index 0 is already processed for HWC.
>  	 * However, the population of irqs array starts with index 0, to be
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
> +			char buf[32];
> +
> +			if (first_unassigned == nvec - 1)
> +				snprintf(buf, sizeof(buf), "%d",
> +					 first_unassigned);
> +			else
> +				snprintf(buf, sizeof(buf), "%d-%d",
> +					 first_unassigned, nvec - 1);
> +
> +			dev_dbg(&pdev->dev,
> +				"MANA IRQ indices #%s will retain the default CPU affinity\n", buf);
> +		}
>  
> -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> -	if (err) {
> -		cpus_read_unlock();
> -		goto free_irq;
> +		irq_setup_linear(irqs, nvec);
>  	}
>  
>  	cpus_read_unlock();
> 
> base-commit: 8415598365503ced2e3d019491b0a2756c85c494
> -- 
> 2.34.1

