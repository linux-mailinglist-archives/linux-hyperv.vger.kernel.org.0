Return-Path: <linux-hyperv+bounces-8951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kl5A+lenGkUFQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8951-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 15:06:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63F177BA9
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C1F43021E72
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45DC277029;
	Mon, 23 Feb 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="hdFxmx6D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13DB26E6F2;
	Mon, 23 Feb 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771855337; cv=pass; b=GvbjLOunocvtFChNZwP6nJHUfrdE5DXkT+kxxQAk1I45T+k9G5BwSf6xVxAtmirsTbvetT/kCg82TMxoIlEtGG3uoEtG0zZ9iUPMKomgyOCJ17l1Ksi6ZRe7DQp1l0vUM8oykYSNXJ2mWiIbQ0JVQvluoYGSR3bFshEJadvXdRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771855337; c=relaxed/simple;
	bh=SzNjSlKOgUQZLOg/hBEmuU6ov6JB/Ri1R+qtlZbH72Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktt1twvYDhkQcE71yxK91M+xnBfP6NTGHU8xPJBTiXEkSQ1u0gVnkBdrjDvaLUqhM8TIaBGief9aZIpadwM7Ba6dlPWpSZ76AGItV3rBFn581/ym1jqztY7vu5FXQpVeeggEqMy5XnnKx6FM28KoieAPfhKP5T+KsGeyacE+3Mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=hdFxmx6D; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1771855329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=N+J4li4eK7i4gn9phYxZJkpjyG6GMBLT3oizTZWIddjkLjzq+f9WzdDdKHkLVf2V4gAlVGNbqwVSDlIyl85b3B1NgZPW3284WWqTX2eBW4ty51Oet2Lc7L1LGYLBkzH+YrU/YblgIDhzbiXrVgmtSh0la5u/wgVHEZz67DCGDl0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771855329; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tu5x9whB/DLOkNOxE3OZo/8olqk5MmoZIRHVY3kDhGw=; 
	b=aAmC7OhDEA7SlxgJrBQFiCXOAressDCtdRGLo7EqIoyrFKm947EAO6wj40symhvdkN4UijSJJzXW+ZQ1JffH/Rq65Zr5sa8fK9uykt5CIbE8RouCrr9NC1sAGh7hY+IEuOZK+6BoJz8degF0cxfqv/L2I8EfWQ2ybDTwjCNwO/I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771855329;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=tu5x9whB/DLOkNOxE3OZo/8olqk5MmoZIRHVY3kDhGw=;
	b=hdFxmx6DYAZrjYDgTFFr2aESKBP8/QWekbM519w2tTGCuz6yCDSsPdgEkQFMsG6C
	kZEcq5y+vSgZA1ZaqcnESXuFevUOwCWqjVPzwjWctMOhsr3D/Vf39sjNFZrkUz9ushV
	9c3+G6NFBqKqWALSqp7MqcEWkqYQ4JaQYB2Q0UG4=
Received: by mx.zohomail.com with SMTPS id 1771855327418775.6402218655211;
	Mon, 23 Feb 2026 06:02:07 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v5 0/2] ARM64 support for doorbell and intercept SINTs
Date: Mon, 23 Feb 2026 14:01:57 +0000
Message-Id: <20260223140159.1627229-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8951-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F63F177BA9
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the hypervisor exposes a synthetic register that can be read
to find the INTID that should be used for SINTs. This INTID is in the
PPI range.

Changes in v5:
  - Better align with coding-style.rst guidelines.

Changes in v4:
  - Hypervisor now exposes a synthetic register to read the SINT vector
    instead of using an ACPI platform device. So make changes to accomodate that.

Changes in v3:
  - Moved the hv_root_partition() check into the reboot notifier
    to avoid doing it multiple times.

v2: https://lore.kernel.org/linux-hyperv/20260202182706.648192-1-anirudh@anirudhrb.com/
Changes in v2:
Addressed review comments:
  - Moved more stuff into mshv_synic.c
  - Code simplifications
  - Removed unnecessary debug prints

v1: https://lore.kernel.org/linux-hyperv/20260128160437.3342167-1-anirudh@anirudhrb.com/

Anirudh Rayabharam (Microsoft) (2):
  mshv: refactor synic init and cleanup
  mshv: add arm64 support for doorbell & intercept SINTs

 drivers/hv/mshv_root.h      |   5 +-
 drivers/hv/mshv_root_main.c |  59 ++---------
 drivers/hv/mshv_synic.c     | 189 +++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |   2 +
 4 files changed, 186 insertions(+), 69 deletions(-)

-- 
2.34.1


