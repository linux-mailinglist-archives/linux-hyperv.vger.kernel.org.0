Return-Path: <linux-hyperv+bounces-6173-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3563AFF5FF
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 02:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E80170E91
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 00:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D933125B2;
	Thu, 10 Jul 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4KgXoDl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F14D1EA80;
	Thu, 10 Jul 2025 00:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107604; cv=none; b=TvLS3dPrREHVJ02smlNm2d1sVtY2D4+WnfxfUIHq84d83EyqgzQ0Rw323cnVT79gJFoiAgAA79r0sRPtJXsJ/oefDddgs+lsBvgVx2dfXtH60cUY3UYHIX7exN/whqSxIybfhXRTdesIPhrNqOPNmBQI939MXOHkFbF4tpE8buQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107604; c=relaxed/simple;
	bh=YEeckHKCFE1NcP4TydHNicpGNicwK7iWvdNQF9JsqNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqbbFQlQ7EHsVl4if7FwCntDIZGYFQEakLQ+HMDL0ROBWIf5Hm2eypnBnO0pcsM3BF0nbICadYeoUF7GL21MLaKfi/SF/nO7oKxfWsEOJsWGkYnTSIV1R4b3Wf3/DHSQHdS5ZoxpYqnTjjz4FQ7N6nRzxhxYa/ZE+MQuXIk3Eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4KgXoDl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CCFC4CEEF;
	Thu, 10 Jul 2025 00:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107604;
	bh=YEeckHKCFE1NcP4TydHNicpGNicwK7iWvdNQF9JsqNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4KgXoDlvu2vkJvd2HuLqTgrcAM1YeJyKxBur+6KhaWqovalD3ruhwJevuk+boILH
	 B3vsnbo/PVWEMhE/cmaHQfyqDCKkHV2yCIfMGtJmyixDirA1RyGqJP0whUcdfCBpk7
	 K7YII7EGQKVCrn7auVzWz7QfscuvF9GIYZY+9XexCAVIFTag5a7vH0wBj4e11phooE
	 aCBLdS7gHI8dWitsFOJuxBKpu2vCtZzRMVPd2DSBzXc5AmaCN8AaH0DXB3k/jCgm94
	 Jpaj3GJgemg9rUnmdtPrPh27QkHpmSAuIJO56nEYoc9D7b+9Vqlh6aNaLlcsAieTZc
	 2D7EJJRKglGRg==
Date: Thu, 10 Jul 2025 00:33:22 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	mhklinux@outlook.com, tglx@linutronix.de, bhelgaas@google.com,
	romank@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	jinankjain@linux.microsoft.com, skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com, x86@kernel.org
Subject: Re: [PATCH v2 0/6] Nested virtualization fixes for root partition
Message-ID: <aG8KUlEAejn7IDxb@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1751582677-30930-1-git-send-email-nunodasneves@linux.microsoft.com>
 <aG8Ad0yeifapux5D@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG8Ad0yeifapux5D@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Wed, Jul 09, 2025 at 11:51:19PM +0000, Wei Liu wrote:
> On Thu, Jul 03, 2025 at 03:44:31PM -0700, Nuno Das Neves wrote:
> [...]
> >   PCI: hv: Don't load the driver for baremetal root partition
> >   x86/hyperv: Fix usage of cpu_online_mask to get valid cpu
> >   x86/hyperv: Clean up hv_map/unmap_interrupt() return values
> >   PCI: hv: Use the correct hypercall for unmasking interrupts on nested
> > 
> 
> These are applied to hyperv-fixes.
> 
> >   Drivers: hv: Use nested hypercall for post message and signal event
> >   x86: hyperv: Expose hv_map_msi_interrupt function
> 
> These have pending comments so they are not yet applied.


PCI: hv: Use the correct hypercall for unmasking interrupts on nested

This has a dependency on the second dropped patch, so this is also
dropped.

Wei

