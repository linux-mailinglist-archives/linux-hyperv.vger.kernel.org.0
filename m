Return-Path: <linux-hyperv+bounces-2634-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902F4940DC0
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jul 2024 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515DF283109
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Jul 2024 09:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2180A196DA1;
	Tue, 30 Jul 2024 09:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="nt6yqnGq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E471194C74;
	Tue, 30 Jul 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331874; cv=none; b=aTa180aaWeaGWPR84Tvb68DE7f7EDchHUw1uYQLPeZxFrRocwu4vu9wxnvVk0zpLhzBsVQ0PgmeNhh8ULpSGw0eHv1UcTXaSWyi8I3MllQjCTzCFpnOTEovIBA9cgxrUCyoAQdBYEBGYdf+3n/KRQEKwx5rbpcjb/B4U0KccrAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331874; c=relaxed/simple;
	bh=FI9fwSCGcX+EKhM3a6roYO2SraOUdV1Vik/+z9uWPbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cpv70io5t1kjFPC967zyf77RaAFl4OuLz7BICjRj1iB7+TW1E2L950pF8BQKV9hsSSGXDQ3JbgKh0p+hDOILnyzLO+D9+qelcY8i2KbLXxicPXEw/zcQkRYePJ0dc/n/CKNHB7t5u5CjPTauBgxpjDb/J6rzvj+KQqstqJauEnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=nt6yqnGq; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vIsP67wcAGqmw3YkuPGmIdTV5Er81csfAnp1h6UEIIA=; t=1722331872; x=1723195872; 
	b=nt6yqnGqxoGtXgdS/jv2I9iotHQdByqNAigERuEbJ77bSg1RBDO7VKzrbKQABqhqO2vOxHky8BB
	sd5CH4p3zD1bobe9rlGN0FoPMFCEoAJrTubRUkc00eSPhfGI4sxnQ24DOEobzrDfO5QRfR2y1fUmA
	RR8/v3Orlc4jVY51BmkN0TWTYEtJ1+iD9cXrw9EvFlBV5TBXBTWqOSnjEP+JSXtusiaZCSIHP8OxR
	siy6KRHO34nnEod+RYcUjGCY0X0UvvdEEdfHhgLcxf6TZsP2Mgpg0j1qvDMv0t909XYil8CQR0wGC
	hpeHLWZSpaVprOGLYiyCQy+T79ukXbzGU1XQ==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sYjC1-0006Mb-Vu;
	Tue, 30 Jul 2024 05:30:54 -0400
Date: Tue, 30 Jul 2024 09:30:48 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Optimize boot time by concurrent
 execution of hv_synic_init()
Message-ID: <ZqiyyDEHLgvjxfRH@csail.mit.edu>
References: <1722239838-10957-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722239838-10957-1-git-send-email-ssengar@linux.microsoft.com>

On Mon, Jul 29, 2024 at 12:57:18AM -0700, Saurabh Sengar wrote:
> Currently on a very large system with 1780 CPUs, hv_acpi_init() takes
> around 3 seconds to complete. This is because of sequential synic
> initialization for each CPU performed by hv_synic_init().
> 
> Schedule these tasks parallelly so that each CPU executes hv_synic_init()
> in parallel to take full advantage of multiple CPUs.
> 
> This solution saves around 2 seconds of boot time on a 1780 CPU system,
> which is around 66% improvement in the existing logic.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---


Reviewed-by: Srivatsa S. Bhat (Microsoft) <srivatsa@csail.mit.edu>

Regards,
Srivatsa
Microsoft Linux Systems Group

> [V2]
>  - used cpuhp_setup_state_nocalls_cpuslocked instead of internal function
>  - improve commit message and subject
>  - Added a comment for cpu hotplug callback
> 
> 
>  drivers/hv/vmbus_drv.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index c857dc3975be..f769b34445b8 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1306,6 +1306,13 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> +static void vmbus_percpu_work(struct work_struct *work)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	hv_synic_init(cpu);
> +}
> +
>  /*
>   * vmbus_bus_init -Main vmbus driver initialization routine.
>   *
> @@ -1316,7 +1323,8 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
>   */
>  static int vmbus_bus_init(void)
>  {
> -	int ret;
> +	int ret, cpu;
> +	struct work_struct __percpu *works;
>  
>  	ret = hv_init();
>  	if (ret != 0) {
> @@ -1355,12 +1363,32 @@ static int vmbus_bus_init(void)
>  	if (ret)
>  		goto err_alloc;
>  
> +	works = alloc_percpu(struct work_struct);
> +	if (!works) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
>  	/*
>  	 * Initialize the per-cpu interrupt state and stimer state.
>  	 * Then connect to the host.
>  	 */
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> -				hv_synic_init, hv_synic_cleanup);
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		struct work_struct *work = per_cpu_ptr(works, cpu);
> +
> +		INIT_WORK(work, vmbus_percpu_work);
> +		schedule_work_on(cpu, work);
> +	}
> +
> +	for_each_online_cpu(cpu)
> +		flush_work(per_cpu_ptr(works, cpu));
> +
> +	/* register the callback for hotplug CPUs */
> +	ret = cpuhp_setup_state_nocalls_cpuslocked(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
> +						   hv_synic_init, hv_synic_cleanup);
> +	cpus_read_unlock();
> +	free_percpu(works);
>  	if (ret < 0)
>  		goto err_alloc;
>  	hyperv_cpuhp_online = ret;
> -- 
> 2.43.0
> 

