Return-Path: <linux-hyperv+bounces-9629-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEcCO/DXvGmd3gIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9629-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 06:15:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7992D5EC8
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 06:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CD883034E04
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 05:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93B32BDC2A;
	Fri, 20 Mar 2026 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TmDKKCAh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657D13B58C;
	Fri, 20 Mar 2026 05:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773983726; cv=none; b=pegOyjKI9U0krAgR/dWCM9fbPMKPOJ1w8Acf3C0a1iTyZ8JhMCXU7rzSkaxCX5pWIrMzVS0kGCDoMYruGoHQksv1+1RXyErFO89dMF5YRz9Fa55aB+IzoxcsqfcpOo0UgmJZFofZvLadR8Es3cSiq61Gva5j6L21lGE2Zz3rIDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773983726; c=relaxed/simple;
	bh=wy+oYU5Sp7HyWBw47MQRpRuNakTHSYA2hxh9idEWcPg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mjkdo23fIftxND5GUNKZvywB4/dA9u6/sYw/Z/NFqHwIk1VisLkyxP9wiGrM47/kZI/kbnETyei3mpx5kGGx5SNxAWGAx0b5Jrli2LGo8LeLV9qjdCAHcLDpMiPPmhOqG3DGpdxPN9U3RHQnC6bRBKUn1i4F1whZ+VpajvJfeEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TmDKKCAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135EEC4CEF7;
	Fri, 20 Mar 2026 05:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773983726;
	bh=wy+oYU5Sp7HyWBw47MQRpRuNakTHSYA2hxh9idEWcPg=;
	h=Date:From:To:Cc:Subject:From;
	b=TmDKKCAhSDMAgicONTRgTfKzzWMsNSz/tv+Hq9XGkkbgPi7wu7aAeNtk1EnBUNlsC
	 bWuKnn/bTjVmELa4PC2Ia+gLKYx0REuArzZVRqm1qsZPpZzeVMe/ga/jM+iKbws+Xu
	 B3kTHhQ+YTl5sd64hs3XM+0eFtwu+ngqk61wtgjkt82nQY9BQEa58eTU7BpuntEJkL
	 sYuGDkyof5PwbL9qUiMKzoRAlr/nA7SSEb/l7216buXS9P19zI5Q3aihaBTY2TRI0s
	 M31EvYxB22Qlqr0T5HZet5hPe4KVxV8yHqEQXboGE7bX669Lk+WIVATygNIWW/b7ol
	 qVjOnNd+2PLRw==
Date: Fri, 20 Mar 2026 05:15:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v7.0-rc5
Message-ID: <20260320051524.GA759166@liuwe-devbox-debian-v2.local>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9629-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.934];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 5D7992D5EC8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260319

for you to fetch changes up to c0e296f257671ba10249630fe58026f29e4804d9:

  mshv: Fix error handling in mshv_region_pin (2026-03-18 16:18:49 +0000)

----------------------------------------------------------------
hyperv-fixes for v7.0-rc5
 - Fix ARM64 MSHV support (Anirudh Rayabharam)
 - Fix MSHV driver memory handling issues (Stanislav Kinsburskii)
 - Update maintainers for Hyper-V DRM driver (Saurabh Sengar)
 - Misc clean up in MSHV crashdump code (Ard Biesheuvel, Uros Bizjak)
 - Minor improvements to MSHV code (Mukesh R, Wei Liu)
 - Revert not yet released MSHV scrub partition hypercall (Wei Liu)
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (2):
      mshv: refactor synic init and cleanup
      mshv: add arm64 support for doorbell & intercept SINTs

Ard Biesheuvel (1):
      x86/hyperv: Use __naked attribute to fix stackless C function

Mukesh R (1):
      mshv: pass struct mshv_user_mem_region by reference

Saurabh Sengar (1):
      MAINTAINERS: Update maintainers for Hyper-V DRM driver

Stanislav Kinsburskii (2):
      mshv: Fix use-after-free in mshv_map_user_memory error path
      mshv: Fix error handling in mshv_region_pin

Uros Bizjak (3):
      x86/hyperv: Save segment registers directly to memory in hv_hvcrash_ctxt_save()
      x86/hyperv: Use current_stack_pointer to avoid asm() in hv_hvcrash_ctxt_save()
      x86/hyperv: Use any general-purpose register when saving %cr2 and %cr8

Wei Liu (2):
      x86/hyperv: print out reserved vectors in hexadecimal
      Revert "mshv: expose the scrub partition hypercall"

 MAINTAINERS                    |   4 +-
 arch/x86/hyperv/hv_crash.c     | 118 +++++++++++++-------------
 arch/x86/kernel/cpu/mshyperv.c |   5 +-
 drivers/hv/mshv_regions.c      |   6 +-
 drivers/hv/mshv_root.h         |   5 +-
 drivers/hv/mshv_root_main.c    |  93 +++++---------------
 drivers/hv/mshv_synic.c        | 188 +++++++++++++++++++++++++++++++++++++----
 include/hyperv/hvgdk_mini.h    |   3 +-
 8 files changed, 270 insertions(+), 152 deletions(-)

