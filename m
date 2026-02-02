Return-Path: <linux-hyperv+bounces-8654-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N0TDp7sgGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8654-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:27:42 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B613D0295
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 19:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EFBD3003EED
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297552EC0A1;
	Mon,  2 Feb 2026 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="rV7DWYiq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B40F2EC086;
	Mon,  2 Feb 2026 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770056859; cv=pass; b=lKJvEtYNprR11/eHwFsmtTSpVRJqm3uxlZ3bcU0J95+EKFAJJa7VdBvgBfJ81kegI5HZuK+No02XHubMXXKntYAPuIbQdkLRSPTIXm5C8yPtNEMS1BETs+FhKHoiTgOnMn2vvQRnXWYg06tyyjAVyYM2KWLoM7P/2TJ8wYd0FvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770056859; c=relaxed/simple;
	bh=/lH1s/J43MWqBM4/eNpirgqCbqpEFmhLyHMANZI18dA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=owBACpLWwBGYZE+VzSXuaB+iCAVPhQOzYE+kMHV3WotzP8tc74IC9OGpU29ctRabF03E43qD61hfyaoL/Hy7+lhirk2yvgD4OJTG5iRlwYeJ2mj9F5m0wR5x8rBr9ow7lO0ouoiUpWX4LHuaI+LxbkC3dQ7nMYR4tNYs9AjdxHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=rV7DWYiq; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770056851; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DkOpp97KHNYE21TvYFSN/WgxyCLCaDXRuLkWSwVpFusfk6MbBVa9mnbAhHStAgeYr3giVsCKKBF4JMXUn2+cI/4x9WkqmVgoQYYTGv8Fi+MCvTBe4lpk0N+PQzd/kBUW29joKqq2gCLpDX+XHSi8PXmGrSSn7CT5MIE5x/jP90Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770056851; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C9xQj1K7HEVal9SQiJ5nturGPbWAbk3oKvGjpCk90aI=; 
	b=PLsrbJnnr8jaKi+qBqyldGtY7/uewKhqSJfXUBngrmBdKNeCa8rODRGPCYRx6XIJrTN9sEIBKjYRglbv056hBpxeB+Rv3zJUjo9iVA1+XMy87Rr6ZSYPEa24P9MejxZ8VwhuJqxukTeP8RisXvv4c7+nnVpq9I60/zGEdvxwLTQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770056851;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=C9xQj1K7HEVal9SQiJ5nturGPbWAbk3oKvGjpCk90aI=;
	b=rV7DWYiqXXUWeUYWfXa/nQbwzq1md0vFFeJOfMBexDvCBMGSUR/shB2TIexZFs4+
	ANLzFVpGLOUEiW72HjLAT2IXQRN+9lPMiGv0ptjCStPM1O73jckSbT8ow4evv8+Pvjh
	1LxtMbeXhDnz+UEkuXjUXgZ43m63dObCCICCJwRA=
Received: by mx.zohomail.com with SMTPS id 1770056848652354.2876457517199;
	Mon, 2 Feb 2026 10:27:28 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH v2 0/2] ARM64 support for doorbell and intercept SINTs
Date: Mon,  2 Feb 2026 18:27:04 +0000
Message-Id: <20260202182706.648192-1-anirudh@anirudhrb.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8654-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B613D0295
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the INTID for SINTs should be in the SGI or PPI range. The
hypervisor exposes a virtual device in the ACPI that reserves a
PPI for this use. Introduce a platform_driver that binds to this ACPI
device and obtains the interrupt vector that can be used for SINTs.

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


