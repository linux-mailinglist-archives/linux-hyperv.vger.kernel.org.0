Return-Path: <linux-hyperv+bounces-11678-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eS4bBw5rPWrC2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11678-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:53:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 943C26C8084
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=M7geG8xy;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11678-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11678-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CF430C58BA
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1173235E940;
	Thu, 25 Jun 2026 17:42:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EBF25785C;
	Thu, 25 Jun 2026 17:42:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409376; cv=none; b=LwW8n8BOpSxebGb6rR/YKq5exhrxi0yj2AxfECRHal7dVjFD7c0eECs9BkAPZH0swGoAkecT+6ofWEBq804Xk/CbA1H2thXOeDg9P0AgNfUwRKVJLjvOZDURX7+sINAZmf/VTbGd/3Jt42oqftA0p8lH73e2U6kvtqf0qr6wilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409376; c=relaxed/simple;
	bh=ex0ixU8nrolSMbX0zWTpjeHiIaN3XTiwbYCu6pteU5k=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZBGltmiuNkrjXkR336xbjkmUxLIMbZTn5lLXPUGbvRtYicYUlrynakryZrtiqBIzcZS61Ko2yrXNfnkF46BuqNLdEwdcG26ZPWGsDYWNFrB9MryfzQmr1O72u2jCru1rNdx5LhGYK47b+Wtnr0QwwqkCsuivcn59firwTDxuLes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M7geG8xy; arc=none smtp.client-ip=13.77.154.182
Received: from DairyQueen (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id CCE1C20B7167;
	Thu, 25 Jun 2026 10:42:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CCE1C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782409368;
	bh=pnOfNp9/ctehv6PmReGlUMeN9R8JuaY0IwGr+iGJTlQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=M7geG8xyuW3jaKBpp3FmBW4kbWpHezIBq47o5MufG7sOysIPZXBqCTpdgclvpB1ZI
	 nk0OqJdgyEKrm4mi2pBsz8xsgWsMUSIAG5uCeKblrU1kMdilPADNuyR+gtBWX/Xj0h
	 t0oswmRWmaHFk8EWTH72SKsvFnajnmtyUCTik4RQ=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>
Cc: <catalin.marinas@arm.com>,
	<will@kernel.org>,
	<mark.rutland@arm.com>,
	<lpieralisi@kernel.org>,
	<sudeep.holla@kernel.org>,
	<arnd@arndb.de>,
	<thuth@redhat.com>,
	<linux-hyperv@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com> <20260609181030.2378391-3-kameroncarr@linux.microsoft.com> <SN6PR02MB4157F6A66DEDE650298E120ED4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157F6A66DEDE650298E120ED4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 2/6] firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
Date: Thu, 25 Jun 2026 10:42:41 -0700
Message-ID: <001701dd04ca$0cfd88b0$26f89a10$@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQIqsf51yBS/Or0EhgWD9giRtIuOSwIF3n0XAZ3FyRa1lxLTUA==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11678-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 943C26C8084

On Thursday, June 18, 2026 10:46 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June
> 9, 2026 11:10 AM
> > diff --git a/drivers/firmware/smccc/smccc.c
> b/drivers/firmware/smccc/smccc.c
> > index bdee057db2fd3..6b465e65472b0 100644
> > --- a/drivers/firmware/smccc/smccc.c
> > +++ b/drivers/firmware/smccc/smccc.c
> > @@ -12,6 +12,12 @@
> >  #include <linux/platform_device.h>
> >  #include <asm/archrandom.h>
> >
> > +#ifdef CONFIG_ARM64
> > +#include <linux/cleanup.h>
> > +#include <linux/spinlock.h>
> > +#include <asm/rsi.h>
> > +#endif
> > +
> >  static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
> >  static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
> >
> > @@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
> >  }
> >  EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> >
> > +#ifdef CONFIG_ARM64
> > +static struct rsi_host_call uuid_hc;
> > +static DEFINE_SPINLOCK(uuid_hc_lock);
> 
> So evidently Sashiko is wrong in saying that struct rsi_host_call must be
> in decrypted memory?

Yes, Sashiko is wrong. The RMM spec clearly states that the rsi_host_call
struct must be encrypted / "protected". The other two requirements are
256 aligned and not RIPAS_EMPTY.


