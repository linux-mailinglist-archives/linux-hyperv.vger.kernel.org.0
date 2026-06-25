Return-Path: <linux-hyperv+bounces-11679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L9r4BqRpPWpb2wgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11679-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:47:16 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB066C7FDC
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 19:47:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=VCooPUmw;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11679-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11679-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAD2E300E3C4
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jun 2026 17:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C450A23E25B;
	Thu, 25 Jun 2026 17:44:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD12BE655;
	Thu, 25 Jun 2026 17:44:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782409455; cv=none; b=i/gAS6e7q7vlN3jC/zP36ZVp75zdxA4yGveRhoifl6JSD2HA5QQ4XPVKIqhEJ6ZWOva7vstR42SBKM1aTgFihJyBt9q+H4pPBSRwWiGjqMzrd6OxD/6JxCp28EqY/6F54BVFjaHcxDp/lbSYGbEggm1/Yjb20gAaXLEkxbBhlt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782409455; c=relaxed/simple;
	bh=MyA4FF6q29A+3SbH42mR6pdTj/r8DAqnGUJXrBt0b6U=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=QPtgCLP6DRyWdXkciLxUYJGZxfxTrRihYkXfsQc7pChXKbx4vppEq6/U1cJNNCbQO+goAtbuomVfFjJ9k1Wvpdm1ykV9l/EwO8FPErfOx1XU6TNxr3Ei9TyfjLGbykGarZqg0RR4dObqOTx7ev4GGo/uFa9QfIAVA6dCp5CUKak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VCooPUmw; arc=none smtp.client-ip=13.77.154.182
Received: from DairyQueen (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E9C020B7169;
	Thu, 25 Jun 2026 10:44:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E9C020B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782409449;
	bh=Kyjn1XSSFV58s+xzTe6JzUKJQyHLDtnE8CF0wlcJZv4=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=VCooPUmwR/wlrM2n6KX/vnrc83rJeGIC/OlIu/bNZ+mxcX9vX4C0BkVWWe/l5FcFz
	 dzRI9NJWTfCx8eCjt7Sk/EUiLvqOtyf5E2zCLdcVuIJDi3nlfjQ/pw0LYseh5rnOUf
	 etjYJztVs+bKPWObYamRLHTgwhkaBtpqkpMIDCcs=
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
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com> <20260609181030.2378391-2-kameroncarr@linux.microsoft.com> <SN6PR02MB4157C9AA6BA2DD14E7697F2BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157C9AA6BA2DD14E7697F2BD4E32@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [RFC PATCH 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Thu, 25 Jun 2026 10:44:04 -0700
Message-ID: <001901dd04ca$3d2d3260$b7879720$@linux.microsoft.com>
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
Thread-Index: AQIqsf51yBS/Or0EhgWD9giRtIuOSwGQcImIAlNLHk21lRJa8A==
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-11679-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,linux.microsoft.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7AB066C7FDC

On Thursday, June 18, 2026 10:46 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Tuesday, June
> 9, 2026 11:10 AM
> > diff --git a/arch/arm64/include/asm/rsi_smc.h
> b/arch/arm64/include/asm/rsi_smc.h
> > index e19253f96c940..ffea93340ed7f 100644
> > --- a/arch/arm64/include/asm/rsi_smc.h
> > +++ b/arch/arm64/include/asm/rsi_smc.h
> > @@ -142,6 +142,12 @@ struct realm_config {
> >  	 */
> >  } __aligned(0x1000);
> >
> > +struct rsi_host_call {
> > +	u16 immediate;
> 
> I don't see the "immediate" used anywhere in this patch set.
> Is it always zero for the Hyper-V use cases?  Just curious ...

Yes, the immediate value is always zero for Hyper-V host calls.

-- Kameron


