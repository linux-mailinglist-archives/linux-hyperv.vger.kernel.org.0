Return-Path: <linux-hyperv+bounces-500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DB77C02EF
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 19:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C488281B82
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 17:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DFA225AB;
	Tue, 10 Oct 2023 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBpniwwT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60314225A6;
	Tue, 10 Oct 2023 17:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360A4C433C7;
	Tue, 10 Oct 2023 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696959921;
	bh=12HETObScvICGvJBj/jsxHUGs+99NSdL0zEu4lhBNzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBpniwwTUojc0NnCQJeOU65qlwLKGVTSmkkVf7Iy6gZ+L/0v5MRNtOwTstrHS5+td
	 QCDTF/eZXfb1s3RelWJdj7Z9ajTRKlNdpLwkHPTXiDs0EyNltaCYL04uLFzS6ZAhbu
	 V4nEf1wDAa6zsJXOW8QJkk+NRC/hp3Oscwsk95rBuTLP0JMEWDVxyCW9ElEycUMKDn
	 SRj9bkBc1s19gDDyfF6KONE94I9MkbgGqOw2GWzc86G0lCFYx10VAsbq1SLcd795bj
	 KKadPfA8+XJeagyKFmjz5lwaf87UuEnRgYX17ObVKwdVrPixhjabn5IeBl6y158lL+
	 8v0vnBXTQIyQA==
Date: Tue, 10 Oct 2023 19:45:16 +0200
From: Simon Horman <horms@kernel.org>
To: Sonia Sharma <sosha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
	mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v7] hv_netvsc: fix netvsc_send_completion to
 avoid multiple message length checks
Message-ID: <20231010174516.GA1003866@kernel.org>
References: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696838416-8925-1-git-send-email-sosha@linux.microsoft.com>

On Mon, Oct 09, 2023 at 01:00:16AM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> ---
> Changes in v3:
> * added return statement in default case as pointed by Michael Kelley.
> Changes in v4:
> * added fixes tag
> * modified commit message to explain the issue fixed by patch.
> Changes in v5:
> * Dropped fixes tag as suggested by Simon Horman.
> * fixed indentation
> Changes in v7:
> * Dropped the prefix "net" from subject line.

This seems address the concerns raised by Michael Kelly in his review of v6.

It doesn't include his (or my) Reviewed-by tag(s).
That not withstanding the logic change and overall patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

