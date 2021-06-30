Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27BB3B8116
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Jun 2021 13:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhF3LNV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 30 Jun 2021 07:13:21 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38502 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3LNU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 30 Jun 2021 07:13:20 -0400
Received: by mail-wm1-f53.google.com with SMTP id p10-20020a05600c430ab02901df57d735f7so4115179wme.3;
        Wed, 30 Jun 2021 04:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5fyJDpViiDLBvLsYN05zyTOw1686s7k8wVdCkDXRujI=;
        b=ktVTgS9b2TXJvS53DiAQ2a7FwIrktaeUdTju+kB0P9CzZG0zU2aHtc03cG2wYE/WPa
         IdK/FLjX1aqw/pnOmy3nng/n8ZAttRYQ1bsY/xDsnEj1cusXeFGlFI9hyeDfuxISz26T
         0gVyc02DRJz0Q2XM2xgGd1X+u+HVzsc5ePsrpv6vYr9VbyZBK1Lh3+iyeJxWEyM2b1xI
         jVVhY45vzmNwXWR8qSaOGU0av8dTQWjJr2ZUWRit3xEz9XQJS0Ss1Ok4OZurXCeJ8/Ee
         h+kX8NaZwBV4x8uvN6541UF+KEuuFguTUO52VbQfdt9WotRGPBX/Zx9USG214TbRPF93
         gi/A==
X-Gm-Message-State: AOAM5336VuwOPvYORRdXlgALA1qBwo3Qj4ZLIWmGfijwZVHUc9Lkwo8t
        QpVWggLaG+nJaNCDA6etlH8=
X-Google-Smtp-Source: ABdhPJxlHkfxSDu6CIdORE83974jFxGf3G1+BosxKk90BSsJajRDYkyleI6/nrpFGkAra3s2ER0Tig==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr3847760wmq.71.1625051450258;
        Wed, 30 Jun 2021 04:10:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b187sm6800307wmh.32.2021.06.30.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 04:10:49 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:10:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
Message-ID: <20210630111048.xn3gbht33inx2luh@liuwe-devbox-debian-v2>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 02, 2021 at 05:20:51PM +0000, Vineeth Pillai wrote:
> Hyper-V enables inter-partition communication through the port and
> connection constructs. More details about ports and connections in
> TLFS chapter 11.
> 
> Implement hypercalls related to ports and connections for enabling
> inter-partiion communication.
> 
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  drivers/hv/hv_call.c                   | 161 +++++++++++++++++++++++++
>  drivers/hv/mshv.h                      |  12 ++
>  include/asm-generic/hyperv-tlfs.h      |  55 +++++++++
>  include/linux/hyperv.h                 |   9 --
>  include/uapi/asm-generic/hyperv-tlfs.h |  76 ++++++++++++
>  5 files changed, 304 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
> index 025d4e2b892f..57db3a8ac94a 100644
> --- a/drivers/hv/hv_call.c
> +++ b/drivers/hv/hv_call.c
> @@ -742,3 +742,164 @@ int hv_call_translate_virtual_address(
>  	return hv_status_to_errno(status);
>  }
>  
> +
> +int
> +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +		    u64 connection_partition_id,
> +		    struct hv_port_info *port_info,
> +		    u8 port_vtl, u8 min_connection_vtl, int node)
> +{
> +	struct hv_create_port *input;
> +	unsigned long flags;
> +	int ret = 0;
> +	int status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = (struct hv_create_port *)(*this_cpu_ptr(
> +				hyperv_pcpu_input_arg));
> +		memset(input, 0, sizeof(*input));
> +
> +		input->port_partition_id = port_partition_id;
> +		input->port_id = port_id;
> +		input->connection_partition_id = connection_partition_id;
> +		input->port_info = *port_info;
> +		input->port_vtl = port_vtl;
> +		input->min_connection_vtl = min_connection_vtl;
> +		input->proximity_domain_info =
> +			numa_node_to_proximity_domain_info(node);

This misses the check for NUMA_NO_NODE, so does the function for port
connection (see below).

I think it would actually be better to leave the check in
numa_node_to_proximity_domain_info to avoid problems like this.

Of course, adapting this approach means some call sites for that
function will need to be changed too.

---8<---
From 8705857c62b3e5f13d415736ca8b508c22e3f5ba Mon Sep 17 00:00:00 2001
From: Wei Liu <wei.liu@kernel.org>
Date: Wed, 30 Jun 2021 11:08:31 +0000
Subject: [PATCH] numa_node_to_proximity_domain_info should cope with
 NUMA_NO_NODE

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/mshyperv.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index d9b91b8f63c8..44552b7a02ef 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -31,10 +31,14 @@ numa_node_to_proximity_domain_info(int node)
 {
 	union hv_proximity_domain_info proximity_domain_info;
 
-	proximity_domain_info.domain_id = node_to_pxm(node);
-	proximity_domain_info.flags.reserved = 0;
-	proximity_domain_info.flags.proximity_info_valid = 1;
-	proximity_domain_info.flags.proximity_preferred = 1;
+	proximity_domain_info.as_uint64 = 0;
+
+	if (node != NUMA_NO_NODE) {
+		proximity_domain_info.domain_id = node_to_pxm(node);
+		proximity_domain_info.flags.reserved = 0;
+		proximity_domain_info.flags.proximity_info_valid = 1;
+		proximity_domain_info.flags.proximity_preferred = 1;
+	}
 
 	return proximity_domain_info;
 }
-- 
2.30.2


[...]
> +int
> +hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +		     u64 connection_partition_id,
> +		     union hv_connection_id connection_id,
> +		     struct hv_connection_info *connection_info,
> +		     u8 connection_vtl, int node)
> +{
> +	struct hv_connect_port *input;
> +	unsigned long flags;
> +	int ret = 0, status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = (struct hv_connect_port *)(*this_cpu_ptr(
> +				hyperv_pcpu_input_arg));
> +		memset(input, 0, sizeof(*input));
> +		input->port_partition_id = port_partition_id;
> +		input->port_id = port_id;
> +		input->connection_partition_id = connection_partition_id;
> +		input->connection_id = connection_id;
> +		input->connection_info = *connection_info;
> +		input->connection_vtl = connection_vtl;
> +		input->proximity_domain_info =
> +			numa_node_to_proximity_domain_info(node);

Here...
