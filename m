Return-Path: <linux-hyperv+bounces-3572-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E734CA00CED
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 18:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD1A23A402A
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 17:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82781FBEA0;
	Fri,  3 Jan 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPZHQcSu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD231FAC53;
	Fri,  3 Jan 2025 17:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735925973; cv=none; b=N5rKiMNIyFZOLRq9w8Dq/6RRFhyxeiwNRM/hcZur7Csg+yHocv4Jiotc50UKnNtQEMVECp5QqAOACvAAgqlYZYPKgC5bIrmlgHtCJ6p0TgfvgihdLBWP4h1dQNQ1wNBihHOU6n77TQiCyY1hX5Qp8RD7oGohM2XnvMez26pFWtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735925973; c=relaxed/simple;
	bh=1wIXlOJ0PKHN5nwQGBTEiR9c24IV0eG7sZVh7WolJVk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fmyj9O4cYQezPgRqvvXZwEiPOFQuHL8XmmPNtYk+VVwlg6a9d/Q2tuVT0XnWYsuj5RJVlMIyj+9Q75VkkvKLiijGHPXn1MGgo1WZ22zzVijgsRrvFj6mqo2t6jcocDqPmHOEPxH+atxa3+9/mr6OjmXwjYB241t8EGRKDoqWQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPZHQcSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE1FC4CECE;
	Fri,  3 Jan 2025 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735925972;
	bh=1wIXlOJ0PKHN5nwQGBTEiR9c24IV0eG7sZVh7WolJVk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BPZHQcSuqbbqIrFTIHtpgna4b6QvnL4z/0HIBd8gv8ph5yszadSe/qj+ladr3VFNt
	 +RzGsJVqLfFNKC/ELtlYOlI8qNNTl5pc7jno9F67QXEo3jd8YAESptcsx+qrGQNjRd
	 sCrK2ZHAgXwzCB6C7R1ZM4XnPt0W82nZpG2X5E3i+FBChhK07J8+/vIyoQdBYlfMNm
	 5xdrsJqUTRq2VWs3MjjZ0eWLBJF7182AFCCV6RZHioNKUg6/kmS1Xz4ovHGjFFi6WM
	 +luqDU7/cilINIqmflBdqTukOj+NNIO2pBMdlD3sZcKGEBhxnH+x9P/lTeHzzT/3DP
	 hpdMB8ku98kkw==
Date: Fri, 3 Jan 2025 11:39:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matt Wu <wuqiang.matt@bytedance.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kurz <groug@kaod.org>, Peter Xu <peterx@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: Re: [PATCH 05/14] cpumask: deprecate cpumask_next_wrap()
Message-ID: <20250103173930.GA4181899@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-6-yury.norov@gmail.com>

On Sat, Dec 28, 2024 at 10:49:37AM -0800, Yury Norov wrote:
> The next patche aligns implementation of cpumask_next_wrap() with the
> generic version in find.h which changes function signature.

s/patche/patch/

I guess this is an indirect reference to find_next_bit_wrap()?  If so,
I think mentioning the function name would be more useful than
referring to "the generic version in find.h".

