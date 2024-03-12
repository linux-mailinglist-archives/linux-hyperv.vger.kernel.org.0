Return-Path: <linux-hyperv+bounces-1723-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0DE878E15
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 06:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70CADB21966
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Mar 2024 05:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BF0C2FD;
	Tue, 12 Mar 2024 05:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jx6WGBAV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE33D546;
	Tue, 12 Mar 2024 05:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710219843; cv=none; b=nTTW1AVxJv5gi/PNSS2KNTlBp6QxZFVEfy3nmuIzKoxqP40SafLigPzlL5LK5mjsh24ZiQtw66ou4coiwXd35hkeRAt5/uC5bqj1+kwY8B7JI7DnmSgtoH3ue/NovJrwAGMfAC56Ce/Qmh8qFgvFPPSP1HZyh+YSkDdH83lKV+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710219843; c=relaxed/simple;
	bh=8neXfi2X+WVQhguox54JUzmChFdmDP9K5OhnCl/lVLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GBpuwIxR52B4/c+m7eDp2SlqydRBTkxoJU15Nuax1L46d/5PnItb9Q/p2/al+qPwtNX0b6LgAoNED8NIYeJLTJAmb6tuRnEm49yw2nOnW40yTiuGOxAtvja6R+Z1soTuCgytzm7fmNZLHXF65BPP9978Qzp9gSjyQwjf3ETpo1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jx6WGBAV; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710219841; x=1741755841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8neXfi2X+WVQhguox54JUzmChFdmDP9K5OhnCl/lVLA=;
  b=Jx6WGBAVmF+LY9Y0DcUMt/dTraXv4aTmyqz+De6TEEEYEOIs6f//TNoq
   eiwAWsc48xgFqc44CobuR/hMJ8l0kOPg6qA6nL05PDi6BxSMSPjWfN0qC
   PIFgG9uY/6JMmd/k+yGnOmeuCJsw1Vn9KKEhSDKddhoiAmQwbwcjDE33L
   7Tam02pH8sHZgolxIitVGde3yVkLrknXq+ohr8KoQFNaWO2s2PReGv+Th
   Y7c/e0PSJCzVjhxEGBT59fsle4nTB3cTJJTEaG/9Z5nSPL0OlzD1YEDsQ
   ZRKw6gFf18JEvDvpFOC/2TwLBluqpJ+B7zRbjswzPeB8bmprGx69ytGzf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="15639665"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="15639665"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:04:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11834932"
Received: from sbrowne-mobl.amr.corp.intel.com (HELO [10.209.68.239]) ([10.209.68.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:03:59 -0700
Message-ID: <9cfe5fb6-5373-46a8-aec8-766dac6ddb69@linux.intel.com>
Date: Mon, 11 Mar 2024 22:03:59 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] hv_netvsc: Don't free decrypted memory
Content-Language: en-US
To: mhklinux@outlook.com, rick.p.edgecombe@intel.com, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kirill.shutemov@linux.intel.com,
 dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-coco@lists.linux.dev
Cc: elena.reshetova@intel.com
References: <20240311161558.1310-1-mhklinux@outlook.com>
 <20240311161558.1310-4-mhklinux@outlook.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240311161558.1310-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/11/24 9:15 AM, mhkelley58@gmail.com wrote:
> From: Rick Edgecombe <rick.p.edgecombe@intel.com>
>
> In CoCo VMs it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to
> take care to handle these errors to avoid returning decrypted (shared)
> memory to the page allocator, which could lead to functional or security
> issues.
>
> The netvsc driver could free decrypted/shared pages if
> set_memory_decrypted() fails. Check the decrypted field in the gpadl
> to decide whether to free the memory.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
LGTM

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>  drivers/net/hyperv/netvsc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 82e9796c8f5e..70b7f91fb96b 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -154,8 +154,11 @@ static void free_netvsc_device(struct rcu_head *head)
>  	int i;
>  
>  	kfree(nvdev->extension);
> -	vfree(nvdev->recv_buf);
> -	vfree(nvdev->send_buf);
> +
> +	if (!nvdev->recv_buf_gpadl_handle.decrypted)
> +		vfree(nvdev->recv_buf);
> +	if (!nvdev->send_buf_gpadl_handle.decrypted)
> +		vfree(nvdev->send_buf);
>  	bitmap_free(nvdev->send_section_map);
>  
>  	for (i = 0; i < VRSS_CHANNEL_MAX; i++) {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


