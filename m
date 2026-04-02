Return-Path: <linux-hyperv+bounces-9935-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SO4XEa3QzmmUqQYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9935-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:25:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C89D38DF11
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 22:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF155300917D
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 20:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523538AC97;
	Thu,  2 Apr 2026 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b="aeuLq9tG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7698338A28F;
	Thu,  2 Apr 2026 20:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775161513; cv=pass; b=Ms3epxQnP90rSxDQn5Gcl0+m+1MxWXFZSNh9k6vP6qIEO2rKMfuH3f4mH6Ly2kBjTSguTeDxW8xUpLvtquJXxpDxx9VNcoavjGaYf4YqDNsH9MB6fH128j2MiMbXPXyXdkbXYH49+jCp1PNNfJMl0JFY/IEqNlSYOw0hBYxSEYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775161513; c=relaxed/simple;
	bh=F4LgDRq2v/rbUOmDnv6Whmnrku4Rr/JGT33GpNEor9I=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iyPA6lwa4JN/gKO+L8I96nyVSAiBZgQQmvsDHSp/nmUTEWCQAdYvoeAk8QYsWzlLeAWMyvmZ9SbKLR2uMx5PHX0ymhmJXoQ0GOS9mTSqlvlqk73ZujTrRKl7yM1knBB44pFRy+OXnogqVqvIyKRB0kI/PwrRDF7FPTUrEFoFTow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=mhklkml@zohomail.com header.b=aeuLq9tG; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1775161457; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ERoBfHhaVO73gC+GrXCMMwodBVwt9BHfp2CmcehDqy9Pq/EnaYMslycMLg9/1yuj4bFQluMtD4Fj/qr7O548AU71Y3WIzyHTW+t8/uHI92Lyu+0o0roS7NAIqzn2O4jZvm4VQ036ipQdoYsruGD+vAgnpqXfpXncohJ5La1bf7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775161457; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Reply-To:References:Subject:Subject:To:To:Message-Id:Cc; 
	bh=eyQFAmheBIp6QuU8rjyhHusND7EN1rSqPmCqpBGxAiI=; 
	b=CcyoTdU9mciqNlX9NXVYFl4LuMV01UN1nDYHqaoCCUpJeNmRX1D8xjZSrP8mXkubJKkO5ArV12ZbVqYijvWVObY8m438E/SjMUtSL2uXv2fbTlTjv3k/a8+OiN3zx+OJKX1lxuUylunZJiRpi2PzX8pwS0lrTnLSVXjpm1r3l9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=mhklkml@zohomail.com;
	dmarc=pass header.from=<mhklkml@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775161457;
	s=zm2022; d=zohomail.com; i=mhklkml@zohomail.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:Reply-To:Reply-To:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Cc;
	bh=eyQFAmheBIp6QuU8rjyhHusND7EN1rSqPmCqpBGxAiI=;
	b=aeuLq9tGYcyoQFimEZd9v1/eZmDOk8rvHYssCpWpaIc9Ei73nZ2dXaJpMTBDMkpa
	8IEg4ujaZvQ3FOoVeoY8o8gggwBP+Tbj/Yom9rdtgK+fAqhaCjYl9/cx0o1CjdApSdD
	OvJC/JOrQpZt7HPJCwMjzJ1SU3xvmf3MXIZSoOXU=
Received: by mx.zohomail.com with SMTPS id 1775161454230532.5382218817623;
	Thu, 2 Apr 2026 13:24:14 -0700 (PDT)
From: Michael Kelley <mhklkml@zohomail.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	maz@kernel.org,
	bigeasy@linutronix.de,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/2] genirq/chip: Do add_interrupt_randomness() in handle_percpu_devid_irq()
Date: Thu,  2 Apr 2026 13:23:59 -0700
Message-Id: <20260402202400.1707-2-mhklkml@zohomail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402202400.1707-1-mhklkml@zohomail.com>
References: <20260402202400.1707-1-mhklkml@zohomail.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122759ff960247f20993572a473200007be8766086786e1ecdf5c45700d67505177c79872009088d78:zu08011227f004be260bb709d241c038eb0000a02eb8d58dfa55092f99dd1202c863e9e067f0d9c1e2860267:rf0801122c2e093a47bde57cdde0f18709000025de50774f2780eb3956e3f29cf25058116fd88fd82dae08ae48bb1e5426:ZohoMail
X-ZohoMailClient: External
X-Spamd-Result: default: False [1.34 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zohomail.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[zohomail.com:s=zm2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9935-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_REPLYTO(0.00)[outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[zohomail.com:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklkml@zohomail.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	HAS_REPLYTO(0.00)[mhklinux@outlook.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[zohomail.com:dkim,zohomail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,outlook.com:replyto]
X-Rspamd-Queue-Id: 8C89D38DF11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Michael Kelley <mhklinux@outlook.com>

handle_percpu_devid_irq() is a version of handle_percpu_irq() but with
the addition of a pointer to a per-cpu devid. However, handle_percpu_irq()
does add_interrupt_randomness(), while handle_percpu_devid_irq() currently
does not. Add the missing add_interrupt_randomness(), as it is needed
when per-cpu interrupts with devid's are used in VMs for interrupts
from the hypervisor.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 kernel/irq/chip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6147a07d0127..6c9b1dc4e7d4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel_stat.h>
 #include <linux/irqdomain.h>
+#include <linux/random.h>
 
 #include <trace/events/irq.h>
 
@@ -929,6 +930,8 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 			    enabled ? " and unmasked" : "", irq, cpu);
 	}
 
+	add_interrupt_randomness(irq);
+
 	if (chip->irq_eoi)
 		chip->irq_eoi(&desc->irq_data);
 }
-- 
2.25.1


