Return-Path: <linux-hyperv+bounces-3476-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D69F1523
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 19:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C1637A0F66
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Dec 2024 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F31E47DD;
	Fri, 13 Dec 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PWYQ1wgH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5301EB9F8;
	Fri, 13 Dec 2024 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115436; cv=none; b=JHt0U1ppknQaDnC70G4dqz91MeMt74tQoDWRiIMgPkb2TJPvfhCXouFwD55WifZd84G61fPW2n+/mDz0RceD2OigqgOszkQYjHssLRF4FJAoMp33rxG8ZQWLoyqzl4zqC485KXeOaVZYymMEdBxJt4R3JaOyj79eqwJRTv1gZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115436; c=relaxed/simple;
	bh=Q6zLz2bmojhmOJOh/rBq+Fy6cuzFn1bweS5FwE8wyVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e48j4cTWKoumT+jp0bG6aez7so3K+SNeDm8uaMkRu/qCXa9ulPP9eyxb9rDIqjctP3dl7Xc0y3AvOHl2Ft6dSvqDmE+iPFWGR5JhvxaCDvoj3rSWsf6yorVy57x0spIeIuRvcDG2JL63mDdgMWaydQ7baO5emKTzgFep55w/QwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PWYQ1wgH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0886620BCAD0;
	Fri, 13 Dec 2024 10:43:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0886620BCAD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734115430;
	bh=UrDyvgO6ZPT7ZVpI6U07cePW8U77+X2SF48HloIFiXE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PWYQ1wgH2P+Q31Mqv3PePoIQfmLJPKWrBXRbTmiA5ewlRfx3iyD+T07PjhoTCv4sU
	 /0/oPgB+sDnCZBCoCtBYAytUTLo5p4j5luDJpLO3X4VHacOA7m12EMVnva+1fLNJkH
	 2qaRdVlP1nrV3bQLqujEb9XGEvZB8qIZy5nwpFBE=
Message-ID: <130fb73d-110e-4aec-9491-371da9d0e338@linux.microsoft.com>
Date: Fri, 13 Dec 2024 10:43:49 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: hyperv: Add overview of guest VM
 hibernation
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20241212231700.6977-1-mhklinux@outlook.com>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <20241212231700.6977-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/2024 3:17 PM, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Add documentation on how hibernation works in a guest VM on Hyper-V.
> Describe how VMBus devices and the VMBus itself are hibernated and
> resumed, along with various limitations.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   Documentation/virt/hyperv/hibernation.rst | 312 ++++++++++++++++++++++
>   Documentation/virt/hyperv/index.rst       |   1 +
>   2 files changed, 313 insertions(+)
>   create mode 100644 Documentation/virt/hyperv/hibernation.rst
> 
> diff --git a/Documentation/virt/hyperv/hibernation.rst b/Documentation/virt/hyperv/hibernation.rst
> new file mode 100644
> index 000000000000..9e177c1f5bae
> --- /dev/null
> +++ b/Documentation/virt/hyperv/hibernation.rst
> @@ -0,0 +1,312 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +

---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8

> +Considerations for Guest VM Hibernation
> +---------------------------------------
> +Linux guests on Hyper-V can also be hibernated, in which case the
> +hardware is the virtual hardware provided by Hyper-V to the guest VM.
> +Only the targeted guest VM is hibernated, while other guest VMs and
> +the underlying Hyper-V host continue to run normally. While the
> +underlying Windows Hyper-V and physical hardware on which it is
> +running might also be hibernated using hibernation functionality in
> +the Windows host, host hibernation and its impact on guest VMs is not
> +in scope for this documentation.
> +
> +Resuming a hibernated guest VM can be more challenging than with
> +physical hardware because VMs make it very easy to change the hardware
> +configuration between the hibernation and resume. Even when the resume
> +is done on the same VM that hibernated, the memory size might be
> +changed, or virtual NICs or SCSI controllers might be added or
> +removed. Virtual PCI devices assigned to the VM might be added or
> +removed. Most such changes cause the resume steps to fail, though
> +adding a new virtual NIC, SCSI controller, or vPCI device should work.
> +

Would it be useful mentioning the (likely lethal for the VM) risk
of copying the hibernated VM to another host (of the same arch) that has
another set of CPUID bits/features?

---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8

> +Key-Value Pair (KVP) Pseudo-Device Anomalies
> +--------------------------------------------

---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8


> +Virtual PCI devices
> +-------------------
> +Virtual PCI devices are physical PCI devices that are mapped directly


---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8 ---->8

Appreciated documenting all the intricacies of the hibernation and
resume paths for various devices, an incredible read! Are there
any special considerations known to you for the hibernation of
the devices driven through the Hyper-V UIO?

> +out-of-the-box by local Hyper-V and so requires custom scripting.
> diff --git a/Documentation/virt/hyperv/index.rst b/Documentation/virt/hyperv/index.rst
> index 79bc4080329e..c84c40fd61c9 100644
> --- a/Documentation/virt/hyperv/index.rst
> +++ b/Documentation/virt/hyperv/index.rst
> @@ -11,4 +11,5 @@ Hyper-V Enlightenments
>      vmbus
>      clocks
>      vpci
> +   hibernation
>      coco

Besides these two questions, LGTM.

-- 
Thank you,
Roman


