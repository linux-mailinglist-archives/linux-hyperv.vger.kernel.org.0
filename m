Return-Path: <linux-hyperv+bounces-9969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGt9NdgP0GlQ2wYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9969-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:07:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 455A939783A
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Apr 2026 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45149305DD59
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2026 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B693CE492;
	Fri,  3 Apr 2026 19:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LZVrFFPo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F69369225;
	Fri,  3 Apr 2026 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243180; cv=none; b=PT84DJt2kDQg2Rw+uZqWfLST+PVkgVh5DGIZY2p7ZPfhzqBg6Cs+x/hrnoC4UbUoDDmHPkjeHesPN2mZh33hDOdyJs9ngYJzuSu1OzpA0764SqgYsJkcv2tmP+w5/IWIEm8rpfaxDKxafXfsmlatE3FzKnglpDzI4b9K8Wa5XEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243180; c=relaxed/simple;
	bh=kQx2w6tjXS70FM6QN8ZD2XsXn3DcBvyYIGxSEVKnzeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VNJRtOfuBwv3zInZg6F3nNofewdckRkYZ4notiZIyzcKLciqdT/2yKCWAAgpRhh5Yw6XDr4a+/0145WxqFMiVgN9EC7E4SyyHrQ/wlio+jRq8rQsH5juqcSy1tzwKZ+SKxvCIfcFl1rmt5YqUI6hTgBgIJCmvKp6lYfn1gkDwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LZVrFFPo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id CD7ED20B6F08; Fri,  3 Apr 2026 12:06:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD7ED20B6F08
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775243178;
	bh=/2DAmCjc8SwftdIXiNdKNR+rhLn04r/3WgiKSyZp/C8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LZVrFFPoH2ZOMAfozYttxNb43tMnOShX418hsfi2bG8mpphlgaHaFh2HkyUnFs45/
	 73G2v5UmNX0qoVoSFvBBodXuWFgAu4L6zfgC5C3fSSHuSUnN7A5u+uzgcqZ9Q3uHNS
	 V9FVProCEZzsGcj43Z4FEeoMR4R2FX1PsbsirDZw=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v2 1/6] Drivers: hv: vmbus: fix hyperv_cpuhp_online variable shadowing
Date: Fri,  3 Apr 2026 12:06:07 -0700
Message-ID: <20260403190613.47026-2-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403190613.47026-1-jloeser@linux.microsoft.com>
References: <20260403190613.47026-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,outlook.com,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9969-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 455A939783A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

vmbus_alloc_synic_and_connect() declares a local 'int
hyperv_cpuhp_online' that shadows the file-scope global of the same
name. The cpuhp state returned by cpuhp_setup_state() is stored in
the local, leaving the global at 0 (CPUHP_OFFLINE). When
hv_kexec_handler() or hv_machine_shutdown() later call
cpuhp_remove_state(hyperv_cpuhp_online) they pass 0, which hits the
BUG_ON in __cpuhp_remove_state_cpuslocked().

Remove the local declaration so the cpuhp state is stored in the
file-scope global where hv_kexec_handler() and hv_machine_shutdown()
expect it.

Fixes: 2647c96649ba ("Drivers: hv: Support establishing the confidential VMBus connection")
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/vmbus_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 3e7a52918ce0..301273d61892 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1430,7 +1430,6 @@ static int vmbus_alloc_synic_and_connect(void)
 {
 	int ret, cpu;
 	struct work_struct __percpu *works;
-	int hyperv_cpuhp_online;
 
 	ret = hv_synic_alloc();
 	if (ret < 0)
-- 
2.43.0


