Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2B54EA37F
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Mar 2022 01:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiC1XOZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Mar 2022 19:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiC1XOY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Mar 2022 19:14:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0F6447;
        Mon, 28 Mar 2022 16:12:43 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b24so18689019edu.10;
        Mon, 28 Mar 2022 16:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nQG8j8adD47TTidkz+7AQDmn+QN52qQ6CCfa3YMx7v0=;
        b=PhxUbyL7+q0eHH7O68pKrAM5b8X839330NCsdzVny0YXgyTMH+wt8lFIB2OX8rDJWE
         jS9dUxvXCrcjGMnzIp8tY6VAvCfXGACQu1nb8NhkMe7WEhNTbViXrcZ+3Yh9FfWq73oO
         0FibJiWDd5kh/ufBzC6ncxvwAVn4+Bocon6i8vcftHhVrUjYbwXvcFQeroPIook4n6oC
         io7EOcCvGQgBGl3gjYxE0vdSDIYNX9LPbe3w4xTzLXqJh7wXws/UfNQzKDxYEQyuP8YW
         FUTmCjkoCzQW8WkXrvP3vFMxpUIbwGI+F3kXHE3hg1qaYxFOvMJaEC/Q23L2N2M3+80r
         LICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQG8j8adD47TTidkz+7AQDmn+QN52qQ6CCfa3YMx7v0=;
        b=eaCnfHZcywX/6MHDbLYH2h6hXNmHVfN1NCgFFUMOL0Xh+nwyRAJTRBFy3iwwPzXBjC
         oInKtsZ+K5rsgG3Ps6GKmIvtQw/FnQFHKrNlirXJbqmDLBL50KuuhOLrnZfHRdQ+GMVu
         egFfwS5lPuCnTwF7BKAhFcIRiQWL8mb+TDs9VQ40h9t0akLa1wetE6J4m5+ZZCSvFDJR
         ijApWDRpbdpsufv2rTzz9IzDl+s9W78KLcqaCf3aTVfzDsvO9iNj1rcH3ofO4KXqD+7S
         Z8AqVR4q+KE9+RKr+EJ3gQmbPX/bNGzhSht03DDlecm/RxjlquXIGmsBee8YwkfKGPcq
         O86g==
X-Gm-Message-State: AOAM532VLEGjcJNl6Ztmu3Hh29V1ZbAvbLqSDykbbrLf7xKXArrK8dXe
        gHtoK2gY6U8dQDx9YnMAqBM=
X-Google-Smtp-Source: ABdhPJxFSGw+5TZ5QabLOtItEkK1xbL5vSOfieJzZdVtUYlq6C/A6AugpQSUTsmNiMRAtbYS8k3k1A==
X-Received: by 2002:a05:6402:43cc:b0:419:2486:6cd2 with SMTP id p12-20020a05640243cc00b0041924866cd2mr386960edc.334.1648509161391;
        Mon, 28 Mar 2022 16:12:41 -0700 (PDT)
Received: from anparri (host-82-59-4-232.retail.telecomitalia.it. [82.59.4.232])
        by smtp.gmail.com with ESMTPSA id v26-20020a50955a000000b00418ebdb07ddsm7746006eda.56.2022.03.28.16.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 16:12:41 -0700 (PDT)
Date:   Tue, 29 Mar 2022 01:12:33 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, vkuznets@redhat.com,
        decui@microsoft.com
Subject: Re: [PATCH 1/1] hv: drivers: vmbus: Prevent load re-ordering when
 reading ring buffer
Message-ID: <20220328231233.GA102571@anparri>
References: <1648394710-33480-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648394710-33480-1-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sun, Mar 27, 2022 at 08:25:10AM -0700, Michael Kelley wrote:
> When reading a packet from a host-to-guest ring buffer, there is no
> memory barrier between reading the write index (to see if there is
> a packet to read) and reading the contents of the packet. The Hyper-V
> host uses store-release when updating the write index to ensure that
> writes of the packet data are completed first. On the guest side,
> the processor can reorder and read the packet data before the write
> index, and sometimes get stale packet data. Getting such stale packet
> data has been observed in a reproducible case in a VM on ARM64.
> 
> Fix this by using virt_load_acquire() to read the write index,
> ensuring that reads of the packet data cannot be reordered
> before it. Preventing such reordering is logically correct, and
> with this change, getting stale data can no longer be reproduced.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>

Nit: subject prefix -> "Drivers: hv: vmbus:".

Thanks,
  Andrea
