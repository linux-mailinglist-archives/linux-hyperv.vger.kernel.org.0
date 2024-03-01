Return-Path: <linux-hyperv+bounces-1628-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DFE86DE39
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B419C1C20E8D
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BF6A33C;
	Fri,  1 Mar 2024 09:26:42 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4CD6BB21;
	Fri,  1 Mar 2024 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709285202; cv=none; b=e62GUgS78jEM6BKLfST2m6JYmuMhQ6EivEvWY9ZBuAQ3lQmpg9Y5tirEl8eztALZhCho6UsrYR7CiiNFxl1urJK7DVFcfK82HY0sx5Me4CclbclAMayNYiB5VxcAIIZ0wUZX6j5KxcB5v2cRqX97JBJPTJrYyrYoxu8bTp4i2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709285202; c=relaxed/simple;
	bh=0wdFpKbEyNhuu/RpjYvuz8KPZKT0kttiGp+cGiKwHZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq1Uhv/kX4HOYZfg2hSTmyY5DZtbb94XbzEPjtnO78rFUI/jWwbWzLhTutYhh9QfQcpkEdLCYoGOZWBLdj5eM1lGMRjupXZx1CrUqcQKdj1DUuEsk8sxRjzJeYxrIc/gqhfjtkpy9NdqR2hCVC/9dtJBfC9BY6D/bMzu9biuVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1429749a12.3;
        Fri, 01 Mar 2024 01:26:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709285201; x=1709890001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fp76SLNrOitLz2IPJZxtYaUARyA39f42XEHvT3cwYM=;
        b=wrjuv3Wk9FR/qzOMrvkBV0U6QMzH5WI7lDVlldaTvJWOaD3jqq3UxdtKAaY4Jc40TN
         3llrQ+Ka9uGMkYxulCTW+3lNz9ZDIJqh5GTnKOS/PXfY9b5cXY0+LPvQ/iDxPn9Gz4Ie
         9UBnHmhPXl38olLNqUQTHQcK5fcEu+PKAuuN75GItuJAufhjMMMtgmOLyJwiA7yiUTkv
         3Z777iBLYVu4dIrbbKQ5adrDD+P3kKt0GGKyGL0F64pXH4tWD9DQ9L4nEe5F5i6Cndqv
         dWjo8oT7NAR14xkxcDTZR9vq7ToDyvitTS46Z/zPwXT9+Jg3Z1RNNotdO58EG6jjibdj
         jXAA==
X-Forwarded-Encrypted: i=1; AJvYcCWyAUSugSMcnDGMbY8YXlwSSzzfpejMofz9LLlv+aYn9QmY77cRxNo85zkzbrC3sDm1H5hGrWOKFQ7qM0zzJyewJOb7hUUHpMpgCGqHVxVn0xffC4BQigRP9PKcCeuMnCur3j+nnNP/d5fySnyc93DY6TxXFQvvURSSWpnuFzx3Wdy6
X-Gm-Message-State: AOJu0Yym9L/5af98h0T37gnOgjiS/7dd8+6l4tocN3iQF6lB53VIMNQj
	vPKOAt76ssIIKWOnv7jjTF9HGkk35WG1SFYR4dxI+fyiNOuXnTrZ
X-Google-Smtp-Source: AGHT+IFzP30XgcgRz16jjeqSQMfVBbG9kjUBn2FuxIWeyBnM+Cs+BqPA7eeqULcAd7TXur4Xy4bBMg==
X-Received: by 2002:a05:6a20:7343:b0:1a1:2f17:1bc2 with SMTP id v3-20020a056a20734300b001a12f171bc2mr989042pzc.35.1709285200822;
        Fri, 01 Mar 2024 01:26:40 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d11-20020a170902cecb00b001d739667fc3sm2947317plg.207.2024.03.01.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 01:26:40 -0800 (PST)
Date: Fri, 1 Mar 2024 09:26:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org, gregkh@linuxfoundation.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com
Subject: Re: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Message-ID: <ZeGfTtlx0JOj9gVS@liuwe-devbox-debian-v2>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222021006.2279329-2-rick.p.edgecombe@intel.com>

On Wed, Feb 21, 2024 at 06:10:03PM -0800, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> Hyperv could free decrypted/shared pages if set_memory_encrypted() fails.

"Hyper-V" throughout.

> Leak the pages if this happens.
> 
> Only compile tested.
> 
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  drivers/hv/connection.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 3cabeeabb1ca..e39493421bbb 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -315,6 +315,7 @@ int vmbus_connect(void)
>  
>  void vmbus_disconnect(void)
>  {
> +	int ret;
>  	/*
>  	 * First send the unload request to the host.
>  	 */
> @@ -337,11 +338,13 @@ void vmbus_disconnect(void)
>  		vmbus_connection.int_page = NULL;
>  	}
>  
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
> -	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
> +	ret = set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
> +	ret |= set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
>  
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> -	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +	if (!ret) {
> +		hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
> +		hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
> +	}

This silently leaks the pages if set_memory_encrypted() fails.  I think
there should print some warning or error messages here.

Thanks,
Wei.

>  	vmbus_connection.monitor_pages[0] = NULL;
>  	vmbus_connection.monitor_pages[1] = NULL;
>  }
> -- 
> 2.34.1
> 

