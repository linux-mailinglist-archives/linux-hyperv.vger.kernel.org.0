Return-Path: <linux-hyperv+bounces-3532-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562C9FCE11
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB25E1633AC
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FEB13BAD5;
	Thu, 26 Dec 2024 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aeHfveEV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E959C18E1F;
	Thu, 26 Dec 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249301; cv=none; b=dgvlXGnI6tDtEu91TlR4BYTz5FK066AZmDODYi6hjQf8RrcHHYxmKUWaFDLITzqpRbJqpCzmMuWxJxTaMX5hgDZ2yqYo+wQ+ls5+UQXoOndPn+UkTOsPQKQooUGJ82qv2TTTz+/Ybw7v9vIYPuwMYAZl+gWhqR4aVo3aFLKmEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249301; c=relaxed/simple;
	bh=e3EmRr7IJV1IP0sT64otsAu1C87fbxe5Fi2dpYGmccA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T+yg5sbPfhvdIIU6Y2mytsNAe1alJb9jTfs3FyHgLgblcO46EJE7oCs0eDWvvwi36B9dr/a8k0iYTnDDnMHaFm6j8THcmyUk6JqqHnTZnR33wVrcwTzEatYv4ZogMd5xWDE1WD07wUFAdncx/beoDAkpD9yjksX+8Ua3wHBUAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aeHfveEV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.224.184] (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD189203EC22;
	Thu, 26 Dec 2024 13:41:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD189203EC22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735249299;
	bh=F+VQgIycDIekgFXcuq9kl2tCm3dSmojRNZL9SNq2610=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=aeHfveEVJFAtOx/ULOE1Qp2Uv6hliT6qZAKuYadBDLBzqggFbauANMeZMEHKMh8pc
	 oSgyQT2A4O/z1KwM0mbv7yQDe7d18T6mqVS6j6FcagugM7H6sx8E/RXqw0m4fwB5XV
	 4RLnf2NEMvhoOICpn1JRvP3tEMaYYoFT1ZITHN+0=
Message-ID: <721f28b3-5091-47c7-921a-66336f17987c@linux.microsoft.com>
Date: Thu, 26 Dec 2024 13:41:41 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 2/5] hyperv: Fix pointer type for the output of the
 hypercall in get_vtl(void)
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-3-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241226213110.899497-3-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/2024 1:31 PM, Roman Kisel wrote:
> Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
> changed the type of the output pointer to `struct hv_register_assoc` from
> `struct hv_get_vp_registers_output`. That leads to an incorrect computation,
> and leaves the system broken.
> 
> Use the correct pointer type for the output of the GetVpRegisters hypercall.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)


Please add a Fixes tag, you can just reply to this email, tooling would
probably pick it up. Assuming that:

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

