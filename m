Return-Path: <linux-hyperv+bounces-10627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCalKFXX+WmbEgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-10627-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 13:41:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 218954CCD5B
	for <lists+linux-hyperv@lfdr.de>; Tue, 05 May 2026 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 910A4300D632
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 May 2026 11:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F83738A726;
	Tue,  5 May 2026 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OYTAspS4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73DE387364;
	Tue,  5 May 2026 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777980950; cv=none; b=gtxiHV3cl+ND5yeXuGEfDbdxfjFWE6XyTXxQRs937l91XVgAY9kDSLuQLE7iSyioriZY8Ao6RRwkHS+NPmD7W6KV7cwmxI/BSfztQy8ZmJKbuk1l9cIb3wejRZJNKyVECbQtnIL4iP4Gtu7yonZta+5WNO9p08cBqMiqE6cuIpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777980950; c=relaxed/simple;
	bh=at19uvxNcHMfcG+vd2NFqn/Rp/ZQnuYgva4Zq0bYUg4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=njdTLr//DcqIldHfpfp2dIVfC2lY0+JC7lXeJa+cEEwbGzZ08bbDUUHO8N6aETUZoofd51jejTIUx1kgpPm43Zl51O9QId5ltynhV+S+aJ1Y5XeZu8yzHxVF1rehVPBI5smxesswrrfXr1kwPyuHmSJTSphGNzCSjcLL9fLdgE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OYTAspS4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 2C94820B7168; Tue,  5 May 2026 04:35:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C94820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777980946;
	bh=I4klsKzTXH34c/6RkK2WQi9jxixheunHFgfWXjXIHIk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=OYTAspS4xGyg/MRyaMAAWFEcDxi2hRjko1QnVvfe/d7s6tdxoWlXkL9rBrBmk4XlA
	 64i7Cnk2/Jo+G2c/nseUdPntKzM5IUpcU7NcYaSqjbPdaK8Fh+C+c2sHp8KhlxBFsf
	 SP0OdePFhHmpi8kDIA59gm7AmoFoxmyxQIpmD3HQ=
Received: from localhost (localhost [127.0.0.1])
	by linux.microsoft.com (Postfix) with ESMTP id 2A8ED30705A3;
	Tue,  5 May 2026 04:35:46 -0700 (PDT)
Date: Tue, 5 May 2026 04:35:46 -0700 (PDT)
From: Jork Loeser <jloeser@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
    "x86@kernel.org" <x86@kernel.org>, 
    "K . Y . Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
    Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
    Anirudh Rayabharam <anirudh@anirudhrb.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 1/3] mshv: limit SynIC management to MSHV-owned
 resources
In-Reply-To: <SN6PR02MB4157280E305E11C5840B444DD4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Message-ID: <91faacb-d16-8540-4713-dad25bacf695@linux.microsoft.com>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com> <20260427213855.1675044-2-jloeser@linux.microsoft.com> <SN6PR02MB4157280E305E11C5840B444DD4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Rspamd-Queue-Id: 218954CCD5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10627-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jloeser@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

On Mon, 4 May 2026, Michael Kelley wrote:

> From: Jork Loeser <jloeser@linux.microsoft.com> Sent: Monday, April 27, 2026 2:39 PM
>>
>> While here, fix the SIEFP and SIRBP memremap() and virt_to_phys()
>> calls to use HV_HYP_PAGE_SHIFT/HV_HYP_PAGE_SIZE instead of
>> PAGE_SHIFT/PAGE_SIZE. The hypervisor always uses 4K pages for SynIC
>> register GPAs regardless of the kernel page size, so using PAGE_SHIFT
>> produces wrong addresses on ARM64 with 64K pages.
>
> I agree that this is a good change. But any kernel image built with
> CONFIG_MSHV_ROOT set must use only 4KiB pages, as enforced
> by the dependency in drivers/hv/Kconfig. The change makes the
> code explicitly match the SynIC register layout, which is good,
> but it doesn't actually fix a problem since root MSHV code can't
> run on ARM64 with 64KiB pages. My only concern is that this
> commit message should not imply that an ARM64/64KiB
> configuration is possible for the root.

Agree for root. For L1VH, I think it theoretically could (likely with 
other changes needing to happen elsewhere).

Best,
Jork

