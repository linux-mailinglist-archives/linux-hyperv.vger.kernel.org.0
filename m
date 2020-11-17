Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB702B5DAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Nov 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKQK6s (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Nov 2020 05:58:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgKQK6r (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Nov 2020 05:58:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id c17so22678506wrc.11;
        Tue, 17 Nov 2020 02:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/RzeNf/OgnmiKBvEYjhwPpW3M/t40qj348YOpvITIw=;
        b=sedAY7DhLJcd3gR2xrsXhKz1oGNK88lF79Uo6rLnaumvKiiY3qZv2WqUkOb6Tvj1AJ
         3YMdozMfmkgj2wp3skczWFKPtrFhDyiZoq46jK24DGsfp3/MtGFewv5bX8z6J4uHQbPq
         To3A5FjkDiuleFPqHGudWYot59Dh4xM6kzutpIzaFOBywuJklotI5/BNdUxU7FqsoQGl
         xg06l3pvFbu2Rw6jcplUT5WlEVu4OuklwKuJrEL/NsCINeYr9U1vFeHFe2ugLOGfnTvk
         w4Ebv1907SsigQNpZIZU5Q8XpXDJ/o02aY0XEVfFo1isxEAgoVUCv7IHQzRTz7fQvfQj
         IKjg==
X-Gm-Message-State: AOAM533NQvgjv+eZZ5WwUOiidDvhuH4EQDMK3YkweBunPX38WQ4zu8r5
        yn70Mov4HDuy+pPeu1HS5CUNGOAEIpI=
X-Google-Smtp-Source: ABdhPJwZrq2JpVGvZa2iCpKQt4vmc6Eh09/md4cChTshuxp3eXTlXXG+Z60wC7BGQR4gdhbjUugl7A==
X-Received: by 2002:adf:db8e:: with SMTP id u14mr23113751wri.233.1605610725631;
        Tue, 17 Nov 2020 02:58:45 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id k64sm1461834wmb.11.2020.11.17.02.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 02:58:45 -0800 (PST)
Date:   Tue, 17 Nov 2020 10:58:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, sashal@kernel.org, Tianyu.Lan@microsoft.com,
        decui@microsoft.com, mikelley@microsoft.com,
        sunilmut@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add improvements suggested by checkpatch for
 vmbus_drv
Message-ID: <20201117105843.ijvulc7cx3ac2zng@liuwe-devbox-debian-v2>
References: <20201115195734.8338-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115195734.8338-1-matheus@castello.eng.br>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Nov 15, 2020 at 04:57:28PM -0300, Matheus Castello wrote:
> This series fixes some warnings edmited by the checkpatch in the file
> vmbus_drv.c. I thought it would be good to split each fix into a commit to
> help with the review.
> 
> Matheus Castello (6):
>   drivers: hv: Fix hyperv_record_panic_msg path on comment
>   drivers: hv: vmbus: Replace symbolic permissions by octal permissions
>   drivers: hv: vmbus: Fix checkpatch LINE_SPACING
>   drivers: hv: vmbus: Fix checkpatch SPLIT_STRING
>   drivers: hv: vmbus: Fix unnecessary OOM_MESSAGE
>   drivers: hv: vmbus: Fix call msleep using < 20ms

I've pushed patch 1-3 and 6 to hyperv-next.

Patch 4 has a pending comment from Michael. Patch 5 can be dropped.

Wei.
