Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA30383B35
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 May 2021 19:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhEQR0X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 17 May 2021 13:26:23 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:36820 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhEQR0X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 17 May 2021 13:26:23 -0400
Received: by mail-wr1-f53.google.com with SMTP id c14so5468058wrx.3
        for <linux-hyperv@vger.kernel.org>; Mon, 17 May 2021 10:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WT4MO0jfb54/WwmN/o06DVse7nmY0vnuEJqC7jhWbgY=;
        b=E1eQtULY2EDbdeAX3YETcPyih5GyTTfUj2bbKBOI/1LPKJ3gBwuGro2xovp0QHuNk0
         EvHfISojMx0dRJLdzGcie2C9kM0Kb5czSZYrRQ/XChJ93zf9ezkFPo8wpH3OzF5Wx04W
         J30WvaS8N8q7fREJBmzVJNXIATtN+xuiaY0PjYSnR6f6iA2wG/IjaUCIJlfJYrW9PVjl
         2WvUCBC66Nr61bKN5PKiDo4newkwEP0jdsryfMIimeHnV3SdFoay13LuW7LRhQwRWIbz
         g3vffTCBseu/+TUadTAca4mZcaZzIPqNj4mlaBCTyxmPd0qrQcldjWm0RVTCzoiJZWFQ
         5QRw==
X-Gm-Message-State: AOAM532Q3sof0dh+uHGSjiQGQ2g46MI7Uu9ESNehKAtHQvmje3P4TfMl
        Yb7S1Lojb+VOTV9kq9KX644=
X-Google-Smtp-Source: ABdhPJzYSsHmPrZIBMT2msycq5e5zD+9oKEFqKX3aOgJHZ/eY6DIPzBHqZSfoHPEj4NKpI1A/MLQYQ==
X-Received: by 2002:adf:e384:: with SMTP id e4mr869351wrm.347.1621272305940;
        Mon, 17 May 2021 10:25:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z18sm17398946wrh.16.2021.05.17.10.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:25:05 -0700 (PDT)
Date:   Mon, 17 May 2021 17:25:03 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Deepak Rawat <drawat.floss@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v4 3/3] MAINTAINERS: Add maintainer for hyperv video
 device
Message-ID: <20210517172503.ytpuucwphtwhcgsi@liuwe-devbox-debian-v2>
References: <20210517115922.8033-1-drawat.floss@gmail.com>
 <20210517115922.8033-3-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517115922.8033-3-drawat.floss@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, May 17, 2021 at 04:59:22AM -0700, Deepak Rawat wrote:
> Maintainer for hyperv synthetic video device.
> 
> Signed-off-by: Deepak Rawat <drawat.floss@gmail.com>
> ---
>  MAINTAINERS | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bd7aff0c120f..261342551406 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6077,6 +6077,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/hisilicon/
>  F:	drivers/gpu/drm/hisilicon/
>  
> +DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
> +M:	Deepak Rawat <drawat.floss@gmail.com>
> +L:	linux-hyperv@vger.kernel.org
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	drivers/gpu/drm/hyperv
> +
>  DRM DRIVERS FOR LIMA
>  M:	Qiang Yu <yuq825@gmail.com>
>  L:	dri-devel@lists.freedesktop.org
> @@ -6223,6 +6231,14 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	Documentation/devicetree/bindings/display/xlnx/
>  F:	drivers/gpu/drm/xlnx/
>  
> +DRM DRIVERS FOR ZTE ZX
> +M:	Shawn Guo <shawnguo@kernel.org>
> +L:	dri-devel@lists.freedesktop.org
> +S:	Maintained
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
> +F:	Documentation/devicetree/bindings/display/zte,vou.txt
> +F:	drivers/gpu/drm/zte/
> +

What is the section about? Is this a mistake?

Wei.
