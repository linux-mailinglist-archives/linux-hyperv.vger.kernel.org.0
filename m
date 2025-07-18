Return-Path: <linux-hyperv+bounces-6300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66587B0AAE2
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 21:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A14CD167DFA
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Jul 2025 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC812202996;
	Fri, 18 Jul 2025 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DQ6AGSp2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eZbzVf33"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0831E98F3;
	Fri, 18 Jul 2025 19:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752868693; cv=none; b=d2KQ/Cvfk/MTB+p3qlhtOPHAYYWpVusqpPc9NTeW5Enddxe7t9FDm3GZAYYjBbTxfeB1qSGEV3ZPqjPu+pBERfZKNRtm57UredODaXe4KUraYT8GUr9oKiBgxyUSfVlX2xdf6wjstN5usmt/1z7MLtp+Q44NG5sfCZ+N1/Hk740=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752868693; c=relaxed/simple;
	bh=z7n0285SXSteAJhL4o98M9i11JzYONRHBlsojyJ6jDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SW32jID96HGtL5tKhKEc3Tvk1X7fc/MEwFpEmXaV3Xm1pOnIZbRTWwXgGuUDiPQ/89uFEajQecscJDwb+vC7eC7NJLV/13mgy6NmUCYskq5ljEzt8nvRaWY5C+1mEMCVwarnsLpeHS0YN1agvRUwvmq2JJDnld9MhJab+rO7QLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DQ6AGSp2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eZbzVf33; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752868689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZXaF02BaMGEoDKKj0szmJ3qgP0vJ7qLHJvSby6+PbA=;
	b=DQ6AGSp2yHiy2ALC5N5Cz0JwhSsJXzQ9VJApa6LSwwlr5reSp9rNooVYmsHHln+I0zO8Ql
	6R3Pen4GEzoAq5Z5IYbRmK9X8GbWp11JMUax3C6YZQcgKp0oV2kdloHJT4TyRn468pG3U4
	6RpPPf/LblmS6b8xJhQrAA+gK+XWJKLkSr2UDnP6rv368GYPVa3lpogP/1qaEP2HyprF2v
	tA6PL5qcvx2ENUegGy8vz5QBg+9qYoEAO6NKwVryzi3KR83DTfAkiMN+G19X0LhxjB962C
	3eH/LAtuwHhYSH+mXeXu4cwQvscOO2+b2ffre9Zt0VmkqFysDHuPcKmqYY2aIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752868689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gZXaF02BaMGEoDKKj0szmJ3qgP0vJ7qLHJvSby6+PbA=;
	b=eZbzVf33zVnbdFbqtaR9jISb4DEhqSATbOj1q4UwQ/OBFFqkCgUMlu6hcTLjaMSI1xTT1s
	hdvyBJO0LDIuNdCA==
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
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
Subject: [PATCH v3 0/1] x86/hyperv: MSI parent domain conversion
Date: Fri, 18 Jul 2025 21:57:49 +0200
Message-Id: <cover.1752868165.git.namcao@linutronix.de>
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

This series converts the x86 hyperv driver to implement MSI parent domain.

Changes in v3:

  - Drop the merged patch

  - Rebase onto hyperv-fixes

 arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
 drivers/hv/Kconfig          |   1 +
 2 files changed, 77 insertions(+), 35 deletions(-)

--=20
2.49.0


