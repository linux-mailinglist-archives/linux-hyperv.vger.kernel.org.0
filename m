Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B66E3D7C97
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 19:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhG0Rvg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 13:51:36 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:34305 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhG0Rvg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 13:51:36 -0400
Received: by mail-wm1-f49.google.com with SMTP id l4-20020a05600c1d04b02902506f89ad2dso2389220wms.1;
        Tue, 27 Jul 2021 10:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwYScmPim6tE/MDgrbNvahN0e/2bkCVHKdvM2oDO2hU=;
        b=MtrhHyH1EXKfrApBmzExmtJ81J/XnuL7XiVCbcmvQKkxG+hXLKeZCmEfNXGbpWjY62
         rX13lbYIsJ/+Vp4+lD3YnCoytkiz5++QgdO+fDn6ZGS1+kIuDLeXuiNl/IKOyg9N95uf
         SVFif8+8w+kXY8FGi+ldJGBX/CFY38eq6OxTKW+1PkVtzYqhLO5WD+qx+VMcMLC4wiif
         AH9neasCeL8+g+0ajfeGUCBXy5aAgSJeREzCcpD3EWxxdevIgqSwRMVBP0dSP4FQn7oH
         fYJWzZn5H/nH92iR/BIOKOCREACoR7ect04U+4QEKzLd4XWDXYhkT++jEwMxLnIyB0c7
         3aDQ==
X-Gm-Message-State: AOAM531zNZGoisjifNMTs2SH0cvfMU2nLGYTxVgKFB3dppdtTMB3ZUGo
        Bdxv3EC3fS5ttfEZIFz7YP4=
X-Google-Smtp-Source: ABdhPJy+SrPjL/YKIxWhTGnciEmNbBdAW4RbjazaOxiclSAaBLaCvL9GcuSp5o4NuE7F0px1tOP/ug==
X-Received: by 2002:a05:600c:4308:: with SMTP id p8mr5485552wme.45.1627408294068;
        Tue, 27 Jul 2021 10:51:34 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id q22sm3675211wmc.16.2021.07.27.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 10:51:33 -0700 (PDT)
Date:   Tue, 27 Jul 2021 17:51:31 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v3] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Message-ID: <20210727175131.364fxm667marijdk@liuwe-devbox-debian-v2>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 04:10:44PM +0530, Praveen Kumar wrote:
[...]
>  
> @@ -170,9 +185,21 @@ static int hv_cpu_die(unsigned int cpu)
>  
>  	hv_common_cpu_die(cpu);
>  
> -	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
> +	if (hv_vp_assist_page && hv_vp_assist_page[cpu]) {
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
>  

The content of the MSR should be preserved; otherwise you hit the same
fault for root kernel.

Wei.
