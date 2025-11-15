Return-Path: <linux-hyperv+bounces-7611-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B63C601DF
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 10:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1714A35713F
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Nov 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A83245021;
	Sat, 15 Nov 2025 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BO9M39Zl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0361CAA6C;
	Sat, 15 Nov 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763197372; cv=none; b=QjOF0RWlaPsZ0XlbfpKEe/C2Z+8mdZ9KybHovadoRKMM2x3L3Rjv9475w5BaM8FP/uUgKvAaWIln4BcSNdSGcEKvVC+mj5ip04VnHRV+mlPdTMpQAM7BaEotdgAHQRxmbZF1s5ApDFpAL30dOaBZAmpuaLgeEJ86S2fyYNOEKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763197372; c=relaxed/simple;
	bh=MFhj0c7yb3Zy2rIiFDCeNqZFebJE1RHkwCVsysXsxn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INgXeCsGeUQ/Yv9sVl/qS8xGJa9mH5/WEbiLIz8T2UaOg+wkNbYCihWmPMRuycw0xkCv2j9Nql4GKMv+vR2troFa9vRC0nd4dcrDHrIJKXKzUVOIiEWgDFgzZiWgl+Ko3Ib+4TIOKEm9eQwSzZmlIRUQ+yzoOJTzWYk6TA0w8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BO9M39Zl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.96.58] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4A3D3201337F;
	Sat, 15 Nov 2025 01:02:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4A3D3201337F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763197370;
	bh=j12bqJz1UUsIUzbU8unfb3f0S+E9S1DDkX2ObKKmE7Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BO9M39Zl5SXfFcEp02eX5awjo9A8Qhkl+CV0iw2LuMECvEwL/wxCHAozgwrFIhYkU
	 1Yk1R4nYMvmk54Y3+ZIyWA05CopTgb9HrdcR6IvbSuA0M/2Q78qzOWXcfvyZ6ml01m
	 VHPBXieyQ0mZ+oatM5wc86KIzlltF0lJx+L/YOSI=
Message-ID: <dca120db-4751-4de8-961e-05ba701ca100@linux.microsoft.com>
Date: Sat, 15 Nov 2025 14:32:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12] uio_hv_generic: Set event for all channels on the
 device
To: Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Tianyu Lan <tiala@microsoft.com>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Salvatore Bonaccorso <carnil@debian.org>,
 Peter Morrow <pdmorrow@gmail.com>
References: <20251115085730.2197-1-namjain@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20251115085730.2197-1-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/15/2025 2:27 PM, Naman Jain wrote:
> From: Long Li <longli@microsoft.com>
> 
> Hyper-V may offer a non latency sensitive device with subchannels without
> monitor bit enabled. The decision is entirely on the Hyper-V host not
> configurable within guest.
> 
> When a device has subchannels, also signal events for the subchannel
> if its monitor bit is disabled.
> 
> This patch also removes the memory barrier when monitor bit is enabled
> as it is not necessary. The memory barrier is only needed between
> setting up interrupt mask and calling vmbus_set_event() when monitor
> bit is disabled.
> 
> This is a backport of the upstream commit
> d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
> with minor modifications to resolve merge conflicts.
> Original change was not a fix, but it needs to be backported to fix a
> NULL pointer crash resulting from missing interrupt mask setting.
> 
> Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
> removed the default setting of interrupt_mask for channels (including
> subchannels) in the uio_hv_generic driver, as it relies on the user space
> to take care of managing it. This approach works fine when user space
> can control this setting using the irqcontrol interface provided for uio
> devices. Support for setting the interrupt mask through this interface for
> subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
> for all channels on the device"). On older kernels, this change is not
> present. With uio_hv_generic no longer setting the interrupt_mask, and
> userspace not having the capability to set it, it remains unset,
> and interrupts can come for the subchannels, which can result in a crash
> in hv_uio_channel_cb. Backport the change to older kernels, where this
> change was not present, to allow userspace to set the interrupt mask
> properly for subchannels. Additionally, this patch also adds certain
> checks for primary vs subchannels in the hv_uio_channel_cb, which can
> gracefully handle these two cases and prevent the NULL pointer crashes.
> 
> Signed-off-by: Long Li <longli@microsoft.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")

Sorry for missing this, please add Closes tag, if possible before merging.

Closes: https://bugs.debian.org/1120602

I have kept it in the other patch for 6.6 and prior kernels.

Regards,
Naman

> Cc: <stable@vger.kernel.org> # 6.12.x
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---

Regards,
Naman

