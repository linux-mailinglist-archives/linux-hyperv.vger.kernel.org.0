Return-Path: <linux-hyperv+bounces-2102-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D278C44CC
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 May 2024 18:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54F041F2183D
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 May 2024 16:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BAE155335;
	Mon, 13 May 2024 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BYVzRYNE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C573C15532B;
	Mon, 13 May 2024 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616315; cv=none; b=KHiygQY2DmtFo4zLPAcTAnJE+rXRjDrrMnTmEPnAeIV4lmyy62nG3P14PVUhhEepjtbgiXdcQd6nj5Ld4YpmJiUVtMfAdkzSmDSY5MpQanLGk668aU8y1wNlTQAgVh/2SmlqhyZxazZFPtrb8aUwBgi4wyNe2nBTurwjjBJWsM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616315; c=relaxed/simple;
	bh=bYdJm1M3v/L/LA8S0gkxQxCLhbLs2/UBkzFhcNoQrlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LPOPDtwn7LASvbS9xpokvrUh9p2O4limvXasaDTm5gmmV/ZDhunYrx6RzEHGipviscT6wUqq17fJe84YmWFzkC5qDcxSzanSaBvdZB2HPka1AfXgtl0iAohFI07qMEE9rU+rnhSteG3jKKOM8i8O4g739PxhvqKqFo+mrnbKpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BYVzRYNE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.49.54] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CAEA2095CF2;
	Mon, 13 May 2024 09:05:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CAEA2095CF2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715616313;
	bh=kE8+KVkskLCGQvVL4hNflGzRevUkwjjByfB24ZBdHxg=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=BYVzRYNE+gHKTSHrMeNxeZPopZgLF36R3HpRx4q9K4Co94OwrRknyvFp28ZXT7kin
	 6tNs/7APYAbxg+rwmipkc9Df9K26s01L9NMOngjXI/vUCjYrbE5t14gR5rIK98252s
	 YDItUCe1o3rRjG/mau0qxnLjFWWvSisxKQrHsM3o=
Message-ID: <f072acf6-0c25-4199-aaec-f599530d10b2@linux.microsoft.com>
Date: Mon, 13 May 2024 09:05:12 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Documentation: hyperv: Improve synic and interrupt
 handling description
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, kys@microsoft.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240511133818.19649-1-mhklinux@outlook.com>
 <20240511133818.19649-2-mhklinux@outlook.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240511133818.19649-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2024 6:38 AM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current documentation does not describe how Linux handles the synthetic
> interrupt controller (synic) that Hyper-V provides to guest VMs, nor how
> VMBus or timer interrupts are handled. Add text describing the synic and
> reorganize existing text to make this more clear.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2:
> * In clocks.rst, made a hyperlink for the reference to VMBus documentation
>   [Easwar Hariharan]
> 
>  Documentation/virt/hyperv/clocks.rst | 21 +++++---
>  Documentation/virt/hyperv/vmbus.rst  | 79 ++++++++++++++++++----------
>  2 files changed, 66 insertions(+), 34 deletions(-)
> 

LGTM,

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>


