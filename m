Return-Path: <linux-hyperv+bounces-3423-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70DA99E7ED3
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F3C188674B
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BBC77111;
	Sat,  7 Dec 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhItVw+p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C71222C6E3;
	Sat,  7 Dec 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733558175; cv=none; b=HE12vpM2YiLA/zNM+cDuXrVut2Nu6EjyV2xi8Ib1vR8+vDGJ3svIP1lzvIDg7K4VPgZJxWi/MmY/K9B6vx9B/ZWBBGIC4GnCVuXqA/CVP9Mgerv7zZXqMd6feZVN9grk42jyt2XcFt+KP4aXWtBACse91koON4gVzCTacBTThnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733558175; c=relaxed/simple;
	bh=EQPHhX7xYQfHkB/M4JeCSCExwDjxIj9Ff6puySF7OC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ei7B+0pJ+wHD5zB2YkblPqr4ln/OtNihUYkRn/izDL+gOVuk4PUKzfDvT+AIOZrBm4s1BO9OUd/kbc0KqoHb0ldQy90OZ1uTc+PCqG1u3gbLuG1hPF1WlZCi5l5C9Cs3n2b8kKgL8g3AHpbVlNGam5MaC8R7jf2DmbkxsiozzQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhItVw+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECAEC4CECD;
	Sat,  7 Dec 2024 07:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733558174;
	bh=EQPHhX7xYQfHkB/M4JeCSCExwDjxIj9Ff6puySF7OC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhItVw+pGIMBNt6M7+j8SdFU0YQJQkGM8ZIDL+rQgjb9vNv0Rv6nHaWIMbkJgfcp0
	 4+LQ2QGRYeMO60XWSB0jsvYaH6mfHsZZ+PQ3IP7bm+eLQdr5vu7OBtYOkU97D7h7Ci
	 DiFmt/ekjmJCeqIB4h2ryjtmDP2eUBl9Hmq3zxS6Cnaq1OU8ZXGg+WmD7eT+ZE/2e6
	 namZAGr6niiLhx7bH1q6n9QYI/Du7ZTsp9Om9IzKL62JTC1VTWzGX1sdqwx1io17NJ
	 2GXY0qk7NlrO4x7OixUzzIZ0GWlSn9olBZBmSzsi3yQXHGE4VO8jgcjQEGBIoPwWg0
	 mGm+G9aNSKLxw==
Date: Sat, 7 Dec 2024 07:56:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: linux-hyperv@vger.kernel.org, mhklinux@outlook.com,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv/hv_kvp_daemon: Pass NIC name to hv_get_dns_info as
 well
Message-ID: <Z1P_naD-PjHimswj@liuwe-devbox-debian-v2>
References: <20241112150401.217094-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112150401.217094-1-vkuznets@redhat.com>

On Tue, Nov 12, 2024 at 04:04:01PM +0100, Vitaly Kuznetsov wrote:
> The reference implementation of hv_get_dns_info which is in the tree uses
> /etc/resolv.conf to get DNS servers and this does not require to know which
> NIC is queried. Distro specific implementations, however, may want to
> provide per-NIC, fine grained information. E.g. NetworkManager keeps track
> of DNS servers per connection.
> 
> Similar to hv_get_dhcp_info, pass NIC name as a parameter to
> hv_get_dns_info script.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Applied. Thanks.

> ---
>  tools/hv/hv_kvp_daemon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index ae57bf69ad4a..296a7a62c54d 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -725,7 +725,7 @@ static void kvp_get_ipconfig_info(char *if_name,
>  	 * .
>  	 */
>  
> -	sprintf(cmd, KVP_SCRIPTS_PATH "%s",  "hv_get_dns_info");
> +	sprintf(cmd, KVP_SCRIPTS_PATH "%s %s", "hv_get_dns_info", if_name);
>  
>  	/*
>  	 * Execute the command to gather DNS info.
> -- 
> 2.47.0
> 

