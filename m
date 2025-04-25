Return-Path: <linux-hyperv+bounces-5104-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527F4A9BE7D
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517E7466C9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Apr 2025 06:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21D190664;
	Fri, 25 Apr 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G75Yftl8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FC29A5;
	Fri, 25 Apr 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745561759; cv=none; b=A/SYXKFwkZ2des8H58XU2M7EKMbslHdVfxFu0i4Z2FU2vWOQHhC4HnHNOhdued9gXzDQ5CFpfrkMgURXaz59EQUy7MLHrrSCVUlqFZ7IDTc/qpxZiMGWDXv/OmVfaUubDpSMl0IucuKRs3hjLw4ZQvbB6+MTyRi4y0+eJoR8+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745561759; c=relaxed/simple;
	bh=n2fFaggUz9PlV9T/N9QPcpRhu1aHC/oRN6LEMhMgK9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKgMVdmR07V9ixuiYJRjAfMdvPHG3vgrJ4w2EaC3sCcLtJ4ipZ61bVae7ghl11zGGSwHYuv8Nl+llS0gxfFynR6AZc0XXmNW9g7fMpmBeAQ3MUpegOqXAqkhrkJ+/DVj+701L8UnS1uOF0N5hnzXD+nPP8ieg9CdtBjAMHFPGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G75Yftl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE07C4CEE4;
	Fri, 25 Apr 2025 06:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745561759;
	bh=n2fFaggUz9PlV9T/N9QPcpRhu1aHC/oRN6LEMhMgK9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G75Yftl8Bia9PnDJT+sNiKj32JQvSq8ujQgQ6sn9L2hgYaEIgM2DqNIhrnF8KCVsd
	 UJyVu9QxBTxecqNUxfi8k8gzG5mE7P4g4b7yaAY3LvflAsB0WFxVXyTBn8SOKDSpEh
	 736YpyIW8NBV0dRrSQOvDmrNAtc+JZdKSp+d1FEIwfYobYiw/WRRsF7bcIWI5ATY2G
	 RTCK5wPRCqnBC5jnK9QgIfhizBHZgzmj5OYpRjufkebf7IKDN1SmBOked5bVK/R+hb
	 ST4yoyBkY5uYPQ12VBmmP+bf5kkJ6ELcdMQCF/RErvC0lH5pPRcLLJAn7fQoxRQSMW
	 0RV93FTIp7Beg==
Date: Fri, 25 Apr 2025 06:15:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
	mikelley@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next] x86/hyperv: Fix APIC ID and VP ID confusion
 in hv_snp_boot_ap()
Message-ID: <aAsonR1r7esKxjNR@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250424215746.467281-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424215746.467281-1-romank@linux.microsoft.com>

On Thu, Apr 24, 2025 at 02:57:46PM -0700, Roman Kisel wrote:
> To start an application processor in SNP-isolated guest, a hypercall
> is used that takes a virtual processor index. The hv_snp_boot_ap()
> function uses that START_VP hypercall but passes as VP ID to it what
> it receives as a wakeup_secondary_cpu_64 callback: the APIC ID.
> 
> As those two aren't generally interchangeable, that may lead to hung
> APs if VP IDs and APIC IDs don't match, e.g. APIC IDs might be sparse
> whereas VP IDs never are.
> 
> Update the parameter names to avoid confusion as to what the parameter
> is. Use the APIC ID to VP ID conversion to provide correct input to the
> hypercall.
> 
> Cc: stable@vger.kernel.org
> Fixes: 44676bb9d566 ("x86/hyperv: Add smp support for SEV-SNP guest")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Applied to hyperv-fixes.

