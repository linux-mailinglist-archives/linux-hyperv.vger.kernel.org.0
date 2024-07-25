Return-Path: <linux-hyperv+bounces-2584-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F38293C64E
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 17:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0731C21127
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2024 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F9619CCEA;
	Thu, 25 Jul 2024 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="raIEqyh/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B26D1993AE;
	Thu, 25 Jul 2024 15:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921004; cv=none; b=H0F/4amMg8FMLUrn/BY19LycDk7UxGftjbUUinunbZj+PFq/LUWo/bUHqtBJI1p2bVdKQjXYxaOL9Pk/SVxiVHrghKROC7bc8FX/Wsw6lc/a5T3j2s/0hHMgK3WQOdhIDgcDJ9Lb/HNiefJhGkKHVB5gY/so26RKtzVhqE2s3tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921004; c=relaxed/simple;
	bh=gISgBJP8K+0f5fkIHLXqx+gYvibvOs2vBfW4ph9EQ14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpQOSCYJtGiiIguzwu/wurf+JTprQbwHMM2me3Vi5/IibgvBRvKmmRHOaq36HlEkKXa9lzXfrk6O9Hj8WgvisUXaj/czL46d6OhTrDUFdPJzFNHdy0ZuDel/LCf4iEH4U98G/a76o8SPFQnvVuLvFtuPbK0nByC4/GvVICRzFrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=raIEqyh/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.0.0.114] (c-67-182-156-199.hsd1.wa.comcast.net [67.182.156.199])
	by linux.microsoft.com (Postfix) with ESMTPSA id F26F120B7165;
	Thu, 25 Jul 2024 08:23:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F26F120B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721921003;
	bh=f/OdYnIaYGe0Uwf7xV80gfw5zzsB5T+crnI+/IOcs3E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=raIEqyh/TO3whk0f3/80L36IhTzzUoNtuAHI3ksnoZI6+qcE/CSMf29qRXzIBfEU6
	 siS2oW3ZzSM+IDRWxL9n4zYuU/DuZvwvhVONrOk6pqe0Go2grgZ2rvxNTvwjQUtRUT
	 SLDJ4x+UlE0v8NTW3sHT2SjKwq7VpOACW7MvFHQ8=
Message-ID: <133be5cb-761e-4646-96ec-b6b53f0c1097@linux.microsoft.com>
Date: Thu, 25 Jul 2024 08:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: Deferring per cpu tasks
To: Saurabh Sengar <ssengar@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com, srivatsa@csail.mit.edu
References: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <1721885164-6962-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/2024 10:26 PM, Saurabh Sengar wrote:
> Currently on a very large system with 1780 CPUs, hv_acpi_init takes
> around 3 seconds to complete for all the CPUs. This is because of
> sequential synic initialization for each CPU.
> 
> Defer these tasks so that each CPU executes hv_acpi_init in parallel
> to take full advantage of multiple CPUs.

I think you mean hv_synic_init() here, not hv_acpi_init()?

> 
> This solution saves around 2 seconds of boot time on a 1780 CPU system,
> that around 66% improvement in the existing logic.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
> 

LGTM otherwise.

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>


