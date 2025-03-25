Return-Path: <linux-hyperv+bounces-4692-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B84A70722
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 17:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAE637A1765
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFEF25DB0B;
	Tue, 25 Mar 2025 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BP3mPEC7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F72325BAB2;
	Tue, 25 Mar 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920879; cv=none; b=RnaUnwTWnj1pt5Jmv4yDc9tJ7MR0LGkiYrauTz6w3eReN7nCg/OslYRZPwwi/sVMT1Mf+kuTqANrRERfL+CqdQm9ftSmCnjEeWhVSzcS589mRcazgpbcgYv9MD1Dlzm30dhON0gZgJgfn+wanmIRXvNK9RkrV/9aKiJg8R8xeX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920879; c=relaxed/simple;
	bh=6OrG0EOh92n4a0Zkj+S/6zT+agYh6YHqRQLPWyHioFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuhZ3hAo/wnMwzXYgHqc77cdFpoNQjCwWBHyl1d1SXBkWKeFFB8tahN0Tq0JCPFpGTu7R+JzUKy3Wg/LiFxPKvKls2TQ8WEXU8kBgAAwv872ZoT6YbfV/q+FMl9lkqvU3XR8xSLk+abn3jRy1zCnoB3cWIKNstOYTNpopidpLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BP3mPEC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7A0C4CEE4;
	Tue, 25 Mar 2025 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742920878;
	bh=6OrG0EOh92n4a0Zkj+S/6zT+agYh6YHqRQLPWyHioFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BP3mPEC7Yexxe3Vj7pNTaJuwIZBElm1vx99AnbomGqThSPvISpvT2KdBbxwosJHJt
	 QI3ef8YHx/zW6xGAzCyWx/lywpVjDYUvtOkA7uaVluX+owV1jRg5YTG7/yteIxPqr4
	 9V+8z+2dWtvDJh3gjdSVlgncbgAl3RIA1U4mw5ec=
Date: Tue, 25 Mar 2025 12:39:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wei Liu <wei.liu@kernel.org>
Cc: longli@linuxonhyperv.com, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v3] uio_hv_generic: Set event for all channels on the
 device
Message-ID: <2025032533-sassy-blinker-85de@gregkh>
References: <1741644721-20389-1-git-send-email-longli@linuxonhyperv.com>
 <Z-LVk8jWkalG5KdD@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-LVk8jWkalG5KdD@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>

On Tue, Mar 25, 2025 at 04:10:59PM +0000, Wei Liu wrote:
> On Mon, Mar 10, 2025 at 03:12:01PM -0700, longli@linuxonhyperv.com wrote:
> > From: Long Li <longli@microsoft.com>
> > 
> > Hyper-V may offer a non latency sensitive device with subchannels without
> > monitor bit enabled. The decision is entirely on the Hyper-V host not
> > configurable within guest.
> > 
> > When a device has subchannels, also signal events for the subchannel
> > if its monitor bit is disabled.
> > 
> > This patch also removes the memory barrier when monitor bit is enabled
> > as it is not necessary. The memory barrier is only needed between
> > setting up interrupt mask and calling vmbus_set_event() when monitor
> > bit is disabled.
> > 
> > Signed-off-by: Long Li <longli@microsoft.com>
> 
> Greg, are you going to take this patch?
> 
> I can take it if you want.

It's the merge window right now, neither of us should be taking it.  Let
me look into it after -rc1 is out.

thanks,

greg k-h

