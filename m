Return-Path: <linux-hyperv+bounces-6046-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE3FAED9C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413421899154
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jun 2025 10:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3E7254864;
	Mon, 30 Jun 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8agWFaS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="we3zyYYV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153223D28D;
	Mon, 30 Jun 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279187; cv=none; b=Ge06PVq6Ze6JAKrxRofE+rs6ELbAm0eCvjGyQxiLDQr1gsODc7mkomC3WQQ2UTERSacw/6Q/9GzBu/stOcmetNTxwgMCzTwVlZrzyfafkJGBOU3pYtlHXsMs9IeLBDISkRyEEIJ2BD0j4ATbsQvnd45vpSdN6TB4U3SfQayAYbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279187; c=relaxed/simple;
	bh=xdRxBbEFjritY+4aPuvldelsfwaJhw+C1HQnNHvVlww=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4tg6u/2GKIHh+yP6FNYsctF1qUP2QmgyjOocp+QKiClMn+2Ae2UU/Nq7uta4tVQ39sMJQRdCUAhB2tH7Gf9IPmWE3jAUKCAbPZ6IDMfHgJb3UjscAlS6+jC6thlpEm95Osc1HAaMQvX50OaZyVYWIhWc2GtTSX+bq1ilM5+lw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8agWFaS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=we3zyYYV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751279183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=09apZFjkItCff4pERuA6vKzkiicp/3GYycpUthFHj/Q=;
	b=y8agWFaSkjJn5/ZFz6/cfXKDYKa0k669VIENl7oLpKH3wilNC3oT0slQzHt0n8kUTXtXC2
	v+QO+yuv/GxFtUYbh6QCAdE8M5Tl3zDlBHUJYDBLu87M/ty+hqxLZCtJGbnsjLTt9L3l/F
	SDcHgH9tkx6kw23S8+bzik1TwEAb2Q/DiJlKLQYai8gxyxT/LhwKqDAZPr6oVQhilJg4PG
	iRndDe3eh5jLM7BuguTicK53yi1J20zaUhpUFTEsjdfRvfq93r97Ojc/wQDc9uXOLFfqos
	YhfwD87zInKNpb6NEvYKAwnMKMPaAikMBzq2NjuToELy6UoLZytsB2dbOlUjDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751279183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=09apZFjkItCff4pERuA6vKzkiicp/3GYycpUthFHj/Q=;
	b=we3zyYYVmoNnNCQCtpjCXCHlo9UWsgPXgsGuuYXv5Qyh8PiphWRFnReoApafQJxiaSb2r3
	HnjOPU8TMzjW8CAA==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 0/2] x86/hyperv: MSI parent domain conversion
Date: Mon, 30 Jun 2025 12:26:13 +0200
Message-Id: <cover.1751277765.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The initial implementation of PCI/MSI interrupt domains in the hierarchical
interrupt domain model used a shortcut by providing a global PCI/MSI
domain.

This works because the PCI/MSI[X] hardware is standardized and uniform, but
it violates the basic design principle of hierarchical interrupt domains:
Each hardware block involved in the interrupt delivery chain should have a
separate interrupt domain.

For PCI/MSI[X], the interrupt controller is per PCI device and not a global
made-up entity.

Unsurprisingly, the shortcut turned out to have downsides as it does not
allow dynamic allocation of interrupt vectors after initialization and it
prevents supporting IMS on PCI. For further details, see:

https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/

The solution is implementing per device MSI domains, this means the
entities which provide global PCI/MSI domain so far have to implement MSI
parent domain functionality instead.

This series:

  - Fixup a dependency problem with CONFIG_GENERIC_MSI_IRQ

  - converts the x86 hyperv driver to implement MSI parent domain.

Changes in v2:

  - Add the first fixup patch to resolve a build failure

  - Add clarification to the TODO note.

 arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
 drivers/hv/Kconfig          |   1 +
 drivers/irqchip/Kconfig     |   1 +
 3 files changed, 78 insertions(+), 35 deletions(-)

--=20
2.39.5


