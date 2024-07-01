Return-Path: <linux-hyperv+bounces-2512-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E293391E68C
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 19:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B831F218F7
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 17:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A11F16E88C;
	Mon,  1 Jul 2024 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTqfCJZ6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF28616E87A;
	Mon,  1 Jul 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854456; cv=none; b=Wo53KICyXb7AWT9PP74KLM2lH2gX+g1Q87546mikWmYaFiBx57T9t8AXyy5xuAXyTk76fymQdFu14jwXEem/jczTq7dD6TPDGAxFit2xMsIzcaE22k9dNvVdPUWhvxFdng3uHi9YcQHHVVyPKCOITQc+YUf7WU1gsul4fVg3dLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854456; c=relaxed/simple;
	bh=0NqUIdCaQNe/JmGKwMDcVL1B+VgTgCG7plMAVhrtBB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NmZR96vX0UyUhK2ki4M3xBNEbJ/Ewg3lOIjvxhxAjtQ5u8uJWVVPRGcR5VJ/fmCP9bFB+fWzxitRzFNuYGahLAis3tPSsN1AQLzzSxh3LRZyMqxDMJgf5CGNT+RFgZFtdi/aVV0ae5fLTOVZZYxP3QndOcWdC1H/pBJTbaV40G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTqfCJZ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47121C2BD10;
	Mon,  1 Jul 2024 17:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719854455;
	bh=0NqUIdCaQNe/JmGKwMDcVL1B+VgTgCG7plMAVhrtBB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VTqfCJZ6c2Pj7OMrsXKBkVrkXzgrEIbOaGuFg4N/BScgNcEV0wKOu0RUGo4YxoH57
	 w9kkph99DKesMy0vnRm8GVY6wC+Ak4cRQFLxox4Kh+p/mDjfAp2jVODNJmvkSO4giK
	 1tJrBu2jrtC1wYtYH5B2HJGK29OYkIek5uQndV5oYKI6rPqxxhMrE3Paeao3qIXH2X
	 0jJ6SvmSle19OEZ09Ux9SxiOvbbsSSl0czgVUQKlbAn0sS5NeGgzsqFBhxOogojMtP
	 3gqapU1E+7Mo94KYGEDSTW/kcMEgCcxDt3SRZrcdCzLTo4h8ugHrg+sP7xWCtzmGv1
	 znraxD0Ey6B7A==
Date: Mon, 1 Jul 2024 12:20:53 -0500
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
Message-ID: <20240701172053.GA10100@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoJJsolJJcLUYiVG@liuwe-devbox-debian-v2>

On Mon, Jul 01, 2024 at 06:16:18AM +0000, Wei Liu wrote:
> On Wed, Jun 26, 2024 at 10:10:39AM -0500, Bjorn Helgaas wrote:
> > 1) Capitalize subject to match history
> 
> What do you mean here? I got the "PCI: hv: ..." format from recent
> commits. "PCI" is capitalized. You want to to capitalize "fix"?

Yes.  Look at the history:

  $ git log --oneline --no-merges drivers/pci/controller/pci-hyperv.c
  b5ff74c1ef50 PCI: hv: Fix ring buffer size calculation
  07e8f88568f5 x86/apic: Drop apic::delivery_mode
  f741bcadfe52 PCI: hv: Annotate struct hv_dr_state with __counted_by
  04bbe863241a PCI: hv: Fix a crash in hv_pci_restore_msi_msg() during hibernation
  067d6ec7ed5b PCI: hv: Add a per-bus mutex state_lock
  a847234e24d0 Revert "PCI: hv: Fix a timing issue which causes kdump to fail occasionally"
  add9195e69c9 PCI: hv: Remove the useless hv_pcichild_state from struct hv_pci_dev
  2738d5ab7929 PCI: hv: Fix a race condition in hv_irq_unmask() that can cause panic
  ...

> > 2) Say something more specific than "fix reading ..."
> > 
> > Apparently this returns garbage in some case where you want to return
> > zero?
> 
> Yes. *val is not changed in the old code, so garbage is returned.
> 
> Here is the updated commit message. I can resend once you confirm you're
> happy with it.
> 
>     PCI: hv: Fix reading of PCI_INTERRUPT_PIN

Maybe:

  PCI: hv: Return zero, not garbage, when reading PCI_INTERRUPT_PIN

>     The intent of the code snippet is to always return 0 for both
>     PCI_INTERRUPT_LINE and PCI_INTERRUPT_PIN.
> 
>     The check misses PCI_INTERRUPT_PIN. This patch fixes that.
> 
>     This is discovered by this call in VFIO:
> 
>         pci_read_config_byte(vdev->pdev, PCI_INTERRUPT_PIN, &pin);
> 
>     The old code does not set *val to 0 because it misses the check for
>     PCI_INTERRUPT_PIN. Garbage is returned in this case.
> 
>     Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
>     Cc: stable@kernel.org
>     Signed-off-by: Wei Liu <wei.liu@kernel.org>

Looks fine.

