Return-Path: <linux-hyperv+bounces-11531-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KeeoDXl9JmpsXQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11531-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 10:29:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CF6540D5
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 10:29:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Q5pS/dic";
	dkim=pass header.d=suse.com header.s=susede1 header.b="Q5pS/dic";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11531-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11531-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 295793011E8A
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 08:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628343AFCFD;
	Mon,  8 Jun 2026 08:28:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FCA3AFD19
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Jun 2026 08:28:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780907309; cv=none; b=Ohh8S4Jvs2YoTaamyY3ygQQd0RqeWVxsJPeD3JnLMaWK2tFRBiMEQx9dLpwz9+jcZ/lfwXQQc/Vqj5DXNrKPCHwYjchiZd/YFT/vvGnGcD0hi9Y6atx+T2ktaGjjIdkBt8N9IoNUQq2y2ZxBCvwzCcrhmw4cbbEfyIYMq7krvRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780907309; c=relaxed/simple;
	bh=Nbfff/Lq4CIBFcUwAjHzQLqnMIBCmmIHWP+7IwUIg9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tr51nZFwAKRd3eUzKFJpC3zAWwfAujmQUMYKuQXh7OM3+eLrK2iko0PUdoFvwgHWH4pkROBNLA0a5QztZ3al2liWEME2w9UyFzCNtvC6SaqwjhT3K9j7eNIN/TSzxLDH3ePAwp/2xdozMWMoqmZtBqouwbMRti6PVXxm/nKhqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q5pS/dic; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q5pS/dic; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6984F75EE7;
	Mon,  8 Jun 2026 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIGKCmPgjtkBqF6dJ3E9n7yVh95nUxf6Lp45W7Kn2dU=;
	b=Q5pS/dicx98uyWAW6AjjSdrgxFzmTsYHo4MSVMQCe5QgOIVm4xsbyN+F40F103lxBynq9J
	k7tW+MVGAre10Ih/Icd7zvGl9KNdNip4d8/9frO7C+YnKil1Hx40wtDQGNXvG4x3v1IhDf
	/KeanrPWLxERp4BeF3Eee9LfhBt5qCA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780907298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CIGKCmPgjtkBqF6dJ3E9n7yVh95nUxf6Lp45W7Kn2dU=;
	b=Q5pS/dicx98uyWAW6AjjSdrgxFzmTsYHo4MSVMQCe5QgOIVm4xsbyN+F40F103lxBynq9J
	k7tW+MVGAre10Ih/Icd7zvGl9KNdNip4d8/9frO7C+YnKil1Hx40wtDQGNXvG4x3v1IhDf
	/KeanrPWLxERp4BeF3Eee9LfhBt5qCA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF3D8779A7;
	Mon,  8 Jun 2026 08:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QUyWKSF9JmoqSAAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 08:28:17 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	James Morse <james.morse@arm.com>,
	Babu Moger <babu.moger@amd.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Artem Bityutskiy <dedekind1@gmail.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 1/4] x86/msr: Switch rdmsrl() users to rdmsrq()
Date: Mon,  8 Jun 2026 10:28:06 +0200
Message-ID: <20260608082809.3492719-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608082809.3492719-1-jgross@suse.com>
References: <20260608082809.3492719-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	TAGGED_FROM(0.00)[bounces-11531-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,infradead.org,redhat.com,kernel.org,arm.com,linux.intel.com,google.com,intel.com,linaro.org,alien8.de,zytor.com,amd.com,microsoft.com,gmail.com];
	FORGED_SENDER(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:x86@kernel.org,m:linux-perf-users@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-pm@vger.kernel.org,m:jgross@suse.com,m:peterz@infradead.org,m:mingo@redhat.com,m:acme@kernel.org,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:james.clark@linaro.org,m:tglx@kernel.org,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:tony.luck@intel.com,m:reinette.chatre@intel.com,m:Dave.Martin@arm.com,m:james.morse@arm.com,m:babu.moger@amd.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:rafael@kernel.org,m:artem.bityutskiy@linux.intel.com,m:dedekind1@gmail.com,m:lenb@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgross@suse.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C84CF6540D5

rdmsrl() is a deprecated synonym for rdmsrq(). Switch its users to
rdmsrq().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/amd/uncore.c          | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c | 2 +-
 drivers/hv/mshv_vtl_main.c            | 2 +-
 drivers/idle/intel_idle.c             | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dd956cfcadef..98ef4bf9911a 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -966,7 +966,7 @@ static void amd_uncore_umc_read(struct perf_event *event)
 	 * UMC counters do not have RDPMC assignments. Read counts directly
 	 * from the corresponding PERF_CTR.
 	 */
-	rdmsrl(hwc->event_base, new);
+	rdmsrq(hwc->event_base, new);
 
 	/*
 	 * Unlike the other uncore counters, UMC counters saturate and set the
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 59215fef3924..c5ed0bc1f831 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -301,7 +301,7 @@ static int __cntr_id_read(u32 cntr_id, u64 *val)
 	 * is set if the counter data is unavailable.
 	 */
 	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
-	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+	rdmsrq(MSR_IA32_QM_CTR, msr_val);
 
 	if (msr_val & RMID_VAL_ERROR)
 		return -EIO;
diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index c19400701467..f5d27f28d6ad 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -598,7 +598,7 @@ static int mshv_vtl_get_set_reg(struct hv_register_assoc *regs, bool set)
 			if (set)
 				wrmsrl(reg_table[i].msr_addr, *reg64);
 			else
-				rdmsrl(reg_table[i].msr_addr, *reg64);
+				rdmsrq(reg_table[i].msr_addr, *reg64);
 		}
 		return 0;
 	}
diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index f49354e37777..15c698291b32 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -2370,7 +2370,7 @@ static void intel_c1_demotion_toggle(void *enable)
 {
 	unsigned long long msr_val;
 
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
 	/*
 	 * Enable/disable C1 undemotion along with C1 demotion, as this is the
 	 * most sensible configuration in general.
@@ -2410,7 +2410,7 @@ static ssize_t intel_c1_demotion_show(struct device *dev,
 	 * Read the MSR value for a CPU and assume it is the same for all CPUs. Any other
 	 * configuration would be a BIOS bug.
 	 */
-	rdmsrl(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
+	rdmsrq(MSR_PKG_CST_CONFIG_CONTROL, msr_val);
 	return sysfs_emit(buf, "%d\n", !!(msr_val & NHM_C1_AUTO_DEMOTE));
 }
 static DEVICE_ATTR_RW(intel_c1_demotion);
-- 
2.54.0


