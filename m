Return-Path: <linux-hyperv+bounces-8898-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIivBr3wlWlTWwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8898-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 18:02:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6E2158040
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 18:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A0A30056D7
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2882F49EC;
	Wed, 18 Feb 2026 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="NbkhTPhY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1174022D4DC;
	Wed, 18 Feb 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434097; cv=pass; b=JOEjFU44dFXgTk/m8pmc5IJat9T1scw1Ba4PpggfgfG20k8S3fe9DRRF8TFy3KqWeA20+tZ+cLq3haJKYQRpvpfkZLF1QY26lAfUtZxhAQ4ImV71GefNmKKlVrI6j1G3vyPcRx7o6B/wKVuRRFRL4sZo7D5d5GSAJQZDifEr+Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434097; c=relaxed/simple;
	bh=sTdy++im/qC8oUNeYR5M8UW9ckOjQ46B3F2Ve632DXM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CAp2fFq4XWgirTdrunvst6rQOyDGMUd67nmP8F7tqlbIqQ+I5tGuB2q5f6KDWKDwh+y6zXpGH+Dl21nOJblqYygUw1V1LBJzwPUhqOz5qe9S9f1cUfxv1jhGUNbeSG9SZTOvbqSZ+SZYACI2NnXBasYltpIabNVUM0BvzqyttLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=NbkhTPhY; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1771434090; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EK4OVxKG3AsYH7B4dBXDmosxlC933d38X0aycKa9AchM/ZvTplow1m+DJ6zLbgrt67i++EpNIwM00jzzat/MlfTQR/BPRxSuipwnZJAfxrB+K7HRzEF7dtSL5dvg3iCJyhGwJxoTruFQshlQ63uGfWZIZu8Jv4sZXS4FUn0Domg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771434090; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id; 
	bh=tzCn6q5MVHFSe2xHTeG5eXj5VtgjEipJxD81SGwjMq0=; 
	b=eqOOnFXZXb3jaI2Rc8BZYIX6CaoQOhC5CgO+S864ynUH33Q55t580c777uF16thpQIu695rR9YsJVtFeufyycBUbumQkU3n/mQttYpf9W7lFRefbZDLUYw4htsrPoN7aHiAqwkKCos0wRkxLLbzENegZAfTeHpc8ihN6IYIa1xQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771434090;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=tzCn6q5MVHFSe2xHTeG5eXj5VtgjEipJxD81SGwjMq0=;
	b=NbkhTPhY8wkU11BDdQf3SD6eVw9dGyX39PA9H0i4Ik3zM0snpGYvPwliniOEtlcs
	Xyqhw/BEd24Vu64hAWFjhwKNGN0s6oKkncOIOi7WTEQLceDF2krAHSu1JKDfauZ6QKt
	nCCNqHpmqqsXw3DcLyX+pB9cxbA9QwKPER2aX5j4=
Received: by mx.zohomail.com with SMTPS id 1771434087255233.25860762231764;
	Wed, 18 Feb 2026 09:01:27 -0800 (PST)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Simplify allocation of vmbus_evt
Date: Wed, 18 Feb 2026 09:01:21 -0800
Message-Id: <20260218170121.1522-1-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227998de60bdd019d5e5c4995560000dfd1893db465250fe270533de613e88a67ba04d54280fee504:zu080112273ec040023ab4392f7f809bd100006a536fd3a6728196e00ad9f5dc4532436fc1879c7ac4665134:rf08011226b5473ae4af57d242f6d2a14a0000c7a7320b729b9ba4c91f23c3afab0381b4a0c6f033d6f1f5:ZohoMail
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8898-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:replyto,outlook.com:email,zohomail.com:mid,zohomail.com:dkim]
X-Rspamd-Queue-Id: 7B6E2158040
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com>

The per-cpu variable vmbus_evt is currently dynamically allocated. It's
only 8 bytes, so just allocate it statically to simplify and save a few
lines of code.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 97dfa529d250..2219ce41b384 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -51,7 +51,7 @@ static struct device  *vmbus_root_device;
 
 static int hyperv_cpuhp_online;
 
-static long __percpu *vmbus_evt;
+static DEFINE_PER_CPU(long, vmbus_evt);
 
 /* Values parsed from ACPI DSDT */
 int vmbus_irq;
@@ -1475,13 +1475,11 @@ static int vmbus_bus_init(void)
 	if (vmbus_irq == -1) {
 		hv_setup_vmbus_handler(vmbus_isr);
 	} else {
-		vmbus_evt = alloc_percpu(long);
 		ret = request_percpu_irq(vmbus_irq, vmbus_percpu_isr,
-				"Hyper-V VMbus", vmbus_evt);
+				"Hyper-V VMbus", &vmbus_evt);
 		if (ret) {
 			pr_err("Can't request Hyper-V VMbus IRQ %d, Err %d",
 					vmbus_irq, ret);
-			free_percpu(vmbus_evt);
 			goto err_setup;
 		}
 	}
@@ -1510,12 +1508,10 @@ static int vmbus_bus_init(void)
 	return 0;
 
 err_connect:
-	if (vmbus_irq == -1) {
+	if (vmbus_irq == -1)
 		hv_remove_vmbus_handler();
-	} else {
-		free_percpu_irq(vmbus_irq, vmbus_evt);
-		free_percpu(vmbus_evt);
-	}
+	else
+		free_percpu_irq(vmbus_irq, &vmbus_evt);
 err_setup:
 	bus_unregister(&hv_bus);
 	return ret;
@@ -2981,12 +2977,11 @@ static void __exit vmbus_exit(void)
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
-	if (vmbus_irq == -1) {
+	if (vmbus_irq == -1)
 		hv_remove_vmbus_handler();
-	} else {
-		free_percpu_irq(vmbus_irq, vmbus_evt);
-		free_percpu(vmbus_evt);
-	}
+	else
+		free_percpu_irq(vmbus_irq, &vmbus_evt);
+
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
-- 
2.25.1


