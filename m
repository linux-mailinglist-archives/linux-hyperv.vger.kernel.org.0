Return-Path: <linux-hyperv+bounces-3413-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504C99E7EAF
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 08:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9CC283C1F
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Dec 2024 07:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47CC200A0;
	Sat,  7 Dec 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFORjXkA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992C4C79;
	Sat,  7 Dec 2024 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733556330; cv=none; b=mcajTapwyJQGWBCEunEf03+cZx0P8gA9UsQreVE6ycum74qEp7OpIs8ycr67dSpdwcoZ55jRrqBvnH+XgXvn965xDC+wAmN5FEQHdNy0QpdRqI4Rn49G+/s+hEtAAm23f0ttBJBQpLRv97XYSbMl+GMvvHaLbLqiJvf0wzz2wpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733556330; c=relaxed/simple;
	bh=5FDHhUoLjzoGXeO4abHanu6sdCUNkeQkPznob9yup9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsfXanDE7h09ZMyPYRxFDXRXEYDwCEUJJuAQ7VClQsqIp6z98pwqg7Eq1v2ewS4gOVoIcC6vSQS0AfT0oceYH7k/cGerXP15ZTM8dFaqw6JIaCsxIpfq/QBs67pCg0eLj4mEu58l7CxGgKnVdtNj7fw6SmHJA6rF5tWKGVlEhbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFORjXkA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8691C4CECD;
	Sat,  7 Dec 2024 07:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733556330;
	bh=5FDHhUoLjzoGXeO4abHanu6sdCUNkeQkPznob9yup9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFORjXkAhiCPSNz+/RkYlnYV18l0t303XthSrfsFwk/l2YjFV6Z/yy3LEQluHCSOB
	 cQ4UiaGbBABVbdIuiA1zZDeB7z1w1v/LnQkxtFf/y1+UCeUw2i0d3oDOMeCU+1xiKc
	 KzcBuNwsWWpIk/bWJFjjQZMWcmetTx4YdR5P3w8BVs/h41Q5IluQ0hg2/z2M2OTMhp
	 0o5rhCeEJIucBZa1QCWO3sI9N2j4lTqSbxSrGCznGFOpsarh9vnwSPXheJqdYPWhgY
	 Ygxh49iA7G+s/fTG98vbkZ3KiQc3ZoFTFYQ+YBwJrNtQBXcYNCBw0a74mm1fKRHeh6
	 D1GO1sTHjsMBg==
Date: Sat, 7 Dec 2024 07:25:28 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com
Subject: Re: [PATCH v1] tools/hv: update route parsing in kvp daemon
Message-ID: <Z1P4aKCP8qt4FfSF@liuwe-devbox-debian-v2>
References: <20241202102235.9701-1-olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202102235.9701-1-olaf@aepfle.de>

On Mon, Dec 02, 2024 at 11:19:55AM +0100, Olaf Hering wrote:
> After recent changes in the VM network stack, the host fails to
> display the IP addresses of the VM. As a result the "IP Addresses"
> column in the "Networking" tab in the Windows Hyper-V Manager is
> empty. This is caused by a change in the expected output of the
> "ip route show" command. Previously the gateway address was shown
> in the third row. Now the gateway addresses might be split into
> several lines of output. As a result, the string "ra" instead of
> an IP address is sent to the host.
> 
> To me more specific, a VM with the wellknown wicked network

me -> be.

Heh, it took me a while to realize that "wicked" is the name of a
network manager. :-)

> managing tool still shows the expected output in recent openSUSE
> Tumbleweed snapshots:
> 
> ip a show dev uplink;ip -4 route show;ip -6 route show
> 2: uplink: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state ...
>     link/ether 00:15:5d:d0:93:08 brd ff:ff:ff:ff:ff:ff
>     inet 1.2.3.4/22 brd 1.2.3.255 scope global uplink
>        valid_lft forever preferred_lft forever
>     inet6 fe80::215:5dff:fed0:9308/64 scope link proto kernel_ll
>        valid_lft forever preferred_lft forever
> default via 1.2.3.254 dev uplink proto dhcp
> 1.2.3.0/22 dev uplink proto kernel scope link src 1.2.3.4
> fe80::/64 dev uplink proto kernel metric 256 pref medium
> default via fe80::26fc:4e00:3b:74 dev uplink proto ra metric 1024 exp...
> default via fe80::6a22:8e00:fb:14f8 dev uplink proto ra metric 1024 e...
> 
> A similar VM, but with NetworkManager as network managing tool:
> 
> ip a show dev eth0;ip -4 route show;ip -6 route show
> 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP...
>     link/ether 00:15:5d:d0:93:0b brd ff:ff:ff:ff:ff:ff
>     inet 1.2.3.8/22 brd 1.2.3.255 scope global dynamic noprefixroute ...
>        valid_lft 1022sec preferred_lft 1022sec
>     inet6 fe80::215:5dff:fed0:930b/64 scope link noprefixroute
>        valid_lft forever preferred_lft forever
> default via 1.2.3.254 dev eth0 proto dhcp src 1.2.3.8 metric 100
> 1.2.3.0/22 dev eth0 proto kernel scope link src 1.2.3.8 metric 100
> fe80::/64 dev eth0 proto kernel metric 1024 pref medium
> default proto ra metric 20100 pref medium
>         nexthop via fe80::6a22:8e00:fb:14f8 dev eth0 weight 1
>         nexthop via fe80::26fc:4e00:3b:74 dev eth0 weight 1
> 
> Adjust the route parsing to use a single line for each line of
> output. Also use a single shell invocation to retrieve both IPv4
> and IPv6 information. The actual IP addresses are expected after
> the "via" keyword.
> 

