Return-Path: <linux-hyperv+bounces-7708-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA86C716BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Nov 2025 00:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37BA64E542F
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 23:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AA432AACA;
	Wed, 19 Nov 2025 23:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QvgWhN/P"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB332B999;
	Wed, 19 Nov 2025 23:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593778; cv=none; b=Y884FoV3EpalBDioqERbxLkZ56z8sxEq+c7ehSobYhTZzZhiTp+U7w8YL7BmxVgzituRbKqBodoqFne7uho7WahEvqjODnFKzjCqkQRQpBHvG3EuL+gnVj0fjraUjOTun4q12b0nJF3xUlu5kjKksQ3U/ROBlOAu0kF0pqurZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593778; c=relaxed/simple;
	bh=34TBn5bQilrtM8x3rqaiBRft68uj+bFgPXE57W6VQ7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sOMXQ0rkkBMla0ZgVtd381+3j9XlPTrBWiRNjNZ/KXr97TqfFA+6FtrsRPFiNXNbWlbXvIZGuYI2sQ/0MTwrCbhV9FBbzLR4Tm2iNXOoiPTeETzIdDRnajbdjF5a+wLR5CUpl+6y95oTAzwzJtuIgPJZLQt60P4vkVsQl9ONhxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QvgWhN/P; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.161.83] (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B4B8201AE75;
	Wed, 19 Nov 2025 15:09:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B4B8201AE75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763593773;
	bh=sgZCzxS5afrHIPcBpvtQ2UGcvZt6K0oeVqNebsfqxdg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QvgWhN/PMgiOQt4GvEaNgH4GZmF0ofHzXLOkTgAkEDn0s1eCLTi29ji6+aN658Cky
	 f6RJEJSC+vs2x/8D5ABbk0wRZ8y9wErqZ6dQLlgJQt10TBQr1N+HizaU2r/m5SWAGq
	 s9wFVenzi/ZGMEVaGa4FItzt+suFAZCpKK0bLfHw=
Message-ID: <b7170d08-8cd2-4add-8abd-8013017203c9@linux.microsoft.com>
Date: Wed, 19 Nov 2025 15:09:28 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
To: Anirudh Rayabharam <anirudh@anirudhrb.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251119171708.819072-1-anirudh@anirudhrb.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20251119171708.819072-1-anirudh@anirudhrb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/2025 9:17 AM, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Allow MSHV_ROOT_HVCALL IOCTL on the /dev/mshv fd. This IOCTL would
> execute a passthrough hypercall targeting the root/parent partition
> i.e. HV_PARTITION_ID_SELF.
> 
> This will be useful for the VMM to query things like supported
> synthetic processor features, supported VMM capabiliites etc.
> 
> Since hypercalls targeting the host partition could potentially perform
> privileged operations, allow only a limited set of hypercalls. To begin
> with, allow only:
> 
> 	HVCALL_GET_PARTITION_PROPERTY
> 	HVCALL_GET_PARTITION_PROPERTY_EX
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
> 
> v3: restricted the allowed self-targeted passthrough hypercalls to
>     smaller, carefully selected list.
> v2: rebased on latest hyperv-next
> 
> ---
>  drivers/hv/mshv_root_main.c | 47 ++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 9 deletions(-)
> 
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>


