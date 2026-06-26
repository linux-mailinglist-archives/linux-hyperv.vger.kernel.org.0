Return-Path: <linux-hyperv+bounces-11691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TE7QEtFdPmqXEgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-11691-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 13:09:05 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3CC6CC4A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 13:09:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=gn8G+z5G;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11691-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11691-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C4A6301CF9A
	for <lists+linux-hyperv@lfdr.de>; Fri, 26 Jun 2026 11:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C943E3E51E7;
	Fri, 26 Jun 2026 11:09:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36A379EE8;
	Fri, 26 Jun 2026 11:09:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472142; cv=none; b=DKQjSfCq7YuH5cNznYkhwnksM+y4BTcdWii3JmETB0zmBbHuJgxS8hTl6TNuRkDXjNFf5FKFVT+k9sd0XVkOi3QbOTdugIlxYrGD0xbxSirBTfsjjtPo1OHy5n4ibvBKAxZ3kz5Z9HKpw5zffRBEZFYsq5DgVcdyc88Tfj97+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472142; c=relaxed/simple;
	bh=tpxBv6SR8AFlZnUlebSAxkhctIUO8PhcUXPu/ZOgS2c=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=HHkOYFPp95st6nolPlvjQdpVLqWPEme8joCEHO6IV0wYBS0lHchD+AV+mVw29ZKBmBO5E52APlA8S7+H1Llz4ofRXQKULF2/JfADTlcLUQPNx6MKM+Eftt3OK2QV80CRwZUB9vigHMtgIBnp7kni9EQITIZruhkmuUo/JKzyufg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gn8G+z5G; arc=none smtp.client-ip=13.77.154.182
Received: from DairyQueen (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6DA3320B7169;
	Fri, 26 Jun 2026 04:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DA3320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782472130;
	bh=3tXlinCc4IpnuxZycQ2g/1yaIY+ksDllWGNc2F2P03I=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
	b=gn8G+z5GBVcwrrg49tOu6UrJ2T/Q7/0ZG4TisIRJkAZJxzfJaem8sRm2Dq3BZJI7+
	 CRoYohSTdyZKVDOcxWqw0+h3F8t6vgjNnXxgZ1nb1RzuDefkxLuQKpJZlgFX/eEtJA
	 NmmLv/voUeuLZOsDLzUSs0jZ5ALyakKRlI0wy8E0=
From: "Kameron Carr" <kameroncarr@linux.microsoft.com>
To: "'Michael Kelley'" <mhklinux@outlook.com>,
	<kys@microsoft.com>,
	<haiyangz@microsoft.com>,
	<wei.liu@kernel.org>,
	<decui@microsoft.com>,
	<longli@microsoft.com>
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
	<linux-arch@vger.kernel.org>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com> <20260625173500.1995481-5-kameroncarr@linux.microsoft.com> <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157D5F94B5C5F35020FF047D4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Fri, 26 Jun 2026 04:08:42 -0700
Message-ID: <000801dd055c$2e375050$8aa5f0f0$@linux.microsoft.com>
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
Thread-Index: AQEAlq3oFwuiSVNoPj5kD0Q006gIdwI/GO7nAcdUdB636UC94A==
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
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:mark.rutland@arm.com,m:lpieralisi@kernel.org,m:sudeep.holla@kernel.org,m:arnd@arndb.de,m:thuth@redhat.com,m:linux-hyperv@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kameroncarr@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11691-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9B3CC6CC4A4

On Thursday, June 25, 2026 11:59 AM, Michael Kelley wrote:
> From: Kameron Carr <kameroncarr@linux.microsoft.com> Sent: Thursday,
> June 25, 2026 10:35 AM
> > We need to round up the memory allocated for the input/output pages to
> > the nearest PAGE_SIZE, since set_memory_decrypted() requires the size to
> > be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that are
> > using PAGE_SIZE larger than 4K.
> 
> I think this change resulted from a Sashiko comment. My understanding is
> that the ARM CCA architecture only supports CCA guests with 4 KiB page
> size. Is that still the case, or has that restriction been lifted in a
later version
> of the architecture? I'm in favor of handling the larger page sizes, if
only for
> future proofing. But I wondered whether your intent is to always support
> > 4 KiB page sizes even if CCA doesn't support them now. Another way to
> put it: In reviewing code, should I flag issues related to page sizes > 4
KiB?

I think you might be right. I'm looking at RMM spec 2.0 beta 2, and the RMI
can have granule size 4KB, 16KB, 64KB, but the RSI is restricted to granule
size
4KB.

I'm open to suggestion on best way to move forward.

> > @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
> >  		}
> >
> >  		if (!ms_hyperv.paravisor_present &&
> > -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> > -			ret = set_memory_decrypted((unsigned long)mem,
> pgcount);
> > +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> > +		     hv_isolation_type_cca())) {
> > +			ret = set_memory_decrypted((unsigned
> long)kasan_reset_tag(mem),
> > +				alloc_size >> PAGE_SHIFT);
> 
> I don't know enough about KASAN or the tag situation on ARM64
> to comment on this change. But this same sequence of allocating
> memory and then decrypting it occurs in other places in Hyper-V
> code. It seems like those places would also need the same
> kasan_reset_tag() call.

I'm not sure of the exact behavior of PAGE_END when there are
KASAN tags, but it looks like tags could mess with the address
comparison.

I do see that __virt_to_phys_nodebug() and virt_addr_valid() in
arch/arm64/include/asm/memory.h both reset tags before calling
__is_lm_address().

If there are many calls that follow this pattern, it may be better to
add the tag reset in __set_memory_enc_dec().

I can undo this change.

Regards,
Kameron




