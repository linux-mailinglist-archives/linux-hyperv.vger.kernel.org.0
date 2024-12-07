Return-Path: <linux-hyperv+bounces-3411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E3A9E7EA9
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DDDD1884CAB
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4255B216;
	Sat,  7 Dec 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBgv3zx9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122164C79;
	Sat,  7 Dec 2024 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733555858; cv=none; b=YCyk3a1kRmThbWrP2L47P78TRyWq24WPxvTo7bMnpko4R7TZz4gy1oDeDvcAJqsETdJWOd0PBj9sgmzdX8gvLQCE8ZEiigMzvrlVccTDRxHbMdy19u+isMhBPA+B3261N5/D1nnUm0RNrzZiEdaQQTA5B3s6jqXAAnKQxY8aNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733555858; c=relaxed/simple;
	bh=zzO/0Si0mDzTUHUMMIco8TyztL00M6LvmoCEmzGWkY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2Q40xvkYaLauCa+ApL7RGOW//g/AqrFdKsqw6FXXt7uyifqRwJmyvgwA9tnakmD0vJ9UjWWpsGlSkIfvbB8DW/3+JAFjyr7S91B+zD9bWT2KbL3TVhgogdbnF2l/l6U6fFw/2Ty9idI77QpdKm6zJJKfhkCxN011g7UNvf8qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBgv3zx9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA8C4CECD;
	Sat,  7 Dec 2024 07:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733555857;
	bh=zzO/0Si0mDzTUHUMMIco8TyztL00M6LvmoCEmzGWkY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JBgv3zx9ShqueUxc0ml896JXjUOW2lDRx00E78k57mndpxaTXxNOrwS/ei1IAjeeJ
	 QthwVKp3Qo+h9Yp+WKjjWdLPnvdD0RBWVMPK8RosbsrVWKBpRu1GYnP3bsGLasLYp6
	 bTb1kYXmGEaKjqWRhmm++eFvmq+dkXD9im4nIdlz8l17n1kgkXYjSLNjGtUXfP13RF
	 DlQ3SvVDK5CViXIjzU9As6th0lC1kXuMTV160eSWG4ToRXwmc1Nt+7OMUvvZAorevl
	 TWemyunAxxSYIDz7JGAmPCXHE3VB0bvLiKZYd7YUAxgnXbRHnsQHiffLf4SxZs9fca
	 BW8C2MRqR3iVQ==
Date: Sat, 7 Dec 2024 07:17:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v1] tools/hv: reduce resouce usage in hv_get_dns_info
 helper
Message-ID: <Z1P2kKZQuPX-LH4x@liuwe-devbox-debian-v2>
References: <20241202120432.21115-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202120432.21115-1-olaf@aepfle.de>

On Mon, Dec 02, 2024 at 01:04:10PM +0100, Olaf Hering wrote:
> Remove the usage of cat. Replace the shell process with awk with 'exec'.
> Also use a generic shell because no bash specific features will be used.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>

The resource saving is not a lot, but nonetheless:

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  tools/hv/hv_get_dns_info.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
> index 058c17b46ffc..268521234d4b 100755
> --- a/tools/hv/hv_get_dns_info.sh
> +++ b/tools/hv/hv_get_dns_info.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/bin/sh
>  
>  # This example script parses /etc/resolv.conf to retrive DNS information.
>  # In the interest of keeping the KVP daemon code free of distro specific
> @@ -10,4 +10,4 @@
>  # this script can be based on the Network Manager APIs for retrieving DNS
>  # entries.
>  
> -cat /etc/resolv.conf 2>/dev/null | awk '/^nameserver/ { print $2 }'
> +exec awk '/^nameserver/ { print $2 }' /etc/resolv.conf 2>/dev/null
> 

