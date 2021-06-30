Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46C03B85B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jun 2021 17:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbhF3PFd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Jun 2021 11:05:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhF3PFc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Jun 2021 11:05:32 -0400
Received: from [192.168.86.23] (c-73-38-52-84.hsd1.vt.comcast.net [73.38.52.84])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17B5220B7188;
        Wed, 30 Jun 2021 08:03:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17B5220B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1625065383;
        bh=1A02Vb1b0hWl2fsJJswCKDtOOcqlivyCit8PUhlwAU4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Go8xRQTHsSWhZIKZ1FtjNlG7k3rULbb589ryayPmFbnQFelG5VYc86izQWQaCd1+N
         z7o7C3aV9S1sKGMFeVAewa9ntrbeX+SfuoeeB5xM+Y4Y+OMI3pyqHy8VeIO3vYih6G
         FszfrRg+vL0jjL/nzoJipPaRcQ1zx0Ardlhn2Jdc=
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
 <20210630111048.xn3gbht33inx2luh@liuwe-devbox-debian-v2>
From:   Vineeth Pillai <viremana@linux.microsoft.com>
Message-ID: <50df2b12-18a6-8a11-f57a-d1e4bc04e9cd@linux.microsoft.com>
Date:   Wed, 30 Jun 2021 11:03:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630111048.xn3gbht33inx2luh@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


>> +
>> +int
>> +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
>> +		    u64 connection_partition_id,
>> +		    struct hv_port_info *port_info,
>> +		    u8 port_vtl, u8 min_connection_vtl, int node)
>> +{
>> +	struct hv_create_port *input;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +	int status;
>> +
>> +	do {
>> +		local_irq_save(flags);
>> +		input = (struct hv_create_port *)(*this_cpu_ptr(
>> +				hyperv_pcpu_input_arg));
>> +		memset(input, 0, sizeof(*input));
>> +
>> +		input->port_partition_id = port_partition_id;
>> +		input->port_id = port_id;
>> +		input->connection_partition_id = connection_partition_id;
>> +		input->port_info = *port_info;
>> +		input->port_vtl = port_vtl;
>> +		input->min_connection_vtl = min_connection_vtl;
>> +		input->proximity_domain_info =
>> +			numa_node_to_proximity_domain_info(node);
> This misses the check for NUMA_NO_NODE, so does the function for port
> connection (see below).
>
> I think it would actually be better to leave the check in
> numa_node_to_proximity_domain_info to avoid problems like this.
>
> Of course, adapting this approach means some call sites for that
> function will need to be changed too.
Thanks for catching this and fixing Wei, will roll it into my branch.

~Vineeth


>
> ---8<---
> >From 8705857c62b3e5f13d415736ca8b508c22e3f5ba Mon Sep 17 00:00:00 2001
> From: Wei Liu <wei.liu@kernel.org>
> Date: Wed, 30 Jun 2021 11:08:31 +0000
> Subject: [PATCH] numa_node_to_proximity_domain_info should cope with
>   NUMA_NO_NODE
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>   include/asm-generic/mshyperv.h | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index d9b91b8f63c8..44552b7a02ef 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -31,10 +31,14 @@ numa_node_to_proximity_domain_info(int node)
>   {
>   	union hv_proximity_domain_info proximity_domain_info;
>   
> -	proximity_domain_info.domain_id = node_to_pxm(node);
> -	proximity_domain_info.flags.reserved = 0;
> -	proximity_domain_info.flags.proximity_info_valid = 1;
> -	proximity_domain_info.flags.proximity_preferred = 1;
> +	proximity_domain_info.as_uint64 = 0;
> +
> +	if (node != NUMA_NO_NODE) {
> +		proximity_domain_info.domain_id = node_to_pxm(node);
> +		proximity_domain_info.flags.reserved = 0;
> +		proximity_domain_info.flags.proximity_info_valid = 1;
> +		proximity_domain_info.flags.proximity_preferred = 1;
> +	}
>   
>   	return proximity_domain_info;
>   }
