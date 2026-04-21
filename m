Return-Path: <linux-hyperv+bounces-10271-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O72JXmJ52kU9wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10271-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:28:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D8043C044
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DAF930438EB
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8073D88F8;
	Tue, 21 Apr 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsDV5bqK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58C3D7D91
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781489; cv=none; b=UIeTfuf+hHW1+xi3ZGA/8g4IJI6EgkqIRGl4FAt6O1H04pxZ+1Vo4WtP/n2yORtRD+u9LKp/SrXzGsS34tJZZv2HT+PyP4c+dNPze1dDJriM6EQuU/a2iOBT2iYWqa42oHyY3y6IH6Xef9fTtWcnGjYH4WC8SgVgbiHAJUYRqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781489; c=relaxed/simple;
	bh=FyIraVrHiuAFr1sLKmcvcUxCiKhFGy96CX6L/fpzy5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw12aTFfufuVqNxU1JGYUnfTnK2cMXHz71g+cwemXu/Qpnm6QTQse+Ht4pMzdHAFywPhSMOIwnCcnr2hnUX/oatqVgbqunpqQ1wegn3b0Nj1ASTNGm8RT5AV+QTDRhrfalLHTmhuiMTT/u11HzBUn0VEfAQ49suuzmo4lAVpNoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsDV5bqK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776781487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJwriG+ahQwDS3h8Yxos5MsPzqcz/+7HSnjU+qtTgL4=;
	b=XsDV5bqK6mRE6QwKhju5LXPwV8qfIVMextxCeSoJbOvNJ47qP2ED9cR1if4di3M7G0zSff
	4F64xDXMIYTiA1XAEWJhSSIQZz9a43VndA6dl+paP3AdsHWrCU0Ek43nIkaKftNDghYwIZ
	pKJ7qRZQ/yEA/xr+cfvI+k9y4irAfXI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-wQAIgnC2OYmtjWU2dR8Nkg-1; Tue,
 21 Apr 2026 10:24:41 -0400
X-MC-Unique: wQAIgnC2OYmtjWU2dR8Nkg-1
X-Mimecast-MFC-AGG-ID: wQAIgnC2OYmtjWU2dR8Nkg_1776781475
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 615881956048;
	Tue, 21 Apr 2026 14:24:33 +0000 (UTC)
