Return-Path: <linux-hyperv+bounces-10039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hUyWDR+I1GmyuwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10039-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 06:29:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F113A9B1C
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 06:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6828E3014C74
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 04:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7D02D594F;
	Tue,  7 Apr 2026 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM7GEDGm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE83923EAB7;
	Tue,  7 Apr 2026 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775536153; cv=none; b=TnMptijslEu86s0MtG9fCUZDl5UUNS/wYw3ufZWOpHnctAkwXeYHUToSoliWGs801wI1BAMsf5+pudgUX5XwQAIPtxVh5S+3nrS7S1y2KoT2GXgzh4sF935lYWFDBVSKykSiSuCUbqafkzsZEV+IQwzT11okaqymXJadlg/Ka6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775536153; c=relaxed/simple;
	bh=E29jiuxKtMJc3Kqj3J5kLEl5FOK+H5PAxScGEVW4NZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZgonLzrVLGjokj1xwEnp6w1LiPggDNbF3E/5/d7jiTU+eV3UUR1d31qljZBjMHMyoeUyalQTZm+K2NpGl/5UEAzt7um/lpCtkHZJvJoUmXbASaEc9IQkE9f2H34Kw+6GKQVAII0kbNynvYyGQvwQ+Z4JDVTE8r4hX/ZUE0UI/no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM7GEDGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C31C19424;
	Tue,  7 Apr 2026 04:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775536153;
	bh=E29jiuxKtMJc3Kqj3J5kLEl5FOK+H5PAxScGEVW4NZY=;
	h=Date:From:To:Cc:Subject:From;
	b=pM7GEDGmxmy49eqmqYWQQjfgnkmlyRj/Sx7MwQqHjLZtPt+M0C+7L9dFcR57x5BQW
	 mEwCmJ2A6OU/+Od8HN8sP1lbVodyctZ8o+f0Kb1Mb0GzOPLkag8//FbaUyjoCAjXl3
	 pSCk4jcP+eSMuvH2aEa9x2hl+UEajDKjZ8NxxzSpNbSZJn9j/2bf9PuGjUEYzK1E1O
	 Yc2TuhUVB/tcPHgmf+DBTqI1+WRmJDWKWVRoNf0kwgv11zs02nWe1OmU9YDA3AbHRr
	 E+W2tYKTaHX7m7UkmIRUPHraZSl5KozJMMfrDeJeADRVz/RpWo3hFSYSJGZYUkmWuE
	 pq7fUFxClpRSw==
Date: Tue, 7 Apr 2026 04:29:12 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v7.0-rc8
Message-ID: <20260407042912.GA1012143@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10039-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20F113A9B1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Linus,

The following changes since commit c0e296f257671ba10249630fe58026f29e4804d9:

  mshv: Fix error handling in mshv_region_pin (2026-03-18 16:18:49 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260406

for you to fetch changes up to 16cbec24897624051b324aa3a85859c38ca65fde:

  mshv: Fix infinite fault loop on permission-denied GPA intercepts (2026-04-04 05:25:53 +0000)

----------------------------------------------------------------
hyperv-fixes for v7.0-rc8
  - Two fixes for Hyper-V PCI driver (Long Li, Sahil Chandna)
  - Fix an infinity loop issue in MSHV driver (Stanislav Kinsburskii)
----------------------------------------------------------------
Long Li (1):
      PCI: hv: Set default NUMA node to 0 for devices without affinity info

Sahil Chandna (1):
      PCI: hv: Fix double ida_free in hv_pci_probe error path

Stanislav Kinsburskii (1):
      mshv: Fix infinite fault loop on permission-denied GPA intercepts

 drivers/hv/mshv_root_main.c         | 15 ++++++++++++---
 drivers/pci/controller/pci-hyperv.c | 12 +++++++++---
 include/hyperv/hvgdk_mini.h         |  6 ++++++
 include/hyperv/hvhdk.h              |  4 ++--
 4 files changed, 29 insertions(+), 8 deletions(-)

