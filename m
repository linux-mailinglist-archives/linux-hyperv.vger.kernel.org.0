Return-Path: <linux-hyperv+bounces-4317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C022A58958
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Mar 2025 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144003A874A
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Mar 2025 23:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488401C1F0D;
	Sun,  9 Mar 2025 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpILkOrk"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5B117741;
	Sun,  9 Mar 2025 23:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741564118; cv=none; b=mkd8ZmajIk6lBJnVa4TAZ3mDtVrK6k6Fiishhz6YS3PLAzwTjz5yv+nTKAty6Sg0qFi8WNByQy6F5+AP0+3TbkhtiRI5wXf/B+AJezx+W77qvLBif+Mzb/OGs1hw9ffra1xC3AbqtXS/bcsOl4xOOA6eq0uJEsMAbIZtbWTH5GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741564118; c=relaxed/simple;
	bh=lf6ZBbuxeUauTWqDo8TNf9cQ+rK8UKnvv+A3eXrj1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWuLOfz/8lEi+kjjVRm5JIiyU9ICwHpqV7KmybLQKB2RUHB5J8DOLVKyIM+yH0za1xhEE7MemiKUr/w2Ef4owYKcp0eP9Y4tPywjdPr7z49b0jQZ9bIhx3QIUvP1v4p6J0Y9uQPJTDAbDqmevhllgTe2/Gst/nakwrms6kCKvo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpILkOrk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F69CC4CEE3;
	Sun,  9 Mar 2025 23:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741564117;
	bh=lf6ZBbuxeUauTWqDo8TNf9cQ+rK8UKnvv+A3eXrj1X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JpILkOrk2UpE7/J+gySr+GPsQabyHxxhL4ZOmM8tEEpJ6wzUnPJn+bJwsQ4Ydt4zn
	 Ll9e2A9bkVA+bMLSV09+hhUpZ16gYgFerIBUKm9Lf6gk8PWLpBdkDIdbWkgHfnmnqI
	 pUDIcK3jVkn3GP90Isji4FNO+RnJEPP3Yf5hn41CFj0CbEA+btaPMDpqIyJtfAYCvS
	 qW3GH97rNMJo+1DsFYi9Uu9bp+S8zxOP60S3Z3jyU+24NHbZ22pc//jizGgzjl6W5H
	 NQBQ4xfU8rsyDir0e26bnGno/ucdBVmK+2EdPWXY25BWc051AWwJB2RO8MkNWMT8No
	 N5dQl7zTIFCGA==
Date: Sun, 9 Mar 2025 23:48:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, christophe.jaillet@wanadoo.fr,
	ssengar@linux.microsoft.com, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/hyperv: Fix address space leak when Hyper-V DRM
 device is removed
Message-ID: <Z84o1IEo_irAp8mJ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <20250210193441.2414-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210193441.2414-1-mhklinux@outlook.com>

On Mon, Feb 10, 2025 at 11:34:41AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a Hyper-V DRM device is probed, the driver allocates MMIO space for
> the vram, and maps it cacheable. If the device removed, or in the error
> path for device probing, the MMIO space is released but no unmap is done.
> Consequently the kernel address space for the mapping is leaked.
> 
> Fix this by adding iounmap() calls in the device removal path, and in the
> error path during device probing.
> 
> Fixes: f1f63cbb705d ("drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()")
> Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-fixes. Thanks.

