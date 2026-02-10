Return-Path: <linux-hyperv+bounces-8773-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIjBNl2Ki2nYVgAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8773-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 20:43:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16011EC07
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 20:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16E8330257A2
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Feb 2026 19:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE6A319850;
	Tue, 10 Feb 2026 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WfJH1LIb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B75265629;
	Tue, 10 Feb 2026 19:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770752574; cv=none; b=tquOIgDnEN/azhXWklox4s9WSC1tOJe1C+TZh20LYJ78HiuVTQJCNlNix+eYCEn6xHg8G8oG82XCmzaQjH9yc1eo/wmSO81rly1UWXTzgzKONU3XKSmR/hLPtAiJJ3QruZ5lIzeu4Ly+l78t9pS8twIMmumy43GeJIg4aTgeDUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770752574; c=relaxed/simple;
	bh=aJSWqNwGdh6QALlFM2/7Y6QuTmhNDkg4CEaPzZNWPec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKh3Nl4du5dT/n4YWTErfY+PuGq0PfJm+UQkewBvndF/eipSak2gQYqmtgZivkIe5TkjDT/zCwuCy0MvpDyZCkHoYzjCCp0hj5DZ+KgPt4920O1kOYXyarjyjbdlc8ZHFvVoCpKiRmyjky81udR40WOXWjsMTYyjG03JWDpMy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WfJH1LIb; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 61AJfO1X3500081
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 10 Feb 2026 11:41:57 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 61AJfO1X3500081
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026012301; t=1770752518;
	bh=W2zkZjdMhLXYK319kIcTCS27Ism2TmOGRXZgMPLh4Fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WfJH1LIbPKN7bLH8TvBrLbCJ6AdZ2XXuVq2ZEw15dMKXoPlZrJL8xryD1kE0f1CFW
	 dVr6njvujajETMs5mq/gDVT7iacH7lncLvZXQpXmY8rz5Rwi8CaI8bIWU+CZ62lsx3
	 oDeyV86axTEMVkf2VNKuiRjAwHqFQmmCZvih+Iydl3vbd8783m7SHOW3PP0LMAVaz0
	 dgOdTbtpo48/likUF8UQmdo9e5XbQxTrz9bvE5pfopDUWzGfN39F/Gtfq271KsTro/
	 3dTorEFbV6aWvuXsR4j5ni+VI/cWTka63LNScU+BrObI3fa84vsjmkqj3OE6m4eySf
	 /A5LDz9n18Mpw==
Message-ID: <e6d26515-4ee7-4b1c-ad45-ca378330eed3@zytor.com>
Date: Tue, 10 Feb 2026 11:41:19 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] x86/hyperv: Reserve 3 interrupt vectors used
 exclusively by mshv
To: Wei Liu <wei.liu@kernel.org>, Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        longli@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
References: <20260102220208.862818-1-mrathor@linux.microsoft.com>
 <20260115072509.GF3557088@liuwe-devbox-debian-v2.local>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260115072509.GF3557088@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zytor.com,none];
	R_DKIM_ALLOW(-0.20)[zytor.com:s=2026012301];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8773-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hpa@zytor.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[zytor.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F16011EC07
X-Rspamd-Action: no action

On 2026-01-14 23:25, Wei Liu wrote:
> 
> I briefly looked up FRED and checked the code. I understand that once it
> is enabled, Linux kernel doesn't setup the IDT anymore (code in
> arch/x86/kernel/traps.c).
> 
> My question is, do we need to do anything when FRED is enabled?
> 

Assuming you don't need them handled in any specific way, then you don't. INT
instructions are treated completely separately from hardware interrupts in
FRED, and so they cannot be confused.

By default they will emulate a #GP(0) just as if an INT instruction had been
executed in user space with the DPL of the corresponding interrupt gate < 3;
this is currently the case for interrupt vectors other than 3, 4, and 0x80
(which are handled in fred_intx).

Any INT instruction in kernel space will end up in fred_bad_type().

	-hpa


