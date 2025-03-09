Return-Path: <linux-hyperv+bounces-4319-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2102A5895F
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 00:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901423A8919
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 23:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F04D1DEFCD;
	Sun,  9 Mar 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCVOt3IK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0214A155398;
	Sun,  9 Mar 2025 23:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564347; cv=none; b=pVOA+OlXwdDL+LbZA20n8dzGXDhd1nW0UlqjPsdz3V7j8zw9y+Tsw+o8WUH69g+jExhwFY0SWtsl8C88LqbuuFSGy0d4JqcW5EkhOaoF7EIUxQPNBQkaze/U0l3DtNndGdm2hInMXeDtRsxK8YLZHNh7TP/RjHQXV9I7hJYREDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564347; c=relaxed/simple;
	bh=ZRqcVLniZJ7OzME8hR1RfRrDdaMS238qtQHq2gGlFTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sz4AkgFmVht5q2jjQh4Z29eSpSt4qwATXN3YdCZWGuhw4qonQK1jXqsEgCAryfTQVLa58FwnE7FuaZNV3euzhetOtFyiMXbDbC8vrM4Gmp9OI5n8jEnXY9KE6W/6WmB+B53VP2rmj4KXZqJqPmdIE5snOjP8h4hWEsCXpEaaFOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCVOt3IK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99756C4CEE3;
	Sun,  9 Mar 2025 23:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741564346;
	bh=ZRqcVLniZJ7OzME8hR1RfRrDdaMS238qtQHq2gGlFTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCVOt3IKpWx3q691nhtN536xr7Hq6NgXfdmCoW/BIVVrEdeAe1PUItFrTQhSJZvmh
	 VJJJpJVdNZUwlLW8qeNdUx4OmKkgyHdplpn5KUvaxNnfjWH6JQRE2/vSn2NO21iXL9
	 OZNCS9Ds5b/23yjxQ1hQdltBhJHrwhZiQEVgUj/NBfLR0lfcOUsXQ6D8Nwya0AFKBF
	 NY1dF2cF3pZoveyjulGka0S4KUT0n5a0Ezl7EscZlI+kCcKNNcFVUQ18wrccO+QoJt
	 p5wm1pXlVSOztU9CTLksPXc1pgXJzmB1ifHy+54nvrm4vshBi7BQWIMCfpsvFknSC1
	 tjyRwkO2IcUnA==
Date: Sun, 9 Mar 2025 23:52:25 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] fbdev: hyperv_fb: Fix hang in kdump kernel when on
 Hyper-V Gen 2 VMs
Message-ID: <Z84pue7eIjr0VtrE@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250218230130.3207-1-mhklinux@outlook.com>
 <24668c7d-6333-423e-bd48-28af1431b263@gmx.de>
 <SN6PR02MB4157594508B80319444C6C24D4D72@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fc8f7246-2e05-4433-85d8-65dbed723826@gmx.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc8f7246-2e05-4433-85d8-65dbed723826@gmx.de>

On Sun, Mar 09, 2025 at 03:20:04PM +0100, Helge Deller wrote:
> On 3/9/25 05:10, Michael Kelley wrote:
> > From: Helge Deller <deller@gmx.de> Sent: Saturday, March 8, 2025 6:59 PM
> > > 
> > > On 2/19/25 00:01, mhkelley58@gmail.com wrote:
> > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > 
> > [snip]
> > 
> > > > 
> > > > Reported-by: Thomas Tai <thomas.tai@oracle.com>
> > > > Fixes: c25a19afb81c ("fbdev/hyperv_fb: Do not clear global screen_info")
> > > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > > ---
> > > > The "Fixes" tag uses commit c25a19afb81c because that's where the problem
> > > > was re-exposed, and how far back a stable backport is needed. But I've
> > > > taken a completely different, and hopefully better, approach in the
> > > > solution that isn't related to the code changes in c25a19afb81c.
> > > > 
> > > >    drivers/video/fbdev/hyperv_fb.c | 20 +++++++++++++-------
> > > >    1 file changed, 13 insertions(+), 7 deletions(-)
> > > 
> > > applied to fbdev tree.
> > > 
> > 
> > Thank you!
> > 
> > Related, I noticed the patch "fbdev: hyperv_fb: iounmap() the correct
> > memory when removing a device" is also in the fbdev for-next branch.
> > Wei Liu previously applied this patch to the hyperv-fixes tree (see [1])
> > and it's already in linux-next. Won't having it also in fbdev produce a
> > merge conflict?
> > [1] https://lore.kernel.org/linux-hyperv/Z6wHDw8BssJyQHiM@liuwe-devbox-debian-v2/
> 
> Thanks Michael!
> I now dropped that patch from the fbdev tree to avoid collisions.
> 
> Btw, I'm fine if we agree that all hyperv-fbdev fixes & patches go through
> hyperv or other trees. Just let me know.

I can pick up all hyperv-fbdev patches in the future. Thanks Helge.

Wei.

> 
> Helge

