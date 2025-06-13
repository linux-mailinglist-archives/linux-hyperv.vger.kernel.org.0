Return-Path: <linux-hyperv+bounces-5913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF91AD95A2
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 21:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925AB1BC0092
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 19:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77582441A7;
	Fri, 13 Jun 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA+bbtTV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85091242D80;
	Fri, 13 Jun 2025 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843378; cv=none; b=NRucYWuk8zd5/diOfUwo2pj0055R5dQrPemQGNDCKjsrihaF4nZ5N0nv2YgR7SN9GPXReJ9qJDcNqLgIvLAm3AGgK6dL4hWObeSOqypeWlQ3dXQ6JO/p7HHWJ39Lx9cw8qr416Fy03PbvS/w6GAmDwUg/zOwh3T+mhJV41YwA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843378; c=relaxed/simple;
	bh=dBkT5f8fAKtHK7jzxmh9DkTqqqZtM261/i4B9cEg6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Df+XWQ0M98sUbru2ga4CFDurqZvJk76hyfMEGWmoCwWaZFPXlE4s2yYl9GCBzYOSDwwQG1fO+qeBfhGn03IWCVFdUz0gKw9iRKholD00MK91oP+OWV4bkpjGwZ3u3oDJkG7vaQvSw7qb9+WVkNNYARz0AHaHd3S6HjCDLJwZ3EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA+bbtTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18E1C4CEE3;
	Fri, 13 Jun 2025 19:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749843378;
	bh=dBkT5f8fAKtHK7jzxmh9DkTqqqZtM261/i4B9cEg6ys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GA+bbtTVzgFpKvTQA8xE4YPDSmLjvHrRh92eFCHuw+8KEv+6kNkssCfAR+yH2CpW5
	 B2nn3xhnMp4hMJl7LRvwn9XlU86L9kms7W9Aodxz5+NWWx4KoD6ybrNiVsD3OkeZIv
	 QjHko6pEccjQDw/uHA6mi+sCtdYH9GW02H6xmp5vPxBXvTONa2p91Iv/9Su+ubxHyI
	 4pn5ptTmp5AbleEqHOUxMZ6uHp7Oj56YFjhog4DtSvTIZDqCkGDQ1LXXNcWLjXHQ9p
	 2JFvEPQ6Ank3b236mVNRQlQsZyHGDPkZhmHyKwd37SkziGt1ZRB5ZGb+zu3OJnRy1O
	 L7ZqQkBzIbFIg==
Date: Fri, 13 Jun 2025 14:36:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, jinankjain@linux.microsoft.com,
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
	x86@kernel.org
Subject: Re: [PATCH 4/4] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
Message-ID: <20250613193616.GA971782@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1749599526-19963-5-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Jun 10, 2025 at 04:52:06PM -0700, Nuno Das Neves wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> 
> Running as nested root on MSHV imposes a different requirement
> for the pci-hyperv controller.
> 
> In this setup, the interrupt will first come to the L1 (nested) hypervisor,
> which will deliver it to the appropriate root CPU. Instead of issuing the
> RETARGET hypercall, we should issue the MAP_DEVICE_INTERRUPT
> hypercall to L1 to complete the setup.

Maybe strengthen this to say that this issues MAP_DEVICE_INTERRUPT
instead of RETARGET in this case?  (Not just that we "should".) 

> Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().

