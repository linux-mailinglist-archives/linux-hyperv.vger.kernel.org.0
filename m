Return-Path: <linux-hyperv+bounces-5990-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98CAE3490
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 06:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7D03A0441
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Jun 2025 04:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B8418DF6D;
	Mon, 23 Jun 2025 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Dyso1E1n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5D63FFD
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Jun 2025 04:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654609; cv=none; b=DUULXEXufoniXJvpsqlNcclTlcox7TRHk/NAdtc20UFKDWibiNaEEYlNXsWqBpmOMtrDjqlsU8rTGkVGsQhD3FDtXQ1fUbUhsshpc9nwS4kRSO83OZnu1dATf+T5ohYQU03Z1SDie0ORshxyYtRAfHFMWYKQvffaZR1kewdWpLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654609; c=relaxed/simple;
	bh=scl1uj+9BWZbH3KZs083SVTr6HF4a+xt9w8QyM00UNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HjKLyK67+DVaGnqfsEl7FCYeqGDkj4baYE0u1jt384WKa/HO3j4w6EcN3jW/XSx2FH0HQxZFRX+pUYl3H3OxHVYmmdZpzlVnhGrfzDNbX/gJIFU680rAUE/UGMgQlUPlXdmDdE0m3pjYqSDrBWLiXqmQWKbwC+6jRE8hafRNuS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Dyso1E1n; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.67.184] (unknown [167.220.238.152])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8781D2117FA1;
	Sun, 22 Jun 2025 21:56:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8781D2117FA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750654607;
	bh=fKtTQ/V3tLM/Q3sN+XHyquj7NVafM2Wlq4hlZqZqMmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dyso1E1nlmNzq6ZafFDIIUmOp181ng0s8qzeG656hhcPe5C0vB4DaYKwZNtuqnyvp
	 JxJaoKP5jvXlq5y9SJy6+lNCmciWhcRzDTEMaQ24AUajpM8hiI6TMQIUYPCNRHifvz
	 9HlsYUFSECf+/JW19J1LEFsYbKZ+myGqeJJWowLo=
Message-ID: <f22d2784-25f9-40ed-9aea-da6a70b8b7ea@linux.microsoft.com>
Date: Mon, 23 Jun 2025 10:26:42 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/hv: fcopy: Fix irregularities with size of ring
 buffer
To: Olaf Hering <olaf@aepfle.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>, linux-hyperv@vger.kernel.org
References: <20250620070618.3097-1-namjain@linux.microsoft.com>
 <20250621070644.3b4185b6.olaf@aepfle.de>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20250621070644.3b4185b6.olaf@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/21/2025 10:36 AM, Olaf Hering wrote:
> Fri, 20 Jun 2025 12:36:18 +0530 Naman Jain <namjain@linux.microsoft.com>:
> 
>> +	desc = (unsigned char *)malloc(ring_size * sizeof(unsigned char));
> 
> Is this cast required?
> 
> 
> Olaf

This should not be required, will remove it. Thanks for catching this!

Regards,
Naman

