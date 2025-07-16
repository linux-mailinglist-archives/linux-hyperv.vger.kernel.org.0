Return-Path: <linux-hyperv+bounces-6273-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1FDB07E9E
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 22:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 382BF1C2394C
	for <lists+linux-hyperv@lfdr.de>; Wed, 16 Jul 2025 20:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92862BE03B;
	Wed, 16 Jul 2025 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0iMAgNn+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uxWnWyuK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407312BD024;
	Wed, 16 Jul 2025 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752696742; cv=none; b=e/51AGE5SFe1d9nzgjgLR2DyqHXGh2gaQlgZ6i3D4ZgtLMOAS7x1x5kF05q+lf/ZWfZNR2EvCmtfc5SH9FFSqPzpcLwAYx116ZhZM2Cc/6WcqI7lckECLahVU9EjIvuCmH/lVewWxZk/+WEZiJJ1ikmlgm4DWrqe3z0k95VPeKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752696742; c=relaxed/simple;
	bh=Ybp6StaPBlYn6EwhfIdy1XRd1DpGtpI1OGf8ErxYp8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVM3k/96NuoFVFBbnQ2Rr6I7efzBOz1g5y5Hzx3cbOdkKwTwujR27epHO3T4jy/+XLPFb3jeLIpwhFHo5AhxlZjI6R1nuBhbr+ISCIPrl4ayfVihZWoipUfxVsMTM4f2dZHoYOn26JqNctMusSJ3DeW6/uHG2ku/et0cDB/JZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iMAgNn+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uxWnWyuK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Jul 2025 22:12:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752696738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsB3pN9BQv4DpfHkiX5eiA//lEFGbcJJHnUld0yEYFc=;
	b=0iMAgNn+c/kCnByEs8UgRRPA18M+uD9wAaFSuobsvit7xfmdRQSbBav0+R+cyQdTKlATk5
	Vn497KWdlGQNFc1V6oa8MTrZFVG0mmvtMDZPSoub+gmU+kRj6TVUGsrpHsKELQgGLXpPn2
	XYdVPop5ISRobjC4HIZxUdmQgGd/H6T48xu+GoLy7117KeNomdpomup7EDjdSK/D3epwba
	RTBFSYuIRSzAxYgm/Tc9PpoPrGgrfgiRl4R4uPkk06XZy7/4A/MyDtlEhoPRSBOeLVlGZU
	j78xr90jcjZD1FLRZeQuN93FMC9oFa1dBvTarvUvI/ixexZPa1s9odpdq/6gSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752696738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsB3pN9BQv4DpfHkiX5eiA//lEFGbcJJHnUld0yEYFc=;
	b=uxWnWyuKJVvzspABpfi/gXCuMAXydr0WBKa104KKmTR1BllVXpBkb3lsibrME6nMIPgslH
	iQpjtEr0b8TO10Dg==
From: Nam Cao <namcao@linutronix.de>
To: Antonio Quartulli <antonio@mandelbit.com>
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Message-ID: <20250716201216.TsY3Kn45@linutronix.de>
References: <cover.1750858083.git.namcao@linutronix.de>
 <de3f1d737831b251e9cd2cbf9e4c732a5bbba13a.1750858083.git.namcao@linutronix.de>
 <7d8cfcf5-08db-4712-a98f-2cbfb9beeb85@mandelbit.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8cfcf5-08db-4712-a98f-2cbfb9beeb85@mandelbit.com>

On Wed, Jul 16, 2025 at 09:52:05PM +0200, Antonio Quartulli wrote:
> Hi Nam,
Hi Antonio,

> On 26/06/2025 16:48, Nam Cao wrote:
> [...]
> > -static void vmd_msi_free(struct irq_domain *domain,
> > -			struct msi_domain_info *info, unsigned int virq)
> > +static void vmd_msi_free(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs)
> >   {
> >   	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
> > -	synchronize_srcu(&vmdirq->irq->srcu);
> > +	for (int i = 0; i < nr_irqs; ++i) {
> > +		synchronize_srcu(&vmdirq->irq->srcu);
> > -	/* XXX: Potential optimization to rebalance */
> > -	scoped_guard(raw_spinlock_irq, &list_lock)
> > -		vmdirq->irq->count--;
> > +		/* XXX: Potential optimization to rebalance */
> > +		scoped_guard(raw_spinlock_irq, &list_lock)
> > +			vmdirq->irq->count--;
> > -	kfree(vmdirq);
> > +		kfree(vmdirq);
> > +	}
> 
> By introducing a for loop in this function, you are re-using vmdirq after
> free'ing it.
> 
> I can't send a patch because I am not faimliar with this API and I don't
> know how to fix it.
> 
> However, the issue was reported today by Coverity.
> 
> Any idea? :-)

Thanks for the report. That was indeed a mistake from my side.

I hope PCI maintainers don't mind squashing the below diff.

Sorry for the troubles so far,
Nam

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 48a6096cbbc0..50f0c91d561c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -280,9 +280,11 @@ static int vmd_msi_alloc(struct irq_domain *domain, unsigned int virq,
 static void vmd_msi_free(struct irq_domain *domain, unsigned int virq,
 			 unsigned int nr_irqs)
 {
-	struct vmd_irq *vmdirq = irq_get_chip_data(virq);
+	struct vmd_irq *vmdirq;
 
 	for (int i = 0; i < nr_irqs; ++i) {
+		vmdirq = irq_get_chip_data(virq + i);
+
 		synchronize_srcu(&vmdirq->irq->srcu);
 
 		/* XXX: Potential optimization to rebalance */


