Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C922A7F01
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 13:51:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgKEMvw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 07:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgKEMvw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 07:51:52 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0233CC0613CF;
        Thu,  5 Nov 2020 04:51:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 23so1055832wmg.1;
        Thu, 05 Nov 2020 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=21tQgACA2MlFk2eFW9R6MtzILXqxGUisi7N1EoyxkIQ=;
        b=K96680qm4O/M6l+aWKJNu+ZJ9qiYiGvXmUdXeJkmlO2Ypsq397j9+hLmeE0HhwoONS
         dR+e7K8bHhd9afInT0CPDgOW+WnhQxVnFL0efmyUhKjIlVSqseq6hVvzqHbYnB28Lj2S
         hf0xmtmx5YH6ZjfPifKQug+eC+kPnb/jroq06bCjGxg7dFRzEqUvwL2ez4feO27xnWlH
         58cMnHokwJSCKZQ9nr6t7unOXpHYPXlPDx5OF2w8Oav0V2bZYDKa5KCEo1oRHrZGD6AI
         zyIMHjVtjrok2SUZgYcOyYvyTSB+9b/kmLPVXjAswpaSIl8DDzwuvWXFdFsKJbpGqvBD
         ZjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=21tQgACA2MlFk2eFW9R6MtzILXqxGUisi7N1EoyxkIQ=;
        b=j2/Jwq/tTK3f7WgxS3BvQvWvRzDTvahqlUeqxZSFEGYitTJXcCPbWzrKTQqtxZhwwZ
         MyqfAi5cyjgBqmfnYARhfmjIxpZ8hrU8FxPjYygoskpQ27mHE7p2LyHdkKfOtprBlfrW
         dsuEs1rNb+vFUqaitPbJ/VntKuzGevjmbs6vs/uEFdho4/lV/bf+9p7ZYX74nn9v9BR2
         J8HXp38vhhQ1RxH+gMYcXqZJGtMKfQ1dvF0xIQkCQOBVKUpNF5Ad0NOgNAJb/NMCXL8u
         ZQNkOL+CC6s7BtxDK58OUFW3AZcRRgQbkPevHcFHg3gwDNwsmJShP/G62hjXXNMrBoHb
         /OrA==
X-Gm-Message-State: AOAM531KByDjzxdyHzwAz4rnB2j8JV44sZzlfgCgx2Qtw0CTkkSfo8Sa
        4+ldtUQrh/jJWAtGuNindnYuYYZWtUn8FYcI
X-Google-Smtp-Source: ABdhPJyWTeQ6y6xMAOGUTk5rY+inL6ySSMprZBBjwbibLmAiJ4eaSRMesCMXdKqZDK4J/PcHOmHe7g==
X-Received: by 2002:a1c:1f05:: with SMTP id f5mr2505758wmf.98.1604580710395;
        Thu, 05 Nov 2020 04:51:50 -0800 (PST)
Received: from andrea (host-87-7-71-164.retail.telecomitalia.it. [87.7.71.164])
        by smtp.gmail.com with ESMTPSA id l16sm2373963wrx.5.2020.11.05.04.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 04:51:49 -0800 (PST)
Date:   Thu, 5 Nov 2020 13:51:41 +0100
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
        Andres Beltran <lkmlabelt@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, lkp@intel.com
Subject: Re: [PATCH v8 1/3] Drivers: hv: vmbus: Add vmbus_requestor data
 structure for VMBus hardening
Message-ID: <20201105125141.GA353914@andrea>
References: <20201104154027.319432-1-parri.andrea@gmail.com>
 <20201104154027.319432-2-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104154027.319432-2-parri.andrea@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> @@ -300,6 +303,22 @@ int hv_ringbuffer_write(struct vmbus_channel *channel,
>  						     kv_list[i].iov_len);
>  	}
>  
> +	/*
> +	 * Allocate the request ID after the data has been copied into the
> +	 * ring buffer.  Once this request ID is allocated, the completion
> +	 * path could find the data and free it.
> +	 */
> +
> +	if (desc->flags == VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED) {
> +		rqst_id = vmbus_next_request_id(&channel->requestor, requestid);
> +		if (rqst_id == VMBUS_RQST_ERROR) {
> +			pr_err("No request id available\n");
> +			return -EAGAIN;

FYI, the lkp kernel test robot reported a missing call to
spin_unlock_irqrestore(&outring_info->ring_lock, flags) before the
above 'return': I'll address this in the next submission.

  Andrea