Shradha, can you help review and test this patch? You changed the code in this
file recently.

Keep in mind that we want this tool to be useable for different network
managers.

Thanks,
Wei.

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  tools/hv/hv_kvp_daemon.c | 108 ++++++++++++++++++++++++++++++---------
>  1 file changed, 84 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
> index ae57bf69ad4a..63b44b191320 100644
> --- a/tools/hv/hv_kvp_daemon.c
> +++ b/tools/hv/hv_kvp_daemon.c
> @@ -24,6 +24,7 @@
>  
>  #include <sys/poll.h>
>  #include <sys/utsname.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -677,6 +678,88 @@ static void kvp_process_ipconfig_file(char *cmd,
>  	pclose(file);
>  }
>  
> +static bool kvp_verify_ip_address(const void *address_string)
> +{
> +	char verify_buf[sizeof(struct in6_addr)];
> +
> +	if (inet_pton(AF_INET, address_string, verify_buf) == 1)
> +		return true;
> +	if (inet_pton(AF_INET6, address_string, verify_buf) == 1)
> +		return true;
> +	return false;
> +}
> +
> +static void kvp_extract_routes(const char *line, void **output, size_t *remaining)
> +{
> +	static const char needle[] = "via ";
> +	const char *match, *haystack = line;
> +
> +	while ((match = strstr(haystack, needle))) {
> +		const char *address, *next_char;
> +
> +		/* Address starts after needle. */
> +		address = match + strlen(needle);
> +
> +		/* The char following address is a space or end of line. */
> +		next_char = strpbrk(address, " \t\\");
> +		if (!next_char)
> +			next_char = address + strlen(address) + 1;
> +
> +		/* Enough room for address and semicolon. */
> +		if (*remaining >= (next_char - address) + 1) {
> +			memcpy(*output, address, next_char - address);
> +			/* Terminate string for verification. */
> +			memcpy(*output + (next_char - address), "", 1);
> +			if (kvp_verify_ip_address(*output)) {
> +				/* Advance output buffer. */
> +				*output += next_char - address;
> +				*remaining -= next_char - address;
> +
> +				/* Each address needs a trailing semicolon. */
> +				memcpy(*output, ";", 1);
> +				*output += 1;
> +				*remaining -= 1;
> +			}
> +		}
> +		haystack = next_char;
> +	}
> +}
> +
> +static void kvp_get_gateway(void *buffer, size_t buffer_len)
> +{
> +	static const char needle[] = "default ";
> +	FILE *f;
> +	void *output = buffer;
> +	char *line = NULL;
> +	size_t alloc_size = 0, remaining = buffer_len - 1;
> +	ssize_t num_chars;
> +
> +	/* Show route information in a single line, for each address family */
> +	f = popen("ip --oneline -4 route show;ip --oneline -6 route show", "r");
> +	if (!f) {
> +		/* Convert buffer into C-String. */
> +		memcpy(output, "", 1);
> +		return;
> +	}
> +	while ((num_chars = getline(&line, &alloc_size, f)) > 0) {
> +		/* Skip short lines. */
> +		if (num_chars <= strlen(needle))
> +			continue;
> +		/* Skip lines without default route. */
> +		if (memcmp(line, needle, strlen(needle)))
> +			continue;
> +		/* Remove trailing newline to simplify further parsing. */
> +		if (line[num_chars - 1] == '\n')
> +			line[num_chars - 1] = '\0';
> +		/* Search routes after match. */
> +		kvp_extract_routes(line + strlen(needle), &output, &remaining);
> +	}
> +	/* Convert buffer into C-String. */
> +	memcpy(output, "", 1);
> +	free(line);
> +	pclose(f);
> +}
> +
>  static void kvp_get_ipconfig_info(char *if_name,
>  				 struct hv_kvp_ipaddr_value *buffer)
>  {
> @@ -685,30 +768,7 @@ static void kvp_get_ipconfig_info(char *if_name,
>  	char *p;
>  	FILE *file;
>  
> -	/*
> -	 * Get the address of default gateway (ipv4).
> -	 */
> -	sprintf(cmd, "%s %s", "ip route show dev", if_name);
> -	strcat(cmd, " | awk '/default/ {print $3 }'");
> -
> -	/*
> -	 * Execute the command to gather gateway info.
> -	 */
> -	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
> -				(MAX_GATEWAY_SIZE * 2), INET_ADDRSTRLEN, 0);
> -
> -	/*
> -	 * Get the address of default gateway (ipv6).
> -	 */
> -	sprintf(cmd, "%s %s", "ip -f inet6  route show dev", if_name);
> -	strcat(cmd, " | awk '/default/ {print $3 }'");
> -
> -	/*
> -	 * Execute the command to gather gateway info (ipv6).
> -	 */
> -	kvp_process_ipconfig_file(cmd, (char *)buffer->gate_way,
> -				(MAX_GATEWAY_SIZE * 2), INET6_ADDRSTRLEN, 1);
> -
> +	kvp_get_gateway(buffer->gate_way, sizeof(buffer->gate_way));
>  
>  	/*
>  	 * Gather the DNS state.
> 

