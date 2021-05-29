Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2C394E51
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 23:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhE2V53 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 29 May 2021 17:57:29 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38556 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhE2V53 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 29 May 2021 17:57:29 -0400
Received: by mail-wm1-f53.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso6502267wmm.3;
        Sat, 29 May 2021 14:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkbfnMFIBjJ28sV3lmcDjwO88P3Jvg5MRuBy7DpTbY4=;
        b=ubpK27qmeUEcEYikODq08aeKKys+1feGJefPL2xYTxmjFRGGCU6bStVy5wOd9nepNx
         7IpbaLoR86TP+ege/WwOIWmAIC0gK6ycKIoYdc36xm4FtHzY7P6+kd8TtHpmABh9Gq3Y
         rPRyG0EiOKy7SUwU8G+t0ra9yYZ/lPVooIbnVG1ffNl02jNiUJGZM/sSUAo3ZmBD9ZcJ
         VDNH1rL2AF+fmepy9F6DrQ66WeZ+t2OeowtH/DFSemAbbsM5iKT2bkBy9Ay1rEp1X+Zy
         RKRVilO9J7N2N+k9T1AZHOx1Z0/mxu7s6ZrRiUbDRhJev2gqB5shojTaUf1HBg1XrGUu
         Mafw==
X-Gm-Message-State: AOAM533aUSY6fRtxHyHRTNWSIGyd1z5KW6R6pGzIdIobANMXplobLv8F
        FSWfSflAuEHm3cmIEtuXkwY=
X-Google-Smtp-Source: ABdhPJwFnxiQWJqP4OIAzJU9YeAxMunrAusQp1OBLGeZ96nRU9guTlqlRW3DeNf4xLLcWrHD6xKfAw==
X-Received: by 2002:a05:600c:4f8b:: with SMTP id n11mr14453897wmq.11.1622325350394;
        Sat, 29 May 2021 14:55:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b135sm9518073wmb.5.2021.05.29.14.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 14:55:49 -0700 (PDT)
Date:   Sat, 29 May 2021 21:55:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH 12/19] drivers/hv: run vp ioctl and isr
Message-ID: <20210529215548.okh67gtegsa4fd7r@liuwe-devbox-debian-v2>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-13-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622241819-21155-13-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 28, 2021 at 03:43:32PM -0700, Nuno Das Neves wrote:
[...]
>  int mshv_synic_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
> @@ -30,7 +126,7 @@ int mshv_synic_init(unsigned int cpu)
>  	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
>  			     HV_HYP_PAGE_SIZE,
>                               MEMREMAP_WB);
> -	if (!msg_page) {
> +	if (!(*msg_page)) {

This hunk belongs to the previous patch in which you introduced this
function, not this one.

Wei.
