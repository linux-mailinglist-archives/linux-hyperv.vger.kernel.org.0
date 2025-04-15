Return-Path: <linux-hyperv+bounces-4916-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B38DA8A275
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 17:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE3A19018AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CC175D47;
	Tue, 15 Apr 2025 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P940ouPD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F72DFA42;
	Tue, 15 Apr 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729850; cv=none; b=TT/DjaKSXSh4WII6c3XLAFh5FPHpV20Cn81du7g3SwmIggzNWXIShix5t65lpgzFQA2eNBb9Lf3bO/xpmxIRIDNxqnCixDrqaXWqtXwgoggAAv1rRxsZreJs+bsAoW2SpXfCQstK402WPy2JwHCsyHe00qIWvE7qIUiS/A9Incg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729850; c=relaxed/simple;
	bh=O+gwOnhjyavqaM35YyMh2F8kVk/KcS+8tNTxAAWr0Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl6DSrNpApYil+TzW7/MaN/S6S2XXi2NUVVSDanEa7+M1bzQLRaAqDhRCV/Ujlb84rmrzVNkUi02uAYx9daWBR7HAYLHfTn1ZRyQ0RYd/lPRRCXWzcfOR8HqrBXDDDtDSqpuVVLGxHSmdS5+a4Uc/s/9Mzud2fbuhJdmRtuLWzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P940ouPD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02E5C4CEEB;
	Tue, 15 Apr 2025 15:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744729849;
	bh=O+gwOnhjyavqaM35YyMh2F8kVk/KcS+8tNTxAAWr0Mk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P940ouPD+MZr2C5qxy3lHq5NBKN7P7A7hSOdkf6CzUeXgRvKOVSlb0CK3+XHb6Jmh
	 8S/FGaO2Gq1cpqzC83dTmDGEs6qRJ32cv5z9ar+ZssVU5ISpe+5JKdMzcD4Hqdl3cp
	 7DLaSeGWolA6BgtXfIA5IHSZdFoZsqYyy4KpIoNQ=
Date: Tue, 15 Apr 2025 17:10:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025041527-cesarean-facial-cdca@gregkh>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
 <20250410060847.82407-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410060847.82407-2-namjain@linux.microsoft.com>

On Thu, Apr 10, 2025 at 11:38:46AM +0530, Naman Jain wrote:
> On regular bootup, devices get registered to VMBus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed
> and brought back, the channel rescinds and device again gets
> registered to VMBus. However this time, the uio_hv_generic driver is
> already registered to probe for that device and in this case sysfs
> creation is tried before the device's kobject gets initialized
> completely.
> 
> Fix this by moving the core logic of sysfs creation for ring buffer,
> from uio_hv_generic to HyperV's VMBus driver, where rest of the sysfs
> attributes for the channels are defined. While doing that, make use
> of attribute groups and macros, instead of creating sysfs directly,
> to ensure better error handling and code flow.
> 
> Problem path:
> vmbus_process_offer (new offer comes for the VMBus device)
>   vmbus_add_channel_work
>     vmbus_device_register
>       |-> device_register
>       |     |...
>       |     |-> hv_uio_probe
>       |           |...
>       |           |-> sysfs_create_bin_file (leads to a warning as
>       |                 primary channel's kobject, which is used to
>       |                 create sysfs is not yet initialized)
>       |-> kset_create_and_add
>       |-> vmbus_add_channel_kobj (initialization of primary channel's
>                                   kobject happens later)
> 
> Above code flow is sequential and the warning is always reproducible in
> this path.
> 
> Fixes: 9ab877a6ccf8 ("uio_hv_generic: make ring buffer attribute for primary channel")
> Cc: stable@kernel.org
> Suggested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/hyperv_vmbus.h    |   6 ++
>  drivers/hv/vmbus_drv.c       | 110 ++++++++++++++++++++++++++++++++++-
>  drivers/uio/uio_hv_generic.c |  39 ++++++-------
>  include/linux/hyperv.h       |   6 ++
>  4 files changed, 138 insertions(+), 23 deletions(-)

Always run checkpatch on a patch before submitting it for review :(


