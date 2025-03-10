Return-Path: <linux-hyperv+bounces-4338-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B5EA59BA6
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 17:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D361D16EE70
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 16:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D1B2309A7;
	Mon, 10 Mar 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr0BQaNr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B061C5D5C;
	Mon, 10 Mar 2025 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625508; cv=none; b=RI0qz1TJy3OD6Fyt9C/TzuRmPdhsZkz4Qb8gzNY0aS1sQQYAwyavl2qL4xIslYvxLrqXEemdkithbRvdI6R6BwNaAE0Gh5oaUf9KJbBe1T2V6Qe1LsuftFj7oh6jZOzKzfTUoDNZyHC1eK+jOwFWT2tzK9SqHRoM+Umf5XrfxLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625508; c=relaxed/simple;
	bh=PoUNN7Lo//yW65ne6TFDNKbmP3/NLag4OiCQZYZeQLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=lOzaVJjRU1riJamkcN68D52KLX4WKL7MIHzvvaS3Wc0lmeVJsB7IBWpeawYyFLXpjBcV7njmta65ZIeJOthOZc28GNqvS0gT63P1rzgwpzWH0LZzhM71q7DRY6tytzxi7xO1gSuJxzdUADxHzPGVWsoD+MbNxRjZC4Q1ySGEZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr0BQaNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493D4C4CEE5;
	Mon, 10 Mar 2025 16:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741625508;
	bh=PoUNN7Lo//yW65ne6TFDNKbmP3/NLag4OiCQZYZeQLI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gr0BQaNrr34Y1LuZdl5pe5rck02H9T15hy6ztzehWq8cXkeUdjXaXpj8O1WHmJ10S
	 zYYQUowXfFBsGCe4NqNq/PC+23K8gqrfez9SQiImQaGo4+LdyPgyRVfhBWBoMnszEa
	 BQqV9lOR/ceTYfQ0Mu5oC0gaI1nqVj/uv/YV7wDjBao0HaifA7UFDfk52HeI2nUjKt
	 Xy/kHW7esHYytG20TNOpTG4JM16WodHAim6AGWUJW3fPL78+QEbRSxn6tc8hheIatX
	 qg7dAh9JSx8iJ4B1i6I5DWTCeQhwY5YwIhj5HOI+b6i5oH2d/GfLtL74Rm4zmRUKCM
	 RWUOkgWFIDpcA==
Date: Mon, 10 Mar 2025 11:51:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
	Wei Huang <wei.huang2@amd.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [patch 00/10] genirq/msi: Spring cleaning
Message-ID: <20250310165146.GA553858@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309083453.900516105@linutronix.de>

On Sun, Mar 09, 2025 at 09:41:40AM +0100, Thomas Gleixner wrote:
> While converting the MSI descriptor locking to a lock guard() I stumbled
> over various abuse of MSI descriptors (again).
> 
> The following series cleans up the offending code and converts the MSI
> descriptor locking over to lock guard().
> 
> The series applies on Linus tree and is also available from git:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git irq/msi
> 
> Thanks,
> 
> 	tglx
> ---
>  drivers/ntb/msi.c                   |   22 +----
>  drivers/pci/controller/pci-hyperv.c |   14 ---
>  drivers/pci/msi/api.c               |    6 -
>  drivers/pci/msi/msi.c               |   77 ++++++++++++++----
>  drivers/pci/pci.h                   |    9 ++
>  drivers/pci/tph.c                   |   44 ----------
>  drivers/soc/ti/ti_sci_inta_msi.c    |   10 --
>  drivers/ufs/host/ufs-qcom.c         |   75 +++++++++---------
>  include/linux/msi.h                 |   12 +-
>  kernel/irq/msi.c                    |  150 ++++++++++++------------------------
>  10 files changed, 181 insertions(+), 238 deletions(-)

For the drivers/pci/ parts:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this somewhere, let me know if otherwise.

