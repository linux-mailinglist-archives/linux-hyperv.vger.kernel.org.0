Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F23E19F6
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Aug 2021 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhHERGW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Aug 2021 13:06:22 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:50938 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236191AbhHERGW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Aug 2021 13:06:22 -0400
Received: by mail-pj1-f49.google.com with SMTP id l19so10478472pjz.0;
        Thu, 05 Aug 2021 10:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vR7UP1Yc/IFDSxfAzsx4Zk+6U+CY6rmoy5VDoc5dXUI=;
        b=EeTZV/AJXbhv5bTuBUc7AREMT8lnpeHHYLBOlJ0n0lvsuyrgy6hRzGPg1DFL9O/g1d
         uVuKQleJEGGT5nSBc0CMLSITBL/BA/39+0Bhkalfsf2cjJuRNHcmId3FmKO0ve2v45+U
         2YS1YqecKo1yn6KFvjuCiyjRdb4FLjhsU5NwRUlxIVa3E8nPDS9a2Z8FMNPAwI+Dg6Ep
         t/GUwYctSwhrwM0BpOE+SRpg6bYRVeF+sr0QZWSf+/YqGmhGxE+kP/PE6DcxqWkV5RVJ
         Zglthq77p8og+c8GZlU5LLJn3p/O/FeepJyMdhMpyug8We0zWqEGtwT1FMSktV9bizHY
         d4LA==
X-Gm-Message-State: AOAM5304W73m5TmqRBrkAQ+YEb63hxW+Nw7CR95/8wNUyZ3hdHKts5z1
        181O3tTc7rpfonHfr0ZlRWyZsIQ9Xxt5YM2K
X-Google-Smtp-Source: ABdhPJym7UTEsOoyahFuIvhnLSuQUQJ0vzzMIuCrvUcLZnEY24LVBLesRBXSynOcj3l47W9aJXJVyw==
X-Received: by 2002:a05:6a00:10cb:b029:3c6:8cc9:5098 with SMTP id d11-20020a056a0010cbb02903c68cc95098mr6013208pfu.41.1628183165889;
        Thu, 05 Aug 2021 10:06:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id c9sm3292599pgq.58.2021.08.05.10.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Aug 2021 10:06:05 -0700 (PDT)
Subject: Re: [Patch v5 2/3] Drivers: hv: add Azure Blob driver
To:     longli@linuxonhyperv.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Long Li <longli@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
References: <1628146812-29798-1-git-send-email-longli@linuxonhyperv.com>
 <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b6404b38-9ea2-b438-dc1b-1196f8e4a158@acm.org>
Date:   Thu, 5 Aug 2021 10:06:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1628146812-29798-3-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/5/21 12:00 AM, longli@linuxonhyperv.com wrote:
> diff --git a/include/uapi/misc/hv_azure_blob.h b/include/uapi/misc/hv_azure_blob.h
> new file mode 100644
> index 0000000..87a3f77
> --- /dev/null
> +++ b/include/uapi/misc/hv_azure_blob.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* Copyright (c) 2021 Microsoft Corporation. */
> +
> +#ifndef _AZ_BLOB_H
> +#define _AZ_BLOB_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/uuid.h>
> +#include <linux/types.h>
> +
> +/* user-mode sync request sent through ioctl */
> +struct az_blob_request_sync_response {
> +	__u32 status;
> +	__u32 response_len;
> +};
> +
> +struct az_blob_request_sync {
> +	guid_t guid;
> +	__u32 timeout;
> +	__u32 request_len;
> +	__u32 response_len;
> +	__u32 data_len;
> +	__u32 data_valid;
> +	__aligned_u64 request_buffer;
> +	__aligned_u64 response_buffer;
> +	__aligned_u64 data_buffer;
> +	struct az_blob_request_sync_response response;
> +};
> +
> +#define AZ_BLOB_MAGIC_NUMBER	'R'
> +#define IOCTL_AZ_BLOB_DRIVER_USER_REQUEST \
> +		_IOWR(AZ_BLOB_MAGIC_NUMBER, 0xf0, \
> +			struct az_blob_request_sync)
> +
> +#endif /* define _AZ_BLOB_H */

So this driver only supports synchronous requests? Is it likely that 
users will ask for support of an API that supports having multiple 
requests outstanding at the same time without having to create multiple 
user space threads?

Thanks,

Bart.


