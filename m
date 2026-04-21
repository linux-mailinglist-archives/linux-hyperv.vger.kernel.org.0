Return-Path: <linux-hyperv+bounces-10240-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK+eIvvp5mlx1wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10240-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:07:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5B7435B6C
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 05:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46A743030740
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 03:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0167436EAA2;
	Tue, 21 Apr 2026 03:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbruz1zH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963C36B05C
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Apr 2026 03:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776740757; cv=none; b=PBPcb6R6S79Dm0E1TQ8GUS3kQGjXgxA+5UvFqxVdurO3SQgjVAXgmojP31dj8krEkjImuAI7RbfFzZo9wXjLqfnHXI7xGiYV4AenfgYFSfaHfXjvB4oh8t8X5xjUQXbVHC2JF2kaCT9TMoKJIuKgGJnqWfe6Jd9g2phAlu++9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776740757; c=relaxed/simple;
	bh=6dOR9VvfHXSOAa+3ONfN9QOA7EaOHN44SvLAlIcSGZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0mWQtPEU6uuCV2lyy98xV5E93Tf0yegN0SHeqEZkxIjz1BygcAWv9sxHLNTMB3o6ZIVVAOqlil03a8qePbMJVss9bRKV7UNCCnm9/HDIexk6PCCrDIxAR2MW0bamE8r7wmIGPnkgfrTjIYYDw7p3r8Ddpo/skjGwfxPoRNi7XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bbruz1zH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776740755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRnLiTFd5Q/8p4sCGe2o1EMdVAtDIxePLghGCtdhHc0=;
	b=Bbruz1zHSwEDfdR//i9NJ4Ns7Bqfk6fcsbjWsCgqaQ9vJreaObAIzNqOb3XH5fQZVrzGu/
	UKFent1Dg8hcTqM9Tmx7ZHt8RAQa/kS4Lg6aweoI3Dj7aqUMRzaaY1HhNkFiEoIrqkepB5
	xoc/CaVhcGkLfKJYgrxfPd0Wx1yYXrE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-30-2NDOP3YyMf-mNL6wwN032w-1; Mon,
 20 Apr 2026 23:05:51 -0400
X-MC-Unique: 2NDOP3YyMf-mNL6wwN032w-1
X-Mimecast-MFC-AGG-ID: 2NDOP3YyMf-mNL6wwN032w_1776740746
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7ACED19560AD;
	Tue, 21 Apr 2026 03:05:46 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.81])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2157519560B7;
	Tue, 21 Apr 2026 03:05:39 +0000 (UTC)
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
Subject: [PATCH 07/23] watchdog: Sync up with runtime change of isolated CPUs
Date: Mon, 20 Apr 2026 23:03:35 -0400
Message-ID: <20260421030351.281436-8-longman@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,cmpxchg.org,suse.com,lwn.net,linuxfoundation.org,arm.com,microsoft.com,roeck-us.net,nvidia.com,joshtriplett.org,gmail.com,goodmis.org,efficios.com,linux.dev,linutronix.de,huaweicloud.com,infradead.org,redhat.com,linaro.org,google.com,suse.de,amd.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-10240-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 4A5B7435B6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

At bootup, watchdog will exclude nohz_full CPUs specified at boot time.
As we are now enabling runtime changes to nohz_full CPUs, the list of
CPUs with watchdog timer running should be updated to exclude the
current set of isolated CPUs.

Add a new watchdog_cpumask_update() helper to be invoked
by housekeeping_update() when the HK_TYPE_KERNEL_NOISE
(HK_TYPE_TIMER) cpumask is being updated to update watchdog_cpumask and
watchdog_allowed_mask for soft lockup detector. The cpumask updates will
be done when the affected CPUs are in the offline state. When those
CPUs are brought up later, the new cpumask will be used to determine
if any hard/soft watchdog should be enabled again.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/nmi.h      |  2 ++
 kernel/sched/isolation.c |  1 +
 kernel/watchdog.c        | 24 ++++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index bc1162895f35..5bf941d2b168 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -17,6 +17,7 @@
 void lockup_detector_init(void);
 void lockup_detector_retry_init(void);
 void lockup_detector_soft_poweroff(void);
+void watchdog_cpumask_update(struct cpumask *mask);
 
 extern int watchdog_user_enabled;
 extern int watchdog_thresh;
@@ -37,6 +38,7 @@ extern int sysctl_hardlockup_all_cpu_backtrace;
 static inline void lockup_detector_init(void) { }
 static inline void lockup_detector_retry_init(void) { }
 static inline void lockup_detector_soft_poweroff(void) { }
+static inline void watchdog_cpumask_update(struct cpumask *mask) { }
 #endif /* !CONFIG_LOCKUP_DETECTOR */
 
 #ifdef CONFIG_SOFTLOCKUP_DETECTOR
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index b5635484ec69..1f3f1c83dd12 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -184,6 +184,7 @@ int housekeeping_update(struct cpumask *isol_mask, unsigned long flags)
 	if (flags & HK_FLAG_KERNEL_NOISE) {
 		tick_nohz_full_update_cpus(isol_mask);
 		rcu_nocb_update_cpus(isol_mask);
+		watchdog_cpumask_update(isol_mask);
 	}
 
 	synchronize_rcu();
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 87dd5e0f6968..498c1463b843 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1071,6 +1071,30 @@ static inline void lockup_detector_setup(void)
 }
 #endif /* !CONFIG_SOFTLOCKUP_DETECTOR */
 
+/**
+ * watchdog_cpumask_update - update watchdog_cpumask & watchdog_allowed_mask
+ * @isol_mask: cpumask of isolated CPUs
+ *
+ * Update watchdog_cpumask and watchdog_allowed_mask to be inverse of the
+ * given isolated cpumask to disable watchdog activities on isolated CPUs.
+ * It should be called with the affected CPUs in offline state which will be
+ * brought up online later.
+ *
+ * Any changes made in watchdog_cpumask by users via the sysctl parameter will
+ * be overridden. However, proc_watchdog_update() isn't called. So change will
+ * only happens on CPUs that will brought up later on to minimize changes to
+ * the existing watchdog configuration.
+ */
+void watchdog_cpumask_update(struct cpumask *isol_mask)
+{
+	mutex_lock(&watchdog_mutex);
+	cpumask_andnot(&watchdog_cpumask, cpu_possible_mask, isol_mask);
+#ifdef CONFIG_SOFTLOCKUP_DETECTOR
+	cpumask_copy(&watchdog_allowed_mask, &watchdog_cpumask);
+#endif
+	mutex_unlock(&watchdog_mutex);
+}
+
 /**
  * lockup_detector_soft_poweroff - Interface to stop lockup detector(s)
  *
-- 
2.53.0


