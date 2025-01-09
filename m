Return-Path: <linux-hyperv+bounces-3647-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59BA08070
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 20:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354D618890E9
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F119E7F8;
	Thu,  9 Jan 2025 19:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbTjiOEB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F252AF07;
	Thu,  9 Jan 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736449767; cv=none; b=gGMZcwTZgeUZwL4/GmB8iNKiETyn546wieOlBUNeQuJDZtiV6nU8HL/24uUcE/Na4PFiWb+Zuc2Q7k8694bjCqtgqunWEecYyS/0SfPs4YSjBmIXJg8YRZl1K+p7HRauOZ39Azr2Xrfb7cROc/oJnnNNmUh9oKBgyR7f8vkUgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736449767; c=relaxed/simple;
	bh=4gP+yApHZt7UH8Dfs1iEcV2O1G2/j94cfLvnstqIEvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmhnAO2FOP7GbZoCRj4J4W/uOg+hr13LlLV9s3/3z0u1wGmI/KLrv5g09rPP1ONSIT2Q6/zC6W1pt49lEpN5F4ND+igpejKzxT2Mr7KjfWcsc8gtvhN8quI/ltY9deYfCQjd6Q3KR0KQRWMKEUcWuh0hr57eVn/KCYO8KyMcTS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbTjiOEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC663C4CED2;
	Thu,  9 Jan 2025 19:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736449766;
	bh=4gP+yApHZt7UH8Dfs1iEcV2O1G2/j94cfLvnstqIEvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XbTjiOEBG6ML/in8Eujx2woi3MuXq0HGHjk1sZoNvteH5D+JdIgpXjuLJaImnkrMl
	 MN45u+roBlOmytM7PL/pDlaIm+J7YRNnupOJGKoFPp/Pt/EobDY1ziESiKvt6dWlR7
	 FCSDPCX7dwfTH/R2vbCqd6z6PpOquvha4XloYZNWstm5RO77/LcKYgnsKUzcX6ydHt
	 MJml7AZ3yfsJq9Tes2fQYJRHYrpU2lwKXSYjEUJ8qfvO5vSu7dBX7nAs5cruC2+GaA
	 xQqbsHe1JKds2bUc2GhfZLUjVXSvNaA6LwyGhXYe/yTEdzVOeZFxkNU2X3FOuXlIYh
	 jnNDl/6LUzg6A==
Date: Thu, 9 Jan 2025 19:09:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, eahariha@linux.microsoft.com,
	haiyangz@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
	tglx@linutronix.de, tiala@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com,
	ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v6 1/5] hyperv: Define struct hv_output_get_vp_registers
Message-ID: <Z4Ae5AVbjiSl821h@liuwe-devbox-debian-v2>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
 <20250108222138.1623703-2-romank@linux.microsoft.com>
 <d5fb5c9b-a477-4043-8438-aff29dbd96bb@linux.microsoft.com>
 <Z39jvq4CsBjurJ1v@liuwe-devbox-debian-v2>
 <2102df2f-117c-4c35-b727-cd9865c0e31d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2102df2f-117c-4c35-b727-cd9865c0e31d@linux.microsoft.com>

On Thu, Jan 09, 2025 at 09:25:58AM -0800, Roman Kisel wrote:
> 
> 
> On 1/8/2025 9:50 PM, Wei Liu wrote:
> > On Wed, Jan 08, 2025 at 03:25:22PM -0800, Nuno Das Neves wrote:
> > > On 1/8/2025 2:21 PM, Roman Kisel wrote:
> 
> [...]
> 
> > > 
> > 
> > I can fix this when I commit the change . This patch will be folded into
> > your old one anyway.
> > 
> Nuno, thank you very much for spotting that! Wei, appreciate that!
> Didn't mean to create more work for you, sorry about that.

No problem at all. I'm happy to help.

Wei.

> 
> > Thanks,
> > Wei.
> 
> -- 
> Thank you,
> Roman
> 
> 

