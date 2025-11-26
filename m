Return-Path: <linux-hyperv+bounces-7835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 61381C883AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 07:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 354B8352C4D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 06:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F1722154F;
	Wed, 26 Nov 2025 06:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CqVULmqe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72151D7995;
	Wed, 26 Nov 2025 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137731; cv=none; b=N5y5Lf0nMuz4vcg455aDwDaXB25/kXJ8/GITwjs0iHiTncTJ1jrsQYG3XOLPYpoAWCBsFlekbmNH3dZNqXigRsxeYEVuhQ7G+6E9qMWXVf7n2MEzm5pmOoPWMrNk2GvCN1yMVPIekGSxCh9fRaFFdcZ1XuHkcY7IyLV6OCr6oMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137731; c=relaxed/simple;
	bh=LpBcEy8bnxtMa8mq6ZQdHo94SI6kk0VpssK47nsOWj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXmMBRKOuOi4Uyvf8PNqGlEdEQd0Nq46STXdCeCbnlg2ndmnTNkhX8C/aZ9RlvnQxxj2bwl/eewjt2OUnPGPleuTejxJ83AIEXeKrWzyKmcgQZS9D++FfNICdaW+4GtEBX3Mx5AU6GZ2pxdwwqCIwh0wvhAeVdkezSnbGZNvY6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CqVULmqe; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.66.235] (unknown [167.220.238.139])
	by linux.microsoft.com (Postfix) with ESMTPSA id D482F2120EB5;
	Tue, 25 Nov 2025 22:15:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D482F2120EB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764137729;
	bh=oBNpyNmU+M6ZcEV7fHhlIGTKM9KfZA0mvfPsglQ09yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CqVULmqe5Kq1TXCs29vv1QjWMTRsk+gM96OZtvKJHtWxpRJtBSr4Mv0olgzu69dvm
	 Y0io2JA4ug8Wg5svnXEkKJsA0LIGXKCFxNBU98YnqYr5IlbE9D1mpaiM9wo2onCvVt
	 OWOB0akANdM7TKuBIT93o3fp3l6fvTRq8t1j35f4=
Message-ID: <9f9f63aa-f4a9-4747-9ff0-3d18b7f3c2fb@linux.microsoft.com>
Date: Wed, 26 Nov 2025 11:45:23 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 and older] uio_hv_generic: Enable user space to manage
 interrupt_mask for subchannels
To: Salvatore Bonaccorso <carnil@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Tianyu Lan <tiala@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Peter Morrow <pdmorrow@gmail.com>
References: <20251115085937.2237-1-namjain@linux.microsoft.com>
 <2025112109-legroom-resend-643f@gregkh> <aSBeVyYD2HQ5zNbC@eldamar.lan>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aSBeVyYD2HQ5zNbC@eldamar.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/21/2025 6:13 PM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Fri, Nov 21, 2025 at 11:10:43AM +0100, Greg Kroah-Hartman wrote:
>> On Sat, Nov 15, 2025 at 02:29:37PM +0530, Naman Jain wrote:
>>> From: Long Li <longli@microsoft.com>
>>>
>>> Enable the user space to manage interrupt_mask for subchannels through
>>> irqcontrol interface for uio device. Also remove the memory barrier
>>> when monitor bit is enabled as it is not necessary.
>>>
>>> This is a backport of the upstream commit
>>> d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
>>> with some modifications to resolve merge conflicts and take care of
>>> missing support for slow devices on older kernels.
>>> Original change was not a fix, but it needs to be backported to fix a
>>> NULL pointer crash resulting from missing interrupt mask setting.
>>>
>>> Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
>>> removed the default setting of interrupt_mask for channels (including
>>> subchannels) in the uio_hv_generic driver, as it relies on the user space
>>> to take care of managing it. This approach works fine when user space
>>> can control this setting using the irqcontrol interface provided for uio
>>> devices. Support for setting the interrupt mask through this interface for
>>> subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
>>> for all channels on the device"). On older kernels, this change is not
>>> present. With uio_hv_generic no longer setting the interrupt_mask, and
>>> userspace not having the capability to set it, it remains unset,
>>> and interrupts can come for the subchannels, which can result in a crash
>>> in hv_uio_channel_cb. Backport the change to older kernels, where this
>>> change was not present, to allow userspace to set the interrupt mask
>>> properly for subchannels. Additionally, this patch also adds certain
>>> checks for primary vs subchannels in the hv_uio_channel_cb, which can
>>> gracefully handle these two cases and prevent the NULL pointer crashes.
>>>
>>> Signed-off-by: Long Li <longli@microsoft.com>
>>> Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
>>
>> This is a 6.12.y commit id, so a fix for 6.6.y does not make sense :(
> 
> Should maybe be updated to reflect the original upstream commit. In
> fact b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of
> interrupt mask") was backported to various stable series:
> 
> v5.4.301: 540aac117eaea5723cef5e4cbf3035c4ac654d92 uio_hv_generic: Let userspace take care of interrupt mask
> v5.10.246: 65d40acd911c7011745cbbd2aaac34eb5266d11e uio_hv_generic: Let userspace take care of interrupt mask
> v5.15.195: a44f61f878f32071d6378e8dd7c2d47f9490c8f7 uio_hv_generic: Let userspace take care of interrupt mask
> v6.1.156: 01ce972e6f9974a7c76943bcb7e93746917db83a uio_hv_generic: Let userspace take care of interrupt mask
> v6.6.112: 2af39ab5e6dc46b835a52e80a22d0cad430985e3 uio_hv_generic: Let userspace take care of interrupt mask
> v6.12.53: 37bd91f22794dc05436130d6983302cb90ecfe7e uio_hv_generic: Let userspace take care of interrupt mask
> v6.17.3: e29587c07537929684faa365027f4b0d87521e1b uio_hv_generic: Let userspace take care of interrupt mask
> 
> And Peter just confirmed in
> https://lore.kernel.org/stable/CAFcZKTyOcDqDJRB4sgN7Q-dabBU0eg7KKs=yBJhB=CNDyy7scQ@mail.gmail.com/
> that he is seeing the problem now as well after updating from
> 6.1.153-1 to 6.1.158-1 in Debian.
> 
>>> Closes: https://bugs.debian.org/1120602
>>> Cc: <stable@vger.kernel.org> # 6.6.x and older
>>
>> How "old" do you want this?  Can you fix the Fixes: line up and resend
>> with this info?

Hi Greg,

Sorry for replying late, as I was away for personal reasons since last week.

I'll change the commit to reflect upstream commit id and resend the 
patch and also include the exact older kernels info in the stable tag.

> 
> It is at least relevant for back in 6.1.y now, but I'm not sure about
> the older series. I will let Naman speak up.
> 
> I guess the proper fixes tracking is a bit "tricky" because it only
> affected some of the stable series, namely those which had a backport
> of b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of interrupt
> mask") done before the including a backport of d062463edf17
> ("uio_hv_generic: Set event for all channels on the device"). So this
> is the reason why we seeing it first in 6.12.y stable series (but now
> as well on olders), but not a problem on 6.17.y.
> 
> Hope this explanation helps, please keep in mind that I'm no expert
> here by no means, just helping to report it from downstream Debian up
> here.
> 
> Regards,
> Salvatore
Thanks Salvatore for chiming in. I was under the impression that the 
commit ids remain same across different kernel versions for the same 
commit, but that was completely wrong.

Regards,
Naman

