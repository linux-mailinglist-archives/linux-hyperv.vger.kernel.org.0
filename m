Return-Path: <linux-hyperv+bounces-3949-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9A9A3576B
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 07:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7273B163984
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Feb 2025 06:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9983118A6D5;
	Fri, 14 Feb 2025 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iueNChuM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781415199D;
	Fri, 14 Feb 2025 06:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515982; cv=none; b=pdqLqwfr9FifmAudQNegE408whS1aZjgFzKjyHQ3Z9t2HTgdIhWrLzd1+URAxsfG1j1NUUzti0mdG57dc4t+ZZ/ILIYVe4s93pUYP/k6lH0twCMAZu4UhNw3dwEo/vw7hS/+KSV35D2YVo2L6dy2u73+xV/9uCHyrrQxbkcVURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515982; c=relaxed/simple;
	bh=Ty99QVjHnT29+FDxEr8KLWM1q6q0YgaA052BsgoNExM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=it+Bc1rUAW6Dyc8Ck0oRRsvtnEs20+IptU2oTchT2QTTyMpbTf10DM1A3zNvpa6KNH6zKbW/XyhJ8y/vePr0kUCpkQ6FiCNxrJ8dWxlkGedQj9YCa31kYVbVF8R8isUq0GBwkxYaJdY/rrKa3O4Svs9uIhWdWUhX7LtCYmCpx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iueNChuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2FCC4CED1;
	Fri, 14 Feb 2025 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739515981;
	bh=Ty99QVjHnT29+FDxEr8KLWM1q6q0YgaA052BsgoNExM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iueNChuM3b1PuYdVsPUh2q3VFfkUVbnlEJA/3Z7s2VKH1ikgmdKRq4jlcrQhvOVG2
	 cH6YpDyhq3K906OItd9dOolXBLlU9yRAq270PTzp8ucb8yQyrvhJ9CHjLGTYMFfpmF
	 ufL61mEGrMnJa1J6vnNoissyUJ9KLoLLr9xK8Fi4=
Date: Fri, 14 Feb 2025 07:51:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [RFC PATCH] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025021455-tricky-rebalance-4acc@gregkh>
References: <20250214064351.8994-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214064351.8994-1-namjain@linux.microsoft.com>

On Fri, Feb 14, 2025 at 12:13:51PM +0530, Naman Jain wrote:
> On regular bootup, devices get registered to vmbus first, so when
> uio_hv_generic driver for a particular device type is probed,
> the device is already initialized and added, so sysfs creation in
> uio_hv_generic probe works fine. However, when device is removed
> and brought back, the channel rescinds and again gets registered
> to vmbus. However this time, the uio_hv_generic driver is already
> registered to probe for that device and in this case sysfs creation
> is tried before the device gets initialized completely. Fix this by
> deferring sysfs creation till device gets initialized completely.
> 
> Problem path:
> vmbus_device_register
>     device_register
>         uio_hv_generic probe
> 		    sysfs_create_bin_file (fails here)

Ick, that's the issue, you shouldn't be manually creating sysfs files.
Have the driver core do it for you at the proper time, which should make
your logic much simpler, right?

Set the default attribute groups instead of manually creating this and
see if that works out better.

thanks,

greg k-h

