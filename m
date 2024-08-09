Return-Path: <linux-hyperv+bounces-2757-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B31594CC9D
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 10:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B610AB20CE5
	for <lists+linux-hyperv@lfdr.de>; Fri,  9 Aug 2024 08:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF818F2D9;
	Fri,  9 Aug 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxI142bh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3744431;
	Fri,  9 Aug 2024 08:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193242; cv=none; b=FSRobMpJiw+rZe7fUJu3UgWFw8pureAtei/3mo/XN4qYDe4NGqLDQ5Zkyy55IatxwskZyXOPMzWdHrS9k4uSV0qzVqhzTjQ/9F60D7kp9OLqU2uFb042Z174Rx4rVBtxHVKymFNdE5ylbIY5qYGz9EqzBjp8YoyqKPa8mKSlay0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193242; c=relaxed/simple;
	bh=iXPqWLhyydEY9YljmfF4VAQ07JaykzvJfToiUIJSK/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcAniCX04s7cngtIkjpF3FqNTRDjJ7tjRHkkZRESZXHoUe5VcuERLZjs/MX/b6xQMSfoUj0jOQcsZ0hA6yQzb4tK4WwfaUpOw3ZLijuHXcVsr7bl28ATJN48jeVbapX8TvJgqwjfl5br/Erwtq1iMvUxwBAtYNQvhjCkOgF3dl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxI142bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81209C4AF0D;
	Fri,  9 Aug 2024 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723193242;
	bh=iXPqWLhyydEY9YljmfF4VAQ07JaykzvJfToiUIJSK/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxI142bhWfRH6jH17f0yElgC5vxURZVOlmL4W1CW3ux0+Fw9MP96S8JlRp87GsJAQ
	 lvFKA99Q3vDIUUGrFxGA7SA5tcFL9VVjhO4Ud+3PKNhRTpP6X301tnn+BnMBlyik/3
	 I959FgQzMWefV3DQwKnkCqUtjjbiE4y9DvHIegvzkDz39lyACQXBKgWgZeP8Dy96kL
	 Mj8Rw6tq/2zmr9fJYjfp0iAHQ3zmKVRrtZw3gVPzxZrCL24cKKvii98GLrGUh+2ivQ
	 DjsX5QHWUjb52+Gbiey1hG2x7igaivsX67Hy6gPXFoLap4bJqA/qzEMIg3iNUrTIO1
	 AgC7dhYw1IVlA==
Date: Fri, 9 Aug 2024 09:47:16 +0100
From: Simon Horman <horms@kernel.org>
To: longli@microsoft.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Message-ID: <20240809084716.GA3432921@kernel.org>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>

On Wed, Aug 07, 2024 at 04:17:06PM -0700, longli@linuxonhyperv.com wrote:
> From: Long Li <longli@microsoft.com>
> 
> After napi_complete_done() is called when NAPI is polling in the current
> process context, another NAPI may be scheduled and start running in
> softirq on another CPU and may ring the doorbell before the current CPU
> does. When combined with unnecessary rings when there is no need to arm
> the CQ, it triggers error paths in the hardware.
> 
> This patch fixes this by calling napi_complete_done() after doorbell
> rings. It limits the number of unnecessary rings when there is
> no need to arm. MANA hardware specifies that there must be one doorbell
> ring every 8 CQ wraparounds. This driver guarantees one doorbell ring as
> soon as the number of consumed CQEs exceeds 4 CQ wraparounds. In pratical

nit: practical

     Flagged by checkpatch.pl --codespell

...

