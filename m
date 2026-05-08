Return-Path: <linux-hyperv+bounces-10710-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEr7B519/WnnegAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10710-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 08:07:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E614F23C0
	for <lists+linux-hyperv@lfdr.de>; Fri, 08 May 2026 08:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE33E30B5D78
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 May 2026 05:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB7736DA14;
	Fri,  8 May 2026 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b/KDVKYL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C53603FB;
	Fri,  8 May 2026 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778219484; cv=none; b=ne8bMc0RYbg7NamTJh7H0fxc13UG3xrGEL0DK0znxgs0DbX7LmDHu3Zu1m8UDIS+K4Eaa+ZRkPc+vjyOgSbplxMfVPghSCfvG8F/uGbPgDf2Qbs1Vzu4MkAysgGZVEXbVIqWx8WWhK1HWmTtelAidrkybDwiSWbdZHu7OiVREqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778219484; c=relaxed/simple;
	bh=OSfhS7yO8Zldas5SJPlYONssSQTiPu2F+pc8GqQfRB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f/A8tRLimcndstm4H5RYfKiHDbZIpaWlUsdQhZ2a0ddo71J9lkNzOv6NfVKfA2AUgk7IewgKAgUw6l220nbf0NU2b/LRdMT7EETtRy9nPrmhiHH6AASy/uY5bRpd46W+4EEPBY6J72k1S9y3urNcMbNIrFRdy76cWp4hR6EjCC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b/KDVKYL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 8001C20B7165; Thu,  7 May 2026 22:51:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8001C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778219465;
	bh=piwiPJVpBvVe/mx2ii5SPKDIEERBdTB7oUyH6FpJbqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/KDVKYLLF5dexw2p5TUqlZrwIzdqIrvqa4HllCfwe23l3yEWr7vewTNIb/Ch0ITN
	 Ci2b+zg/sB++4tCFO0ipiwZ9J4lO+BumYBu/XyW2mThq91AGZj9ePycgi7VsWVLDxQ
	 GMQ42IVq6xy/ImoO7vUO+2TgnYgnAJGfMYWOgKvE=
Date: Thu, 7 May 2026 22:51:05 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Yury Norov <ynorov@nvidia.com>
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
Subject: Re: [PATCH net v2] net: mana: Optimize irq affinity for low vcpu
 configs
Message-ID: <af15yfdotzVbK8Kb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260429090640.1790104-1-shradhagupta@linux.microsoft.com>
 <afTTPLClWwIMWTOh@yury>
 <afYMN6vbiX7Rzss+@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afYxOPL4DNjXM7tL@yury>
 <afmK531eRcPCecKm@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <afoQHm28qj8JnKww@yury>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afoQHm28qj8JnKww@yury>
