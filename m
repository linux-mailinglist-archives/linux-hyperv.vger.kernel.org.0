Return-Path: <linux-hyperv+bounces-3429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A4B9E8898
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 00:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765E5163B7E
	for <lists+linux-hyperv@lfdr.de>; Sun,  8 Dec 2024 23:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F4713A865;
	Sun,  8 Dec 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlNZt8NX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6FB66E;
	Sun,  8 Dec 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733701976; cv=none; b=iyR5qMkOwT6PCW0uR1KEQR7wHj6uxJzR7q0fk3Ym+hx/xZJOihzg1/3iqEHOyZ36h+l3+8QpToPurnKoIjj/oDJ4/njxgQzAZmQ1l4v0rQHqwS5RuQr/tRA6/xO8F/+2J4ggnylrUKkLttSeDEHGjctrpXx77e6SfnugEBjNdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733701976; c=relaxed/simple;
	bh=r5Xqq6FNBE7zB2TzBM9mS93DhtkIznVQorgiWvDRuG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US+MvbEH/w2nTllyRxJKfGZ+B8TdpBrhT6FZ+j1d05jGN/Fy1pkpb6jOlXWjNdCukUQUWKPnirgQSOj0TzDuBQQQugaP+UXrtBMXW9nuJeg+Ve+sWvOdeGGC989SBcimg0QuJpMxodkfTUbhnjnY5rv3YimMNFUhtsrjYtKvnpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlNZt8NX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B5CDC4CED2;
	Sun,  8 Dec 2024 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733701975;
	bh=r5Xqq6FNBE7zB2TzBM9mS93DhtkIznVQorgiWvDRuG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlNZt8NXHN/tFQSm7P0rFkbM00LCfafLHqm5ibR4gJDjkxstiJ5o3bla1U7MdfJ0d
	 PPwb7soCAbLjfiYuWJWI9SvzYN7Oao615lnlyAxaBXyEJlR6KUnUstU+h3tKlaKA0R
	 xqbF9BdjIfDg5Gxfuedjomp0FXssSfxDqRm8jx0m+Gs/n7iisM1AP0i9A4UcYnHlSe
	 vM+lPKKEn4oPoJnodfYVg91ScHEj/W1qI+LtqUpdW4Dgy88wft8EChW3j7QO7Hu4g7
	 kQf3UZ/VLzrNooDTKM3KqRzsxWttx5EJKj/avrOtWomtwOr4yQZUjxBC0qYXn9e68N
	 I6gtS5o0D/vHA==
Date: Sun, 8 Dec 2024 23:52:54 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: reduce resouce usage in hv_kvp_daemon
Message-ID: <Z1YxVhO1x2YTLX_F@liuwe-devbox-debian-v2>
References: <20241202123520.27812-1-olaf@aepfle.de>
 <Z1P2ucUPPEYN2cg5@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1P2ucUPPEYN2cg5@liuwe-devbox-debian-v2>

On Sat, Dec 07, 2024 at 07:18:17AM +0000, Wei Liu wrote:
> On Mon, Dec 02, 2024 at 01:35:16PM +0100, Olaf Hering wrote:
> > hv_kvp_daemon uses popen(3) and system(3) as convinience helper to
> > launch external helpers. These helpers are invoked via a
> > temporary shell process. There is no need to keep this temporary
> > process around while the helper runs. Replace this temporary shell
> > with the actual helper process via 'exec'.
> > 
> > Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> Acked-by: Wei Liu <wei.liu@kernel.org>

There's one conflict caused by an earlier patch by Vitaly. I've resolved
the conflict and applied the patch to hyperv-fixes. Please check the
final result.

Thanks,
Wei.

