Return-Path: <linux-hyperv+bounces-2637-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A936694298C
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2024 10:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DA6B2200B
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jul 2024 08:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5A1A8BF2;
	Wed, 31 Jul 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MZPw1gAC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391A718CBED;
	Wed, 31 Jul 2024 08:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722415785; cv=none; b=NElvX5v5hMXc9wdOQJ3+VE0RV7dNG5baSGZJHwuEzhz4IBdBjngUuyCrodv7AipXpeqClc8lri8NiVQZif6eym6/1UHbe/4TI64bHRL58dT73IP6C/W6AwMIaJhbeAgD0z7SyUm7G6IcLdMzyA3meQvivnc+8rIrmVcBgKi/vYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722415785; c=relaxed/simple;
	bh=zcTY/GqUfYE3yguTn78cETVE64YCw8EsY/LDEWceEGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oaZ6ISh2ll32x5F9aF4NAqb1ArWQQX4Mktk53f95QQNDpo4eGAcl98/P8cM+OLpKdP6HoLC+Zmh3ylKvN5To+qM19H18kafvw1OoxxeD0J6GmvAV9aSEW+jRHzb9jELuiVsWFbRDcYIHVWRHJTfrEtcn6z/WClctNZdkUEDo/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MZPw1gAC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.79.192.202] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id A9A4C20B7165;
	Wed, 31 Jul 2024 01:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A9A4C20B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722415781;
	bh=RDk+WVHxBeUm3xVFN39EW1/JZAEiQ71Gmv+Q/rbsnL4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MZPw1gACS8IkH89ctCMI5myecTJmMMcsK4MTAYUmAysGgVORi25CgqwXS45wxqvuS
	 hfNy9DrWgSCIz2Wdh3uEMS80Foo6phzbkBrL4fP3qs6T4CA83aLFUyzweEZfaLq5iV
	 pms0fjhLBpZT7waSSOnPZJ+muOhaE6PuPwX/hZIE=
Message-ID: <f9dfaf0e-2f72-4917-be75-78856fb27712@linux.microsoft.com>
Date: Wed, 31 Jul 2024 14:19:34 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
To: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
 Erick Archer <erick.archer@outlook.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed Zaki <ahmed.zaki@intel.com>,
 Colin Ian King <colin.i.king@gmail.com>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/30/2024 10:31 PM, Shradha Gupta wrote:
> Currently the values of WQs for RX and TX queues for MANA devices
> are hardcoded to default sizes.
> Allow configuring these values for MANA devices as ringparam
> configuration(get/set) through ethtool_ops.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>
> ---
>   Changes in v2:
>   * Removed unnecessary validations in mana_set_ringparam()
>   * Fixed codespell error
>   * Improved error message to indicate issue with the parameter
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 20 +++---
>   .../ethernet/microsoft/mana/mana_ethtool.c    | 66 +++++++++++++++++++
>   include/net/mana/mana.h                       | 21 +++++-
>   3 files changed, 96 insertions(+), 11 deletions(-)
> 

 From what I understand, we are adding support for "ethtool -G --set-
ring"  command.
Please correct me if I am wrong.

Maybe it would be good to capture the benefit/purpose of this patch in
the commit msg, as in which use-cases/scenarios we are now trying to
support that previously were not supported. The "why?" part basically.



Regards,
Naman Jain

