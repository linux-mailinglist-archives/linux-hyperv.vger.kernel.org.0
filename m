Return-Path: <linux-hyperv+bounces-9489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHJ2Ao0luWm1sQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9489-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 10:57:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDBE2A75E3
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 10:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD39E31221F0
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 09:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283C13A0B2D;
	Tue, 17 Mar 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TlHV8gse"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC13A1A38;
	Tue, 17 Mar 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773741115; cv=none; b=iV9kY8mmo5CIycRmVQ/YouYEdRSTSxBB5d3E7z6NHRGB5AHu50lBHhTMgjtu7IAJ3PZzTxH1F5qxLw6qtfACVkxf8Uy2GTJhy/Z2yqhLteZF+hZpAC9aAh3aUNCFiuSUMOPdyqiOkTDXKPpPrp65Yw6gCnYi1FtXjShae8lOku8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773741115; c=relaxed/simple;
	bh=ZfbAAGzHolQDpcCwIaogk9iC5IdaRXUEYFw8UIUKTrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5shh+3AQ2UtvI9nYGkHCyvDnvTl3+MHisyxXQMA4sqcV2e9LqSe1iBHejve/jgL5uPAYaqy62tMnGBu7y67mrHw8LM4mUtcB0jRTFhOHktj2EPx1X7hV+GtU8GF0ezWIc8y2KQDBoHYlgqKodAwmmnWZ8nfRfhGdtVSU6bGuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TlHV8gse; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.143.174] (unknown [167.220.238.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 189EA20B7128;
	Tue, 17 Mar 2026 02:51:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 189EA20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773741112;
	bh=xbh6eljYGdIRxffTU4mBqSyhNeDzEqtJalkt9/WqCMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TlHV8gseTBNNxGEDRkCzVMCSmd3juWFaVPdWxwkFVsF6tEp6RFYQ9PhNIvO8/4zhO
	 CwxZjNSs888nrrnCbWD+v1KrGqmach6lg7YTIFingtscICit44Aty6Ge9XFBSArwze
	 0OX07pJe6ypUTXqx3/qSvI1tzRxdT46HbinGl2G0=
Message-ID: <2b1c444c-7545-4ce7-90b0-208aee31904a@linux.microsoft.com>
Date: Tue, 17 Mar 2026 15:21:42 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
To: vdso@mailbox.org, ssengar@linux.microsoft.com
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <1755043210.33472.1773718457301@app.mailbox.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1755043210.33472.1773718457301@app.mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9489-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,outlook.com,vger.kernel.org,lists.infradead.org,microsoft.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namjain@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:email]
X-Rspamd-Queue-Id: 5EDBE2A75E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 9:04 AM, vdso@mailbox.org wrote:
> 
>> On 03/16/2026 5:12 AM  Naman Jain <namjain@linux.microsoft.com> wrote:
>>
>>   
>> The series intends to add support for ARM64 to mshv_vtl driver.
>> For this, common Hyper-V code is refactored, necessary support is added,
>> mshv_vtl_main.c is refactored and then finally support is added in
>> Kconfig.
> 
> Hi Naman, Saurabh,
> 
> So awesome to see the ARM64 support for the VSM being upstreamed!!
> 
> Few of the patches carry my old Microsoft "Signed-off-by" tag,
> and I really appreciate you folks very much kindly adding it
> although the code appears to be a far more evolved and crisper
> version of what it was back then!
> 
> Do feel free to drop my SOB from these few patches so the below SRB
> doesn't look weird or as a conflict of interest - that is if you see
> adding my below SRB to these few patches as a good option. It's been
> 2 years, and after 2 years who can really remember their code :D
> 
> For the series,
> Reviewed-by: Roman Kisel <vdso@mailbox.org>



Thank you so much Roman for reviewing the changes. I think we can retain 
both the tags from you. I'll let the maintainers decide.

Regards,
Naman