X-Rspamd-Queue-Id: A3E614F23C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10710-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,outlook.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shradhagupta@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 11:43:26AM -0400, Yury Norov wrote:
> On Mon, May 04, 2026 at 11:15:03PM -0700, Shradha Gupta wrote:
> > On Sat, May 02, 2026 at 01:15:36PM -0400, Yury Norov wrote:
> > > On Sat, May 02, 2026 at 07:37:43AM -0700, Shradha Gupta wrote:
> > > > On Fri, May 01, 2026 at 12:22:20PM -0400, Yury Norov wrote:
> > > > > On Wed, Apr 29, 2026 at 02:06:37AM -0700, Shradha Gupta wrote:
> > > > > > In mana driver, the number of IRQs allocated is capped by the
> > > > > > min(num_cpu + 1, queue count). In cases, where the IRQ count is greater
> > > > > > than the vcpu count, we want to utilize all the vCPUs, irrespective of
> > > > > > their NUMA/core bindings.
> > > > > > 
> > > > > > This is important, especially in the envs where number of vCPUs are so
> > > > > > few that the softIRQ handling overhead on two IRQs on the same vCPU is
> > > > > > much more than their overheads if they were spread across sibling vCPUs.
> > > > > > 
> > > > > > This behaviour is more evident with dynamic IRQ allocation. Since MANA
> > > > > > IRQs are assigned at a later stage compared to static allocation, other
> > > > > > device IRQs may already be affinitized to the vCPUs. As a result, IRQ
> > > > > > weights become imbalanced, causing multiple MANA IRQs to land on the
> > > > > > same vCPU, while some vCPUs have none.
> > > > > > 
> > > > > > In such cases when many parallel TCP connections are tested, the
> > > > > > throughput drops significantly.
> > > > > > 
> > > > > > Test envs:
> > > > > > =======================================================
> > > > > > Case 1: without this patch
> > > > > > =======================================================
> > > > > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > > > > 
> > > > > > 	TYPE		effective vCPU aff
> > > > > > =======================================================
> > > > > > IRQ0:	HWC		0
> > > > > > IRQ1:	mana_q1		0
> > > > > > IRQ2:	mana_q2		2
> > > > > > IRQ3:	mana_q3		0
> > > > > > IRQ4:	mana_q4		3
> > > > > > 
> > > > > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > > > > vCPU		0	1	2	3
> > > > > > =======================================================
> > > > > > pass 1:		38.85	0.03	24.89	24.65
> > > > > > pass 2:		39.15	0.03	24.57	25.28
> > > > > > pass 3:		40.36	0.03	23.20	23.17
> > > > > > 
> > > > > > =======================================================
> > > > > > Case 2: with this patch
> > > > > > =======================================================
> > > > > > 4 vcpu(2 cores), 5 MANA IRQs (1 HWC + 4 Queue)
> > > > > > 
> > > > > >         TYPE            effective vCPU aff
> > > > > > =======================================================
> > > > > > IRQ0:   HWC             0
> > > > > > IRQ1:   mana_q1         0
> > > > > > IRQ2:   mana_q2         1
> > > > > > IRQ3:   mana_q3         2
> > > > > > IRQ4:   mana_q4         3
> > > > > > 
> > > > > > %soft on each vCPU(mpstat -P ALL 1) on receiver
> > > > > > vCPU            0       1       2       3
> > > > > > =======================================================
> > > > > > pass 1:         15.42	15.85	14.99	14.51
> > > > > > pass 2:         15.53	15.94	15.81	15.93
> > > > > > pass 3:         16.41	16.35	16.40	16.36
> > > > > > 
> > > > > > =======================================================
> > > > > > Throughput Impact(in Gbps, same env)
> > > > > > =======================================================
> > > > > > TCP conn	with patch	w/o patch
> > > > > > 20480		15.65		7.73
> > > > > > 10240		15.63		8.93
> > > > > > 8192		15.64		9.69
> > > > > > 6144		15.64		13.16
> > > > > > 4096		15.69		15.75
> > > > > > 2048		15.69		15.83
> > > > > > 1024		15.71		15.28
> > > > > > 
> > > > > > Fixes: 755391121038 ("net: mana: Allocate MSI-X vectors dynamically")
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Co-developed-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > > > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> > > > > > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > > > > > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> > > > > > ---
> > > > > > Changes in v2
> > > > > >  * Removed the unused skip_first_cpu variable
> > > > > >  * fixed exit condition in irq_setup_linear() with len == 0
> > > > > >  * changed return type of irq_setup_linear() as it will always be 0
> > > > > >  * removed the unnecessary rcu_read_lock() in irq_setup_linear()
> > > > > >  * added appropriate comments to indicate expected behaviour when
> > > > > >    IRQs are more than or equal to num_online_cpus()
> > > > > > ---
> > > > > >  .../net/ethernet/microsoft/mana/gdma_main.c   | 47 ++++++++++++++++---
> > > > > >  1 file changed, 40 insertions(+), 7 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > > index 098fbda0d128..d740d1dc43da 100644
> > > > > > --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > > +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> > > > > > @@ -167,6 +167,8 @@ static int mana_gd_query_max_resources(struct pci_dev *pdev)
> > > > > >  	} else {
> > > > > >  		/* If dynamic allocation is enabled we have already allocated
> > > > > >  		 * hwc msi
> > > > > > +		 * Also, we make sure in this case the following is always true
> > > > > > +		 * (num_msix_usable - 1 HWC) <= num_online_cpus()
> > > > > >  		 */
> > > > > >  		gc->num_msix_usable = min(resp.max_msix, num_online_cpus() + 1);
> > > > > >  	}
> > > > > > @@ -1672,11 +1674,24 @@ static int irq_setup(unsigned int *irqs, unsigned int len, int node,
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  
> > > > > > +/* should be called with cpus_read_lock() held */
> > > > > > +static void irq_setup_linear(unsigned int *irqs, unsigned int len)
> > > > > > +{
> > > > > > +	int cpu;
> > > > > > +
> > > > > > +	for_each_online_cpu(cpu) {
> > > > > > +		if (len == 0)
> > > > > > +			break;
> > > > > > +
> > > > > > +		irq_set_affinity_and_hint(*irqs++, cpumask_of(cpu));
> > > > > > +		len--;
> > > > > > +	}
> > > > > > +}
> > > > > > +
> > > > > >  static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > > > > >  {
> > > > > >  	struct gdma_context *gc = pci_get_drvdata(pdev);
> > > > > >  	struct gdma_irq_context *gic;
> > > > > > -	bool skip_first_cpu = false;
> > > > > >  	int *irqs, irq, err, i;
> > > > > >  
> > > > > >  	irqs = kmalloc_objs(int, nvec);
> > > > > 
> > > > > So what about WARN_ON() and nvec adjustment before kmalloc?
> > > > Hey Yury,
> > > > 
> > > > I am still a bit unsure about the WARN_ON() before kmalloc, as after
> > > > that also, in the same function till we take the cpus_read_lock() the
> > > > num_online_cpus() can change(or reduce). That's why I introduced the
> > > > dev_dbg() to capture hot-remove edge case.
> > > 
> > > OK.
> > >  
> > > > Do you still think it adds more value?
> > > 
> > > It's your driver, so you know better. I just wonder because you said
> > > it's good to add WARN_ON(), and then didn't do that.
> > > 
> > > > > 
> > > > > > @@ -1722,13 +1737,31 @@ static int mana_gd_setup_dyn_irqs(struct pci_dev *pdev, int nvec)
> > > > > >  	 * first CPU sibling group since they are already affinitized to HWC IRQ
> > > > > >  	 */
> > > > > >  	cpus_read_lock();
> > > > > > -	if (gc->num_msix_usable <= num_online_cpus())
> > > > > > -		skip_first_cpu = true;
> > > > > > +	if (gc->num_msix_usable <= num_online_cpus()) {
> > > > > > +		err = irq_setup(irqs, nvec, gc->numa_node, true);
> > > > > > +		if (err) {
> > > > > > +			cpus_read_unlock();
> > > > > > +			goto free_irq;
> > > > > 
> > > > > One thing puzzles me: if you skip first CPU with this 'true', and the
> > > > > gc->num_msix_usable == num_online_cpus(), it's one more than you can
> > > > > distribute. What do I miss?
> > > > > 
> > > > 
> > > > Let me explain this case a bit better then,
> > > > 
> > > > - num_msix_usable = HWC IRQ + Queue IRQ
> > > > - nvec in this functions is only Queue IRQ (HWC already setup)
> > > > 
> > > > When num_online_cpus == num_msix_usable:
> > > > - nvec = num_online_cpus - 1
> > > > - first CPU is already assigned to HWC IRQ, so skip it
> > > > - Queue IRQs fit in the remaining CPUs
> > > > 
> > > > please let me know if I did not get your question right
> > > 
> > > Can you put that in a comment?
> > 
> > Sure I will. thanks
> > 
> > > 
> > > > > > +		}
> > > > > > +	} else {
> > > > > > +		/*
> > > > > > +		 * When num_msix_usable are more than num_online_cpus, we try to
> > > > > > +		 * make sure we are using all vcpus. In such a case NUMA or
> > > > > > +		 * CPU core affinity does not matter.
> > > > > 
> > > > > If it doesn't matter, why don't you assign each IRQ to all CPUs then?
> > > > > In theory, the system would have most of flexibility to balance them.
> > > > > 
> > > > 
> > > > Okay, let me fix the comment and elaborate on this. It doesn't matter
> > > > because in such a case we want to anyway exhaust and distribute the
> > > > Queue IRQs to all vCPUs.
> > > > We don't want to rely on the system's balancer in this case as it could
> > > > be skewed by other devices' IRQ weights
> > > 
> > > I don't understand this. If I want to reserve some CPUs to solely
> > > handle IRQs from my high-priority hardware, then I configure my system
> > > accordingly. For example, assign all non-networking IRQs on CPU0, and
> > > all networking IRQs to all CPUs.
> > > 
> > > In your case, you distribute IRQs evenly, which means you've no
> > > preferred CPUs. So, assuming the system is only running your IRQ
> > > driver, it's at max is as good as all-CPU distribution. In case of
> > > heavy loading some particular CPU, your scheme could cause
> > > corresponding IRQs to starve.
> > > 
> > > I recall, when we was working on irq_setup(), the original idea was to
> > > distribute IRQs one-to-one, but than I suggested the 
> > > 
> > >         irq_set_affinity_and_hint(*irqs++, topology_sibling_cpumask(cpu));
> > > 
> > > and after experiments, you agreed on that.
> > > 
> > > Can you please run your throughput test for my suggested distribution
> > > too? Would be also nice to see how each distribution works when some
> > > CPUs are under stress.
> > > 
> > > Thanks,
> > > Yury
> > 
> > The design of irq_setup() works exactly how we want it for our IRQs for
> > almost all of our usecases, so we want to keep that as is. The only
> > scenarios where this is an issue in terms of significant throughput drop
> > is when we are working with low vCPU VMs (vCPU <= 4 with high TCP
> > connection counts) and where there are additional NVMe devices attached
> > to the VM.
> > 
> > The current patch about utilizing all the vCPUs helps in that case and
> > doesn't cause any regression for other cases.
> > 
> > This linear path is only taken when num_msix_usable > num_online_cpus(),
> > which is limited to low-vCPU VMs. Larger VMs continue using irq_setup()
> > as before.
> > 
> > We can definately get our throughput run results on other suggestions
> > you have. And about that, I just needed a bit more clarity on what to
> > test against. Are you suggesting, with irq_setup() intact and in use, we
> > configure the non-mana IRQs to say CPU0 and capture the numbers?
> 
> Can you try this:
> 
>        while(len--)
>                // Or cpu_online_mask or cpu_all_mask?
>                irq_set_affinity_and_hint(*irqs++, NULL);
> 
> And compare it to the linear version under your vCPU scenario?
> 
> Can you run your throughput test alone and on parallel with some
> IRQ torture test?
> 
>         stress-ng --timer 4 --timeout 60s
> 
> And maybe pin the stress test to the default CPU. Assuming it's 0:
> 
>         taskset -c 0 stress-ng --timer 4 --timeout 60s
> 
> Unless the 'linear' version is significantly faster, I'd stick to the
> above.
> 
> Thanks,
> Yury

Hey Yury,

We tried a few tests with your suggestion, and throughput seems to be
the same compared to the linear distribution approach. We stressed out
CPU0 in both the cases and the results were similar. No IRQ migration
was observed in either case and no throughput drop.
 
But one observation I had was that " irq_set_affinity_and_hint(*irqs++,
NULL);" is essentially a no-op and we end up relying on the initial
placement from pci_alloc_irq_vectors(). Even though in these tests we
were not able to reproduce it, but with this distribution there is a
chance we end up clustering the mana queue IRQs, while other vCPUs are
not running any network load. It's because the placement depends on
system-wide IRQ state at allocation time.
 
The linear approach however gaurantees each queue IRQ lands on a
distinct vCPU regardless of system state. Even after stressing the cpus
using stress-ng, we did not observe any significant throughput drop.


regards,
Shradha.

