Return-Path: <linux-hyperv+bounces-4920-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5AAA8A3CB
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCCE443E10
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 16:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6E51FDA9B;
	Tue, 15 Apr 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f/LBdjBy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91469E571;
	Tue, 15 Apr 2025 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744733630; cv=none; b=PjyfxkTjk3WhKOzxtVy7rvpLkHdQh4KiYOTxt1qSPvGcV0md+tHCbhlccuzo/uuZkAXlwrGP0bryg43kSrnMNoxY8PUKONXkTR+4bCOaVMmfLzAvZtbrCJvS7TpAl0ki/tcKBjElMR/bb4Gn1XTVxEPzJOHTGe7E4XDWxx1ig5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744733630; c=relaxed/simple;
	bh=A7IOfJrGTdM+t9rJJwDd7yZYt9+Wnd76Xf/OqIDSEAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU0OSm9z2ajKiJN5nMGrY6IQXaXWMvQ8JWP+DGh3Tta7m+8MC9CRGeFNn+hfzZu2JZ6IlH7rFcxWfN9oxlwDomHODufQMtMMHhwwjpTnudV7Joi2PLg0prooI9Uf0BQuS7L8S96wAt4tJmEu4d9NYFs3AZ1nATOve/wdSt8vt4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f/LBdjBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BCEC4CEEC;
	Tue, 15 Apr 2025 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744733630;
	bh=A7IOfJrGTdM+t9rJJwDd7yZYt9+Wnd76Xf/OqIDSEAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f/LBdjByNY5lu5eLzkndO3H0mxezV5wzWDCaMJ1mgnxXIUvPpJ6TmwBjpytpWC5me
	 homRRBnNIaqdCrWFKih/NBy4Uvfyaa5Hb5ao0ZWg6H82QFWx67jy9qfzY085Boc8j0
	 hk0SmeIB5YgG1jlu5XeFxdbqskKjhW6KqvUGkM6Y=
Date: Tue, 15 Apr 2025 18:13:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@kernel.org, Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v4 1/2] uio_hv_generic: Fix sysfs creation path for ring
 buffer
Message-ID: <2025041556-disburse-tiling-8e72@gregkh>
References: <20250410060847.82407-1-namjain@linux.microsoft.com>
 <20250410060847.82407-2-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410060847.82407-2-namjain@linux.microsoft.com>

On Thu, Apr 10, 2025 at 11:38:46AM +0530, Naman Jain wrote:
> +	/*
> +	 * Skip updating the sysfs group if the primary channel is not yet initialized and sysfs
> +	 * group is not yet created. In those cases, the 'ring' will be created later in
> +	 * vmbus_device_register() -> vmbus_add_channel_kobj().
> +	 */
> +	if  (!primary_channel->device_obj->channels_kset)
> +		return 0;

2 spaces after "if"?

Yeah, it's minor, but it made me think that checkpatch had not been run.

thanks,

greg k-h