Received: from [10.22.81.187] (unknown [10.22.81.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE3991956095;
	Tue, 21 Apr 2026 14:24:24 +0000 (UTC)
Message-ID: <0f1d88fa-b651-40eb-97a1-751d781901de@redhat.com>
Date: Tue, 21 Apr 2026 10:24:23 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/23] tick/nohz: Allow runtime changes in full dynticks
 CPUs
To: Thomas Gleixner <tglx@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Guenter Roeck <linux@roeck-us.net>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-5-longman@redhat.com> <87340od7ev.ffs@tglx>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87340od7ev.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-10271-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_GT_50(0.00)[52];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 30D8043C044
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/21/26 4:50 AM, Thomas Gleixner wrote:
> On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:
>> Full dynticks can only be enabled if "nohz_full" boot option has been
>> been specified with or without parameter. Any change in the list of
>> nohz_full CPUs have to be reflected in tick_nohz_full_mask. Introduce
>> a new tick_nohz_full_update_cpus() helper that can be called to update
>> the tick_nohz_full_mask at run time. The housekeeping_update() function
>> is modified to call the new helper when the HK_TYPE_KERNEL_NOSIE cpumask
>> is going to be changed.
>>
>> We also need to enable CPU context tracking for those CPUs that
> We need nothing. Use passive voice for change logs as requested in
> documentation.
>
>> are in tick_nohz_full_mask. So remove __init from tick_nohz_init()
>> and ct_cpu_track_user() so that they be called later when an isolated
>> cpuset partition is being created. The __ro_after_init attribute is
>> taken away from context_tracking_key as well.
>>
>> Also add a new ct_cpu_untrack_user() function to reverse the action of
>> ct_cpu_track_user() in case we need to disable the nohz_full mode of
>> a CPU.
>>
>> With nohz_full enabled, the boot CPU (typically CPU 0) will be the
>> tick CPU which cannot be shut down easily. So the boot CPU should not
>> be used in an isolated cpuset partition.
>>
>> With runtime modification of nohz_full CPUs, tick_do_timer_cpu can become
>> TICK_DO_TIMER_NONE. So remove the two TICK_DO_TIMER_NONE WARN_ON_ONCE()
>> checks in tick-sched.c to avoid unnecessary warnings.
> in tick-sched.c? Describe the functions which contain that.
>
>>   static inline void tick_nohz_task_switch(void)
>> diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
>> index 925999de1a28..394e432630a3 100644
>> --- a/kernel/context_tracking.c
>> +++ b/kernel/context_tracking.c
>> @@ -411,7 +411,7 @@ static __always_inline void ct_kernel_enter(bool user, int offset) { }
>>   #define CREATE_TRACE_POINTS
>>   #include <trace/events/context_tracking.h>
>>   
>> -DEFINE_STATIC_KEY_FALSE_RO(context_tracking_key);
>> +DEFINE_STATIC_KEY_FALSE(context_tracking_key);
>>   EXPORT_SYMBOL_GPL(context_tracking_key);
>>   
>>   static noinstr bool context_tracking_recursion_enter(void)
>> @@ -674,9 +674,9 @@ void user_exit_callable(void)
>>   }
>>   NOKPROBE_SYMBOL(user_exit_callable);
>>   
>> -void __init ct_cpu_track_user(int cpu)
>> +void ct_cpu_track_user(int cpu)
>>   {
>> -	static __initdata bool initialized = false;
>> +	static bool initialized;
>>   
>>   	if (cpu == CONTEXT_TRACKING_FORCE_ENABLE) {
>>   		static_branch_inc(&context_tracking_key);
>> @@ -700,6 +700,15 @@ void __init ct_cpu_track_user(int cpu)
>>   	initialized = true;
>>   }
>>   
>> +void ct_cpu_untrack_user(int cpu)
>> +{
>> +	if (!per_cpu(context_tracking.active, cpu))
>> +		return;
>> +
>> +	per_cpu(context_tracking.active, cpu) = false;
>> +	static_branch_dec(&context_tracking_key);
>> +}
>> +
> Why is this in a patch which makes tick/nohz related changes? This is a
> preparatory change, so make it that way and do not bury it inside
> something else.
Sure, I will break out the context tracking change into its own patch.
>> +/* Get the new set of run-time nohz CPU list & update accordingly */
>> +void tick_nohz_full_update_cpus(struct cpumask *cpumask)
>> +{
>> +	int cpu;
>> +
>> +	if (!tick_nohz_full_running) {
>> +		pr_warn_once("Full dynticks cannot be enabled without the nohz_full kernel boot parameter!\n");
> That's the result of this enforced enable hackery. Make this work
> properly.
>
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * To properly enable/disable nohz_full dynticks for the affected CPUs,
>> +	 * the new nohz_full CPUs have to be copied to tick_nohz_full_mask and
>> +	 * ct_cpu_track_user/ct_cpu_untrack_user() will have to be called
>> +	 * for those CPUs that have their states changed. Those CPUs should be
>> +	 * in an offline state.
>> +	 */
>> +	for_each_cpu_andnot(cpu, cpumask, tick_nohz_full_mask) {
>> +		WARN_ON_ONCE(cpu_online(cpu));
>> +		ct_cpu_track_user(cpu);
>> +		cpumask_set_cpu(cpu, tick_nohz_full_mask);
>> +	}
>> +
>> +	for_each_cpu_andnot(cpu, tick_nohz_full_mask, cpumask) {
>> +		WARN_ON_ONCE(cpu_online(cpu));
>> +		ct_cpu_untrack_user(cpu);
>> +		cpumask_clear_cpu(cpu, tick_nohz_full_mask);
>> +	}
>> +}
> So this writes to tick_nohz_full_mask while other CPUs can access
> it. That's just wrong and I'm not at all interested in the resulting
> KCSAN warnings.
>
> tick_nohz_full_mask needs to become a RCU protected pointer, which is
> updated once the new mask is established in a separately allocated one.

I will work on that.

Cheers,
Longman

>
> Thanks,
>
>          tglx
>
>


