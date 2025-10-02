Return-Path: <linux-hyperv+bounces-7065-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B90E3BB58C5
	for <lists+linux-hyperv@lfdr.de>; Fri, 03 Oct 2025 00:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632E419E0F72
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 22:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DCC2737E0;
	Thu,  2 Oct 2025 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EsFSt/xu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F16266B6F;
	Thu,  2 Oct 2025 22:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759444659; cv=none; b=CO9b8Oaw8SC+SOD7TOBX85+53knYYmrC6zePGKQAu28PD1A8zjV9QmjQ4Z/W9kVayzdCOsJcOn854cDFGyyvdDWLVktR+TWPWUq1KTJmBjU9V66vXv1pgm0pAXo7E11rGcttEv7fYAm7jyMYi8vTBm7W+l4bFY/oZHbzGZ5x47c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759444659; c=relaxed/simple;
	bh=glxXi3s7SsWLEGnP/z02jMbfL1lvWc/8ntYZFo6/alQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5UBBAv0PEuKBL4thrcwl/Uy//BLx+m0DECBrzJMQRqgnuR8BRJk7JE93XSQGSyvfp1U7g4Z9PaRWy4BbUTGVmUS/u98ahlB96SCJ5ZD2gnA3DHUgjEDdZZ7ABqmLlfvUcz8LX5lb3XhUoE2ckAibSOJtcJBw13bk6Nl5qwGyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EsFSt/xu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3D49211B7D4;
	Thu,  2 Oct 2025 15:37:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3D49211B7D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1759444657;
	bh=q4t6CPSFh/vjJF+Z/QnmUlzUbKPkM8VdDIkJASMLvfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsFSt/xuJVFoAvAtNChbTDaekzczb/Sb8fDWuhi9aOClTVJh1OsaX1wXoamQ8RAoq
	 JebCIE1x0D6tfNxU+imZWRDKQMS5azv+JrzbiaA5pdqxYGkQXgxM4/AvydSvd9Gn2Y
	 V0P0HlcvIwyeu+nRBN33deeZZmvM+XNcYRHx9VbA=
Date: Thu, 2 Oct 2025 15:37:35 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drivers: hv: Use -ETIMEDOUT for HV_STATUS_TIME_OUT
 instead of -EIO
Message-ID: <aN7-ryUqFNpgsIzI@skinsburskii.localdomain>
References: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002221347.402320-1-easwar.hariharan@linux.microsoft.com>

On Thu, Oct 02, 2025 at 10:13:46PM +0000, Easwar Hariharan wrote:
> Use the -ETIMEDOUT errno value as the correct 1:1 match for the
> hypervisor timeout status
> 

The commit message should answer the question why this change is being
made.
Is there a practical reason for this or is it only for consistensy?

Thanks,
Stanislav

> Fixes: 3817854ba89201 ("hyperv: Log hypercall status codes as strings")
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 49898d10fafff..9b51b67d54cc8 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -781,7 +781,7 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_INVALID_LP_INDEX,		-EIO),
>  	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EIO),
>  	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
> -	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
> +	_STATUS_INFO(HV_STATUS_TIME_OUT,			-ETIMEDOUT),
>  	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
>  	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
>  #undef _STATUS_INFO
> -- 
> 2.43.0

