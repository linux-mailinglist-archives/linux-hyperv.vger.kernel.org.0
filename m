Return-Path: <linux-hyperv+bounces-3574-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513DFA00D20
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F2C41884A0D
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Jan 2025 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5764A1FCD12;
	Fri,  3 Jan 2025 17:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQvmj+w4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81331FCD14;
	Fri,  3 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735926346; cv=none; b=u17FuUcDY5mZJa1iPyXXvko/Sk/ZrA59VkZtvmamob0tVTXCkAfFa8cOPPn3QbNTOdp3nEV0ue/j0YMZ6mMJW9UqSsdn/onqt3nNPtAEKb9IKbhAykU82QsoZEFFqtnQYcA5W7PTAugO5vvsF/QSwiwPzGIGDohcdKcIRh6GxlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735926346; c=relaxed/simple;
	bh=PjguB0P0QSqRCCIH+3Z+tkA9X1dYzd8blRQleEtdhmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IW/8szTQn2SiAdPp2wM2r0oXS+PgJSRLdzjtPHpuRBYa8ALW20bpzW2/uqkMs3zaXi+pV3qrU/6F6HSstsYRfHXHK6NaeCGBRDX6DUZcuv6AhUxun9NY8FnNlu6y05HQSAe1/EqQ2tT/hq+8YJRY6+lDlqaatsIdr1vXmT0K9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQvmj+w4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C60C4CED7;
	Fri,  3 Jan 2025 17:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735926345;
	bh=PjguB0P0QSqRCCIH+3Z+tkA9X1dYzd8blRQleEtdhmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DQvmj+w4cL6xqInl8wzdW4reWfX5JMVLV8U5lPGqpAGrqUZz8H00lerv7SgUsw9BI
	 1sxHGH1jwthr4h8mIG9jiBMwWv2mJAOVG1NOKN/PSy10LM834DKE2iieZBIIYnqB1e
	 mHaBGTs2Jgktkby6AKxtv1cSu/7O3gar/epejeHoXAXtR4tzXF0sML+3M65rVotLzb
	 gSQk935chddgWVu19PuQEn9LMXQpiZ1kuQy3Mi/Bo1wi1W+/qf6vCok0iq8kfP1kQF
	 klvK546/joxTpBqlwXeuaR1WJU3q9fiTZEAaF8QUkDkmAmKfIIBg+mzOmahstAA50w
	 1MvXWs0I/lxvw==
Date: Fri, 3 Jan 2025 11:45:43 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 13/14] PCI: hv: switch hv_compose_multi_msi_req_get_cpu()
 to using cpumask_next_wrap()
Message-ID: <20250103174543.GA4181373@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241228184949.31582-14-yury.norov@gmail.com>

On Sat, Dec 28, 2024 at 10:49:45AM -0800, Yury Norov wrote:
> Calling cpumask_next_wrap_old() with starting CPU == nr_cpu_ids
> is effectively the same as request to find first CPU, starting
> from a given one and wrapping around if needed.
> 
> cpumask_next_wrap() is a proper replacement for that.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

s/switch/Switch/ in subject to match history.

Since this depends on previous patches, I assume you'll merge them all
together, so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/controller/pci-hyperv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 86d1c2be8eb5..f8ebf98248b3 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1757,8 +1757,7 @@ static int hv_compose_multi_msi_req_get_cpu(void)
>  
>  	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
>  
> -	cpu_next = cpumask_next_wrap_old(cpu_next, cpu_online_mask, nr_cpu_ids,
> -				     false);
> +	cpu_next = cpumask_next_wrap(cpu_next, cpu_online_mask);
>  	cpu = cpu_next;
>  
>  	spin_unlock_irqrestore(&multi_msi_cpu_lock, flags);
> -- 
> 2.43.0
> 

