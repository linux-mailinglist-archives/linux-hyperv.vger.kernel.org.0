Return-Path: <linux-hyperv+bounces-11527-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /MpIGFZUJmq2UwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11527-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 07:34:14 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E49652D54
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 07:34:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KFe97ohi;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11527-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11527-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD84030027D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 05:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C2A2BE7A7;
	Mon,  8 Jun 2026 05:34:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCA11B6D1A;
	Mon,  8 Jun 2026 05:34:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896850; cv=none; b=D5J+HnGFVqC0VtlwFjdw3t84vs3gk25oQltHLa2ifKFv8cjXyNhEtACXHXCpJ78kc03iy5ZAbakiXkHDKqka7j77YnZEY2Dw7ZMEVnCC2Hyp0D90lN7/yAwVOoON9QsGhIuYFSvgSYhoX6RzHD1y5lHq2ofck6zUWJVKKc8Uqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896850; c=relaxed/simple;
	bh=FCLIriCCmgcWIax3D5Xc9jpREXVaX7xezXU5nw9frZY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rcZYr9nfwkkpM3cwd/2oHdvMv1n3Lp4AW4EZFTLia+cQyvtuaHMZr0MCSErz+FdNzq5eRUgucwhtDyli8xvPAP31fy7UXz3greD4Q9sPqWUbO4vacXs3sRcweXYMfaX55tdbzAbx3UoBfkCXaSH1W2FNIN8Bw4nOAz6u/jmxWhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFe97ohi; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633631F00893;
	Mon,  8 Jun 2026 05:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780896849;
	bh=JVWy71YIBt9P1P/WlBP4QVyvzsjWIZeo2ijhUIVAcyA=;
	h=Date:From:To:Cc:Subject;
	b=KFe97ohiQkfWcBZjdYHWQgn3oLPsLGjFLqNsc71i9wWxh2WmybXPZntyKVaw0qm8K
	 skWycwI+NgBk5ac5zDlEsWJ/fKmvX9YKH4jr2gyxqJRIBbxuN5/+u0JSOLmdBaSfyB
	 J65mq9s7FY437SFGDZ3aWA7cHEgenU6/mT72A05WvobxfnxPzTZ3yGaWr/3eBzvNsh
	 pcLjXHJhB3rzHytMNf/7GvaZSrX8U17Ew/ywSdTuNecM+l3vQmHSbAT1jJt9q4ImEp
	 UnluSOAa/3C2N1YqQVg2EVhHJNWM9z/snBy2zAu2B+uGZgqwXXCyzKpi6KpIcCQvPG
	 79HpuDzaQFEzA==
Date: Sun, 7 Jun 2026 22:34:08 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v7.1-rc8
Message-ID: <20260608053408.GA1541576@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11527-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:wei.liu@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C5E49652D54

Hi Linus,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260607

for you to fetch changes up to 98e0fc32e53dd62cd38a0d67eaf5846ae20078cc:

  mshv: support 1G hugepages by passing them as 2M-aligned chunks (2026-05-27 15:30:15 -0700)

----------------------------------------------------------------
hyperv-fixes for v7.1-rc8
 - MSHV driver fixes from various people (Anirudh Rayabharam, Can Peng,
   Dexuan Cui, Michael Kelley, Jork Loeser, Wei Liu)
 - Hyper-V user space tools fixes (Thorsten Blum)
 - Allow VMBus to be unloaded after frame buffer is flushed (Michael
   Kelley)
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (1):
      mshv: support 1G hugepages by passing them as 2M-aligned chunks

Can Peng (1):
      mshv: use kmalloc_array in mshv_root_scheduler_init

Dexuan Cui (2):
      hyperv: Clean up and fix the guest ID comment in hvgdk.h
      Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on Gen2 VMs

Jork Loeser (3):
      mshv: limit SynIC management to MSHV-owned resources
      mshv: clean up SynIC state on kexec for L1VH
      mshv: unmap debugfs stats pages on kexec

Michael Kelley (3):
      Drivers: hv: vmbus: Provide option to skip VMBus unload on panic
      drm/hyperv: During panic do VMBus unload after frame buffer is flushed
      mshv: Add conditional VMBus dependency

Thorsten Blum (2):
      hv: utils: handle and propagate errors in kvp_register
      hv: utils: replace deprecated strcpy with strscpy in kvp_register

Wei Liu (1):
      mshv: add a missing padding field

 drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |   5 +
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  15 +--
 drivers/hv/Kconfig                          |   1 +
 drivers/hv/channel_mgmt.c                   |   1 +
 drivers/hv/hv.c                             |   3 +
 drivers/hv/hv_kvp.c                         |  27 +++--
 drivers/hv/hyperv_vmbus.h                   |   1 -
 drivers/hv/mshv_debugfs.c                   |   7 +-
 drivers/hv/mshv_regions.c                   |  29 +++---
 drivers/hv/mshv_root_main.c                 |   2 +-
 drivers/hv/mshv_synic.c                     | 156 ++++++++++++++++++----------
 drivers/hv/vmbus_drv.c                      |  54 ++++++++--
 include/hyperv/hvgdk.h                      |  10 +-
 include/hyperv/hvhdk.h                      |   1 +
 include/linux/hyperv.h                      |   7 ++
 15 files changed, 207 insertions(+), 112 deletions(-)

