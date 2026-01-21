Return-Path: <linux-hyperv+bounces-8400-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOoxDbA+cGnXXAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8400-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 03:49:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA1F5005D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 03:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A8405AFA2E
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEE13570CE;
	Wed, 21 Jan 2026 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ecP9vS5P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F38332EC8;
	Wed, 21 Jan 2026 02:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768963248; cv=none; b=tgqBbfzrmHxjV5lGx2kCjMLGQXK8C/Ab0zAX3AjXzN4qfB4s2Zc+mB5kgXKmLjhF0A/2zFfxNPVhd16elHOpL3dm5uHg6EyqXdob+841A1uifw49dQCBu3ajjdfw7Hef3cVOVFWmuX2G2Xh3p5gTlIeEbi9de59+wgtDPvNF62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768963248; c=relaxed/simple;
	bh=En2HW4+UaKjpZS8Kh7qdMgwX3h09E7xgLtKoyYzyLAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Do6dQks9YLdNlZsFxq1Hmz94cgEENT8rvPz0aErgwfjhK9ls9w2NIPcvfdNNaB2ufzSay8ZaU7DGuLPa7p+koG99Huv8KALqwA5FTLqU7nnakY1ftSeEVTfkpGoAkPkmqvqm0Ua4YVZMyw5OttsiiIkCXilNupg8Ea9rJxwqK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ecP9vS5P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82A4720B7167;
	Tue, 20 Jan 2026 18:40:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82A4720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768963246;
	bh=CVwJONf59IKX8KA1dnLan/FVVfzrrZSgGi4IehKl2o8=;
	h=From:To:Cc:Subject:Date:From;
	b=ecP9vS5PNiQ8qSE77OFehPJEAfantY8fFYQgOf+Vl+fb1H+WuT8nM8VTj0UtbrHVu
	 Z7QvgaZd8sfZ96MzTxE5jxJOyiXu+FGE7Fts6fGTcBDPdhkSyvoB+meBzcBH/eM/pN
	 /tvfNszGt9s2lEFtXk0+flKA4e5TMFgbw2qUqg+E=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH V0] x86/hyperv: Fix compiler warnings in hv_crash.c
Date: Tue, 20 Jan 2026 18:40:45 -0800
Message-ID: <20260121024045.3834787-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.microsoft.com,none];
	TAGGED_FROM(0.00)[bounces-8400-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,intel.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9AA1F5005D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix two compiler warnings:
  o smp_ops is only defined if CONFIG_SMP
  o status is set but not explicitly used.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512301641.FC6OAbGM-lkp@intel.com/
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_crash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_crash.c b/arch/x86/hyperv/hv_crash.c
index c0e22921ace1..82915b22ceae 100644
--- a/arch/x86/hyperv/hv_crash.c
+++ b/arch/x86/hyperv/hv_crash.c
@@ -279,7 +279,6 @@ static void hv_notify_prepare_hyp(void)
 static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
 {
 	struct hv_input_disable_hyp_ex *input;
-	u64 status;
 	int msecs = 1000, ccpu = smp_processor_id();
 
 	if (ccpu == 0) {
@@ -313,7 +312,7 @@ static noinline __noclone void crash_nmi_callback(struct pt_regs *regs)
 	input->rip = trampoline_pa;
 	input->arg = devirt_arg;
 
-	status = hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
+	hv_do_hypercall(HVCALL_DISABLE_HYP_EX, input, NULL);
 
 	hv_panic_timeout_reboot();
 }
@@ -628,8 +627,9 @@ void hv_root_crash_init(void)
 	if (rc)
 		goto err_out;
 
+#ifdef CONFIG_SMP
 	smp_ops.crash_stop_other_cpus = hv_crash_stop_other_cpus;
-
+#endif
 	crash_kexec_post_notifiers = true;
 	hv_crash_enabled = true;
 	pr_info("Hyper-V: both linux and hypervisor kdump support enabled\n");
-- 
2.51.2.vfs.0.1


