Return-Path: <linux-hyperv+bounces-7468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABE1C413EF
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 19:15:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B993BC6DD
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 18:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7763358C6;
	Fri,  7 Nov 2025 18:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ex7uFGyx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C76220F2C;
	Fri,  7 Nov 2025 18:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539299; cv=none; b=dswhipbUF00sv5BvLx6Vqe1Dsftg4vGuNP66nh8Mlo2qSO3s6Ik+UtvncpRP/QHJwj73JjnUATNYyd3N8ZFRUW0TrVYq07mY0mP4mQK7SXg8un/Vz1T4D9ZNFtAy0GWBh6Y9QohVTg3vYbk96HdtXTEMfflM6b23fLI7wF7vaBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539299; c=relaxed/simple;
	bh=yYukpopBNcB5pj9s1/ex82dxZOSh9SeOKr0wtFTyyck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTHYm8GAwvYcZwvcV7nd9zubz8utJm4UeZOjkY5OLB0RkO7RDYTono8fFEWNmUYxb78T49MvM5qhR6VQtkjK6MTJZ2LuNsSgpqI9eivMs4HrJZfCiF90wxXhow6I40rcSgpUXdJUVmcSliT7mUYZgum8ZWdt9n/wL8Pn0XrQhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ex7uFGyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88403C4CEF7;
	Fri,  7 Nov 2025 18:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539298;
	bh=yYukpopBNcB5pj9s1/ex82dxZOSh9SeOKr0wtFTyyck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ex7uFGyxHtpiYIYVkb2bLv0xd14hQzwKNoa5BmsodlSsQfflkK8CLRtCoxIzRmPFc
	 sof+pFvpPo5JKPSXHdYinXzbha4Tdukz2XzD8q2qiIeYzoM04VOxvYkiyc66LNWxaw
	 83xGlTjBf6aOxC6fGHy/ynK3vmw7A4AwW+R9GYy0yZmjpr6lnn498SkPGof3GzVKci
	 RkHHDfWq1qD5nu+QqnOsTSHV5iAoRLh6LlT9WbZcBCDegxLL0MVrRkXifpwqon0Iq6
	 HUwUK/Be39c8U6f0togzdOzl0XHsR0JK5kfhwIHrRuo12Z/jyBdDvLqPoBJbPtFaGd
	 sq7gCkyMpYA0w==
Date: Fri, 7 Nov 2025 18:14:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, muislam@microsoft.com,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>
Subject: Re: [PATCH v2] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <20251107181457.GC4041739@liuwe-devbox-debian-v2.local>
References: <1761860431-11208-1-git-send-email-nunodasneves@linux.microsoft.com>
 <20251031183109.GC2612078@liuwe-devbox-debian-v2.local>
 <28ab51c0-fe14-4122-8828-3f680207865d@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28ab51c0-fe14-4122-8828-3f680207865d@linux.microsoft.com>

On Fri, Oct 31, 2025 at 01:08:45PM -0700, Nuno Das Neves wrote:
> On 10/31/2025 11:31 AM, Wei Liu wrote:
> > On Thu, Oct 30, 2025 at 02:40:31PM -0700, Nuno Das Neves wrote:
> >> From: Muminul Islam <muislam@microsoft.com>
> >>
> >> The existing mshv create partition ioctl does not provide a way to
> >> specify which cpu features are enabled in the guest. This was done
> >> to reduce unnecessary complexity in the API.
> >>
> >> However, some new scenarios require fine-grained control over the
> >> cpu feature bits.
> >>
> >> Define a new mshv_create_partition_v2 structure which supports passing
> >> through the disabled cpu flags and xsave flags to the hypervisor
> >> directly.
> >>
> >> When these are not specified (pt_num_cpu_fbanks == 0) or the old
> >> structure is used, define a set of default flags which cover most
> >> cases.
> >>
> >> Retain backward compatibility with the old structure via a new flag
> >> MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES which enables the new struct.
> >>
> >> Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
> >> Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
> >> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> >> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> >> ---
> >> Changes in v2:
> >> - Fix compilation issues [kernel test robot]
> >>
> >> ---
> >>  drivers/hv/mshv_root_main.c | 176 ++++++++++++++++++++++++++++++++----
> >>  include/hyperv/hvhdk.h      |  86 +++++++++++++++++-
> > 
> > There is no mention of updating hvhdk.h in the commit message.
> > 
> Ah, that's true..
> 
> > Can you split out this part to a separate commit?
> 
> I put the header changes in this patch because a patch containing
> those alone doesn't have much merit on its own.
> 
> I know we have split header changes into separate patches in the
> past but I'm not sure it's always the right choice.
> 

This makes it easier for me or other maintainers to track specifically
the header changes.

> Thinking about this, I could also split it up another way: one
> patch to introduce the new cpu features flags and use them in the
> driver, and one patch to introduce mshv_create_partition_v2.

That's fine by me.

Wei

> 
> Nuno> 
> > Wei
> 

