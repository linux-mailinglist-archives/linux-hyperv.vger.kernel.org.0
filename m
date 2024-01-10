Return-Path: <linux-hyperv+bounces-1412-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA65282A054
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 19:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C611F24A45
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Jan 2024 18:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832EB4D590;
	Wed, 10 Jan 2024 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4y9m4px"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E094D584
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Jan 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d87df95ddso46234625e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Jan 2024 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704911866; x=1705516666; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0bRmYP/rNPWw+8+5BllGhXOmL25I0DLXSeKEgWDNQLs=;
        b=B4y9m4pxhpxRGOujWf+e9E3fjzFu5dOFOwf6HawGfDo4SP73owmvHqGT6+ep0hBuY4
         RhU2Ca7MzBDbCnCSE0A47ldGPGAuyW6Y1qnIecRaj3u43zkfAJWb0ab9G8E52rw//fjV
         xg8dYajX+RjVoFVP9Lbpk3hT85MqmDH4e/BzkXUjcT45ZHgtVkHlR0If7NLkvwkZVr24
         K4Cd6BxoKiQyanYjNYrHvcnOeUFowoUl0JOyRNQqpKhZ+1TOfmVGQtbZibTsjkViDfzi
         hJQRObKO+yDpY88g+6Wz6rmYy3NDFY7IgKHiieRrWGZLomxHaSza63XMzBJ0AOONSoF1
         szBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704911866; x=1705516666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bRmYP/rNPWw+8+5BllGhXOmL25I0DLXSeKEgWDNQLs=;
        b=CK7xM6RdSJknYEzc9IAv3XiejVgX6PQNXO+W9TfR+NWuF0W8R+5ASRA2d0T2N+ToQ3
         qtkgMFJ19lii3h2plCtQcYT5z+epo05JWANAjMcqBOJOBKFQx/bEGM+0uTjoaQDeyScH
         NMTXcoYz2hplqBYvkFER5wc47fLWvoNFDmFTj140jKEvf/RowlkBkSH3TlXjUinXXBFH
         WD3fWkaW7rpOT7JwiuZh617e96VJd//d18Ltx5BrlBIIuZxUGmwro1a4axPlNDE2VrGC
         P2ZxP4ltB10oFXiuFXRJcpscXaPCDW87G3+Wvx6yhlLaLjBKAq1mlj83Kh2Oy+o92lH5
         YSMw==
X-Gm-Message-State: AOJu0YykIFXUuizWYl7Kgmzh0o1IfnbBey3L+uqgdCxXWPHG5Eyx1x8U
	Rf1RQCgAlZ2W97K5KxmncB7g5b22QPpmGg==
X-Google-Smtp-Source: AGHT+IEOYHVXjBcX1zYY8aTR9nE/xddM0bNI/sKTb4IkdC06BAEXBpFk57A1vGcVFhzX51Zgcm0+0w==
X-Received: by 2002:a05:600c:1603:b0:40e:54f1:5d3e with SMTP id m3-20020a05600c160300b0040e54f15d3emr372091wmn.199.1704911866001;
        Wed, 10 Jan 2024 10:37:46 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b0040d91fa270fsm3064239wmb.36.2024.01.10.10.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:37:45 -0800 (PST)
Date: Wed, 10 Jan 2024 21:37:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, "cocci@inria.fr" <cocci@inria.fr>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Drivers: hv: vmbus: One function call less in
 create_gpadl_header() after error detection
Message-ID: <d3c13efc-a1a3-4f19-b0b9-f8c02cc674d5@moroto.mountain>
References: <6d97cafb-ad7c-41c1-9f20-41024bb18515@web.de>
 <SN6PR02MB4157AA51AD8AEBB24D0668B7D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <82054a0a-72e5-45b2-8808-e411a9587406@web.de>
 <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157CA3901DD8D069C755C72D4692@SN6PR02MB4157.namprd02.prod.outlook.com>

The second half of the if statement is basically duplicated.  It doesn't
need to be treated as a special case.  We could do something like below.
I deliberately didn't delete the tabs.  Also I haven't tested it.

regards,
dan carpenter

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 56f7e06c673e..2ba65f9ad3f1 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -328,9 +328,9 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 		  sizeof(struct gpa_range);
 	pfncount = pfnsize / sizeof(u64);
 
-	if (pagecount > pfncount) {
-		/* we need a gpadl body */
-		/* fill in the header */
+	if (pagecount < pfncount)
+		pfncount = pagecount;
+
 		msgsize = sizeof(struct vmbus_channel_msginfo) +
 			  sizeof(struct vmbus_channel_gpadl_header) +
 			  sizeof(struct gpa_range) + pfncount * sizeof(u64);
@@ -410,31 +410,6 @@ static int create_gpadl_header(enum hv_gpadl_type type, void *kbuffer,
 			pfnsum += pfncurr;
 			pfnleft -= pfncurr;
 		}
-	} else {
-		/* everything fits in a header */
-		msgsize = sizeof(struct vmbus_channel_msginfo) +
-			  sizeof(struct vmbus_channel_gpadl_header) +
-			  sizeof(struct gpa_range) + pagecount * sizeof(u64);
-		msgheader = kzalloc(msgsize, GFP_KERNEL);
-		if (msgheader == NULL)
-			goto nomem;
-
-		INIT_LIST_HEAD(&msgheader->submsglist);
-		msgheader->msgsize = msgsize;
-
-		gpadl_header = (struct vmbus_channel_gpadl_header *)
-			msgheader->msg;
-		gpadl_header->rangecount = 1;
-		gpadl_header->range_buflen = sizeof(struct gpa_range) +
-					 pagecount * sizeof(u64);
-		gpadl_header->range[0].byte_offset = 0;
-		gpadl_header->range[0].byte_count = hv_gpadl_size(type, size);
-		for (i = 0; i < pagecount; i++)
-			gpadl_header->range[0].pfn_array[i] = hv_gpadl_hvpfn(
-				type, kbuffer, size, send_offset, i);
-
-		*msginfo = msgheader;
-	}
 
 	return 0;
 nomem:

