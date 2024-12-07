Return-Path: <linux-hyperv+bounces-3419-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD19E7EC7
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FB216C031
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD9577F10;
	Sat,  7 Dec 2024 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dT54/Vye"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0499822C6E3;
	Sat,  7 Dec 2024 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557775; cv=none; b=MNoULfzJdM45BsVNWWzpGnOTHYvn5B+AWEBBssdhf09kh5BNbc7+gDmm7gI1xHKvIJ/fTpQPeWKTp/b26jAUQY15lmk/5S6ZRPqCqZfkriigJIAQUbpQRLqduULI31WTtEQZCVbAwiggV12f6SCtnIDKKvKGLP9JHdwBA43JKGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557775; c=relaxed/simple;
	bh=uK/a1tklW6ypYTTbskZPlwxyXREmMXdYMEocVp5ndkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=be9/6f97zU/frhyXRE8LRotr9qPOA1auz8mpuGkL8pJfVH8mXnWLVIbyzJTowJVEs+PquyPMg9q2xs87r8ePYjbF9tiwbkNUwsU692iPKnQPeYb/pCJEBaPBmoeHl+HpRyUJpFqazXsb6Bvd80yC9SE2etI/+/KnriQeCzBlaB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dT54/Vye; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56578C4CECD;
	Sat,  7 Dec 2024 07:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557774;
	bh=uK/a1tklW6ypYTTbskZPlwxyXREmMXdYMEocVp5ndkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dT54/Vyen1XnUvX7vH2G95NyefnbHihUB4kGygJI/vbGccfWS/zjgyOKJP106WvMA
	 xF++dg3MgcxONNqizAdwlbNv8GHh0EB/KqqFk0hJMIPKHhSL41k3FJpHWjCH2XX6N2
	 jpFFJqSAilUgTe64d3Tx4yJcMcUmooaTaVSiCNIN6cWlxyvWAthTpDhU5sVye4GQci
	 I1ZVprAJglbYqwXIMypFPoemy5qm1dugql7oSgis5K6VvBhv3XKLdQsxNce20pUB81
	 wOaEijQXoFp1V4x4J7hn8sBYQvdZRzgn4Z0tmgOQ1KxE7DlDky5iMCy5TQEH5gqrzQ
	 6gDgJ6B13fiBw==
Date: Sat, 7 Dec 2024 07:49:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: Wei Liu <wei.liu@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Ani Sinha <anisinha@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools: hv: change permissions of NetworkManager
 configuration file
Message-ID: <Z1P-Ddw3C1E7Rwqb@liuwe-devbox-debian-v2>
References: <20241016143521.3735-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016143521.3735-1-olaf@aepfle.de>

On Wed, Oct 16, 2024 at 04:35:10PM +0200, Olaf Hering wrote:
> Align permissions of the resulting .nmconnection file, instead of
> the input file from hv_kvp_daemon. To avoid the tiny time frame
> where the output file is world-readable, use umask instead of chmod.
> 
> Fixes: 42999c90 ("Support for keyfile based connection profile")
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

Applied to hyperv-fixes. Thanks.

> ---
>  tools/hv/hv_set_ifconfig.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_set_ifconfig.sh b/tools/hv/hv_set_ifconfig.sh
> index 440a91b35823..2f8baed2b8f7 100755
> --- a/tools/hv/hv_set_ifconfig.sh
> +++ b/tools/hv/hv_set_ifconfig.sh
> @@ -81,7 +81,7 @@ echo "ONBOOT=yes" >> $1
>  
>  cp $1 /etc/sysconfig/network-scripts/
>  
> -chmod 600 $2
> +umask 0177
>  interface=$(echo $2 | awk -F - '{ print $2 }')
>  filename="${2##*/}"
>  
> 

