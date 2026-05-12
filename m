Return-Path: <linux-hyperv+bounces-10809-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DViNgR0A2rl5wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10809-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 20:40:04 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EC7527F12
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 20:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99FE93261FE3
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 May 2026 18:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC44366548;
	Tue, 12 May 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KOhaaKYo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19618349AF5;
	Tue, 12 May 2026 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609303; cv=none; b=i1XVWmBNH+G5SYSw2Jb+LgXTwWf3BkqjS5e2JvJuxwIfTrPncfKRIRXpxvH9nLMRlSOR0m0pW8deWR+b2BE0OFqnCU75ZtoxWVP8ds7rm7LUQxVsSXjgC03r+XxXbKhfvvcjHzrWxCLAMYC0acvJtxeE6k702jq2zJpxsDtTQfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609303; c=relaxed/simple;
	bh=GDCs8izwjVjaIQgsAzOQC1PLBBb47MPU6AsrUhc0Fq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nl6iA/n1uTsNX4K0SlV+AzSTcDEydbl1RqJzP09VidtSe/4+/E4NGqnPVmTZMxrHMvzZOZdi3QPfts3n+tgm1+CbG3sU+hHTCqQ8C2h+7TtngPvK2dLh1+hti9LJjy+3CLP63MFij0N7auguXBDUj8kh/ocu6b8WI4p9cNOqO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KOhaaKYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3098C2BCB0;
	Tue, 12 May 2026 18:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609303;
	bh=GDCs8izwjVjaIQgsAzOQC1PLBBb47MPU6AsrUhc0Fq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KOhaaKYo+A3y81RaX8ng4lYE/uGc2cZmsYtEhzrwKsSDTZKWKvPMTlLjFiCe6CBT1
	 LDrR3l4Sp0kUmr+o+Buv3OO6nnmKw+pYx5A/98P1CWoEixQVbsRQ1TQvc2lp0cKSg8
	 F0roxIZtifj/Zep7P4pVziV9NDVSeNh5J3yT4Lbw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 7.0 142/307] hv: Select CONFIG_SYSFB only for CONFIG_HYPERV_VMBUS
Date: Tue, 12 May 2026 19:38:57 +0200
Message-ID: <20260512173943.124738342@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60EC7527F12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10809-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,outlook.com,linux.microsoft.com,kernel.org,microsoft.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,outlook.com:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit d33db956c9618e7cb08c2520ce708437914214ec upstream.

Hyperv's sysfb access only exists in the VMBUS support. Therefore
only select CONFIG_SYSFB for CONFIG_HYPERV_VMBUS. Avoids sysfb code
on systems that don't need it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 96959283a58d ("Drivers: hv: Always select CONFIG_SYSFB for Hyper-V guests")
Cc: Michael Kelley <mhklinux@outlook.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Link: https://patch.msgid.link/20260402092305.208728-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -9,7 +9,6 @@ config HYPERV
 	select PARAVIRT
 	select X86_HV_CALLBACK_VECTOR if X86
 	select OF_EARLY_FLATTREE if OF
-	select SYSFB if EFI && !HYPERV_VTL_MODE
 	select IRQ_MSI_LIB if X86
 	help
 	  Select this option to run Linux as a Hyper-V client operating
@@ -62,6 +61,7 @@ config HYPERV_VMBUS
 	tristate "Microsoft Hyper-V VMBus driver"
 	depends on HYPERV
 	default HYPERV
+	select SYSFB if EFI && !HYPERV_VTL_MODE
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 



