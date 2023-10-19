Return-Path: <linux-hyperv+bounces-560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA77CFF45
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 18:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C91C20835
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Oct 2023 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC4D321B5;
	Thu, 19 Oct 2023 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V0DayayE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AED314
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 16:18:20 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id C29FF114
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Oct 2023 09:18:19 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id ECDDC20B74C0;
	Thu, 19 Oct 2023 09:18:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ECDDC20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697732299;
	bh=iWNnJ4ipSrAKi9jrgJAtNwiYBggkVi3kjOWcjgUO2FM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=V0DayayEKwKlespH/Q3Uwo1WsAtrPXW6jGSOkceVWJeA1uInVUrtM9fNb+ChmwCfk
	 qLP+HUp2kaghSe9p+w2yhqxSL1HBi4BPwlRpb2t6UO9+mFv91un3dyLIU2YUMMJ4Aw
	 fMXC5BJOCzu5dJZCFerajE0JCplIIrHX0xkJyp68=
Message-ID: <d6e7e256-8267-4202-80e4-5412419bc882@linux.microsoft.com>
Date: Thu, 19 Oct 2023 09:18:19 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect definition of hv_enable_vp_vtl in hyperv-tlfs.h
Content-Language: en-US
To: Alex Ionescu <aionescu@gmail.com>, linux-hyperv@vger.kernel.org
References: <CAJ-90N+sS6tuzMtRLOSan7WMZZ2g1H-iFc1F1ne631d2kgoi_g@mail.gmail.com>
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <CAJ-90N+sS6tuzMtRLOSan7WMZZ2g1H-iFc1F1ne631d2kgoi_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/16/2023 4:49 AM, Alex Ionescu wrote:
> Hi,
> 
> In arch/x86/include/asm/hyperv-tlfs.h, the following definition at
> line 786 (in Linus' tree), I believe to be incorrect.
> 
> struct hv_enable_vp_vtl {
>      u64                partition_id;
>      u32                vp_index;
>      union hv_input_vtl        target_vtl; <==== Here
> 
> For this hypercall, the TLFS and MSDN documentation states this field
> is HV_VTL (u8) and not HV_INPUT_VTL (the bit-field used for targeting
> hypercalls to specific target VTLs, which is not the case here).
> 
> I realize this is essentially a no-op in code at the moment, but for
> correctness should be addressed? I'm happy to make a patch, but wanted
> to make sure this isn't a mistake in TLFS/MSDN to begin with
> (although, my copy of GDK headers would corroborate it's indeed HV_VTL
> as well).
> 
> Best regards,
> Alex Ionescu

Hi Alex,

I checked the code to make sure - seems like the TLFS doc is correct. It
should indeed be HV_VTL (u8).

Feel free to submit a patch.

Thanks
Nuno

