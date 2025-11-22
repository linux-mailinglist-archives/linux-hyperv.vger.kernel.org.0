Return-Path: <linux-hyperv+bounces-7777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC7EC7BFE5
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 01:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BE9C9365382
	for <lists+linux-hyperv@lfdr.de>; Sat, 22 Nov 2025 00:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4ED83594A;
	Sat, 22 Nov 2025 00:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Emcewl2W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CCA29CEB;
	Sat, 22 Nov 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763770038; cv=none; b=NC5CnMY3mKLvoAV0PEcyn6ApAKVR1EBZe0iULxyUKl0HAEpHeZ0PY2mbXgAn+stzckR/d2VVxrZtsDa5zERR9ptiqJRxMIBubr0ZPkrR83ldkZVJsy/eUDoYt8B7gAb/tIwmgeIUnIcoF0jJBX8zkMfmnPdGQu0XQfOHhQJcp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763770038; c=relaxed/simple;
	bh=3bA8hD/dYfOzkafIPyQLWqg9K7+JcTzWJNpyypH4dbI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=SqKVzQyzd9UD5tieh0LhIy/yniCPcKJ2JJc/lFYjCnzgpTSqZ/xtyEYrqnNsAi+B2om8MGUIdzy80hKhliuEoGfFP/jRzrS8HBX0hngT/0jEELVR/C02IlIUyafPpWTp9EciEEaKq2Q+H5jwte80WZ8ygd8ryIgbawmzGbZNAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Emcewl2W; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 5AM06Ciq3278018
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 21 Nov 2025 16:06:13 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 5AM06Ciq3278018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025102301; t=1763769974;
	bh=3lbnsGLtSexKHuqzE8P8GA8GUW6GBdygdwQUYycWS/Y=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Emcewl2WWzRaFQ0wozYMZ09aGOoCmZAAzwOhLAy4PooE9NjArvzqg7hFYLeVo+uEG
	 GmPlwSYK5WDyVEq5vlkAEKhzc0Q5Ze4evxabHKLZxwmX6rFm0rC4YJb/2o8XNLhpm2
	 5gDvAaINAwYGOfQsInDw8c4zi3L6rkT79G7AAifCo0kFfW2U0RQH2ifP6BdmqKhGUT
	 L0Kprw1XruxmCPyLHg36QOXmgCO6jbiLF6oFGssFKA5RmosiPUm1eQ9lhDJ87mHFnq
	 al4zTwug/2QK+ukRN+wGMm2kkYfhgGxXvpo/kzAtrCzSl/2vg9RzCUqJjmU0qycEqm
	 azKSFeWLWPMNg==
Date: Fri, 21 Nov 2025 16:06:11 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Uros Bizjak <ubizjak@gmail.com>, linux-hyperv@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
CC: Michael Kelley <mhklinux@outlook.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/3=5D_x86/hyperv=3A_Remove?=
 =?US-ASCII?Q?_ASM=5FCALL=5FCONSTRAINT_with_VMMCALL_insn?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20251121141437.205481-3-ubizjak@gmail.com>
References: <20251121141437.205481-1-ubizjak@gmail.com> <20251121141437.205481-3-ubizjak@gmail.com>
Message-ID: <8F5147DF-E0E2-4942-99D9-4242F3013635@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 21, 2025 6:14:11 AM PST, Uros Bizjak <ubizjak@gmail=2Ecom> wrot=
e:
>Unlike CALL instruction, VMMCALL does not push to the stack, so it's
>OK to allow the compiler to insert it before the frame pointer gets
>set up by the containing function=2E ASM_CALL_CONSTRAINT is for CALLs
>that must be inserted after the frame pointer is set up, so it is
>over-constraining here and can be removed=2E
>
>Signed-off-by: Uros Bizjak <ubizjak@gmail=2Ecom>
>Tested-by: Michael Kelley <mhklinux@outlook=2Ecom>
>Cc: "K=2E Y=2E Srinivasan" <kys@microsoft=2Ecom>
>Cc: Haiyang Zhang <haiyangz@microsoft=2Ecom>
>Cc: Wei Liu <wei=2Eliu@kernel=2Eorg>
>Cc: Dexuan Cui <decui@microsoft=2Ecom>
>Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>Cc: Ingo Molnar <mingo@redhat=2Ecom>
>Cc: Borislav Petkov <bp@alien8=2Ede>
>Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>---
>v2: Expand commit message and include ASM_CALL_CONSTRAINT explanation
>---
> arch/x86/hyperv/ivm=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/hyperv/ivm=2Ec b/arch/x86/hyperv/ivm=2Ec
>index 7365d8f43181=2E=2Ebe7fad43a88d 100644
>--- a/arch/x86/hyperv/ivm=2Ec
>+++ b/arch/x86/hyperv/ivm=2Ec
>@@ -392,7 +392,7 @@ u64 hv_snp_hypercall(u64 control, u64 param1, u64 par=
am2)
>=20
> 	register u64 __r8 asm("r8") =3D param2;
> 	asm volatile("vmmcall"
>-		     : "=3Da" (hv_status), ASM_CALL_CONSTRAINT,
>+		     : "=3Da" (hv_status),
> 		       "+c" (control), "+d" (param1), "+r" (__r8)
> 		     : : "cc", "memory", "r9", "r10", "r11");
>=20

I think it would be good to have a comment at the point where ASM_CALL_CON=
STRAINT is defined explaining its proper use=2E

Specifically, instructions like syscall, vmcall, vmfunc, vmmcall, int xx a=
nd VM-specific escape instructions are not "calls" because they either don'=
t modify the stack or create an exception frame (kernel) or signal frame (u=
ser space) which is completely special=2E

