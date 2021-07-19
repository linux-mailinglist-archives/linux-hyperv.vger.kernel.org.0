Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF73E3CD0C1
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jul 2021 11:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhGSIrW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jul 2021 04:47:22 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40510 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhGSIrS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jul 2021 04:47:18 -0400
Received: by mail-wr1-f51.google.com with SMTP id l7so21144595wrv.7;
        Mon, 19 Jul 2021 02:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdNcKm/5tWIKzoJJEWGoc8HuwkdVdE+Ye382bk1RyWI=;
        b=iLdfzB9gkSOmRgKAfGqx8+yxJlQNcZYTBx2GkwjWY8arlPlvJJFm6Vqtr1fA7YOPL/
         su06eTFEKu/U3cyLk/gkm0NdEkpenxBP0OkuS1psd6yRYpIDuSsU4EGC3oPfq52BMouN
         d4VPDFtycTsRvLCdkO+yyNsxegaGoMNWOnJPlFDXn3VGsYFrF9Uqel7JythFd68nDwof
         sF6fxTrEag4qqf7VvAuXuIqjh2Hu1xNe6YAhNPuQioJ5m7Mk+f6BId3Pi23WZ8xY7cPd
         s5l51vyrBjYN7hz4LShqVJpQfyfoNRdSfrvF5WAuvp4CPUItbkfj4jNorY7TvBmACDwV
         UnKg==
X-Gm-Message-State: AOAM532M/KAklV+kbJGpclwsLCS0N1+1WebMXY2RuQC9/d2POeVxbQD1
        dJxtjhcfk9kNTQTBgGYDREw=
X-Google-Smtp-Source: ABdhPJwj3PNr8oe9ZBWc4Yv5ZV7cI+XIJnDGOWg5TfuS07JxXdIVRp5On5n5HjJHgCKgTE6JaP0mOA==
X-Received: by 2002:a05:6000:18ae:: with SMTP id b14mr27745167wri.427.1626686877784;
        Mon, 19 Jul 2021 02:27:57 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id d29sm23874777wrb.63.2021.07.19.02.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 02:27:57 -0700 (PDT)
Date:   Mon, 19 Jul 2021 09:27:56 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Haiyang Zhang <haiyangz@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, kys@microsoft.com,
        linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3,hyperv-fixes] Drivers: hv: vmbus: Fix duplicate CPU
 assignments within a device
Message-ID: <20210719092756.p4pg356ljhyrho42@liuwe-devbox-debian-v2>
References: <1626459673-17420-1-git-send-email-haiyangz@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626459673-17420-1-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Jul 16, 2021 at 11:21:13AM -0700, Haiyang Zhang wrote:
[...]
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> Tested-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-fixes. Thanks.
