Return-Path: <linux-hyperv+bounces-8560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EM5eBIk0eml+4gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-8560-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:08:41 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC32A524A
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBA2D3000738
	for <lists+linux-hyperv@lfdr.de>; Wed, 28 Jan 2026 16:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35DD3093C3;
	Wed, 28 Jan 2026 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="nc8owg5m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17529E0F8;
	Wed, 28 Jan 2026 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616314; cv=pass; b=D9LOrjqnW57LrPMjkcSCSR3WHFzM9Rp23rrOC+Bd3l3X/xRghtBTH3WREGF+d7k5w6NSd4eYABe6RszpQ6jJRS2EUtaQCMAdgk6UIS2QWhB5EKwEBaV0sDwY2HsQOTkJy7ZveI8wGY4rlx36XSMVAL1my/C2SeKI2GE/YqCBbz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616314; c=relaxed/simple;
	bh=mb+P0JqANf9kY1hOA8/+79p6iL/2KrGMdrJ0bDnQ9jE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WEhLsVWwvFWNsZziZ51C/cETLn4VRvym/fPO0hK+34fBClmGcKE20mrArgMyIlCypSvHVU5mPqb/J6huUCNQrjQPMMnPHWTI6WfnC9YwZVXixjF8+GhgLUci0BFkMSJXmI3jYSUoA7oSeOBDLMcV3GzG6KRRhMPRb+8rheeGqLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=nc8owg5m; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769616306; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F4qDZprC13sdbswjcxRi+Lx4l7Kc8Rkb3/bryjZk1gVHNbzowLTuttR9VkUfQylgwcx/7Q6KWN32EYwfNtmcYEa81FrMzFA/U6HIndB41o1zZyFjHIJ8Y319rFAen5bWwoUXfSOlFYV3zJXq/O1u5lQqEs0IJ8aO4KGsIrd9D9w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769616306; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EDlkrm5rVP9ihTA6xt/yRUpb89h3nGsKXfWyKYxK55c=; 
	b=PLVp60JALV+FEMdDpLKIHNAOlE2WQOddxf/Y3fQAQ78OqWzCxr0qfeYFlDdMdRkWcS3n8NyIhRaeKRtoLXC7gOqp7TIJjZEl2hRVeBm0W5Pt05+wf4ag01ZYMMp0W0k9sP7qnS7cDPk45Gx9LpPPvDUza+0cR7gyrtFEHfazRnM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769616306;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=EDlkrm5rVP9ihTA6xt/yRUpb89h3nGsKXfWyKYxK55c=;
	b=nc8owg5mKk+Be1EfPfk3hAGn23ehL08rbasbHTjo4vqqMWm78MuNqKIxKfHaHkM0
	cvtvEXAC1Ye/wDgFZ9Jju7JJ8T+oSjvBuA4QUog+w1jiWCtTFoAx2RxY2SVazg4CLKL
	IbXi43kxi+pqpezd/A7nM21+/pySQ/yQHfamdQ+Y=
Received: by mx.zohomail.com with SMTPS id 1769616304839692.0987143973513;
	Wed, 28 Jan 2026 08:05:04 -0800 (PST)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: anirudh@anirudhrb.com
Subject: [PATCH 0/2] ARM64 support for doorbell and intercept SINTs
Date: Wed, 28 Jan 2026 16:04:35 +0000
Message-Id: <20260128160437.3342167-1-anirudh@anirudhrb.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8560-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:email,anirudhrb.com:dkim,anirudhrb.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7AC32A524A
X-Rspamd-Action: no action

From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>

On x86, the HYPERVISOR_CALLBACK_VECTOR is used to receive synthetic
interrupts (SINTs) from the hypervisor for doorbells and intercepts.
There is no such vector reserved for arm64.

On arm64, the INTID for SINTs should be in the SGI or PPI range. The
hypervisor exposes a virtual device in the ACPI that reserves a
PPI for this use. Introduce a platform_driver that binds to this ACPI
device and obtains the interrupt vector that can be used for SINTs.

Anirudh Rayabharam (Microsoft) (2):
  mshv: rename synic per-cpu init/cleanup functions
  mshv: add arm64 support for doorbell & intercept SINTs

 drivers/hv/mshv_root.h      |   6 +-
 drivers/hv/mshv_root_main.c |  15 +++-
 drivers/hv/mshv_synic.c     | 156 ++++++++++++++++++++++++++++++++++--
 3 files changed, 164 insertions(+), 13 deletions(-)

-- 
2.34.1


