Return-Path: <linux-hyperv+bounces-6249-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEBCB050A6
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 07:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739F73B4617
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 05:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2E62D29CA;
	Tue, 15 Jul 2025 05:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIEvPi/U"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3100A264F8A;
	Tue, 15 Jul 2025 05:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752556464; cv=none; b=JzHNpZ464LPgWHRxh96+NVkcY5xMTxSjC3Kw12eYO5ShddTB9iSjP1oYXzdZ5Ggx4F0d0wpTCsAQHJTBQRXW0oIJ3JKSQgZqwdfI73bCUUQ+KQoqWxzS6RKCrpWGNgu6+s15MUCcbhyGLxCcb9zpdKeGv/Mbai30zaMwbQTQQxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752556464; c=relaxed/simple;
	bh=bJWUBkfd0+ssYKNHmKTp4EUZF9DwET4v/SSPJR0/iiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjJj7RFoGTFl0y0639EIAparHZR16Z4wfdNYnR76C2qF9OYnRqTschduVjZZ6WfskerReJeGTtDisKxInV8GHuqFB8gn7qVdNQs16StXN3EJLEPSzUftScHHyc8kEcn8DmrcvuJkYvtZ/NfDnlw4yq/7JoDDuz7anA4C6yUdUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIEvPi/U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F29EC4CEE3;
	Tue, 15 Jul 2025 05:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752556463;
	bh=bJWUBkfd0+ssYKNHmKTp4EUZF9DwET4v/SSPJR0/iiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIEvPi/UEgrlc5X0YYHdooFNkDHa7MFRa5kv4c4kbY8KnrnBl2bsJdr57IcwzadRx
	 2SBK2/DrVCrfWhiLHdeMXtO7FpN7xyJDNOe2AzKSOdnybkeTI1cRXgSX02tZ06RWv+
	 Kv/M1Ly/ogoybEzfClPb1D/SEYfE2fE1DuoPJo8FzMWywlUcNbw7JiGMmnIjy7/cY3
	 7DQSXHp07+te7p8CIgn0x9BpZMZUTrg260uwyFgp4ENIlVtZvM850c/LL7myuog6Dt
	 9HVdteZDasgzKqxgEis/ejctkaZEz2IEw+SrX52ccX3COMOgR4q6xNwGnU+P6mRf7Z
	 nQfm7tbZBRw/Q==
Date: Tue, 15 Jul 2025 05:14:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Nam Cao <namcao@linutronix.de>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH for-netdev v2 2/2] PCI: hv: Switch to
 msi_create_parent_irq_domain()
Message-ID: <aHXjrmccYWWfFEEl@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <cover.1751875853.git.namcao@linutronix.de>
 <7b99cca47b41dacc9a82b96093935eab07cac43a.1751875853.git.namcao@linutronix.de>
 <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41577987DB4DA08E86403738D44FA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Jul 07, 2025 at 06:49:02PM +0000, Michael Kelley wrote:
> From: Nam Cao <namcao@linutronix.de> Sent: Monday, July 7, 2025 1:20 AM
> > 
> > Move away from the legacy MSI domain setup, switch to use
> > msi_create_parent_irq_domain().
> > 
> > While doing the conversion, I noticed that hv_compose_msi_msg() is doing
> > more than it is supposed to (composing message). This function also
> > allocates and populates struct tran_int_desc, which should be done in
> > hv_pcie_domain_alloc() instead. It works, but it is not the correct design.
> > However, I have no hardware to test such change, therefore I leave a TODO
> > note.
> > 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> 
> [Adding linux-hyperv@vger.kernel.org so that the Linux on Hyper-V folks
> have visibility.]
> 
> This all looks good to me now. Thanks for the additional explanation of
> the TODO. I understand what you are suggesting. Moving the interaction
> with the Hyper-V host into hv_pcie_domain_alloc() has additional appeal
> because it should eliminate the need for the ugly polling for a VMBus
> response. However, I'm unlikely to be the person implementing the
> TODO. hv_compose_msi_msg() is a real beast of a function, and I lack
> access to hardware to fully test the move, particularly a device that
> does multi MSI. I don't think such a device is available in a VM in the
> Azure public cloud.
> 
> I've tested this patch in an Azure VM that has a MANA NIC. The MANA
> driver has updates in linux-next to use MSIX dynamic allocation, and
> that dynamic allocation appears to work correctly with this patch. My
> testing included unbind and rebind the driver several times so that
> the full round-trip is tested.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

