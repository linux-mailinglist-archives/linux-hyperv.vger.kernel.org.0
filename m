Return-Path: <linux-hyperv+bounces-1462-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3222483747C
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 21:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 650081C27DC8
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jan 2024 20:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B2547784;
	Mon, 22 Jan 2024 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1hVgyLq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3D73D3A7;
	Mon, 22 Jan 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956588; cv=none; b=haTpsirdk6FQBbQDCFR6BFfOFVnhmeyxKpvs2vMw0648b3wckt9prYf7lWqujrl4hsjnlJ5abAOUALtrXC3nSZKmDXV5JFMB1vexz9UB+xwHP2ZFLjjWCtKCjU1pz2TYw8ODXSArw5T+meA4HEe9t8IHc+Hyi+yuVdfk6OXBBzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956588; c=relaxed/simple;
	bh=8uQMHUcXhtjhqayjyELeGsTQuyul/RDw0AHVO1zqFyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gRXmGaXvTAzXQtXbd4IwIl6KykjM7NgF1PLC3VXB8SNpZmO1wv987+rHNF++GK1bqDDCPfLcjRAyxxK7ZsLTQj4ZAEi72LXq4OaPfT625jV3x3Fl+NQijjkBfqurOH5gq8tATcW5tUKj94xnd2qG/d0YbSuMyCETAuAcmUFegck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1hVgyLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E8C433B1;
	Mon, 22 Jan 2024 20:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956587;
	bh=8uQMHUcXhtjhqayjyELeGsTQuyul/RDw0AHVO1zqFyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M1hVgyLqytB+uOHN87/G0Mx0O6oa8OSf0K4e4wc1VVYQIoqwi9xrsFE6x4PEEx/8Y
	 lr0H/drkLUBoaLo9VKnXH1F5F8BA6la87ESLGGQN7aAFXtpdL8mX4PEmb3kqSX1SE3
	 06YjGNizjI3n+wh2XLRin7lCLVaJqDFJ49BZpHfCqhUGf0DKgawRJYdNgMToHt7nk3
	 qOFwgp2AqXaKkwgX20Gh6slmRbXDORYVstZToPkBncThvJa8obBig35ydVnzS5+eAR
	 jUzFydz+GaIKg2nnmhyOwuNyW6w5xebf2y26X7zJLIohGGQ+4YP1CbYvzuxGbdR7RD
	 fJlYIJKL8et8A==
Date: Mon, 22 Jan 2024 20:49:38 +0000
From: Simon Horman <horms@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/1] hv_netvsc: Calculate correct ring size when
 PAGE_SIZE is not 4 Kbytes
Message-ID: <20240122204938.GG126470@kernel.org>
References: <20240122162028.348885-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122162028.348885-1-mhklinux@outlook.com>

On Mon, Jan 22, 2024 at 08:20:28AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> Current code in netvsc_drv_init() incorrectly assumes that PAGE_SIZE
> is 4 Kbytes, which is wrong on ARM64 with 16K or 64K page size. As a
> result, the default VMBus ring buffer size on ARM64 with 64K page size
> is 8 Mbytes instead of the expected 512 Kbytes. While this doesn't break
> anything, a typical VM with 8 vCPUs and 8 netvsc channels wastes 120
> Mbytes (8 channels * 2 ring buffers/channel * 7.5 Mbytes/ring buffer).
> 
> Unfortunately, the module parameter specifying the ring buffer size
> is in units of 4 Kbyte pages. Ideally, it should be in units that
> are independent of PAGE_SIZE, but backwards compatibility prevents
> changing that now.
> 
> Fix this by having netvsc_drv_init() hardcode 4096 instead of using
> PAGE_SIZE when calculating the ring buffer size in bytes. Also
> use the VMBUS_RING_SIZE macro to ensure proper alignment when running
> with page size larger than 4K.
> 
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Hi Michael,

As a bug fix this probably warrants a fixes tag.
Perhaps this is appropriate?

Fixes: 450d7a4b7ace ("Staging: hv: ring parameter")

...

