Return-Path: <linux-hyperv+bounces-6005-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AAEAEA14A
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 16:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068C3178312
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Jun 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F03A2EAD0E;
	Thu, 26 Jun 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ew3SQMSn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AaEH+CvS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7C2E975D;
	Thu, 26 Jun 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750949265; cv=none; b=gdr/FqpYng8zQR+obTGq1MvOf4k5rns6rohW8dXxaiz0tr11vjNm8RPguzP1PpnlDBKR0tVBTisFgdRn6qAO84/v/hJulDEUHtHMfkE8rgm8Cd072wNYRK+rQ6SJfJgHV1W1+Dm9QrvFZ03t53lx1m6/RnWZaeSgY8qpxLE6Xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750949265; c=relaxed/simple;
	bh=l0Bjx6xeOY6vGLeKE2AfugFCBPsz6BZ9iRZpai6riIY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=caJpES829hr3VzpJpKu4MuTsRwGF26qiDESXa0lxsyVAWUUKkZc9wU74pZdBTtd4od1icTuEIDPUAVaNGCD7tNcrZUUOO59MmK7wu/vPTyIxLtKUEzvWBqzhxt+7LQ0pqhyOrzXSzUIIV0H7ubjYxbrMNxusN+68diQeGEGJopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ew3SQMSn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AaEH+CvS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750949261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6h/qxlxsCx80YdkBcq5sLfuMZS799e4CgM5xDqcKOBQ=;
	b=Ew3SQMSn5PpxPPFaq0LrkNgaY4LmWYsH5ODz9BxLBwnW5n7SP9v68qJU03f68qCKHhDPHp
	EJHMPDucsLXZqeebKndB2X8IEtomgKJTiavPY4D5eKI4CUWBPZwPTwgryjYZVS50s/zjq2
	8k4SfgHmjUUCO00Rq3Rh24bQNXqdZbn1fYFzqSDxrovsynUPAxRr58LvTjvHQDpiNJq8mD
	aLNwT81AY6D7C1D89UkqDV02U3N95bvLlH9YouGuRa7F1dm1q/Y6olORWCX+Y1mI4ELS90
	Wh06fx2GbJUyXGg/Z/Z2Ah8WQAwS00LyMfmEvtgamXm2u97ner/0BYkD/qKiSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750949261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6h/qxlxsCx80YdkBcq5sLfuMZS799e4CgM5xDqcKOBQ=;
	b=AaEH+CvShNcQvC0sAVIo2Q4AbhZJdRiawI54QYpBEq7uH8PeJWY8N9XyVCTvbF1/L3odBw
	oOXMQvGtaPh1MoBg==
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
Subject: [PATCH 0/1] x86/hyperv: MSI parent domain conversion
Date: Thu, 26 Jun 2025 16:47:25 +0200
Message-Id: <cover.1750947640.git.namcao@linutronix.de>
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

 arch/x86/hyperv/irqdomain.c | 107 ++++++++++++++++++++++++------------
 drivers/hv/Kconfig          |   1 +
 2 files changed, 73 insertions(+), 35 deletions(-)

--=20
2.39.5


