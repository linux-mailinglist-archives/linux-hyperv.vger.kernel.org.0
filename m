Return-Path: <linux-hyperv+bounces-9893-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJZlFLc2zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9893-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:28:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E432B386E93
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8251130172C3
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4F538B7AD;
	Thu,  2 Apr 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gsm5A9Ww";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+OksCf8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gsm5A9Ww";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+OksCf8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBD38BF80
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121796; cv=none; b=LnIpyNKo/1BIGiwgZFOBvMXsvFv2/uroFzQpmKlhkVIpDgVDH5XZvYDjjlV94fuGSH4zC1I0FTTFVR+rCTGup/OEAQek8fH3vJOjYuSo9iygOiK1go8iWhBfsd6EjdknuS9PpWt/oDA2NSdQY7uMHwhL60tcBg1dvvQhdmuJQWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121796; c=relaxed/simple;
	bh=WDFGYZtyYLp+z0Rt0Kel9cVAj0zOatIGepwcVXk3ziw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNnjbZaY7tDrRhSjwhEmuuA1KTZVAD6Tpm44Ybv2DPclp8z3y59uXU3v8D09WsDrQdmI6cwLxYsQO9RKu2ipFpcHdAMc+RqiJUquHKYhqC4MMbgmosj7S+w5DzAThTM6r4w15kgFcFBYyOTILo77LvG4Ya+AYGbHPREw/M69cWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gsm5A9Ww; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+OksCf8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gsm5A9Ww; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+OksCf8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0F135BD6C;
	Thu,  2 Apr 2026 09:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kSnvgggqRkoalA14gFVa+si+vwQUWHJ4fW14t/f7Flc=;
	b=gsm5A9WwczrN8KBvtiNgHReeh6vzRdEDmvSkijVERMrM96Lrh6k+dyva2m3YxaelxhrbVJ
	KmhYowDyFSzzrxzl1OCQcxRSJIP4/VTXKA7fgnVL0rPfVQf2b6vPsCCk6n+DCc9xF6dLed
	n/+MIHFlpnr1oXZMTTwA7SkzEcD3ot8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kSnvgggqRkoalA14gFVa+si+vwQUWHJ4fW14t/f7Flc=;
	b=E+OksCf8Wp6yroWxHqGqPDGC0Wa+UhIKpl9J5/QANWV+4vcCfsixYIPCh8etEBI6NDxiIE
	Egm7Jn5mWLpqyeBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kSnvgggqRkoalA14gFVa+si+vwQUWHJ4fW14t/f7Flc=;
	b=gsm5A9WwczrN8KBvtiNgHReeh6vzRdEDmvSkijVERMrM96Lrh6k+dyva2m3YxaelxhrbVJ
	KmhYowDyFSzzrxzl1OCQcxRSJIP4/VTXKA7fgnVL0rPfVQf2b6vPsCCk6n+DCc9xF6dLed
	n/+MIHFlpnr1oXZMTTwA7SkzEcD3ot8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121790;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=kSnvgggqRkoalA14gFVa+si+vwQUWHJ4fW14t/f7Flc=;
	b=E+OksCf8Wp6yroWxHqGqPDGC0Wa+UhIKpl9J5/QANWV+4vcCfsixYIPCh8etEBI6NDxiIE
	Egm7Jn5mWLpqyeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07D344A0B0;
	Thu,  2 Apr 2026 09:23:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SQWwAH41zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:10 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	arnd@arndb.de,
	ardb@kernel.org,
	ilias.apalodimas@linaro.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	deller@gmx.de
Cc: linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/8] firmware: sysfb: Consolidate config/code wrt. sysfb_primary_screen
Date: Thu,  2 Apr 2026 11:09:14 +0200
Message-ID: <20260402092305.208728-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9893-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E432B386E93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The global state sysfb_primary_screen holds information about the
framebuffer provided by EFI/BIOS systems. It is part of the sysfb
module, but used in several places without direct connection to
sysfb. Fix this by making users of sysfb_primary_screen depend on
CONFIG_SYSFB. Fix a few issues in the process.

Patches 1 and 2 fix general errors in the Kconfig rules. In any case,
these patches should be considered even without the rest of the series.

Patch 3 makes CONFIG_SYSFB a user-controlled option, which gives users
more control over the configuration.

Patches 4 to 6 slightly refactor the sysfb code. The PCI helpers are
now in a separate source file. Support for relocating the PCI framebuffer
is now located in sysfb, where it belongs.

Patches 7 and 8 make earlycon and the firmware EDID depend on sysfb. Both
rely on sysfb_primary_display to work correctly.

Smoke-tested with bochs on qemu. Built with/without CONFIG_SYSFB enabled.

Note: vgaarb still guards sysfb_primary_display with CONFIG_X86 instead
of CONFIG_SYSFB. That works reliably and is left in place, as a change to
guard with SYSFB_SYSFB might affect non-x86 systems in unknown ways.

Thomas Zimmermann (8):
  hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
  firmware: efi: Never declare sysfb_primary_display on x86
  firmware: sysfb: Make CONFIG_SYSFB a user-selectable option
  firmware: sysfb: Split sysfb.c into sysfb_primary.c and sysfb_pci.c
  firmware: sysfb: Implement screen_info relocation for primary display
  firmware: sysfb: Avoid forward-declaring sysfb_parent_dev()
  firmware: efi: Make CONFIG_EFI_EARLYCON depend on CONFIG_SYSFB; clean
    up
  firmware: sysfb: Move CONFIG_FIRMWARE_EDID to firmware options

 arch/arm64/kernel/image-vars.h                |   2 +-
 arch/loongarch/configs/loongson32_defconfig   |   1 +
 arch/loongarch/configs/loongson64_defconfig   |   1 +
 arch/loongarch/kernel/efi.c                   |   4 +-
 arch/loongarch/kernel/image-vars.h            |   2 +-
 arch/riscv/kernel/image-vars.h                |   2 +-
 drivers/firmware/Kconfig                      |  38 ++++-
 drivers/firmware/Makefile                     |   7 +-
 drivers/firmware/efi/Kconfig                  |   3 +-
 drivers/firmware/efi/efi-init.c               |   6 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c |   4 +-
 drivers/firmware/sysfb.h                      |  24 ++++
 drivers/firmware/sysfb_pci.c                  | 132 ++++++++++++++++++
 drivers/firmware/{sysfb.c => sysfb_primary.c} |  70 ++++------
 drivers/gpu/drm/sysfb/Kconfig                 |   4 +-
 drivers/hv/Kconfig                            |   2 +-
 drivers/video/Kconfig                         |  19 ---
 drivers/video/fbdev/Kconfig                   |   5 +-
 drivers/video/screen_info_pci.c               | 110 ---------------
 include/linux/screen_info.h                   |   3 -
 20 files changed, 241 insertions(+), 198 deletions(-)
 create mode 100644 drivers/firmware/sysfb.h
 create mode 100644 drivers/firmware/sysfb_pci.c
 rename drivers/firmware/{sysfb.c => sysfb_primary.c} (90%)


base-commit: 5d36e6d54e963f0c1137aaf2249d2baa781f08c2
-- 
2.53.0


