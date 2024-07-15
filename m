Return-Path: <linux-hyperv+bounces-2565-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675CA9315B7
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 15:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0F99B20D8D
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jul 2024 13:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92A18D4C1;
	Mon, 15 Jul 2024 13:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHzXoOTV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8241850B4;
	Mon, 15 Jul 2024 13:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721050128; cv=none; b=j1Jgt5sZPkqBKH2n6jjQ3INJp1adrw1TD57J0Q1bUKzWfTNJ9E4PfsTMQ2dLNZFWxfUdnqMzu8Yg0vsKux3eYCoazrDyK5Z0IVf6G1qKfq1df1bbnvzKNZxmtT2MzV6uwsMsd8gJ+znocGrTecquy95NOghlveh6hz+1ACr+Q/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721050128; c=relaxed/simple;
	bh=9NPVsR5qF98OX4W3Rn+cf8O6kvRmw1U+OlTkFbsCNBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgE4D2CfGKEIfVXvcVSKpk322D3U0CGSvlUVCAWnVUsWS1dDcfogn6vKwNyxtUi63f2KAoBaG5qM+dmJvvGtwYA9AkCcr8klvEon3BbM9Lr015fCknQJ2vYjhcv1bP5H/5lqJBLA9UKW94LycfL/G7Ry9LvcLC7bNCAv4VZsRFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHzXoOTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAF5C32782;
	Mon, 15 Jul 2024 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721050128;
	bh=9NPVsR5qF98OX4W3Rn+cf8O6kvRmw1U+OlTkFbsCNBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oHzXoOTVOKcEsPc1WEoh/AFThHux2OTJGaNexQJANwjAMCWyikuOdlE6QyIKasB/l
	 q4BG30mI64ZXRPBHlrQ9QcwQlLqi3WmIxqgdH1KHWx7NrkvyVj/+AJdn0BoDzJEhnH
	 aiojMvB0aB3Mj0Qyho1LyQrIA7Gx6wag6+MtwT0m9pFZeIoWboscVhfUCIygIgdz9Z
	 wW0JAylf0jOM5EsLR0LZ3u0Nrs387DyUPanj+p1TVXtpEKPwqTwUnDPoolO9sRF5U0
	 Kd4iuYiBUpDW00AxJ2Gvv6HwHHdFysGjue9gt3palot2fhKPwwm59PWtwqZjv0Mtvu
	 prF4NpSM1LLKw==
Date: Mon, 15 Jul 2024 14:28:42 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240715132842.GF45692@kernel.org>
References: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721014820-2507-1-git-send-email-shradhagupta@linux.microsoft.com>

On Sun, Jul 14, 2024 at 08:40:20PM -0700, Shradha Gupta wrote:
> Currently the values of WQs for RX and TX queues for MANA devices
> are hardcoded to default sizes.
> Allow configuring these values for MANA devices as ringparam
> configuration(get/set) through ethtool_ops.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Long Li <longli@microsoft.com>

...

> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h
> index e39b8676fe54..3e27ca5155aa 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -38,9 +38,21 @@ enum TRI_STATE {
>  
>  #define COMP_ENTRY_SIZE 64
>  
> -#define RX_BUFFERS_PER_QUEUE 512
> +/* This Max value for RX buffers is derived from __alloc_page()'s max page
> + * allocation calculation. It allows maximum 2^(MAX_ORDER -1) pages. RX buffer
> + * size beyond this value gets rejected by __alloc_page() call.
> + */
> +#define MAX_RX_BUFFERS_PER_QUEUE 8192
> +#define DEF_RX_BUFFERS_PER_QUEUE 512
> +#define MIN_RX_BUFFERS_PER_QUEUE 128
>  
> -#define MAX_SEND_BUFFERS_PER_QUEUE 256
> +/* This max value for TX buffers is dervied as the maximum allocatable

nit: derived

     Flagged by checkpatch --codespell



> + * pages supported on host per guest through testing. TX buffer size beyond
> + * this value is rejected by the hardware.
> + */
> +#define MAX_TX_BUFFERS_PER_QUEUE 16384
> +#define DEF_TX_BUFFERS_PER_QUEUE 256
> +#define MIN_TX_BUFFERS_PER_QUEUE 128
>  
>  #define EQ_SIZE (8 * MANA_PAGE_SIZE)
>  

...

