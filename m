Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFB87309A4
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jun 2023 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFNVQK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 17:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFNVQJ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 17:16:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA34D1FFA;
        Wed, 14 Jun 2023 14:16:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 659856219F;
        Wed, 14 Jun 2023 21:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9EEC433C0;
        Wed, 14 Jun 2023 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686777367;
        bh=vfYlJuoOT8kV/jL1ufwpQNEoJSIbItG70HGsulXaqs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDXOeSSGs7Yrr3jq6FAwLRypUqOaQE2CEOKOVnbVCGLNa187/yv4+ARCEUjReecdP
         8xmdaq5i/T2i0Ts/rq6HuC/X0udDFuO0wTCk55253AP3HNHUpT8kJNnkbXBFjTlBsE
         y1c0sX0ITC9Yd+5agZsiAlZ0c2pS0xSmeiRNnlUs=
Date:   Wed, 14 Jun 2023 23:16:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, mikelley@microsoft.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tools: hv: Add vmbus_bufring
Message-ID: <2023061430-facedown-getting-d9f7@gregkh>
References: <1686766512-2589-1-git-send-email-ssengar@linux.microsoft.com>
 <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1686766512-2589-3-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 14, 2023 at 11:15:09AM -0700, Saurabh Sengar wrote:
> Common userspace interface for read/write from VMBus ringbuffer.
> This implementation is open for use by any userspace driver or
> application seeking direct control over VMBus ring buffers.
> A significant  part of this code is borrowed from DPDK.

"  "?

Anyway, this does not explain what this is at all.

And if you "borrowed" it from DPDK, that feels odd, are you sure you are
allowed to do so?

> Link: https://github.com/DPDK/dpdk/

Not what a Link: tag is for, sorry.

> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V2]
> - simpler sysfs path, less parsing
> 
>  tools/hv/vmbus_bufring.c | 322 +++++++++++++++++++++++++++++++++++++++
>  tools/hv/vmbus_bufring.h | 158 +++++++++++++++++++
>  2 files changed, 480 insertions(+)
>  create mode 100644 tools/hv/vmbus_bufring.c
>  create mode 100644 tools/hv/vmbus_bufring.h

You add new files to the tools directory, yet say nothing about how to
use them or even how to build them.

Why is there a .h file for a single .c file?  That seems pointless,
right?

> diff --git a/tools/hv/vmbus_bufring.c b/tools/hv/vmbus_bufring.c
> new file mode 100644
> index 000000000000..d44a06d45b03
> --- /dev/null
> +++ b/tools/hv/vmbus_bufring.c
> @@ -0,0 +1,322 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2009-2012,2016,2023 Microsoft Corp.
> + * Copyright (c) 2012 NetApp Inc.
> + * Copyright (c) 2012 Citrix Inc.
> + * All rights reserved.

No copyright for the work you did?

> + */
> +
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <emmintrin.h>
> +#include <linux/limits.h>
> +#include <stdbool.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/uio.h>
> +#include <unistd.h>
> +#include "vmbus_bufring.h"
> +
> +#define	rte_compiler_barrier()	({ asm volatile ("" : : : "memory"); })
> +
> +#define	rte_smp_rwmb()		({ asm volatile ("" : : : "memory"); })

These aren't in any common header file already?

thanks,

greg k-h
