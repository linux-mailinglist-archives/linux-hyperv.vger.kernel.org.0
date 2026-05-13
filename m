Return-Path: <linux-hyperv+bounces-10841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCvNLlinBGogMQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10841-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:31:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CE1537168
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B47DB300DA47
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 16:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9D4963D8;
	Wed, 13 May 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg2dKFzv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAD4494A19;
	Wed, 13 May 2026 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689187; cv=none; b=lv6H2BZtgCEIgxlv1eQQ4JwtJSKOO9jtmVj6saHUtoLZ4lFY0mAkS6m/A+DWHvDYS2u7Xnqq+CfCO8Ad1i2qBXcpGGK3zP6rHTRZv+02DFTcHKdS1DS+/sUDougcbt9g6XvCuExp6YJWFUGYYkmn4qyTX7I1Y8BpQXxJyhKuHyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689187; c=relaxed/simple;
	bh=nf/EGUFlU1Lh8RetUOEO9Cf1rjcOBc9mFE8STXI1blM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G74Qq0TlRAuLC6+a7QxRUOtQ4ifx9tTp5i2SyNU9MYj+MuHl69Mef1Az9AoIF0bemSl46TfZ5N1W/8tuuIJQkmIZLMmUXj2gD9rGytIZOr9YPYsD8brfHcq2CJAXVgqnaHBkyN6CiFwTC17CBXo6kMNM3/edSPdcZN9VNpjyvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg2dKFzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F64BC19425;
	Wed, 13 May 2026 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778689186;
	bh=nf/EGUFlU1Lh8RetUOEO9Cf1rjcOBc9mFE8STXI1blM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jg2dKFzv6okX1KYFBRwCHm2sFYiTPHsJQ5YnZWeVNvP3Zj5cWasmXNArcBkCV4FtZ
	 Cs1BE9Q0wZLhsOlBOHrsd2IopjTPWv7NKKb7t3BoTTz8JojO679pnlUVmPg4MeiGbQ
	 6zLYjR4CDfYOUbsDGYpd1zSuzlauUB1NRNQRe01/tTMDwm8WH7XUhi1TfmpciK5Xsf
	 0etPp1MQrSRS+wCfMxTZ7prR6YdLs4VaDtxPfv1lXObBTEuOwElYfZR/LUXvkzIUVc
	 BxSEVAgFShBCjO6UrdwYJmioH2S+IXaukrL/d8KUwrmrSwv0XxF4LcRi90IVGiVlC/
	 lhGeNl4KNuwVw==
Date: Wed, 13 May 2026 18:19:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Guenter Roeck <linux@roeck-us.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org, rcu@vger.kernel.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>
Subject: Re: [PATCH 08/23] arm64: topology: Use RCU to protect access to
 HK_TYPE_TICK cpumask
Message-ID: <agSkn9H_Xsz3MZa6@localhost.localdomain>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-9-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260421030351.281436-9-longman@redhat.com>
X-Rspamd-Queue-Id: 33CE1537168
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-10841-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,localhost.localdomain:mid]
X-Rspamd-Action: no action

Le Mon, Apr 20, 2026 at 11:03:36PM -0400, Waiman Long a écrit :
> As the HK_TYPE_TICK cpumask is going to be changeable at run time, we
> need to use RCU to protect access to the cpumask to prevent it from
> going away in the middle of the operation.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/kernel/topology.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
> index b32f13358fbb..48f150801689 100644
> --- a/arch/arm64/kernel/topology.c
> +++ b/arch/arm64/kernel/topology.c
> @@ -173,6 +173,7 @@ void arch_cpu_idle_enter(void)
>  	if (!amu_fie_cpu_supported(cpu))
>  		return;
>  
> +	guard(rcu)();
>  	/* Kick in AMU update but only if one has not happened already */
>  	if (housekeeping_cpu(cpu, HK_TYPE_TICK) &&
>  	    time_is_before_jiffies(per_cpu(cpu_amu_samples.last_scale_update,
>  	cpu)))

This is called with IRQs disabled in the current CPU that is online so it's
already guaranteed to be stable.


> @@ -187,11 +188,16 @@ int arch_freq_get_on_cpu(int cpu)
>  	unsigned int start_cpu = cpu;
>  	unsigned long last_update;
>  	unsigned int freq = 0;
> +	bool hk_cpu;
>  	u64 scale;
>  
>  	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
>  		return -EOPNOTSUPP;
>  
> +	scoped_guard(rcu) {
> +		hk_cpu = housekeeping_cpu(cpu, HK_TYPE_TICK);
> +	}
> +
>  	while (1) {
>  
>  		amu_sample = per_cpu_ptr(&cpu_amu_samples, cpu);
> @@ -204,16 +210,21 @@ int arch_freq_get_on_cpu(int cpu)
>  		 * (and thus freq scale), if available, for given policy: this boils
>  		 * down to identifying an active cpu within the same freq domain, if any.
>  		 */
> -		if (!housekeeping_cpu(cpu, HK_TYPE_TICK) ||
> +		if (!hk_cpu ||
>  		    time_is_before_jiffies(last_update + msecs_to_jiffies(AMU_SAMPLE_EXP_MS))) {
>  			struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
> +			bool hk_intersects;
>  			int ref_cpu;
>  
>  			if (!policy)
>  				return -EINVAL;
>  
> -			if (!cpumask_intersects(policy->related_cpus,
> -						housekeeping_cpumask(HK_TYPE_TICK))) {
> +			scoped_guard(rcu) {
> +				hk_intersects = cpumask_intersects(policy->related_cpus,
> +							housekeeping_cpumask(HK_TYPE_TICK));
> +			}
> +
> +			if (!hk_intersects) {
>  				cpufreq_cpu_put(policy);
>  				return -EOPNOTSUPP;
>  			}

Ok so this is racy but it's fine because:

This function is only used by cpufreq with either cpufreq_policy_write or
cpufreq_policy_read held (that is, struct cpufreq_policy::rwsem).

And that rwsem is write held on cpufreq_online() -> cpufreq_policy_online() and
also offline to guarantee the policy->cpus and policy->cpu stability.

Therefore housekeeping_cpumask() should only deal with stable online CPUs here. So
even if the housekeeping mask can be changed concurrently, those CPUs can't
appear or disappear from it.

Would be worth adding a comment about that.

-- 
Frederic Weisbecker
SUSE Labs

