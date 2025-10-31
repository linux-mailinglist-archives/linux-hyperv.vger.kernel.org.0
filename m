Return-Path: <linux-hyperv+bounces-7391-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33553C26912
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 19:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40453A7CE6
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Oct 2025 18:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9371A0BD6;
	Fri, 31 Oct 2025 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="se15O2SR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E965E405F7;
	Fri, 31 Oct 2025 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761935471; cv=none; b=O8/zge0fbj9XonqpNCiPXBtxnBgCuAEta8kjsfrxaIEzS4pKQwiXM+fiqPFGY/MRYppDBTKliGWYSLQiAIAHUwETU+yjAgCBm8+a4XooFv3ejfOpGdtyqFDHbD8BVqQE2Y2hfD+R28HA3Ffoo94Guc7D6BgNjErhqwUiK5czHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761935471; c=relaxed/simple;
	bh=zYuZsmVAveIzaZzGHayeZuxJiEGHcbpgQtlHJ5Bzb9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZC4MDzF3fRvC+grGhvhxARcXA6QnAMyVq92LVZu9+RHZqcZjUSH7rfVo5Zsx10T4X5XezvI7+xxo4B5pRuH8qM3ibhQcPEMfhe5+DymCubb2N6RFNqoVTpn6zNoYgE8PwlBAssPkh6/gBuucRZE4Fy92HYZPYY89/BVYOs0dyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=se15O2SR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9305FC4CEE7;
	Fri, 31 Oct 2025 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761935470;
	bh=zYuZsmVAveIzaZzGHayeZuxJiEGHcbpgQtlHJ5Bzb9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=se15O2SRovbVlggwRb9+ha+9m6L0oUYw6G+3DUESVPHQ2yDPfnCJ4DjR3qShCQWG8
	 xZ0Hi0YcTr9pf9WCzHooPcs0AyGhXhpb7730svle9QqsmP4S3BCuGQeGzO3A2AMzfx
	 hQcyNihaVFvF8h+FTtVLVqU/oTmllzLeDpRq6RO+DlK62HJKycfpFEBJTVrsLBFHkg
	 0qFo2KoJ6cTIf2lqebYEpEcgMEd2OXMAIj87OqH0Sl9UiKct8ReimBUpciq3ClxDoo
	 +hWKIfOMiUX2bB24QzWZ7K2A9Z1kgMpZQfHsyagGA7L8aH39gU+qp/wyq/KtP0vhVp
	 cPZzkq+d+oQkw==
Date: Fri, 31 Oct 2025 18:31:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	muislam@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	mhklinux@outlook.com, skinsburskii@linux.microsoft.com,
	romank@linux.microsoft.com, Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <20251031183109.GC2612078@liuwe-devbox-debian-v2.local>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Oct 30, 2025 at 02:40:31PM -0700, Nuno Das Neves wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> The existing mshv create partition ioctl does not provide a way to
> specify which cpu features are enabled in the guest. This was done
> to reduce unnecessary complexity in the API.
> 
> However, some new scenarios require fine-grained control over the
> cpu feature bits.
> 
> Define a new mshv_create_partition_v2 structure which supports passing
> through the disabled cpu flags and xsave flags to the hypervisor
> directly.
> 
> When these are not specified (pt_num_cpu_fbanks == 0) or the old
> structure is used, define a set of default flags which cover most
> cases.
> 
> Retain backward compatibility with the old structure via a new flag
> MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables the new struct.
> 
> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
> Changes in v2:
> - Fix compilation issues [kernel test robot]
> 
> ---
>  drivers/hv/mshv_root_main.c | 176 ++++++++++++++++++++++++++++++++----
>  include/hyperv/hvhdk.h      |  86 +++++++++++++++++-

There is no mention of updating hvhdk.h in the commit message.

Can you split out this part to a separate commit? 

Wei