> To make the transition smooth, this patch deprecates current
> implementation by adding an _old suffix. The following patches switch
> current users to the new implementation one by one.
> 
> No functional changes were intended.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/s390/kernel/processor.c        | 2 +-
>  drivers/nvme/host/tcp.c             | 2 +-
>  drivers/pci/controller/pci-hyperv.c | 2 +-
>  drivers/scsi/lpfc/lpfc_init.c       | 2 +-
>  include/linux/cpumask.h             | 4 ++--
>  kernel/padata.c                     | 2 +-
>  lib/cpumask.c                       | 6 +++---
>  7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index 5ce9a795a0fe..42ca61909030 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -72,7 +72,7 @@ void notrace stop_machine_yield(const struct cpumask *cpumask)
>  	this_cpu = smp_processor_id();
>  	if (__this_cpu_inc_return(cpu_relax_retry) >= spin_retry) {
>  		__this_cpu_write(cpu_relax_retry, 0);
> -		cpu = cpumask_next_wrap(this_cpu, cpumask, this_cpu, false);
> +		cpu = cpumask_next_wrap_old(this_cpu, cpumask, this_cpu, false);
>  		if (cpu >= nr_cpu_ids)
>  			return;
>  		if (arch_vcpu_is_preempted(cpu))
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 28c76a3e1bd2..054904376c3c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1578,7 +1578,7 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>  	if (wq_unbound)
>  		queue->io_cpu = WORK_CPU_UNBOUND;
>  	else
> -		queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
> +		queue->io_cpu = cpumask_next_wrap_old(n - 1, cpu_online_mask, -1, false);
>  }
>  
>  static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index cdd5be16021d..86d1c2be8eb5 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1757,7 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
>  
>  	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
>  
> -	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask, nr_cpu_ids,
> +	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
>  				     false);
>  	cpu = cpu_next;
>  
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 7f57397d91a9..31622fb0614a 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -12876,7 +12876,7 @@ lpfc_irq_rebalance(struct lpfc_hba *phba, unsigned int cpu, bool offline)
>  
>  	if (offline) {
>  		/* Find next online CPU on original mask */
> -		cpu_next = cpumask_next_wrap(cpu, orig_mask, cpu, true);
> +		cpu_next = cpumask_next_wrap_old(cpu, orig_mask, cpu, true);
>  		cpu_select = lpfc_next_online_cpu(orig_mask, cpu_next);
>  
>  		/* Found a valid CPU */
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index 30042351f15f..b267a4f6a917 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -296,7 +296,7 @@ unsigned int cpumask_next_and(int n, const struct cpumask *src1p,
>  
>  #if NR_CPUS == 1
>  static __always_inline
> -unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
> +unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
>  {
>  	cpumask_check(start);
>  	if (n != -1)
> @@ -312,7 +312,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
>  	return cpumask_first(mask);
>  }
>  #else
> -unsigned int __pure cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap);
> +unsigned int __pure cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap);
>  #endif
>  
>  /**
> diff --git a/kernel/padata.c b/kernel/padata.c
> index d51bbc76b227..454ff2fca40b 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -274,7 +274,7 @@ static struct padata_priv *padata_find_next(struct parallel_data *pd,
>  	if (remove_object) {
>  		list_del_init(&padata->list);
>  		++pd->processed;
> -		pd->cpu = cpumask_next_wrap(cpu, pd->cpumask.pcpu, -1, false);
> +		pd->cpu = cpumask_next_wrap_old(cpu, pd->cpumask.pcpu, -1, false);
>  	}
>  
>  	spin_unlock(&reorder->lock);
> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index e77ee9d46f71..c9a9b451772a 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -8,7 +8,7 @@
>  #include <linux/numa.h>
>  
>  /**
> - * cpumask_next_wrap - helper to implement for_each_cpu_wrap
> + * cpumask_next_wrap_old - helper to implement for_each_cpu_wrap
>   * @n: the cpu prior to the place to search
>   * @mask: the cpumask pointer
>   * @start: the start point of the iteration
> @@ -19,7 +19,7 @@
>   * Note: the @wrap argument is required for the start condition when
>   * we cannot assume @start is set in @mask.
>   */
> -unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
> +unsigned int cpumask_next_wrap_old(int n, const struct cpumask *mask, int start, bool wrap)
>  {
>  	unsigned int next;
>  
> @@ -37,7 +37,7 @@ unsigned int cpumask_next_wrap(int n, const struct cpumask *mask, int start, boo
>  
>  	return next;
>  }
> -EXPORT_SYMBOL(cpumask_next_wrap);
> +EXPORT_SYMBOL(cpumask_next_wrap_old);
>  
>  /* These are not inline because of header tangles. */
>  #ifdef CONFIG_CPUMASK_OFFSTACK
> -- 
> 2.43.0
> 

