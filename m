Return-Path: <linux-hyperv+bounces-9897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DuBLFU2zmmAmAYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9897-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:26:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC35B386E46
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Apr 2026 11:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48FD3302572E
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Apr 2026 09:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43D43876DA;
	Thu,  2 Apr 2026 09:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pD3FSHRv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PTaVefmb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="00grH+7I";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZqrP0jGa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC4390217
	for <linux-hyperv@vger.kernel.org>; Thu,  2 Apr 2026 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121814; cv=none; b=bWAB9FXn5evzBur9NApD4GokZdg615A66uGhP2B9uKDD0OqJlGt+71mHUEWxqEJwdxxv3q8JFJL6+mOunOs03yHWbjSUji61JUsJt4K/3IUnWFZmbUJ9xh7736aZoZUFKDNY6d74jTdo05JwoDaWdkxX5g8GThRtREvt86AQp/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121814; c=relaxed/simple;
	bh=pPZoSFs1N2nIBD7aCCLIJozgu5AuBlUOSzzkwtYKzRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxJtiyxMNQD8B+48+HFD7/DWjAjKFRXv49o3oqXPv0h+kcpNmXeS7AUOQfwQYeDVPlZojjRHBIehOJPs9jLw4ChhIvomteGBe/gRzTkyr2AE/ILXJGRwmV8T8nkMhgdzeI92FcRofmF9iOGjXqLgEXe09spjwVKrhWDg5mZNb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pD3FSHRv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PTaVefmb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=00grH+7I; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZqrP0jGa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E489C5BD96;
	Thu,  2 Apr 2026 09:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfrLgokIg3L0iceqJ6PsoKUIoDRPjoCqB2eCvr3lsRs=;
	b=pD3FSHRvM0KZAHAOQzoqZpc+gAB8qOmUGFx02vmEpApKvrFID7BzoB7TPc3wdcwT3mrFFv
	URChAye1Sd36sVMkni5Fou36URn3wOlo62N31/IBfha88WqOWg7DGiLsZ0FQlFmRRwTK8m
	F4AOhP0p9Xff20ZAHfCNR7XfSfyGeSw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfrLgokIg3L0iceqJ6PsoKUIoDRPjoCqB2eCvr3lsRs=;
	b=PTaVefmbBpYwy+OsrLt0KtkbJxoehAWVJ3zMjh1XpamKNNQ6S1ckCoHIAvNMOg9bkFHm44
	eYmUjrSdAr+kOyDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775121791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfrLgokIg3L0iceqJ6PsoKUIoDRPjoCqB2eCvr3lsRs=;
	b=00grH+7I/DTkU2uwMtWbrrlw3bKOhylBOG+KO7sk7gu28zSN2VPONMNt/jMEb3RqGrzJQE
	YdRpcSMa0dBaPmMC4P3c6amJcPq0Qjk3DG4yNcl+WpjvSiHAm4vuvxU1Efwq5AYCtldDYr
	GJ2zpKwo1QdUuwkIcvCQu70TTByUwwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775121791;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfrLgokIg3L0iceqJ6PsoKUIoDRPjoCqB2eCvr3lsRs=;
	b=ZqrP0jGahPdOSlrrW3s4HNbA3pcA8w1X2aA1Zb9lvXkdfLuWAd7c+cwB+R2u9grKNw5DKy
	FrkHrqUyh+v9jfBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55E3B4A0B0;
	Thu,  2 Apr 2026 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MKK/E381zmlVYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:11 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 2/8] firmware: efi: Never declare sysfb_primary_display on x86
Date: Thu,  2 Apr 2026 11:09:16 +0200
Message-ID: <20260402092305.208728-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9897-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,arndb.de,kernel.org,linaro.org,xen0n.name,linux.intel.com,gmail.com,ffwll.ch,microsoft.com,gmx.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: BC35B386E46
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The x86 architecture comes with its own instance of the global
state variable sysfb_primary_display. Never declare it in the EFI
subsystem. Fix the test for CONFIG_FIRMWARE_EDID accordingly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: e65ca1646311 ("efi: export sysfb_primary_display for EDID")
Cc: kernel test robot <lkp@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/efi-init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 5a595d026f58..6103b1a082d2 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -60,7 +60,7 @@ extern __weak const efi_config_table_type_t efi_arch_tables[];
  * x86 defines its own instance of sysfb_primary_display and uses
  * it even without EFI, everything else can get them from here.
  */
-#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON)) || defined(CONFIG_FIRMWARE_EDID)
+#if !defined(CONFIG_X86) && (defined(CONFIG_SYSFB) || defined(CONFIG_EFI_EARLYCON) || defined(CONFIG_FIRMWARE_EDID))
 struct sysfb_display_info sysfb_primary_display __section(".data");
 EXPORT_SYMBOL_GPL(sysfb_primary_display);
 #endif
-- 
2.53.0


