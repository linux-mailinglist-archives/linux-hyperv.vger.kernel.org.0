Return-Path: <linux-hyperv+bounces-1764-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ECA87E1F8
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 03:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DB61B23A70
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 02:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB41E879;
	Mon, 18 Mar 2024 02:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="g7kCyzeB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4514C1E86A;
	Mon, 18 Mar 2024 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727382; cv=none; b=g+nDhY+Zo7+4tZ7fRGDQWSaVb3WTMgfAYJEHiLo94Cu4QoNJuK7oABUKoY5Mo/ZmVDZYOFQKuwi8Ib9kRWchTxLwAWddniY0nEQZHmiakqnRkQnK4EepId9eti4e0OmZGlpMQZWdVEGYAIUyukESH/KcQ5tZNf/wmEGESN3A9Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727382; c=relaxed/simple;
	bh=VEV3bHnrvpDLnxzjH5gw8v6jQnwfu7MuGbkOPp9uIZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZTXmqbpXAQDDUsy/HR+JOgB30vxbTFJKHj9F2dgbv7jqNHicngvebD7+/QFS0S7x+IBEkmTiIwlZxjlLJRE2cIo/XuUpZktriz80woH497VFLCV4IPlzx+oUzbAQE8YDvvcWu8+6b9M9yDSnE9UP8BLKAJuUBMruic/XpI+4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=g7kCyzeB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D4DB120B74C1; Sun, 17 Mar 2024 19:02:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D4DB120B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710727375;
	bh=SIf/+MqbeJUe2PsctvamEzR9L4uheZJqgV8P1Cq6s2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7kCyzeBH+DU6DesWij01JeVviGKuGmT0n/3kBzEaWiw0jS37RGr01rF0Ib22POFF
	 XMQGugEfO90LOtzOC5xoJ94+tFkYkxuTk6z86G/uXDoeU71mZZ+8gDbTfwcaovuOcB
	 aUIPqVW5sJvIROqXiUEk/60DUD6KR8/9AeXfrqm4=
Date: Sun, 17 Mar 2024 19:02:55 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Olaf Hering <olaf@aepfle.de>, Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <20240318020255.GA28704@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710247112-7414-1-git-send-email-shradhagupta@linux.microsoft.com>
 <3bf8844a-3e19-4105-8cce-2b1f8f98d3bc@linux.microsoft.com>
 <20240313052212.GB22465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240315140914.GA14685@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <dd1b378d-6750-419f-8c46-a8f42c0ebe11@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd1b378d-6750-419f-8c46-a8f42c0ebe11@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Mar 15, 2024 at 09:56:22AM -0700, Easwar Hariharan wrote:
> On 3/15/2024 7:09 AM, Shradha Gupta wrote:
> 
> <snip>
> 
> >>>>  }
> >>>>  
> >>>> +static int process_dns_gateway_nm(FILE *f, char *ip_string, int type,
> >>>> +				  int ip_sec)
> >>>> +{
> >>>> +	char addr[INET6_ADDRSTRLEN], *output_str;
> >>>> +	int ip_offset = 0, error = 0, ip_ver;
> >>>> +	char *param_name;
> >>>> +
> >>>> +	output_str = (char *)calloc(INET6_ADDRSTRLEN * MAX_IP_ENTRIES,
> >>>> +				    sizeof(char));
> >>>> +
> >>>> +	if (!output_str)
> >>>> +		return -ENOMEM;
> >>>> +
> >>>> +	memset(addr, 0, sizeof(addr));
> >>>> +
> >>>> +	if (type == DNS) {
> >>>> +		param_name = "dns";
> >>>> +	} else if (type == GATEWAY) {
> >>>> +		param_name = "gateway";
> >>>> +	} else {
> >>>> +		error = -EINVAL;
> >>>> +		goto cleanup;
> >>>> +	}
> >>>> +
> >>>> +	while (parse_ip_val_buffer(ip_string, &ip_offset, addr,
> >>>> +				   (MAX_IP_ADDR_SIZE * 2))) {
> >>>> +		ip_ver = ip_version_check(addr);
> >>>> +		if (ip_ver < 0)
> >>>> +			continue;
> >>>> +
> >>>> +		if ((ip_ver == IPV4 && ip_sec == IPV4) ||
> >>>> +		    (ip_ver == IPV6 && ip_sec == IPV6)) {
> >>>> +			if (((INET6_ADDRSTRLEN * MAX_IP_ENTRIES) - strlen(output_str)) >
> >>>> +			    (strlen(addr))) {
> >>>> +				strcat(output_str, addr);
> >>>> +				strcat(output_str, ",");
> >>>
> >>> Prefer strncat() here
> > Is this needed with the bound check above. I am trying to keep parity with the rest of the 
> > file.
> >>>
> <snip>
> 
> I missed this earlier because my comment was more of a general best practice comment.
> 
> Note that in the worst case where your bounds check (INET6_ADDRSTRLEN*MAX_IP_ENTRIES) - strlen(output_str) equals (strlen(addr) + 1),
> you will be adding strlen(addr)+1(","), and end up with no ASCII NUL '\0' delimiter.
> 
> If you're going to rely on the bounds check to ensure correctness, you'll need to correct that. Generally speaking, strncat would still
> be helpful in case the bounds check changes in the future.
> 
> Thanks,
> Easwar
got it. Thanks.

