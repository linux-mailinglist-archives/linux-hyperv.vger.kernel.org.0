Return-Path: <linux-hyperv+bounces-8981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPXgE6nunmk/XwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8981-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:44:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E53FC197862
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B507430168A0
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 12:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A855039281C;
	Wed, 25 Feb 2026 12:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="yKThe6Tq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6E1C84B8;
	Wed, 25 Feb 2026 12:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772023461; cv=pass; b=AFCgstLoHyHNlrGqZqw8nSg6N6iL1QYfWPv5CCOrArgPzitFiUCnJRy7WKO/Ah8GxGuKikQep8yY4TEA9/NyRDX18Fws1HAhOk5ZOLaPeGqenaIOqh5IHMRK5NHsm0oKjbO8t1r9RC+9Qx3YNFDl6WgdyzLFpnCcRizU+p/Fysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772023461; c=relaxed/simple;
	bh=YtwYRKN0OVvEkyRzX0EUuZVP/3Pp/ylxyGFcRVyJg3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QoFWm025sXy6S8z3DU6pFkDyiIO9RYF8XpBRv+Sm5S9LLDh6bAX7CL0tGAWD2kTY0DdJwIVC/5H/reQxh6rsiO8Gj3Ejt1mE/oI+caL6x3QUnpHauJhmlykzYmddxDhbbowdJFGVX6QQoJK/cTtWp4N0Fc9YYN2tuaR3DSzBNJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=yKThe6Tq; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1772023454; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XiutzXxYwE5OFvpbnFVG2LIjWxmCxjFg+NM3WKsMt1xSJt4ltyymuKVtP7Mj9p5EfE8KXt8wdc/o/4Y/V3WSHlrcJyU7nwA5CPAj+r2w4XzJ2Gh4tSc+pZMEEEn1BfWApHp2ZsA92ss6L4Q1zXQmTKXBVMo6pv5egC1zrWSfYU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772023454; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6CU7sLAvSKpJovvoXc/0kwypO9GJcrkXam+jnBByZZg=; 
	b=Ebi9AZHpEAhga3LQznPvsXpnbDTInETEiXYpnwCdYlhH8crWeCloSiW+CKjwB7bo8HcnEsCS8aR4O/JLDwJe4K37eOa1V7yiP1Ux02LtQerAsxQHNhihn7mleeluVXxqRVCMy+rQKThKmCVv9ObFE44tu+V+UZCy6m1boB1ikgM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772023454;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6CU7sLAvSKpJovvoXc/0kwypO9GJcrkXam+jnBByZZg=;
	b=yKThe6TqtHRSE53sufMseeMh6adNlRvJd8x8nGMMU0ADMd0MjGKGpuQrpS9KkYi9
	GQl0Hlwh4pmd9nikoBZLR/jrf6w8AOf/5+aYHt7F5oETfKogRARJvvFDLGkUcJVhfJR
	VHbJRsgy/rqsHWcDMPgw9/fCUgEdA1t0/KF6u9Jk=
Received: by mx.zohomail.com with SMTPS id 1772023452451360.6849253009426;
	Wed, 25 Feb 2026 04:44:12 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v6 0/2] ARM64 support for doorbell and intercept SINTs
Date: Wed, 25 Feb 2026 12:44:01 +0000
Message-Id: <20260225124403.2187880-1-anirudh@anirudhrb.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8981-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudhrb.com:mid,anirudhrb.com:dkim,anirudhrb.com:email]
X-Rspamd-Queue-Id: E53FC197862
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the hypervisor exposes a synthetic register that can be read
to find the INTID that should be used for SINTs. This INTID is in the
PPI range.

Changes in v6:
  - Rebase on latest hyperv-next.
  - Consistent init/exit & setup/cleanup function naming.
  - Pick up Reviewed-by tags.

v5: https://lore.kernel.org/linux-hyperv/20260223140159.1627229-1-anirudh@anirudhrb.com/
Changes in v5:
  - Better align with coding-style.rst guidelines.

v4: https://lore.kernel.org/linux-hyperv/?t=20260211170747
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
 drivers/hv/mshv_root_main.c |  64 ++----------
 drivers/hv/mshv_synic.c     | 188 +++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |   2 +
 4 files changed, 185 insertions(+), 74 deletions(-)

-- 
2.34.1


