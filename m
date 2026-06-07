Return-Path: <linux-hyperv+bounces-11523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ntZpB0xhJWrDHgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11523-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 07 Jun 2026 14:17:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBED65083F
	for <lists+linux-hyperv@lfdr.de>; Sun, 07 Jun 2026 14:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=ADiQgj8l;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11523-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11523-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1932D300CE6E
	for <lists+linux-hyperv@lfdr.de>; Sun,  7 Jun 2026 12:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A432D45B;
	Sun,  7 Jun 2026 12:17:13 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1521127707;
	Sun,  7 Jun 2026 12:17:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780834633; cv=none; b=RKUW2NkRuC3icxkdR5dIcTWx4ia9iFaAkkNgbT6MxeDv91zURbQUu1ENPu+ayqxBwk+Cbropl3BG0PB41lZiF169VlQq2eVLuejPl+KuK71cDLnHbjEr9QMWryZ0BAuoobYTnppg2WRUFuySW0yTD5Fz0WCBdQHYmk9trYzhlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780834633; c=relaxed/simple;
	bh=mvLtTX8/EucSCIeMPmLFnD5GVMbsitcuA3sBEdD0JaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWW0zGlp6s/UDvQNOfjhlKbHNB3mJ/1cFB1CYiI3HxOjeLWdnMYcYuq5Os04pYbTqS5Y2aJmr9PAUgK3f/gQWs8hIKUfwAfOSFBKjcPB3jCq5gSgWOjQreoGYcXfNeRLnr9cNtZb5cDVdv/3s7UfPGL/zhXjjyJ7CLUBS7yKEN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ADiQgj8l; arc=none smtp.client-ip=13.77.154.182
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id C161C20B7166; Sun,  7 Jun 2026 05:16:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C161C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780834608;
	bh=S/5jo6STaNb3nrPIKmjZsWOhrpeWoK1FRXFB6g0K7m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ADiQgj8lXeA6cO8ILOeE6yvyZrEjMUtsZBPYsK9mw5z8aSZlPUJK4tsQH4sOqGV0b
	 /I/Zcls1/TsS558o1+WSx6mGaHxaPcmJpGPElB9X85MzX2HN7pskDwjhZ1KdgZ5Qy4
	 7iD3mH6W5aI3lKcgF4DDDpj2NodPP5stJRJ+nQ2s=
Date: Sun, 7 Jun 2026 05:16:48 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <aiVhMNm0ILpJW583@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260601102749.1768304-1-shradhagupta@linux.microsoft.com>
 <6d1fa9d9-73c2-48b5-95a1-51710d81b3ed@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d1fa9d9-73c2-48b5-95a1-51710d81b3ed@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:decui@microsoft.com,m:wei.liu@kernel.org,m:haiyangz@microsoft.com,m:kys@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:kotaranov@microsoft.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:shirazsaleem@microsoft.com,m:mhklinux@outlook.com,m:longli@microsoft.com,m:yury.norov@gmail.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:paulros@microsoft.com,m:shradhagupta@microsoft.com,m:ssengar@microsoft.com,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:yurynorov@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11523-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4EBED65083F

On Thu, Jun 04, 2026 at 12:45:03PM +0200, Paolo Abeni wrote:
> On 6/1/26 12:27 PM, Shradha Gupta wrote:
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
> > 
> > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > Cc: stable@vger.kernel.org
> > Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Why do you consider this patch a fix? To me is a configuration
> improvement and should land on net-next.

Hi Paolo,

This is a fix for commit 755391121038 ("net: mana: Allocate MSI-X
vectors dynamically"). Before that commit, IRQs were statically
allocated and clustering of MANA IRQs happened less often on low vCPU
configs. With dynamic allocation, MANA IRQs are assigned at a later
stage when other device IRQs have already occupied vCPUs. The NUMA-aware
affinity logic in that commit increased the probability of IRQ
clustering, causing a 2x throughput regression (15.65 vs 7.73 Gbps) on
low vCPU Azure SKUs at high connection counts.

> 
> > @@ -1717,11 +1719,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> >  	return 0;
> >  }
> >  
> > +/* should be called with cpus_read_lock() held */
> 
> Minor nit: s/should/must/ or just drop the comment, as
> `for_each_online_cpu()` usage implies that.
> 

Thanks, will change this in next version.

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
> 
> As this is another heuristic regarding irq spreading, why don't you
> implement that inside irq_setup()?
> 

irq_setup() already handles multiple cases - dynamic, static, and HWC
affinity logic with NUMA-aware sibling group spreading. Adding the
linear case there would make it more complex and harder to follow.
Keeping it as a separate function makes both, NUMA aware and linear
paths easier to understand and maintain.

Happy to reconsider if you feel strongly about it.

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
> 
> An empty line is needed between the variable declaration and the code.

noted, Thanks.

> 
> /P

