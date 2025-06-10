Return-Path: <linux-hyperv+bounces-5826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFEBAD3E4A
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 18:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72863A6254
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Jun 2025 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D399023717C;
	Tue, 10 Jun 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O51AOjvt"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A6412CDAE;
	Tue, 10 Jun 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571620; cv=none; b=ozyb1MEezWlqBW99Te8Gv0w1lZ8wLH2nwgep2hhoYhfbU8uM8PARXvu9aj+j3vctBZspkGbJ4Ll5+0M1ZEjX+1LsNIoYgozvNRhVtSBH59oyZD5ZIbjcaltIQ+99zvaHnK+mjyEFDzlxoq2usvADgJpW6Fwsg2uUNBrc7fZVpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571620; c=relaxed/simple;
	bh=EF6+Ekp5LFOn/Da+vUOZnyB0ssktivNlZp8mV3L4hrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNn37Q9CcYn+YMWFj0ZkJe72W+Rj6n4k9OQdSvK4JKTw/tXJI9RvhgVuyKudBzRn35HaJiROjjqWf/Bsn1brocccfE6I4J9YTsuadfeY9VfwEM75JRx8+nf3i2UCH786yTU15tDicC9Anf0P6z8vdYywqGJ6Xw6fjU2sLLXxkC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O51AOjvt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0A4D21175A4;
	Tue, 10 Jun 2025 09:06:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0A4D21175A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1749571618;
	bh=EF6+Ekp5LFOn/Da+vUOZnyB0ssktivNlZp8mV3L4hrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O51AOjvtxzIfvKmh7tEijTRnn/KFclGPxRlbGJi/7DMCm2/914JouuKmN2ZR3p7pj
	 zQhrDQVXBPTWDBLH/QVuZVmMdcurziTUwQge77GOf7nBMJAlWrHcVXcJ2//OLJ3yDR
	 5X3Zj1w9sseHk+6K9ekaKxn4eKmglkCxmTcTHg3k=
From: Roman Kisel <romank@linux.microsoft.com>
To: sudeep.holla@arm.com
Cc: anirudh@anirudhrb.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com
Subject: Re: [PATCH] firmware: smccc: support both conduits for getting hyp UUID
Date: Tue, 10 Jun 2025 09:06:48 -0700
Message-ID: <20250610160656.11984-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
References: <20250605-kickass-cerulean-honeybee-aa0cba@sudeepholla>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> (sorry for the delay, found the patch in the spam 🙁)

"b4" shows the the mail server used for the patch submission
doesn't pass the DKIM check, so finding the patch in the spam seems
expected :) Thanks for your help!

>
> On Wed, May 21, 2025 at 09:40:48AM +0000, Anirudh Rayabharam wrote:
>> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
>>
>> When Linux is running as the root partition under Microsoft Hypervisor
>> (MSHV) a.k.a Hyper-V, smc is used as the conduit for smc calls.
>>
>> Extend arm_smccc_hypervisor_has_uuid() to support this usecase. Use
>> arm_smccc_1_1_invoke to retrieve and use the appropriate conduit instead
>> of supporting only hvc.
>>
>> Boot tested on MSHV guest, MSHV root & KVM guest.
>>
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
> Are they any dependent patches or series using this ? Do you plan to
> route it via KVM tree if there are any dependency. Or else I can push
> it through (arm-)soc tree. Let me know.

Anirudh had been OOF for some time and would be for another
week iiuc so I thought I'd reply.

The patch this depends on is 13423063c7cb
("arm64: kvm, smccc: Introduce and use API for getting hypervisor UUID"),
and this patch has already been pulled into the Linus'es tree.

As for routing, (arm-)soc should be good it appears as the change
is contained within the firmware drivers path. Although I'd trust more to your,
Arnd's or Wei's opinion than mine!

>
> --
> Regards,
> Sudeep

