Return-Path: <linux-hyperv+bounces-6539-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA877B270D6
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Aug 2025 23:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84008621BFE
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Aug 2025 21:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46427702D;
	Thu, 14 Aug 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tR8Th5QX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4551E247287;
	Thu, 14 Aug 2025 21:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755206928; cv=none; b=QSoDn5c0m4kRdJI/YIoQCmaKAjyDi2c2ACPwgxfpSiq7Al2GXg2S4Ewa2HpEP21lU4/EJi984mEQ32SXOq2HX5UzvFkVCAE1RJjSf1JXw++CPLCimwEbCPBUzTXV31SbZys61zePn3iehrPA8hYGZdgZngQ6XNydLk8rJ6qfD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755206928; c=relaxed/simple;
	bh=mAcDHWbIEiHY+ZG9LlsswHGxMuDBlqa6Js6gcQHODKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGhoni4OF4sg6iGoHhXxW9JhRG/NBJ/4Bj5oMadNHq0G0sTcdd/Ec/LW2plhm2a1RmHiohnw9YCl86TzVFEB0y4gvCUx+YEOiA8sEeeSm4cK6/KdnCMMOl8Q1CKb0wZhrWk1ArJE0js9ONqesg8scpr3Z5OEw8TvIamhF93BaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tR8Th5QX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6633C4CEED;
	Thu, 14 Aug 2025 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755206927;
	bh=mAcDHWbIEiHY+ZG9LlsswHGxMuDBlqa6Js6gcQHODKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tR8Th5QX5KJhk81DTVZXBWsbvfc4YhEslDBIcNQL1dr/wyv8wly6QksknnCDNf9pe
	 UtpfM0Y58S1ZA04x6XQ6RUG4V/tUvYjNWXsgmYzn9j264ePEuRFp7Yq06vaaafOXHH
	 CY08vzX/68rI87PQrG7QsGaGdbcp4h8SwtnNvXR0EiFmtLsRhnXDG71YXlGkqAbPA6
	 ef7Raih9qS/5nEKjnoc2aRS/+h6XDWufK20EhkDAm9FUqNaMMzSwo+xjH5HUTyznxD
	 27UXFrUTq9u7jIE9gMk7eQBJ90RvzG5hI7bSt76IvsT2Nv/BavmbfB0UBvsTnLMzEE
	 OcM/mweMdwkdw==
Date: Thu, 14 Aug 2025 21:28:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com
Subject: Re: [PATCH] hyperv: Add missing field to
 hv_output_map_device_interrupt
Message-ID: <aJ5VDshC2t48ziOq@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755109257-6893-1-git-send-email-nunodasneves@linux.microsoft.com>

On Wed, Aug 13, 2025 at 11:20:57AM -0700, Nuno Das Neves wrote:
> This field is unused, but the correct structure size is needed
> when computing the amount of space for the output argument to
> reside, so that it does not cross a page boundary.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

There doesn't seem to be a need to rush this through hyperv-fixes.

Queued into hyperv-next before Michael's patches.

> ---
>  include/hyperv/hvhdk_mini.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 42e7876455b5..858f6a3925b3 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -301,6 +301,7 @@ struct hv_input_map_device_interrupt {
>  /* HV_OUTPUT_MAP_DEVICE_INTERRUPT */
>  struct hv_output_map_device_interrupt {
>  	struct hv_interrupt_entry interrupt_entry;
> +	u64 ext_status_deprecated[5];
>  } __packed;
>  
>  /* HV_INPUT_UNMAP_DEVICE_INTERRUPT */
> -- 
> 2.34.1
> 

