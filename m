Return-Path: <linux-hyperv+bounces-10266-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNKhG3c952kK5wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10266-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 11:03:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E243891C
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F32D300E63A
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 09:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7FA3A1E73;
	Tue, 21 Apr 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTHsJ8O1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A87823D7DC;
	Tue, 21 Apr 2026 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762153; cv=none; b=kM7cXqrVB4SJsHLqPjyt/rpCaxmVRXv/K59iwuPFUZOOaEKug6s/6CBX8H0sr+M4Uo1TdJAPDVTb85NR9qVHmOGP4f4yrPvT3YZNpmSffQmhH6AhIpVv5e0a1K5IiE0rY9Q1oge5jzw20qbsFYWAbory5N5wL/vENttORWtk/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762153; c=relaxed/simple;
	bh=hyZWWcOnCF0YqBIfepMB2TKvI6XHZWcg6x6y0OZJQLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QGmpFxmiLi2ZiMh/4pUFdLub6B8g0tlQ9SU9FiSw1LJv1U2kQ1/N5fa8KUiSa12yvSQfA/r8BjOcl3BoMGOapUoDSh4903ESek074jkamKBFu7tOxvT7m5xq/dxXM/BLCscPVXvO3234xeIkMVyz7zPp19QuwVAnOXgpu3zS2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dTHsJ8O1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB781C2BCB5;
	Tue, 21 Apr 2026 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776762152;
	bh=hyZWWcOnCF0YqBIfepMB2TKvI6XHZWcg6x6y0OZJQLI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dTHsJ8O1tmL/CMMD9GDGnTM+P4zaYf0VkAPrivxCnrtZ13VF+imGxW9VTBIRq/Uf2
	 SOF+NB6yQxfQQYNPzJk34BR5kVyD+W+jdDXneQtqRSWhS4SD+QZSj6I4bQzTtcspBX
	 e8pzBlONSb73VG8u3/0biZVM1Fe2lfQa3EkCLYd20CL1r9ZXze4oaIXMZz5tEqWYTF
	 Ji9ZurauMtTzsXivS8ZiFUfHXNA89x8w0rTDN5iIoWs3qPAfjwgLXFVn5Tx64Jrd8S
	 IZ8CmCzIzJA5ncBEo/OSVj1zWApAUV1Ddw4xCcHDxilmuZ4e5C0ni0Qolyo9QgCEwE
	 5Nrc5IUcYX9Og==
From: Thomas Gleixner <tglx@kernel.org>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Guenter Roeck <linux@roeck-us.net>, Frederic
 Weisbecker <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Ingo Molnar
 <mingo@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-hwmon@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Costa Shulyupin <cshulyup@redhat.com>,
 Qiliang Yuan <realwujing@gmail.com>, Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 16/23] genirq/cpuhotplug: Use RCU to protect access of
 HK_TYPE_MANAGED_IRQ cpumask
In-Reply-To: <20260421030351.281436-17-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
 <20260421030351.281436-17-longman@redhat.com>
Date: Tue, 21 Apr 2026 11:02:29 +0200
Message-ID: <87qzo8bs9m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10266-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D53E243891C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20 2026 at 23:03, Waiman Long wrote:

> As HK_TYPE_MANAGED_IRQ cpumask is going to be changeable at run time,
> use RCU to protect access to the cpumask.
>
> To enable the new HK_TYPE_MANAGED_IRQ cpumask to take effect, the
> following steps can be done.

Can be done?

>  1) Update the HK_TYPE_MANAGED_IRQ cpumask to take out the newly isolated
>     CPUs and add back the de-isolated CPUs.
>  2) Tear down the affected CPUs to cause irq_migrate_all_off_this_cpu()
>     to be called on the affected CPUs to migrate the irqs to other
>     HK_TYPE_MANAGED_IRQ housekeeping CPUs.
>  3) Bring up the previously offline CPUs to invoke
>     irq_affinity_online_cpu() to allow the newly de-isolated CPUs to
>     be used for managed irqs.

Which previously offline CPUs?

> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 2e8072437826..8270c4de260b 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -263,6 +263,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask, bool
>  	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
>  		const struct cpumask *hk_mask;
>  
> +		guard(rcu)();
>  		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
>  
>  		cpumask_and(tmp_mask, mask, hk_mask);

How is this hunk related to $Subject?

Thanks,

        tglx

