Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24CBA3B533D
	for <lists+linux-hyperv@lfdr.de>; Sun, 27 Jun 2021 14:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhF0MCc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 27 Jun 2021 08:02:32 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:46013 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhF0MCc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 27 Jun 2021 08:02:32 -0400
Received: by mail-wm1-f44.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso8939619wmj.4;
        Sun, 27 Jun 2021 05:00:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdwo+hu4rzr7CNSfK2XGmb89GXpWbAP5ZbbrGV2S2Go=;
        b=ZfLU4noygboLL+Y15dBLRk1tAfmICbmELS2lE4rD+828EyusdCceF8hSPInknIa13P
         heAqzxv+pivvo0scnYm6FbJlHopVI6GkuJxG/r9/uGzu1qUmptWkZtwq5bRPR9qT/KMT
         Wi3lGUM8jiiFfPV8lRYjwxItGfLKxEJg+s9eY0+0T78emfB1Y7X3yY47rXwlv2+1LsOY
         Mf4czytrIu6R5syuGuEizwKmWy51kjD8zCECspd0hZ+hI4mAQ4JEl9GUo3sO4wuxkszB
         y6Z9LjP0bRRHp9XsRJ1y/YUY2jJNGsDV4X3f6VtlPMZrBig04oFIbi3Kv7FadUMQo8cx
         rL0w==
X-Gm-Message-State: AOAM530fGiKJZUc06MaIwFCOJrZflUE5Lfbx04+xVS/GwCIhw88PYPab
        6BuvyBnpehT9Ich1cBRe0L4=
X-Google-Smtp-Source: ABdhPJy6l04II51AeV1FJHfZ4dt7mwek4Iekg6cuTtsFLS1dctNM4dCQ8GxI2wZz76J8vZCjkadg9w==
X-Received: by 2002:a1c:f016:: with SMTP id a22mr21094601wmb.65.1624795206954;
        Sun, 27 Jun 2021 05:00:06 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x1sm10336663wmc.31.2021.06.27.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:00:06 -0700 (PDT)
Date:   Sun, 27 Jun 2021 12:00:04 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
Message-ID: <20210627120004.u4pn3stgcny2zl4i@liuwe-devbox-debian-v2>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 28, 2021 at 03:43:23PM -0700, Nuno Das Neves wrote:
[...]
> +
> +static int
> +__init mshv_init(void)
> +{
> +	int ret;

Please check if Linux is running on Microsoft Hypervisor here. If not,
this module should not be loaded.

Something like:

       if (!hv_is_hyperv_initialized())
               return -ENODEV;

Wei.
