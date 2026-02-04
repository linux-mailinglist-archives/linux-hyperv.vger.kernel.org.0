Return-Path: <linux-hyperv+bounces-8715-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGHkKX6Gg2niowMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8715-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 18:48:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B320EB289
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 18:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DA530B069F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 17:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3134B438;
	Wed,  4 Feb 2026 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="w2z3sEko"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE30D34B1A6;
	Wed,  4 Feb 2026 17:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227050; cv=pass; b=EB607SBKbkD2g7a25m38wHkSPSOrVUuViFEsZtY1K4o5q8YbzFF7OZzTuox2kUYXYEZ9Rx55tHDMCt5xtxZVRpYZOCQz/hi/Qzt3uLLXAvcUQrivqYIO+WL82Ia2ZBEEJOmIuhD5e0JViqRFlYB0uDXU7oBesN1VpnNzifUskpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227050; c=relaxed/simple;
	bh=K/sslgxmUxJZ3QxT88ZPcVjRLIusP/X0av7X/iVGspo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EWWvRgpEyhFx67M9q0+iWAkMNGvgssujPEu0Ep6ivRJymPtcelqc0n0Uv9A3FxNTrlf/f2jZhv7S2/ftrnMYFc7/74TBclpwLiSDyiylFyEu3nHcDh/UghAvhoRZ8rPoqkfFh3MFFVQakvhP4fiQ9ypDUfQUoaQ4fYh2it7hWQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=w2z3sEko; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770227041; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CX5SgtvC3K2tkjNDtkzA7UtFD2Qz2mS7l8AokZ9GfwIgUdzcbf5osKNeEzkkdpEQxTDK1dexGmeS8Fvk8E62SzImhZglR6TF1r0v09/AG5IQUKUZu6opPzbp2gBmrFDsy1K/GwMqhStmexqdfTKZjZR13ytbuyox8DLoIOW2TuI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770227041; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6SLc+iImjZ5MTwVI/ESVjCwT85e6bdGvp8OjIZsbZcU=; 
	b=fEN5B8ILDG0sGfZAo6LOFi7bQu8VMD3EnxiBqFzCppVBXyiC/Nt1QGKuyFO0nW7hXSmi59yaY67Zj/qh0vhhoSYIMTHfrtKwAld3ZtFEGlfW6gcUiWVknP4MVtOflqsAjSR6ZwznZo2CMXvTkoQ0cDBPPG3mexb+HiSGYlZnSLY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770227041;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6SLc+iImjZ5MTwVI/ESVjCwT85e6bdGvp8OjIZsbZcU=;
	b=w2z3sEkohgx16ZAxGYbrj1XRjSY8ZFQZXhVWoOW4P3Kxl4dQ/qmGiwHzFgrF2Qag
	Gqo62KNhUqlVKV2PfoN46RrLI2HeoiJVz7Wd+giT2YtaKGPJzC7AxcmRzMY1Ic5UmvV
	RBWJiJGIDSPe5EiG6QOkpERiPzhWESWPJKJD+f0c=
Received: by mx.zohomail.com with SMTPS id 1770227040260955.8239598017486;
	Wed, 4 Feb 2026 09:44:00 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v3 0/2] ARM64 support for doorbell and intercept SINTs
Date: Wed,  4 Feb 2026 17:42:35 +0000
Message-Id: <20260204174237.1201153-1-anirudh@anirudhrb.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8715-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid]
X-Rspamd-Queue-Id: 3B320EB289
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the INTID for SINTs should be in the SGI or PPI range. The
hypervisor exposes a virtual device in the ACPI that reserves a
PPI for this use. Introduce a platform_driver that binds to this ACPI
device and obtains the interrupt vector that can be used for SINTs.

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
 drivers/hv/mshv_root_main.c |  59 ++-------
 drivers/hv/mshv_synic.c     | 232 ++++++++++++++++++++++++++++++++++--
 3 files changed, 230 insertions(+), 66 deletions(-)

-- 
2.34.1


