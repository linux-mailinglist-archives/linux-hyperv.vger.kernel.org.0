Return-Path: <linux-hyperv+bounces-2499-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AB791855E
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2024 17:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B6A01F28DE2
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Jun 2024 15:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013B91891DE;
	Wed, 26 Jun 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OHxR4Gl4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AD41891CB;
	Wed, 26 Jun 2024 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414642; cv=none; b=GC6QL2hKCsFSgoVRmLpPjKZkYBnhn6Vv1t2ll4EYUFgUTrNuCkhb+5/KX2yHyvRd64O3OQJQDY73olTJDdLm95Nk0GJlYBDlWM745Gr9AXnvolwurR2okkdaSUhVIS3YaNIWvL+ypqNg7F57i6fzy+bwTuERZ0jrsbhMAIbNkhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414642; c=relaxed/simple;
	bh=ekPNzLzryuR1LD67ikqc01Jk5UMQeCiAfkaRGoSGRzs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=YjFaWZSySGTlCICCaxbP01qRIR+uF4r0wh1FF1jaM/yaGNuKtvwq0vAwjsbLytGYE6lMbcLKgLWZqyWS49SS+xJto93/dXSihJDHgUbVMn7+drLZRIvn+uceoTGWvjN2TvbS2JSXDrrzBmKv5ncUzKoJLRAnbcXWbGQf/3FLWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OHxR4Gl4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD4C116B1;
	Wed, 26 Jun 2024 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719414642;
	bh=ekPNzLzryuR1LD67ikqc01Jk5UMQeCiAfkaRGoSGRzs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OHxR4Gl4p5LAIKrmqfWH2GbraItePMGCNEfR+wMu9M4cejZ+RwzM/fPEzl/EKXSWK
	 sDzKGnAERZZgz1NSiXYYZlkO1DPFVgx4KNNXPx53+uES+riMDC4nu3db17Yznmr+1K
	 JvvZGWJ4El3IS8tSUk4OajBfYoCRrfCFRp/3/OJVCXp0y4JmXuvFFAnGRL/9Ba1h/i
	 gKXQBZlHMaQFRmZoZL/BbArG97KotyLM13Drqqqyf1PE4HqhGd0GXk8EIge56Y9E6r
	 H1rK9h1/EmWjmPkNT4I/oWnJZwFXeFxS8tXU6wrkzIopMw1l6Zxz5w6f9b/9eHGtEv
	 GtyqRqd8kZHhw==
Date: Wed, 26 Jun 2024 10:10:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jake Oshins <jakeo@microsoft.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: hv: fix reading of PCI_INTERRUPT_PIN
Message-ID: <20240626151039.GA1466747@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621210018.350429-1-wei.liu@kernel.org>

1) Capitalize subject to match history
2) Say something more specific than "fix reading ..."

Apparently this returns garbage in some case where you want to return
zero?

On Fri, Jun 21, 2024 at 09:00:18PM +0000, Wei Liu wrote:
> The intent of the code snippet is to always return 0 for both
> PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> 
> The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> 
> This is discovered by this call in VFIO:
> 
>     pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> 
> The old code does not set *val to 0 because it misses the check for
> PCI_INTERRUPT_PIN.
> 
> Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> Cc: stable@kernel.org
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v2:
> * Change the commit subject line and message
> * Change the code according to feedback
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 5992280e8110..cdd5be16021d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1130,8 +1130,8 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>  		   PCI_CAPABILITY_LIST) {
>  		/* ROM BARs are unimplemented */
>  		*val = 0;
> -	} else if (where >= PCI_INTERRUPT_LINE && where + size <=
> -		   PCI_INTERRUPT_PIN) {
> +	} else if ((where >= PCI_INTERRUPT_LINE && where + size <= PCI_INTERRUPT_PIN) ||
> +		   (where >= PCI_INTERRUPT_PIN && where + size <= PCI_MIN_GNT)) {
>  		/*
>  		 * Interrupt Line and Interrupt PIN are hard-wired to zero
>  		 * because this front-end only supports message-signaled
> -- 
> 2.43.0
> 

