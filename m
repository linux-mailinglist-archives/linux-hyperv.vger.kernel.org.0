Return-Path: <linux-hyperv+bounces-10249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKzZBwvr5mlx1wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10249-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:12:11 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC7E435D55
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A94B305A11D
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 03:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B46537700D;
	Tue, 21 Apr 2026 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LLaFrSe7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB99377016
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 03:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740824; cv=none; b=WbLZrM2GsV75RqC6l1p//8jOIjMxo45m+0xqNA7OGliEj4kSg4kMPzSj1wglM0WfTDQFY967GChsmkvUMJIyZsa9psR3e55WtUj8MkUUqQvCOztm8sP5O6UuWKbsXR6+Jp/BKQjAPSY32govR3IeAm7nidQNc4WKx/EkooCOA20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740824; c=relaxed/simple;
	bh=wBqbSVNLmblycpPiB4EVKCEJkX8NpN5Q/069MdSR2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqEMvLEONTxlWqpX/Gvboro307oVnYxf47yhXc1M3lH8PLFt7LWV0g682SAy4Wjo1hilwA5l1ZYDCG6Vuut8GH7ugqNLUerb9MaeXF26RstkQZ/KepbkzFVeyTwEUw1qJxazZKULKevvHZMWACvq61JKx262FJiZBshp79SBBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LLaFrSe7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ1jBK4Qvk6IyuAc9PHelYKQB7rpI+GlQygtFZv3Gyc=;
	b=LLaFrSe7H0iJGX0Shmd444Jti497+4/hQXAeDIXxtssgSZ+YLVZUbF7t1y1ZqqXgqwrPVx
	b7btcECQdH26GRKNOsCSYbyJixN8YoNfeskAPXggQH3vIUvfOoUpuDyfB6eUtcna6zDuN5
	6Zkcs5lviN+4DaTeg6zSLGx+xLh+gOU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-wTudjAQlMAi-26eGJaOhJw-1; Mon,
 20 Apr 2026 23:06:57 -0400
X-MC-Unique: wTudjAQlMAi-26eGJaOhJw-1
X-Mimecast-MFC-AGG-ID: wTudjAQlMAi-26eGJaOhJw_1776740812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 517F11956054;
	Tue, 21 Apr 2026 03:06:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DB4119560AB;
	Tue, 21 Apr 2026 03:06:44 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	rcu@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Costa Shulyupin <cshulyup@redhat.com>,
	Qiliang Yuan <realwujing@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 16/23] genirq/cpuhotplug: Use RCU to protect access of HK_TYPE_MANAGED_IRQ cpumask
Date: Mon, 20 Apr 2026 23:03:44 -0400
Message-ID: <20260421030351.281436-17-longman@redhat.com>
In-Reply-To: <20260421030351.281436-1-longman@redhat.com>
References: <20260421030351.281436-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-10249-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[53];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AEC7E435D55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

As HK_TYPE_MANAGED_IRQ cpumask is going to be changeable at run time,
use RCU to protect access to the cpumask.

To enable the new HK_TYPE_MANAGED_IRQ cpumask to take effect, the
following steps can be done.

 1) Update the HK_TYPE_MANAGED_IRQ cpumask to take out the newly isolated
    CPUs and add back the de-isolated CPUs.
 2) Tear down the affected CPUs to cause irq_migrate_all_off_this_cpu()
    to be called on the affected CPUs to migrate the irqs to other
    HK_TYPE_MANAGED_IRQ housekeeping CPUs.
 3) Bring up the previously offline CPUs to invoke
    irq_affinity_online_cpu() to allow the newly de-isolated CPUs to
    be used for managed irqs.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/irq/cpuhotplug.c | 1 +
 kernel/irq/manage.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index cd5689e383b0..86437c78f1f2 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -196,6 +196,7 @@ static bool hk_should_isolate(struct irq_data *data, unsigned int cpu)
 	if (!housekeeping_enabled(HK_TYPE_MANAGED_IRQ))
 		return false;
 
+	guard(rcu)();
 	hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	if (cpumask_subset(irq_data_get_effective_affinity_mask(data), hk_mask))
 		return false;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e8072437826..8270c4de260b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -263,6 +263,7 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask, bool
 	    housekeeping_enabled(HK_TYPE_MANAGED_IRQ)) {
 		const struct cpumask *hk_mask;
 
+		guard(rcu)();
 		hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 
 		cpumask_and(tmp_mask, mask, hk_mask);
-- 
2.53.0


