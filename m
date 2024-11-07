Return-Path: <linux-hyperv+bounces-3285-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF1F9C0EE2
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 20:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A30B22426
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 19:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D052178F2;
	Thu,  7 Nov 2024 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W09KNCLQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B3F217665;
	Thu,  7 Nov 2024 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007784; cv=none; b=OdKBD9roP/n8lbjFQqtxsGx9YltgJG6jei5EL+5WIMtBsW3WLV3e4robbuWkUdh35HMuX5QYdzNxmmIQeAg5yFQ3t9bbvZW2voY7OkaYcwTWI/Vo0gS4YuuAg5YcNcVVROA/z0HhIwuIoIVdVrmQtcr4KZU5qg6xXxSMBKwVWFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007784; c=relaxed/simple;
	bh=NA0dP62FOcQc50700gE3myW2lAd61EGoVhQaQh1zBiM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9+duvG2nt6fLyTSKIh5wggJAehQGgFFIh1a+UuPWRT7zHJHvcijkUAN3EAgPZF/ZFXFfBkdenhAXiNcC40+HJWGu0bXv2vYJvB2V58DlB+NG7+rZG3DBl5vOfMXdolRBEdI1+mldos9/5g6IUA8fcJ+ohaRko0GU7Ss56AER58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W09KNCLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E473FC4CECC;
	Thu,  7 Nov 2024 19:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731007783;
	bh=NA0dP62FOcQc50700gE3myW2lAd61EGoVhQaQh1zBiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W09KNCLQXgxZYFS0Icj/it+o5L1RZY8Q2oiozkChCv1LH/4FqJ+62tIfhFyhaT5qj
	 K5rCgkoa6vXjL6BUx1QZDur/s+nKn5g44xFlTnRlbm4pcgLSqSmej5+HC3m3V5YEd0
	 Gd5voQH/utRBncBqL9icgWpr9TNqMs3HOp4JKIElegBZzi8E036/7ln4iRR+5lUvVV
	 H4w9n3P43pAoDKHJXeS0ERx5DQd4gj+PEr9fQzYbnrmQ9iLiVeO+pFrOVngq55E/c3
	 LwZV7A5N1lGLcT8FT8X0ULUKMnwBEVJB0iTSNIRifLImYi/s2XmRXNy5CF1h1rwjI6
	 UGW0rjBmzXXNA==
Date: Thu, 7 Nov 2024 11:29:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>,
 mst@redhat.com, jasowang@redhat.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent
 a dangling pointer
Message-ID: <20241107112942.0921eb65@kernel.org>
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:
> When hvs is released, there is a possibility that vsk->trans may not
> be initialized to NULL, which could lead to a dangling pointer.
> This issue is resolved by initializing vsk->trans to NULL.
> 
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> Cc: stable@vger.kernel.org

I don't see the v1 on netdev@, nor a link to it in the change log
so I may be missing the context, but the commit message is a bit
sparse.

The stable and Fixes tags indicate this is a fix. But the commit
message reads like currently no such crash is observed, quote:

                          which could lead to a dangling pointer.
                                ^^^^^
                                     ?

Could someone clarify?

