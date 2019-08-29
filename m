Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D999DA2946
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 23:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfH2V5U (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 29 Aug 2019 17:57:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36535 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbfH2V5U (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 29 Aug 2019 17:57:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id l21so2319520pgm.3
        for <linux-hyperv@vger.kernel.org>; Thu, 29 Aug 2019 14:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=px8FhhO74YkYpDrIJvu8UKI4Wl3ea0Yj6/B2M+OVLRE=;
        b=oUX1lkaGk/84GMQj1HwRkeUyDlbxzohYrEYNbuhCRSK+1lfCRor06ttdo24j4ABEpX
         gSUmVxdfoLvqKru5nqBZFyvT0XN9bvsCxKUH5uB0YqkNQMt6C70eu4dC+PU2AML3M5/T
         /rgtqvvesspvgxDE1L529kCLhXhZOyT3PzXtExYvzuFyIiTdntGMvvpLkgdEoT6Lm1BD
         FdtKRVRqdOPglOMVpiIR6znwEO0JCLT5D9AtrkY5UsAPlabR25LY3bQDOJyeJKsY9TUv
         i0HI8u/pnM800Uvs6RYlesWgGgggxu/5HfkNotNT9Eak9ACNmBvWkTdnOd3Q5WFyPSTW
         GRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=px8FhhO74YkYpDrIJvu8UKI4Wl3ea0Yj6/B2M+OVLRE=;
        b=IOHB1mE/kpDNCKPT5n5k3mXJOBXMaKTO6E6wy4E9n1BlvEU6czYSzB2OWOtKVnxir0
         ibEdePqtNxgb7DjKuer8o9fv3Ba7KnFwPqXBJp6Z1QMuJZe0uBGxJm3585bgjFjs0IB+
         KeggZjyJE+SA/gBobCVgvtX66NWi5FWydMja5Y01IqUQzYWxxr157vseQUx5/7HXogS+
         DKNao4t3lBDZe4bLSwx0DHswgdKAXRFTpo6IC6xvSph5/d34lfE8gxPMqv5SQxjwtOpE
         sUTFoTSbrrWvNLfO5owbLlNT2vbrdkOikHu0VijcXWIDw2sgf0gt7Dx1xdwcSTFi1Uys
         UY5w==
X-Gm-Message-State: APjAAAVadFUHQpbClMaONz6/FctyPGTlvk5SejweCFRsXIg/UqYrV1j0
        zkTi7AqnOiaUSgTuZ0Y1Oqwa3w==
X-Google-Smtp-Source: APXvYqxbPJw5QB4+y7MiIzS54JCIUMQSEQJ6OJ0by69cxT+swOwfi0OL4gwM5ezqvGhyaM+9Df+I6w==
X-Received: by 2002:a63:40a:: with SMTP id 10mr10430010pge.317.1567115838454;
        Thu, 29 Aug 2019 14:57:18 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u7sm3162198pgr.94.2019.08.29.14.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 14:57:18 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:57:15 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     "Branden Bonaby" <brandonbonaby94@gmail.com>
Cc:     "KY Srinivasan" <kys@microsoft.com>,
        "Haiyang Zhang" <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>, <sashal@kernel.org>,
        <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drivers: hv: vmbus: Introduce latency testing
Message-ID: <20190829145715.41df52e0@hermes.lan>
In-Reply-To: <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566340843.git.brandonbonaby94@gmail.com>
References: <cover.1566340843.git.brandonbonaby94@gmail.com>
        <ebca54bf70d2af53de419c1b7ac8db5b77b888cb.1566340843.git.brandonbonaby94@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, 20 Aug 2019 16:39:02 -0700
"Branden Bonaby" <brandonbonaby94@gmail.com> wrote:

> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 9a59957922d4..d97437ba0626 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -29,4 +29,11 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_TESTING
> +        bool "Hyper-V testing"
> +        default n
> +        depends on HYPERV && DEBUG_FS
> +        help
> +          Select this option to enable Hyper-V vmbus testing.
> +
>  endmenu

Maybe this should go under the Kernel hacking
section in lib/Kconfig.debug?

