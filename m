Return-Path: <linux-hyperv+bounces-2078-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F4F8BBD45
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 May 2024 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443EA28255F
	for <lists+linux-hyperv@lfdr.de>; Sat,  4 May 2024 16:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E45A0F9;
	Sat,  4 May 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CCKg4H8A"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED734CB55;
	Sat,  4 May 2024 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714841274; cv=none; b=LSKY5djyJAoeL6xF5drcDvEVcCU9HrJgGYRW68ElXnl56ffP4FtOPc6BfTvLSa79popLlsb/OAO9IwikekGcTkDztEp3rRr+MmPMt5JYQMazFEpM5diW2e+ykFqOLgyDeeyoaQ+2UeK9xovaHJWkASSJ8Bvn+aS5CkgY4Kd5Csw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714841274; c=relaxed/simple;
	bh=/vJle/oW4cppd9RU6K2OkI/iCss+7B9VEAlDQG+dpYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od5c7wH3SuTxsBc4xq4fOHG1Bx+9n4QK7HN8hHSxNNrz59/0nQ8LovqH6+IdE0rr+L6zTgSV6aqTg09nehwq74fv9AxL+Qde04N/zrow6hIheBx2n+wQRaFQY0omLP5ikEpAZAd7nxnrPJKcPoSRKZScvQeyTbS+bMxSLOXeAro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CCKg4H8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93559C072AA;
	Sat,  4 May 2024 16:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714841274;
	bh=/vJle/oW4cppd9RU6K2OkI/iCss+7B9VEAlDQG+dpYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CCKg4H8Al65CX2UvgGGDHeUK/z68FEa+EktqJu9JkNTR5/UPKUzQnL+57ZkfW7AHt
	 OAWC5ND1jJmgu1P6UjAKA6went72tkDoRjDTZKpx1kCcQmX7msQSAZivnh7LL19B0n
	 9rUct6PiY6x0QzbHuhGRGhjKWOEtbsTuBa+tSYv8=
Date: Sat, 4 May 2024 18:47:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH] tools: hv: suppress the invalid warning for packed
 member alignment
Message-ID: <2024050435-poise-muster-a52c@gregkh>
References: <1713340848-6901-1-git-send-email-ssengar@linux.microsoft.com>
 <2024041708-juror-briskly-9c86@gregkh>
 <20240417082149.GA9867@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417082149.GA9867@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Wed, Apr 17, 2024 at 01:21:49AM -0700, Saurabh Singh Sengar wrote:
> On Wed, Apr 17, 2024 at 10:17:21AM +0200, Greg KH wrote:
> > On Wed, Apr 17, 2024 at 01:00:48AM -0700, Saurabh Sengar wrote:
> > > Packed struct vmbus_bufring is 4096 byte aligned and the reporting
> > > warning is for the first member of that struct which shouldn't add
> > > any offset to create alignment issue.
> > > 
> > > Suppress the warning by adding -Wno-address-of-packed-member flag to
> > > gcc.
> > > 
> > > Reported-by: kernel test robot <yujie.liu@intel.com>
> > > Closes: https://lore.kernel.org/all/202404121913.GhtSoKbW-lkp@intel.com/
> > > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > 
> > What commit id does this fix?
> 
> Fixes: 45bab4d74651 ("tools: hv: Add vmbus_bufring")

Great, please provide that in the next verion of this change you send
out.

thanks,

greg k-h

