Return-Path: <linux-hyperv+bounces-3159-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08EB9A49C5
	for <lists+linux-hyperv@lfdr.de>; Sat, 19 Oct 2024 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA17FB21F15
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Oct 2024 22:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00CE19047F;
	Fri, 18 Oct 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sBHZFEgx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D8A7485;
	Fri, 18 Oct 2024 22:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291981; cv=none; b=Tr9NrogGJN3Cfd8zOKjou1v1KteDgzj26BqeqFu134olCnJ0H8NOk/UCmmTJiUogTLI+fbANbwTYFs/6PFH0s8pOPdWS5Z0xS1u2o+lknLjTq0FYN3c/fb3/rTPcrkbwBmfHD9fBo7YzZT7ji5iEo83EzhHl10sZWFMSd/b4x88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291981; c=relaxed/simple;
	bh=qJAY9j9zLjKpVAKpCwwy9rLbdmzVv8D6yGxMY76ABpc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T2Bd9/vWELlU9GZJW3vudEZ69doKWHgUAJc+M0KGyEJqN07T97OBwJTpMh2Habt1IAAXWghIdXKkCX1mz3ykp6UODWCPTawqHUf2JNgLSg7sxYY9vKyz/TCOLbvSfgBLjOCqduqfx3EqTFwCY6eLZN5eC81IiB2ZO/5Hfq6T76s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sBHZFEgx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9AE8420FFD88;
	Fri, 18 Oct 2024 15:52:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AE8420FFD88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729291979;
	bh=cxL/Ws+M0z4R2zUfD/dcNWKSQTSiGPFaEHwUtal1xCw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=sBHZFEgxYm5u2n8/RD8IGiNLJgRS+ygm+ZxOLS1A4lhAWZI9DxQZqjg2QtU4V/cgZ
	 EURIjp7HLE/bZiTj99y3cNvSoXb0s1X0fbHyRbDnKqXA885RePWgiWWEV65WuvEIkb
	 d8x8g8aQO/K423mCHqT4oDTS7i/k5MZprbYTp250=
Message-ID: <12eb9ee0-b264-41f5-974e-eb564043cfcf@linux.microsoft.com>
Date: Fri, 18 Oct 2024 15:52:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 1/2] Drivers: hv: vmbus: Wait for offers during boot
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-2-namjain@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241018115811.5530-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/2024 4:58 AM, Naman Jain wrote:
> Channels offers are requested during vmbus initialization and resume
> from hibernation. Add support to wait for all channel offers to be
> delivered and processed before returning from vmbus_request_offers.
> This is to support user mode (VTL0) in OpenHCL (A Linux based
> paravisor for Confidential VMs) to ensure that all channel offers
> are present when init begins in VTL0, and it knows which channels
> the host has offered and which it has not.
> 
> This is in analogy to a PCI bus not returning from probe until it has
> scanned all devices on the bus.
> 
> Without this, user mode can race with vmbus initialization and miss
> channel offers. User mode has no way to work around this other than
> sleeping for a while, since there is no way to know when vmbus has
> finished processing offers.
> 
> With this added functionality, remove earlier logic which keeps track
> of count of offered channels post resume from hibernation. Once all
> offers delivered message is received, no further offers are going to
> be received. Consequently, logic to prevent suspend from happening
> after previous resume had missing offers, is also removed.
> 
> Co-developed-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 38 +++++++++++++++++++++++---------------
>  drivers/hv/connection.c   |  4 ++--
>  drivers/hv/hyperv_vmbus.h | 14 +++-----------
>  drivers/hv/vmbus_drv.c    | 16 ----------------
>  4 files changed, 28 insertions(+), 44 deletions(-)

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

