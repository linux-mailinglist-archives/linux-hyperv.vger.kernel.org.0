Return-Path: <linux-hyperv+bounces-11558-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N/JKItk4KGqnAQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-11558-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 18:01:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B47662162
	for <lists+linux-hyperv@lfdr.de>; Tue, 09 Jun 2026 18:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=DoSwg+Hw;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11558-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11558-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED0433063882
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Jun 2026 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2F648A2A0;
	Tue,  9 Jun 2026 15:50:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D42481248;
	Tue,  9 Jun 2026 15:50:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020202; cv=none; b=rP0xzitycAqtmwLNono7JnX+CzVy3TbYyIrLe6ixupJsrF0TXwCRIXsAvdHycVJYBNo8QO3EpxljRizaMPTHcQrw+PlmsWtyo3/SY6zgVOu6FiUmejiP0YfDD//5Gb8N0ZlIB0sugdZUm08vk9kEi01eolpGL/KC52RA0EmtS9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020202; c=relaxed/simple;
	bh=tk+Sg+3+Z7XOnW5K5ZB4le8+cltted13Anf0uWNiWBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkOC+K97VrwnggniNv6exKNy+LTxD+CIjEf580Lce/SMf5epduBedSutrrgG7S4BFC8C6Defj5l9D5xLvwrnV5qXFdQjS1baC7oY2DQKeVRrNDgEGnKH89eiiXDERadIlfXu7W0/jlJ+TEzxZx8Gn+TQg3SnzBnQdCOjN6NdKx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DoSwg+Hw; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 961EB20B7167; Tue,  9 Jun 2026 08:49:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 961EB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781020183;
	bh=GN0iZVrK+bQfVKdC+51jAwpEepgS0E5JsLN1UgjLM2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoSwg+HwaC4TQsN0G0ZHKZKbdgnMuSX+/V8+q/8cx93aGkA+KGVfkP96dWUD37Ie2
	 l+VAw54ohJyywiAjfgnmlESc7oOWfCkynShPjKA7+RQo+Y0yFC1/VJ1w/l7CamkjKI
	 +ouMOPfp22gvwQJ6tGpVXNAIriFUfnV+03Y4Y7/k=
Date: Tue, 9 Jun 2026 08:49:43 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <yury.norov@gmail.com>
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
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Paul Rosswurm <paulros@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <aig2F0cgxPcQqYbX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
 <aidDwAQqnQRCNQP1@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aidDwAQqnQRCNQP1@yury>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yury.norov@gmail.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:yurynorov@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11558-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.microsoft.com:dkim,linux.microsoft.com:from_mime,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45B47662162

On Mon, Jun 08, 2026 at 06:35:44PM -0400, Yury Norov wrote:
> On Mon, Jun 01, 2026 at 03:27:46AM -0700, Shradha Gupta wrote:
> > In mana driver, the number of IRQs allocated is capped by the
> > min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> > than the vcpu count, we want to utilize all the vCPUs, irrespective of
> > their NUMA/core bindings.
> > 
> > This is important, especially in the envs where number of vCPUs are so
> > few that the softIRQ handling overhead on two IRQs on the same vCPU is
> > much more than their overheads if they were spread across sibling vCPUs.
> > 
> > This behaviour is more evident with dynamic IRQ allocation. Since MANA
> > IRQs are assigned at a later stage compared to static allocation, other
> > device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> > weights become imbalanced, causing multiple MANA IRQs to land on the
> > same vCPU, while some vCPUs have none.
> > 
> > In such cases when many parallel TCP connections are tested, the
> > throughput drops significantly.
> > 
> > Test envs:
> > =======================================================
> > Case 1: without this patch
> > =======================================================
> > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > 
> > 	TYPE		effective vCPU aff
> > =======================================================
> > IRQ0:	HWC		0
> > IRQ1:	mana_q1		0
> > IRQ2:	mana_q2		2
> > IRQ3:	mana_q3		0
> > IRQ4:	mana_q4		3
> > 
> > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > vCPU		0	1	2	3
> > =======================================================
> > pass 1:		38.85	0.03	24.89	24.65
> > pass 2:		39.15	0.03	24.57	25.28
> > pass 3:		40.36	0.03	23.20	23.17
> > 
> > =======================================================
> > Case 2: with this patch
> > =======================================================
> > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > 
> >         TYPE            effective vCPU aff
> > =======================================================
> > IRQ0:   HWC             0
> > IRQ1:   mana_q1         0
> > IRQ2:   mana_q2         1
> > IRQ3:   mana_q3         2
> > IRQ4:   mana_q4         3
> > 
> > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > vCPU            0       1       2       3
> > =======================================================
> > pass 1:         15.42	15.85	14.99	14.51
> > pass 2:         15.53	15.94	15.81	15.93
> > pass 3:         16.41	16.35	16.40	16.36
> > 
> > =======================================================
> > Throughput Impact(in Gbps, same env)
> > =======================================================
> > TCP conn	with patch	w/o patch
> > 20480		15.65		7.73
> > 10240		15.63		8.93
> > 8192		15.64		9.69
> > 6144		15.64		13.16
> > 4096		15.69		15.75
> > 2048		15.69		15.83
> > 1024		15.71		15.28
>  
> So, case 1 is irq_setup(), and case 2 is irq_setup_linear(). Is that
> correct?

That is correct.

> 
> On the previous round we've discussed a no-affinity case:
> 
>         irq_set_affinity_and_hint(irq, NULL);
> 
> My naive view is that the more freedom you give to the scheduler in
> balancing the IRQ handling load, the better results you've got. But
> your numbers show that the 'linear' distribution is still better. Can
> you add the results of that experiment as the 'case 3' please? Any
> ideas why the linear case wins over the no-affinity?

Sure, I will include them in the commit message for the next version.
The reason is that in some cases(reproducible testcases in Azure
environments), there are  existing non-MANA IRQs that are skewing
the IRQ weights on individual vCPUS. And that is causing MANA queue
IRQ clustering again.

I had mentioned a possibility of this in the last thread, and we were
able to reproduce it through some more testcases.

> 
> Thanks,
> Yury
> 
> > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > ---
> > Changes in v3
> >  * Optimize the comments in mana_gd_setup_dyn_irqs()
> >  * add more details in the dev_dbg for extra IRQs 
> > ---
> > Changes in v2
> >  * Removed the unused skip_first_cpu variable
> >  * fixed exit condition in irq_setup_linear() with len == 0
> >  * changed return type of irq_setup_linear() as it will always be 0
> >  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
> >  * added appropriate comments to indicate expected behaviour when
> >    IRQs are more than or equal to num_online_cpus()
> > ---
> >  .../net/ethernet/microsoft/mana/gdma_main.c   | 60 ++++++++++++++++---
> >  1 file changed, 53 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > index 712a0881d720..00a28b3ca0a6 100644
> > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > @@ -197,6 +197,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> >  	} else {
> >  		/* If dynamic allocation is enabled we have already allocated
> >  		 * hwc msi
> > +		 * Also, we make sure in this case the following is always true
> > +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
> >  		 */
> >  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> >  	}
> > @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> >  	return 0;
> >  }
> >  
> > +/* should be called with cpus_read_lock() held */
> > +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> > +{
> > +	int cpu;
> > +
> > +	for_each_online_cpu(cpu) {
> > +		if (len == 0)
> > +			break;
> > +
> > +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> > +		len--;
> > +	}
> > +}
> > +
> >  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  {
> >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> >  	struct gdma_irq_context *gic;
> > -	bool skip_first_cpu = false;
> >  	int *irqs, irq, err, i;
> >  
> >  	irqs = kmalloc_objs(int, nvec);
> > @@ -1729,6 +1744,8 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  		return -ENOMEM;
> >  
> >  	/*
> > +	 * In this function, num_msix_usable = HWC IRQ + Queue IRQ.
> > +	 * nvec is only Queue IRQ (HWC already setup).
> >  	 * While processing the next pci irq vector, we start with index 1,
> >  	 * as IRQ vector at index 0 is already processed for HWC.
> >  	 * However, the population of irqs array starts with index 0, to be
> > @@ -1767,13 +1784,42 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> >  	 * first CPU sibling group since they are already affinitized to HWC IRQ
> >  	 */
> >  	cpus_read_lock();
> > -	if (gc->num_msix_usable <= num_online_cpus())
> > -		skip_first_cpu = true;
> > +	if (gc->num_msix_usable <= num_online_cpus()) {
> > +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> > +		if (err) {
> > +			cpus_read_unlock();
> > +			goto free_irq;
> > +		}
> > +	} else {
> > +		/*
> > +		 * When num_msix_usable are more than num_online_cpus, our
> > +		 * queue IRQs should be equal to num of online vCPUs.
> > +		 * We try to make sure queue IRQs spread across all vCPUs.
> > +		 * In such a case NUMA or CPU core affinity does not matter.
> > +		 * Note: in this case the total mana IRQ should always be
> > +		 * num_online_cpus + 1. The first HWC IRQ is already handled
> > +		 * in HWC setup calls
> > +		 * However, if CPUs went offline since num_msix_usable was
> > +		 * computed, queue IRQs will be more than num_online_cpus().
> > +		 * In such cases remaining extra IRQs will retain their default
> > +		 * affinity.
> > +		 */
> > +		int first_unassigned = num_online_cpus();
> > +		if (nvec > first_unassigned) {
> > +			char buf[32];
> > +
> > +			if (first_unassigned == nvec - 1)
> > +				snprintf(buf, sizeof(buf), "%d",
> > +					 first_unassigned);
> > +			else
> > +				snprintf(buf, sizeof(buf), "%d-%d",
> > +					 first_unassigned, nvec - 1);
> > +
> > +			dev_dbg(&pdev->dev,
> > +				"MANA IRQ indices #%s will retain the default CPU affinity\n", buf);
> > +		}
> >  
> > -	err = irq_setup(irqs, nvec, gc->numa_node, skip_first_cpu);
> > -	if (err) {
> > -		cpus_read_unlock();
> > -		goto free_irq;
> > +		irq_setup_linear(irqs, nvec);
> >  	}
> >  
> >  	cpus_read_unlock();
> > 
> > base-commit: 8415598365503ced2e3d019491b0a2756c85c494
> > -- 
> > 2.34.1

