Return-Path: <linux-hyperv+bounces-8780-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDn2C8e3jGnlsQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8780-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:09:27 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897A7126706
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DA7330125C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 17:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C4534678E;
	Wed, 11 Feb 2026 17:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="b0KKEhPu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E083451AA;
	Wed, 11 Feb 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829668; cv=pass; b=o3oeqQ9j9I3+NrPeDCnx82ISdW7gdFoCu5+PKWCBCq/a3TZ1vAmme1+gtTrGPWm2gJlJC4nOWl6aKocsfDS3Nu71ipABltbYSwMlss+uWVEWe5hw4I5k2yJfBE9YwBLqItNqcf5krH9TbXyrNsdPRsfXwaxdseRbRLcWmHoipbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829668; c=relaxed/simple;
	bh=fWpVdhuTeexC17n59I4fuyIXuUhu2VjVwti28lSFJhM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RmQdPfVLM1+SVl23B4xq9bFcOGlIeTA4a/dANmyoBbsD56Td3JFhddZaZKmfDvu8K2jkCjCuz2OJ46RmCbHtpqcNRdyVNMokGKYLQa2oGeWrfTg9zB39a1PHiFq3grmUXWUTrJsjSO3xWkgTzuXxf8zzcyQRjghXixpg2ZUsx0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=b0KKEhPu; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770829661; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VQ6cwYpaB3mDYTzo8xoPSuASO7oPszriSCjYxPyYqZu/X5ClYJPx6vV9fP5QblRiQTpnqv2hlVJhluedteVgK2H3FLAWVYSoCorP5t06mfXyCLcP2GrHNWtA6nizpyKl8sjjhY32m0rX62sYlNCh79nxNb4R9dBuKS6jvmlMWuc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770829661; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=k+SzAtonNHls7MbH5BRkJEfYTpOjI7yccIzDGfkcPAs=; 
	b=hF2EJbk6aSVHcaAsnbRvatOa1EoISxptAO1FKuG4rw39gXstWjma4aaYm4hFHWBbbd20Xw0Lr4uEU5FFNJZpYf5ykCb8KIz77Olz+M7IwqE6weOa3uwjTlxYe6Zy+X6ZnRmY47AJkcAXBPUtf7eXriKTUV83N00TLtO9SDtE8VQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770829661;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=k+SzAtonNHls7MbH5BRkJEfYTpOjI7yccIzDGfkcPAs=;
	b=b0KKEhPuZKxInZeO5TwJccCl4fY/Fp0lHmGkqOGNYdjkQqxtvpYr9GorPjARycg7
	40oPPGBOs/3tq4VmU50w346Ru2UbiWGr9IW3s3HN49tMoYji46rnBwGowtEFMBc8sHl
	MSbEEaYvZD5DUzUrpVrTZ5bFirI/QdeTpvczC7qY=
Received: by mx.zohomail.com with SMTPS id 1770829658660312.7350345157033;
	Wed, 11 Feb 2026 09:07:38 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v4 0/2] ARM64 support for doorbell and intercept SINTs
Date: Wed, 11 Feb 2026 17:07:26 +0000
Message-Id: <20260211170728.3056226-1-anirudh@anirudhrb.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8780-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:mid,anirudhrb.com:dkim,anirudhrb.com:email]
X-Rspamd-Queue-Id: 897A7126706
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the hypervisor exposes a synthetic register that can be read
to find the INTID that should be used for SINTs. This INTID is in the
PPI range.

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
 drivers/hv/mshv_root_main.c |  59 ++----------
 drivers/hv/mshv_synic.c     | 181 +++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |   2 +
 4 files changed, 181 insertions(+), 66 deletions(-)

-- 
2.34.1


