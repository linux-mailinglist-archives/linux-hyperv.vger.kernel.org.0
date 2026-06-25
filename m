Return-Path: <linux-hyperv+bounces-11671-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GcjTMKFoPWoQ2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11671-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:42:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C26C7F3F
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:42:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=eK3igkyL;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11671-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11671-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73F8731828BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DCB3EE1D6;
	Thu, 25 Jun 2026 17:35:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337683ED135;
	Thu, 25 Jun 2026 17:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408907; cv=none; b=GlBZw3lKG997DadacBaL2pgxOqNzMosky6pvw9LKK01GAaEz2j/HWlqcObM2EefxAlY/CbERfLTWU3youH8QbpgAodHQOcMihr2FDXMI8RizeXLoQWrx9jSzYI/I4RSBBTYpUa4OXhW/kI4F/7sZCCw8MbaoVoWg5oUjwrHWNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408907; c=relaxed/simple;
	bh=JYWvCMIuiuJSlHm3SgpwnMmRMLPNJ6XWNO6s28ejWO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8l3ayOtvP+tXwhQawiqgaBwUwH599mZILS0BABUqY2sPNMioCK40e/+YfeGar3a6nIl8La4BUg8N+nB51m07UfCKxeo6Nt1MEE9SI9mawNajl21jNHbbP5PI4WKEE1uQJjyT1pfJ6J/zuaehFeiafSQBCSuwtlYNEMxW+GqZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eK3igkyL; arc=none smtp.client-ip=13.77.154.182
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1B0420B7167;
	Thu, 25 Jun 2026 10:35:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1B0420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408900;
	bh=nohWA6Z3QOs8Euk83tp6VSWyE7ASO/iSFcpEAB1p3Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=eK3igkyLatBZ6Tk0y7WVi6+UeBtq5AXuE6onb51ImsVboRJaZbX9dPtZvW2yEgJgd
	 EHMc4bljt1luJvOB8uTWVADhy3oWB+vauUbKMO6NwyBL/PRm+TYrFEPGPJOPlxPJEj
	 TFFTc8l7mX2H9x+KoW16zMM245E89V0cVM4ZEJCg=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [PATCH v2 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Thu, 25 Jun 2026 10:34:54 -0700
Message-ID: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11671-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,arndb.de,redhat.com,vger.kernel.org,lists.infradead.org,outlook.com];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:mhklinux@outlook.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B0C26C7F3F

Realms (CoCo VMs on ARM) require host calls to be routed through the RMM
(Realm Management Monitor) via the RSI (Realm Service Interface). This
series implements most of the necessary changes to support Realms on
Hyper-V.

One required change is not included in this series. The two buffers
allocated via vzalloc() in netvsc_init_buf() cannot be decrypted in
vmbus_establish_gpadl(). Currently only linearly mapped memory can be
decrypted. See my RFC patch [1]. I will implement the accompanying netvsc
changes based on the feedback I receive on that patch.

This patch series was tested by booting a Realm on Cobalt 200 running
Windows. I decreased the buffer size and used kzalloc() in
netvsc_init_buf() in my testing as a workaround for the issue mentioned
above.


Changes since v1 [2]:
  Patch 1: Add explicit padding to the RSI host call structure
  Patch 3: Change from a per-cpu pointer lazily allocated to an array
             of host call structs indexed by cpu id
  Patch 4: Align input_page + output_page allocation to PAGE_SIZE since
              that is the smallest unit of memory that can be decrypted
           Remove KSAN tags before passing address to set_memory_decrypted()
             since __is_lm_address() does pointer arithmetic.
  Patch 5: Add a helper function to reduce repetition
           Check for NULL before indexing into host call array

[1] https://lore.kernel.org/all/20260521205834.1012925-1-kameroncarr@linux.microsoft.com/
[2] https://lore.kernel.org/all/20260609181030.2378391-1-kameroncarr@linux.microsoft.com/

Kameron Carr (6):
  arm64: rsi: Add RSI host call structure and helper function
  firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
  arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
  Drivers: hv: Mark shared memory as decrypted for CCA Realms
  arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
  arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms

 arch/arm64/hyperv/hv_core.c       | 155 +++++++++++++++++++++++-------
 arch/arm64/hyperv/mshyperv.c      |  42 +++++++-
 arch/arm64/include/asm/mshyperv.h |   4 +
 arch/arm64/include/asm/rsi_cmds.h |  22 +++++
 arch/arm64/include/asm/rsi_smc.h  |   7 ++
 drivers/firmware/smccc/smccc.c    |  41 +++++++-
 drivers/hv/hv_common.c            |  17 +++-
 include/asm-generic/mshyperv.h    |   1 +
 8 files changed, 249 insertions(+), 40 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4


