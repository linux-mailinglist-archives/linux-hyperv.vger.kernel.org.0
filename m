Return-Path: <linux-hyperv+bounces-6274-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E0BB07EF2
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 22:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89AA516211A
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 20:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837BE4501A;
	Wed, 16 Jul 2025 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efF0hPcZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56121273FD;
	Wed, 16 Jul 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697879; cv=none; b=mtQSJzT3I0ksx8kwcHSKJbFxpT7y+zyvUWh6DUO5r3l77Wo+h97jCVWAzdx50aXWN4G0dCtgnvYpePCGggeStgqCNb9qkfLCW32hw2aY5mjY0S+oFpvbIwgZPpe0no94tg9fR3yFpufJm4L8XAbHngPF8uLmP8mH8ELVbqfk5Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697879; c=relaxed/simple;
	bh=kRiXunSKIWhECmgIaCZqujGPFLD5IyiabiwSwI/oAUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ejgfihwI7Ip4nEZmap0aPhpIjs8bOZE8FM2bn2AxFI8SvQ+iz7EnELHgJSnVoZ3LlYNVMLIoLwFOzLmsU7lK5n1SCtUeB3k+uU6byG8agn2JzkaxA3IdmYMBg3rFCvJS9XA/t/gJ2JyWqwJ3yYcWIUpjza0Rupo2dFqmfKfEc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efF0hPcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B453BC4CEE7;
	Wed, 16 Jul 2025 20:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752697876;
	bh=kRiXunSKIWhECmgIaCZqujGPFLD5IyiabiwSwI/oAUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=efF0hPcZqjnO64wo0iSK/h4ZKrebfuyFzwH7mVu+6WyNJq9lz4t6ieWUVVRTRmp1k
	 ZyUQlnPJBXrf36cVsIwM+lr5rw4JmHHyPSnxIxc+sMTR5nc+fov+3HTPN8Zz+/It7N
	 nFhVdmof/TLwUmuR5wv2Z5SYP1YMaekWd9SRe52KrMJtXOrqM7TWHLN/FIuuNQPx5Y
	 IBpazzdB+v05g2NH6+eI5Egja4tj22kqB5+MXf7a0C48d9Z0SHsuEtTUrYuhEPtBT4
	 DZmGj5yCLKi0JGd+KmWsm+B2IIr4Fk/I4kdlrhDnCNII0vLcGpI6DyGqXSw8zwSesI
	 2ECRq60OVgk5g==
Date: Wed, 16 Jul 2025 15:31:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Antonio Quartulli <antonio@mandelbit.com>,
	Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Joyce Ooi <joyce.ooi@intel.com>, Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Michal Simek <michal.simek@amd.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 16/16] PCI: vmd: Switch to msi_create_parent_irq_domain()
Message-ID: <20250716203115.GA2553753@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716201216.TsY3Kn45@linutronix.de>

On Wed, Jul 16, 2025 at 10:12:16PM +0200, Nam Cao wrote:
> On Wed, Jul 16, 2025 at 09:52:05PM +0200, Antonio Quartulli wrote:
> > Hi Nam,
> Hi Antonio,
> 
> > On 26/06/2025 16:48, Nam Cao wrote:
> > [...]
> > > -static void vmd_msi_free(struct irq_domain *domain,
> > > -			struct msi_domain_info *info, unsigned int virq)
> > > +static void vmd_msi_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
> > >   {
> > >   	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
> > > -	synchronize_srcu(&vmdirq->irq->srcu);
> > > +	for (int i = 0; i < nr_irqs; ++i) {
> > > +		synchronize_srcu(&vmdirq->irq->srcu);
> > > -	/* XXX: Potential optimization to rebalance */
> > > -	scoped_guard(raw_spinlock_irq, &list_lock)
> > > -		vmdirq->irq->count--;
> > > +		/* XXX: Potential optimization to rebalance */
> > > +		scoped_guard(raw_spinlock_irq, &list_lock)
> > > +			vmdirq->irq->count--;
> > > -	kfree(vmdirq);
> > > +		kfree(vmdirq);
> > > +	}
> > 
> > By introducing a for loop in this function, you are re-using vmdirq after
> > free'ing it.
> > 
> > I can't send a patch because I am not faimliar with this API and I don't
> > know how to fix it.
> > 
> > However, the issue was reported today by Coverity.
> > 
> > Any idea? :-)
> 
> Thanks for the report. That was indeed a mistake from my side.
> 
> I hope PCI maintainers don't mind squashing the below diff.

Squashed, thanks!  Updated commit:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?id=4246b7fccf26

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 48a6096cbbc0..50f0c91d561c 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -280,9 +280,11 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
>  static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
>  			 unsigned int nr_irqs)
>  {
> -	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
> +	struct vmd_irq *vmdirq;
>  
>  	for (int i = 0; i < nr_irqs; ++i) {
> +		vmdirq = irq_get_chip_data(virq + i);
> +
>  		synchronize_srcu(&vmdirq->irq->srcu);
>  
>  		/* XXX: Potential optimization to rebalance */
> 

