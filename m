Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C2243A558
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Oct 2021 22:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhJYVAl (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Oct 2021 17:00:41 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:44956 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbhJYVAl (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Oct 2021 17:00:41 -0400
Received: by mail-wm1-f45.google.com with SMTP id j2-20020a1c2302000000b0032ca9b0a057so1204106wmj.3;
        Mon, 25 Oct 2021 13:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7R6VjtnCqdQibzDqCZI9sbf30uci2ezWuNBBPtreEhU=;
        b=zkfdbBhlqZhrsdtJxBegRsQ8uL5fCkyBIIEC9+yFaC1kME2re8LKpsqivs2W7n4auE
         28Y4bXQ3UemoV9bf5UiL9F23RnAHWY25ewgtjMNX5xROjE5H5bMothpOG5zN+XURGBIY
         3gYQ2lRbY1Qbfutb2ehJsihhLzcYqXp1rY06BPfMGFWLMXWJWPSiw2ZWvyMKVFrC53CY
         dX7D7M1poQn/lbjyUxx+9Z3aQ5lkgDUUregMV6MyBtCEEkvMQcY8f0Yw+oecCd0u/qn9
         /fvgHIFDSbABGbmfk15JtBxcCYBayJgA/9dUaZhFUECnQtSLAcGABCnVFN7Sciidrn6m
         O5dw==
X-Gm-Message-State: AOAM533vh5RB3AIjmH8nAUhjhOHxxMfiLKpWuvB/JjpjRqiI0DLTPMy2
        vrdRoIIdsdY3k9H9G4tT4qIqIxSsDgk=
X-Google-Smtp-Source: ABdhPJx8IxOnglUxKKr2q6FC/nRHEFyemhHaTorg+q4PKxo/+8IZzUW2MU/c+MYVCm/YGjAvXiS32A==
X-Received: by 2002:a05:600c:228d:: with SMTP id 13mr21200674wmf.111.1635195497605;
        Mon, 25 Oct 2021 13:58:17 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n66sm17354155wmn.2.2021.10.25.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 13:58:17 -0700 (PDT)
Date:   Mon, 25 Oct 2021 20:58:15 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Remove unused code to check for
 subchannels
Message-ID: <20211025205815.pb66hrfozjc3cq3d@liuwe-devbox-debian-v2>
References: <1635191674-34407-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635191674-34407-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Oct 25, 2021 at 12:54:34PM -0700, Michael Kelley wrote:
> The last caller of vmbus_are_subchannels_present() was removed in commit
> c967590457ca ("scsi: storvsc: Fix a race in sub-channel creation that can cause panic").
> 
> Remove this dead code, and the utility function invoke_sc_cb() that it is
> the only caller of.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Applied to hyperv-next. Thanks.
