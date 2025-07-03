Return-Path: <linux-hyperv+bounces-6092-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0223AF8289
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 23:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DE001C87F21
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Jul 2025 21:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C422135C5;
	Thu,  3 Jul 2025 21:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xh0mQuJC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wEP+EA/D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009032AF19
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Jul 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751577669; cv=none; b=s38LHAGyVgKa/TAgPg/l9DZPBWLM1ZvptleK+ivhDUSHJfKE8jqKGoGxGHVmSyFDydwxgwD1CLD0OecMw0c8r0b6z8tfu0Ucns96x1PtdFgq8MVIZp6CVvxqRo0jZ1IbAWr8OykFD0gSB5+2EqQzZkaY0PAWaBdN8Lst96P2uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751577669; c=relaxed/simple;
	bh=jkjg5bIRablu4pmNltYP56Mt+T7b/kLwvPE2jLtcvVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fwJdZZUYhmSlcA9h+KoRacqql+oE9v5mnc3WkvKsc8OIgM0SwAptbDTW+yX/zrmt43o31sfuqkEDm9nT+yQYxCcFeU1qTvU0bFBefIX0ZurhEDakgWl2LZj0k53nf2C/FU7YpZgGgmJ1qnwpRnmlv2HzCikSQDZeBTX3Q5mduKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xh0mQuJC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wEP+EA/D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751577665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MAotRaZryMe7LxilJjeOAMZDNw2tzZasoTS1As7f2xg=;
	b=xh0mQuJCJG7yFa7IkZiBxx4WuK3DXucrXVXOMHpSFOYllLqhSqq0+ptVlrjL22ayAHBOTH
	bbTagQ0Vc7iweUiboZa6ICbTF+tjblVJ8AGQ16KNEHVUTemZIm13OA9FmUe+2iU/8C6wke
	4nM/yZAXQuIzGpgQlHZ9R3cYrNf8f1rB1h2R6vnHiYHE8MtK79K8QsbnNzj56hXiB+4fpb
	y3zjhRf1332WblwWU2rIuZm/bbVJkOzlH/MBKhVBH4VxbmNrGr+cR3nUAx6Jkv3zFIzymO
	r5D1GJJzyfDuzF6zFLFzDunkFv0wz7ztwoWijVH8WhQpxL7/N5zzGCZg5YArbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751577665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MAotRaZryMe7LxilJjeOAMZDNw2tzZasoTS1As7f2xg=;
	b=wEP+EA/DE6Zk4hKQjMf3ctTXcC2Ibvsf7l07nICYBzqv4Pxy7obIoqnX2jUii2/J2JCAcn
	pdIVfDNUAPDhTZBQ==
To: Thomas Gleixner <tglx@linutronix.de>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH] irqdomain: Export irq_domain_free_irqs_top()
Date: Thu,  3 Jul 2025 23:20:54 +0200
Message-Id: <20250703212054.2561551-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Export irq_domain_free_irqs_top(), making it usable for drivers compiled as
modules.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c8b6de09047b..46919e6c9c45 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1561,6 +1561,7 @@ void irq_domain_free_irqs_top(struct irq_domain *doma=
in, unsigned int virq,
 	}
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
 }
+EXPORT_SYMBOL_GPL(irq_domain_free_irqs_top);
=20
 static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
--=20
2.39.5


