Return-Path: <linux-hyperv+bounces-6380-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276EB10FE1
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6B93A4079
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Jul 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA331DF24F;
	Thu, 24 Jul 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/ljlTmV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13AB72615;
	Thu, 24 Jul 2025 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375663; cv=none; b=EJG+r2z6pDEpy5oh533yyj5fwNIscXTyQVgV2zF6C8V/nyt/wmG7rH0FOcC4sSZGC6ZRtRMWUaFEOdlSXvqmranx9WfFa4AYTXBcplg/P0N5FdYsCB4qbt63rUgnL2VyHwfGyNJctyhlVRnrhmFlSUHCvD2GDhmkZs4ZH2eZe7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375663; c=relaxed/simple;
	bh=v1AREpNatejwJKD6V5Iz6AdvLkLubzChLaD07Isk2a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu4rp2UdtlFEnwG0iOwpAN/95zhnt13qRfTOEkAVct7KZpIkFUggDUkAP3N8iri7/6ixKSJAuHSiCoH1IMKl2WqkCOav9XXXwWfTsSRgGgfpzINikBh5FHKz0X5by6ftlECmUXb223cmKVtHoQtSZKhvwabJfNvVW5lxx9SAvTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/ljlTmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BE9C4CEED;
	Thu, 24 Jul 2025 16:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375663;
	bh=v1AREpNatejwJKD6V5Iz6AdvLkLubzChLaD07Isk2a8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/ljlTmVo+P03V4/cu9sc/Qn8WNO7T1X9sYVfMe/dRm/JUpa8YAxvBt58e5OB9J7p
	 Et0p9KV56dzxRGMOrOOzMuoQ5LVWwmqGyHXphuvOHmCYXYvQYER+yy+UwmxOcTNq3P
	 5YTSxamVn149kW8vg3DzE2LGpey/cd+oKszNYgTmTRa8PGcPfZxaFZQS70ALI2pEWR
	 r4ArvAyuiO68PXhc9+aLLM8zgTidxoBXjqo4tmsETwNPHyfvWNCbQ4o+udFvP5iVdO
	 1MUu0KuLBk2oRJAMxSA/DYcKJbaN0CCrwK+kPlWyyAXsnpBSkWmct63/kl13YOS1Wt
	 tQIW9Q6N8ptAA==
Date: Thu, 24 Jul 2025 16:47:41 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Marc Zyngier <maz@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] x86/hyperv: MSI parent domain conversion
Message-ID: <aIJjrYne1VvGjBux@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <cover.1752868165.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752868165.git.namcao@linutronix.de>

Nuno, can you please take a look at this patch?

On Fri, Jul 18, 2025 at 09:57:49PM +0200, Nam Cao wrote:
> The initial implementation of PCI/MSI interrupt domains in the hierarchical
> interrupt domain model used a shortcut by providing a global PCI/MSI
> domain.
> 
> This works because the PCI/MSI[X] hardware is standardized and uniform, but
> it violates the basic design principle of hierarchical interrupt domains:
> Each hardware block involved in the interrupt delivery chain should have a
> separate interrupt domain.
> 
> For PCI/MSI[X], the interrupt controller is per PCI device and not a global
> made-up entity.
> 
> Unsurprisingly, the shortcut turned out to have downsides as it does not
> allow dynamic allocation of interrupt vectors after initialization and it
> prevents supporting IMS on PCI. For further details, see:
> 
> https://lore.kernel.org/lkml/20221111120501.026511281@linutronix.de/
> 
> The solution is implementing per device MSI domains, this means the
> entities which provide global PCI/MSI domain so far have to implement MSI
> parent domain functionality instead.
> 
> This series converts the x86 hyperv driver to implement MSI parent domain.
> 
> Changes in v3:
> 
>   - Drop the merged patch
> 
>   - Rebase onto hyperv-fixes
> 
>  arch/x86/hyperv/irqdomain.c | 111 ++++++++++++++++++++++++------------
>  drivers/hv/Kconfig          |   1 +
>  2 files changed, 77 insertions(+), 35 deletions(-)
> 
> -- 
> 2.49.0
> 

