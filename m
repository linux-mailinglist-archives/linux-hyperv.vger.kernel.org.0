Return-Path: <linux-hyperv+bounces-7834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57835C883A6
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 07:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0CC83B4621
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0A63161AA;
	Wed, 26 Nov 2025 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EEjcqSNw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA9525F995;
	Wed, 26 Nov 2025 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137717; cv=none; b=G0WHt5btEyx86hTerFotBnprK4OWpYFMCEJw8a34yqsMXsfb9TMjgPcL/nEYfDstAj0org9qeDVb2Fh/FIsaa+iiElsecwmfgu/ZUlksua+8XLPasAm8oKrXgRins/kQdR4ZO2am1QNoaBl9b62tuxtUMHQRyMcOvePRtdzU1T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137717; c=relaxed/simple;
	bh=bdrLy/roSIjZ9hNJOVMpdv6owYEML9awCGFhifYXlJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KBI04WAhB114DwykO2QYQkVQKi69W1xnAaln9ocL6sqnR5cXk0gXZaMbw1S9h2Eb3xqspWZvgxegnMr06DC5NfmuHnHD3Dpn242n47/INDFmepKgKHda18G5ZOm9/g4QzuJyK4nn7Q+4w7MkHlXfa3CSj71WP5rZd+78nM0LM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EEjcqSNw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.66.235] (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id A95212120EAD;
	Tue, 25 Nov 2025 22:15:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A95212120EAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764137711;
	bh=Bc4hdbhO9YOVvNp4UyeZiT+DiaSSmhbUeWedsGko6NU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EEjcqSNwBdZmCZCHYQAJypX7uA5A89diI6v3IuVYWMDVxu8hmKBC0cL3v0TiQfGaN
	 3JI8F7jnNGfpDM6vzdSmN9U5gYZEizZ4sjFvHMF69BS8xJE6bOusdP/XHSrq80maLA
	 nmM0fVEHgnx06GxDN9dqhQkWXgi+BIhjknHWCcPY=
Message-ID: <d3f83ff0-2c4d-4698-a71d-1530b8a2bde7@linux.microsoft.com>
Date: Wed, 26 Nov 2025 11:45:05 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1120602: [REGRESSION 6.12.y] hyper-v: BUG: kernel NULL
 pointer dereference, address: 00000000000000a0: RIP:
 0010:hv_uio_channel_cb+0xd/0x20 [uio_hv_generic]
To: Peter Morrow <pdmorrow@gmail.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 1120602@bugs.debian.org,
 Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Tianyu Lan <tiala@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <aRYjk4JBqHvVl-wN@eldamar.lan>
 <7a38c04d-4e54-4f1a-96fd-43f0f11ab97b@linux.microsoft.com>
 <CAFcZKTwQgd9hrTaXnThML=+WG82TH3DK90FT1-WWsBSoRj7dRw@mail.gmail.com>
 <176298819854.487825.11724175116974643582.reportbug@p15v.lan>
 <18bcf829-04f9-46ec-a874-7c2b9338cf3d@linux.microsoft.com>
 <aRei1DGOWy13GqvE@eldamar.lan>
 <25aff5ca-b5e1-4907-bd12-6571f8454146@linux.microsoft.com>
 <CAFcZKTyOcDqDJRB4sgN7Q-dabBU0eg7KKs=yBJhB=CNDyy7scQ@mail.gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <CAFcZKTyOcDqDJRB4sgN7Q-dabBU0eg7KKs=yBJhB=CNDyy7scQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/2025 3:34 PM, Peter Morrow wrote:
> Hi Naman/Salvatore,
> 
> Is it possible to get this fixed in the 6.1 LTS series too? I just ran
> into this crash when moving from bookworm based Debian kernel
> 6.1.153-1 to 6.1.158-1. I saw that "uio_hv_generic: Let userspace take
> care of interrupt mask" appeared in 6.1.156.
> 
> Thanks,
> Peter.
> 


Hi Peter,
Yes, I have sent a patch for older kernel versions as well.
I am working to fix the review comments and send new revisions.

Here is the link:
https://lore.kernel.org/all/20251115085937.2237-1-namjain@linux.microsoft.com/


Regards,
Naman

