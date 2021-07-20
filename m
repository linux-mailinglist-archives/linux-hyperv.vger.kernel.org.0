Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCD63CF8A2
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Jul 2021 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236423AbhGTKaJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Jul 2021 06:30:09 -0400
Received: from mail-ej1-f44.google.com ([209.85.218.44]:36749 "EHLO
        mail-ej1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbhGTK3a (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Jul 2021 06:29:30 -0400
Received: by mail-ej1-f44.google.com with SMTP id nd37so33746438ejc.3;
        Tue, 20 Jul 2021 04:10:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHZdckbNZ18VQSZzXQt5sEXQRuXvblwckqVY5aEQJWo=;
        b=p3X3kWJFLRpFwit+vPYjYrEZG/SAvIPOpVPICShtXOxMWKAsGbB3Z873cZou8UUohc
         qcKpsAxHmt+Y5+kNPvENE42/5OoyKEWCn1XIs/X4/+qmAz8uFg6l6do7+sI5W1KUfUkn
         UoqPrjHnngBsyf/tV3EHVbjtaiEVA7KnYVxHqKVuISxYeeiOWInWgX1kZyJppQh6oXy9
         VGkGQwoDMyEP+eie4vTtETEsXeOxZevx15AekugkSmXWpUjMuG0zmU9c+cCK1C8RaUVa
         qMWa3zhS3C+EVw58LUvFa0Om+l9WEMMakw6ObxOIw1oYb51ABeNAPxTnhsrSA7zyVZ9B
         3vdA==
X-Gm-Message-State: AOAM531VA1JapqLMJaFSnItSHHXM5FJ7oHKhepQ7aT1EHubL7zLoGDwo
        cvq6b5rwyctX0z4b2yCeIWXR8sHn9EXN5eSD
X-Google-Smtp-Source: ABdhPJx/6R3BpTygKz5Na6aXvE85FbPPIeQekl7WrNh04jNUe66RpMaHk26/Qm3CWZXW6/lJHTCZSQ==
X-Received: by 2002:a17:906:dc0f:: with SMTP id yy15mr31349098ejb.255.1626779406409;
        Tue, 20 Jul 2021 04:10:06 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u5sm9156243edv.64.2021.07.20.04.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 04:10:05 -0700 (PDT)
Subject: Re: [Patch v4 2/3] Drivers: hv: add Azure Blob driver
To:     longli@linuxonhyperv.com, linux-fs@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
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
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>, linux-doc@vger.kernel.org
References: <1626751866-15765-1-git-send-email-longli@linuxonhyperv.com>
 <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <90ed52d3-5095-9789-53f0-477ba70edc3b@kernel.org>
Date:   Tue, 20 Jul 2021 13:10:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1626751866-15765-3-git-send-email-longli@linuxonhyperv.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 20. 07. 21, 5:31, longli@linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/include/uapi/misc/hv_azure_blob.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> +/* Copyright (c) 2021 Microsoft Corporation. */
> +
> +#ifndef _AZ_BLOB_H
> +#define _AZ_BLOB_H
> +
> +#include <linux/kernel.h>
> +#include <linux/uuid.h>

Quoting from 
https://lore.kernel.org/linux-doc/MWHPR21MB159375586D810EC5DCB66AF0D7039@MWHPR21MB1593.namprd21.prod.outlook.com/:
=====
Seems like a #include of asm/ioctl.h (or something similar)
is needed so that _IOWR is defined.  Also, a #include
is needed for __u32, __aligned_u64, guid_t, etc.
=====

Why was no include added?

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
> 

thanks,
-- 
js
suse labs
