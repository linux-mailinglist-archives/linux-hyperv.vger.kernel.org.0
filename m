Return-Path: <linux-hyperv+bounces-4798-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA49AA7D370
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 07:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 759B23A909C
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Apr 2025 05:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1638A17A319;
	Mon,  7 Apr 2025 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXmR3Ut3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF378335BA;
	Mon,  7 Apr 2025 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744003451; cv=none; b=OU/O0uxjwuz/cfxI666+iC5QApORfRMF0L3rH6QTpYVSpfz444kJCcVfoestYH9gJDn7FrZWbWs17Rx2f3DtOS/2aqsIHCtWUMheAld1yDGpE/dpkOE0XCtrxXawosQPySElh+XoImTz+3HuDD7xQsZFS6alkJ9D1j+QbEuTqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744003451; c=relaxed/simple;
	bh=bbG86qY18isIZ/FMEvBXcR5TZXiKG+P/vVVbNorWs04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHtHrpA0S7LIRl4EVOgrjjcIvyU92IOfzXewDgGJD7af2MSR/Xyq9Hpz6qjYx7SFPznD+Cz6hMvSuyD8g+czh2Fo6PqqCDyIFpLszRaPBZySDOc46GQUZCJy81G3ZzDN2u/487hGSSylX8gybFm99C8q8+sY/RfCj3R21KLjiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXmR3Ut3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363F0C4CEDD;
	Mon,  7 Apr 2025 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744003450;
	bh=bbG86qY18isIZ/FMEvBXcR5TZXiKG+P/vVVbNorWs04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GXmR3Ut3+UdLMpGWSFoAVqLFSMIrC5e0N3wLjGnubpaZGwcSHj1wMXz3eVjtL2Kbf
	 AqQAOsfOOtPyJc6iwOugQ3Zho79JmKfvTFX2tvb+DmnHb8wK7VjetR4F96ug3Cr06v
	 JhEFxlB3wTWalBDwE6WCC3tZByVqfc6gdb7vZmNSp1OIh/Nl55D/ivvXjPayR6nlHx
	 o6WpmLhgVwnJ8OgAt7/XJfjk5PcU7yI0XRPd7GFymWVP+Glop33L6MSTo1Mbmg/yNt
	 Y0U362OIVFxHoiG1lU9OlpM1dMcwlZZG+oKinECLCz4HayTfFKXKaCgjdN6uKzJj+l
	 HiObnOqhBUypQ==
Date: Mon, 7 Apr 2025 05:24:08 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	mhklinux@outlook.com, decui@microsoft.com
Subject: Re: [PATCH] Drivers: hv: Fix bad pointer dereference in
 hv_get_partition_id
Message-ID: <Z_NheILh0exTxoo1@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1743528737-20310-1-git-send-email-nunodasneves@linux.microsoft.com>
 <b7102dfb-86e4-4a85-8444-de18258473f2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7102dfb-86e4-4a85-8444-de18258473f2@linux.microsoft.com>

On Thu, Apr 03, 2025 at 01:54:37PM +0530, Naman Jain wrote:
> 
> 
> On 4/1/2025 11:02 PM, Nuno Das Neves wrote:
> > 'output' is already a pointer to the output argument, it should be
> > passed directly to hv_do_hypercall() without the '&' operator.
> > 
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> > This patch is a fixup for:
> > e96204e5e96e hyperv: Move hv_current_partition_id to arch-generic code
> 
> You can add Fixes: tag, so that it gets ported to previous kernel, in case,
> it does not make it to 6.14.

This does not need to be ported to older kernels because the bug was
never released.

Wei.

> 
> 
> Regards,
> Naman
> 
> > 
> >   drivers/hv/hv_common.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index b3b11be11650..a7d7494feaca 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -307,7 +307,7 @@ void __init hv_get_partition_id(void)
> >   	local_irq_save(flags);
> >   	output = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > -	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> > +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output);
> >   	pt_id = output->partition_id;
> >   	local_irq_restore(flags);
> 

